---
layout: post
title: opengl one
categories: [opengl]
---

opengl 하자

먼저 창을 띄워야 하니까 또 glfw를 건드린다.

```
% git clone https://github.com/glfw/glfw.git
```

그러면 `glfw` 폴더가 생기는데, 이곳으로 들어가서 `cmake`와 `make`를 한다.

```
% cmake
```

여기에서 `cmake`가 실패할 수 도 있는데, 이때 주로 뜨는 에러가 `X11`가 없어서 뜨는 에러이다.

```
% sudo apt install libx11-dev
% sudo apt install libxrandr-dev
% sudo apt install libxinerama-dev
% sudo apt install libxcursor-dev
% sudo apt install libxi-dev
% sudo apt install doxygen
```

를 해보면 된다.

```
% make
```

그런 다음에 `glfw/src/` 폴더로 들어가보면 `libglfw.a` 파일과 `include`폴더가 있다.

내가 만들 프로젝트를 다음과 같이 꾸몄다.

```
.
├── include
│   └── glfw3.h
└── lib
    └── libglfw3.a
```

이제 시험 파일을 만든 다음에 컴파일을 시도해본다.

```
// test.c
#include <iostream>
#include "glfw3.h"

int main(void) {
	GLFWwindow* window;

	if (!glfwInit())
		return -1;

	window = glfwCreateWindow(600, 600, "window", nullptr, nullptr);

	if (!window) {
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);

	while (!glfwWindowShouldClose(window)) {
		glClear(GL_COLOR_BUFFER_BIT);
		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glfwTerminate();
	return 0;
}
```

여기에서 `GL/gl.h`를 발견하지 못해서 컴파일이 안되는 경우가 있다.

```
g++ -o test test.c -I./include -L./lib -lglfw3
In file included from test.c:2:0:
./include/glfw3.h:210:12: fatal error: GL/gl.h: No such file or directory
   #include <GL/gl.h>
            ^~~~~~~~~
compilation terminated.
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 1
```

이런 경우에는 우선

```
% sudo apt-get install apt-file
```

하고 나서 `apt-file`을 사용해서 다음과 같은 검색을 한다.

```
% sudo apt-file search "gl.h"
```
그러면 많은 리스트들이 나올 것이다. 우리가 컴파일 할 때 나오는 에러는 `GL/gl.h`이므로 이에 해당하는 라이브러리를 찾으면 된다.

수많은 목록 중에
```
...
libwayland-dev: /usr/include/wayland-egl.h
libygl4-dev: /usr/include/X11/Yfgl.h
libygl4-dev: /usr/include/X11/Ygl.h
mesa-common-dev: /usr/include/GL/gl.h
mesa-common-dev: /usr/share/doc/mesa-common-dev/egl.html
mingw-w64-common: /usr/share/mingw-w64/include/GL/gl.h
mingw-w64-i686-dev: /usr/i686-w64-mingw32/include/GL/gl.h
...
```
와 같이 목록이 나온다. 여기에서 `mesa-common-dev`가 이것을 포함하고 있으므로 이것을 설치하자.

```
% sudo apt install mesa-common-dev
```

이것을 완료하게 되면 다음 단계로 넘어갈 수 있다.

```
g++ -I./include -L./lib -lglfw3 test.c -o out
/tmp/ccfoIJMZ.o: In function `main':
test.c:(.text+0x9): undefined reference to `glfwInit'
test.c:(.text+0x3d): undefined reference to `glfwCreateWindow'
test.c:(.text+0x4d): undefined reference to `glfwTerminate'
test.c:(.text+0x60): undefined reference to `glfwMakeContextCurrent'
test.c:(.text+0x6c): undefined reference to `glfwWindowShouldClose'
test.c:(.text+0x7f): undefined reference to `glClear'
test.c:(.text+0x8b): undefined reference to `glfwSwapBuffers'
test.c:(.text+0x90): undefined reference to `glfwPollEvents'
test.c:(.text+0x97): undefined reference to `glfwTerminate'
collect2: error: ld returned 1 exit status
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 1
```

오류가 뜬다. 함수들이 선언은 되어 있으나 정의가 되어있지 않아서 `ld`가 찾지 못했다는 것.

```
% nm libglfw3.a | grep glfwInit
00000000000008e9 T glfwInit
0000000000000a58 T glfwInitHint
0000000000000000 d _glfwInitHints
0000000000000000 T _glfwInitVulkan
                 U _glfwInitJoysticksLinux
                 U _glfwInitTimerPOSIX
                 U _glfwInitEGL
                 U _glfwInitGLX
                 U _glfwInitOSMesa
0000000000000000 T _glfwInitTimerPOSIX
0000000000000851 T _glfwInitGLX
00000000000008ee T _glfwInitEGL
000000000000021a T _glfwInitOSMesa
0000000000000a75 T _glfwInitJoysticksLinux
```

잘 나온다.

그런데 왜 안될까 그 이유는 `Makefile`을 잘못 만들었기 때문이다. `gcc` 나 `g++`은 순서가 종속성과 상관이 있기 때문에 순서를 지켜주어야 한다. 예를 들어 A가 B를 사용하면 A를 무조건 먼저 써야 한다. 그래서 다음을 

```
g++ -I./include -L./lib -lglfw3 test.c -o out
```

```
g++ -I./include -L./lib test.c -lglfw3 -o out
```

이렇게 써주어야지 `undefined reference`가 나오지 않게 된다. 즉 `gcc`가 은근 바보라서, 라이브러리를 링크해주면 라이브러리는 읽었다고 뜨지만 실제 그 안에 있는 함수는 읽지 않는 것이다.

그러면 오류 메세지가 없어지진 않고 조금 변한다.

```
gcc test.c -I./include -L./lib -lglfw3 -o out
./lib/libglfw3.a(monitor.c.o): In function `glfwSetGamma':
monitor.c:(.text+0x1138): undefined reference to `powf'
./lib/libglfw3.a(vulkan.c.o): In function `_glfwInitVulkan':
vulkan.c:(.text+0x42): undefined reference to `dlopen'
vulkan.c:(.text+0xa9): undefined reference to `dlsym'
./lib/libglfw3.a(vulkan.c.o): In function `_glfwTerminateVulkan':
vulkan.c:(.text+0x38e): undefined reference to `dlclose'
./lib/libglfw3.a(vulkan.c.o): In function `glfwGetInstanceProcAddress':
vulkan.c:(.text+0x73b): undefined reference to `dlsym'
./lib/libglfw3.a(x11_init.c.o): In function `initExtensions':
x11_init.c:(.text+0x1a45): undefined reference to `dlopen'
x11_init.c:(.text+0x1a8a): undefined reference to `dlsym'
x11_init.c:(.text+0x1ab8): undefined reference to `dlsym'
x11_init.c:(.text+0x1ae6): undefined reference to `dlsym'
x11_init.c:(.text+0x1b14): undefined reference to `dlsym'
x11_init.c:(.text+0x1b82): undefined reference to `dlopen'
x11_init.c:(.text+0x1bc7): undefined reference to `dlsym'
x11_init.c:(.text+0x1bf5): undefined reference to `dlsym'
x11_init.c:(.text+0x1cde): undefined reference to `dlopen'
x11_init.c:(.text+0x1d23): undefined reference to `dlsym'
x11_init.c:(.text+0x1d51): undefined reference to `dlsym'
x11_init.c:(.text+0x1d7f): undefined reference to `dlsym'
x11_init.c:(.text+0x1dad): undefined reference to `dlsym'
x11_init.c:(.text+0x1ddb): undefined reference to `dlsym'
./lib/libglfw3.a(x11_init.c.o):x11_init.c:(.text+0x1e09): more undefined references to `dlsym' follow
./lib/libglfw3.a(x11_init.c.o): In function `initExtensions':
x11_init.c:(.text+0x2249): undefined reference to `dlopen'
x11_init.c:(.text+0x228e): undefined reference to `dlsym'
x11_init.c:(.text+0x22bc): undefined reference to `dlsym'
x11_init.c:(.text+0x22ea): undefined reference to `dlsym'
x11_init.c:(.text+0x2318): undefined reference to `dlsym'
x11_init.c:(.text+0x2346): undefined reference to `dlsym'
./lib/libglfw3.a(x11_init.c.o):x11_init.c:(.text+0x2374): more undefined references to `dlsym' follow
./lib/libglfw3.a(x11_init.c.o): In function `initExtensions':
x11_init.c:(.text+0x2396): undefined reference to `dlopen'
x11_init.c:(.text+0x23db): undefined reference to `dlsym'
x11_init.c:(.text+0x2409): undefined reference to `dlsym'
x11_init.c:(.text+0x2437): undefined reference to `dlsym'
x11_init.c:(.text+0x2646): undefined reference to `dlopen'
x11_init.c:(.text+0x2687): undefined reference to `dlsym'
x11_init.c:(.text+0x26a9): undefined reference to `dlopen'
x11_init.c:(.text+0x26ee): undefined reference to `dlsym'
x11_init.c:(.text+0x271c): undefined reference to `dlsym'
x11_init.c:(.text+0x274a): undefined reference to `dlsym'
./lib/libglfw3.a(x11_init.c.o): In function `_glfwPlatformInit':
x11_init.c:(.text+0x368b): undefined reference to `dlopen'
x11_init.c:(.text+0x36ec): undefined reference to `dlsym'
x11_init.c:(.text+0x371a): undefined reference to `dlsym'
x11_init.c:(.text+0x3748): undefined reference to `dlsym'
x11_init.c:(.text+0x3776): undefined reference to `dlsym'
x11_init.c:(.text+0x37a4): undefined reference to `dlsym'
./lib/libglfw3.a(x11_init.c.o):x11_init.c:(.text+0x37d2): more undefined references to `dlsym' follow
./lib/libglfw3.a(x11_init.c.o): In function `_glfwPlatformTerminate':
x11_init.c:(.text+0x4c5c): undefined reference to `dlclose'
x11_init.c:(.text+0x4c97): undefined reference to `dlclose'
x11_init.c:(.text+0x4cd2): undefined reference to `dlclose'
x11_init.c:(.text+0x4d0d): undefined reference to `dlclose'
x11_init.c:(.text+0x4d48): undefined reference to `dlclose'
./lib/libglfw3.a(x11_init.c.o):x11_init.c:(.text+0x4d83): more undefined references to `dlclose' follow
./lib/libglfw3.a(x11_monitor.c.o): In function `calculateRefreshRate':
x11_monitor.c:(.text+0xd2): undefined reference to `round'
./lib/libglfw3.a(posix_thread.c.o): In function `_glfwPlatformCreateTls':
posix_thread.c:(.text+0x46): undefined reference to `pthread_key_create'
./lib/libglfw3.a(posix_thread.c.o): In function `_glfwPlatformDestroyTls':
posix_thread.c:(.text+0x9c): undefined reference to `pthread_key_delete'
./lib/libglfw3.a(posix_thread.c.o): In function `_glfwPlatformGetTls':
posix_thread.c:(.text+0xf9): undefined reference to `pthread_getspecific'
./lib/libglfw3.a(posix_thread.c.o): In function `_glfwPlatformSetTls':
posix_thread.c:(.text+0x14a): undefined reference to `pthread_setspecific'
./lib/libglfw3.a(glx_context.c.o): In function `getProcAddressGLX':
glx_context.c:(.text+0x7a0): undefined reference to `dlsym'
./lib/libglfw3.a(glx_context.c.o): In function `_glfwInitGLX':
glx_context.c:(.text+0x8bf): undefined reference to `dlopen'
glx_context.c:(.text+0x949): undefined reference to `dlsym'
glx_context.c:(.text+0x977): undefined reference to `dlsym'
glx_context.c:(.text+0x9a5): undefined reference to `dlsym'
glx_context.c:(.text+0x9d3): undefined reference to `dlsym'
glx_context.c:(.text+0xa01): undefined reference to `dlsym'
./lib/libglfw3.a(glx_context.c.o):glx_context.c:(.text+0xa2f): more undefined references to `dlsym' follow
./lib/libglfw3.a(glx_context.c.o): In function `_glfwTerminateGLX':
glx_context.c:(.text+0x10d5): undefined reference to `dlclose'
./lib/libglfw3.a(egl_context.c.o): In function `getProcAddressEGL':
egl_context.c:(.text+0x7d2): undefined reference to `dlsym'
./lib/libglfw3.a(egl_context.c.o): In function `destroyContextEGL':
egl_context.c:(.text+0x83c): undefined reference to `dlclose'
./lib/libglfw3.a(egl_context.c.o): In function `_glfwInitEGL':
egl_context.c:(.text+0x951): undefined reference to `dlopen'
egl_context.c:(.text+0xa0e): undefined reference to `dlsym'
egl_context.c:(.text+0xa3c): undefined reference to `dlsym'
egl_context.c:(.text+0xa6a): undefined reference to `dlsym'
egl_context.c:(.text+0xa98): undefined reference to `dlsym'
egl_context.c:(.text+0xac6): undefined reference to `dlsym'
./lib/libglfw3.a(egl_context.c.o):egl_context.c:(.text+0xaf4): more undefined references to `dlsym' follow
./lib/libglfw3.a(egl_context.c.o): In function `_glfwTerminateEGL':
egl_context.c:(.text+0x1063): undefined reference to `dlclose'
./lib/libglfw3.a(egl_context.c.o): In function `_glfwCreateContextEGL':
egl_context.c:(.text+0x1b9a): undefined reference to `dlopen'
./lib/libglfw3.a(osmesa_context.c.o): In function `_glfwInitOSMesa':
osmesa_context.c:(.text+0x288): undefined reference to `dlopen'
osmesa_context.c:(.text+0x312): undefined reference to `dlsym'
osmesa_context.c:(.text+0x340): undefined reference to `dlsym'
osmesa_context.c:(.text+0x36e): undefined reference to `dlsym'
osmesa_context.c:(.text+0x39c): undefined reference to `dlsym'
osmesa_context.c:(.text+0x3ca): undefined reference to `dlsym'
./lib/libglfw3.a(osmesa_context.c.o):osmesa_context.c:(.text+0x3f8): more undefined references to `dlsym' follow
./lib/libglfw3.a(osmesa_context.c.o): In function `_glfwTerminateOSMesa':
osmesa_context.c:(.text+0x513): undefined reference to `dlclose'
collect2: error: ld returned 1 exit status
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 1
```

뭐가 없다고 엄청 뜬다. 이제 한씩 찾아서 필요한 라이브러리를 링크해주어야 한다. 먼저

`powf` 함수를 찾아보자. 터미널에 다음을 치면

```
man powf
```

우리 맨이 아주 친절하게 알려준다.

```
POW(3)                                      Linux Programmer's Manual                                     POW(3)

NAME
       pow, powf, powl - power functions

SYNOPSIS
       #include <math.h>

       double pow(double x, double y);
       float powf(float x, float y);
       long double powl(long double x, long double y);

       Link with -lm.

```

마지막 라인에 -lm이라고 써있는 것이 보일 것이다. 따라서 이것을 사용하면 된다.


`dlopen` 함수를 찾아보자. 이 역시 우리맨이 잘 찾아준다. `-ldl`을 링크하면 된다.

'pthread_key_create' 는 `lpthread`에 있다. 그래서 최종적으로 다음과 같이 컴파일 하자.

```
gcc test.c -I./include -L./lib -lglfw3 -lm -ldl -lpthread -o out
```

그런데도 다음 에러 메세지가 난다. 

```
gcc test.c -I./include -L./lib -lglfw3 -lm -ldl -lpthread -o out
/tmp/ccqSEoG4.o: In function `main':
test.c:(.text+0x64): undefined reference to `glClear'
collect2: error: ld returned 1 exit status
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 1
```

`glClear`를 못찾겠다는 것. 좀 찾아봤더니 `-lGL`에 있다는 것을 알게 되었다. 그것도 추가.

최종적으로 

```
gcc test.c -I./include -L./lib -lglfw3 -lm -ldl -lpthread -lGL -o out
```

이 되었다. 최종적으로 빌드가 되었고, 드디어 화면에 띄울 수 있게 되었다.

만약 `-lGL`을 찾지 못하겠다고 하면 `libgl1-mesa-dev' 를 설치해보자.

```
% sudo apt install libgl1-mesa-dev
```
