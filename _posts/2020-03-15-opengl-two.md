---
layout: post
title: opengl two
categories: [opengl]
---

내가 우선적으로 구현하고 싶은 것은 다음과 같다.

적당한 쉐이더가 구현되어 있는 엔진에, 특정 키들을 사용해서 그 환경을 둘러볼 수 있고, 내가 원하는 모델을 띄울 수 있는 프로그램

그러기 위해선 많은 문제들을 해결해야 한다.

1. 우선 화면에 삼각형을 그릴 줄 알아야 한다.
2. `perspective`를 적용시키는 방법
3. 키들을 사용해서 이 `perspective`를 변경하는 방법
4. 원하는 모델을 가지고 와서 해석하고 이를 자동으로 그리게 만드는 방법

우선 1 번 부터 해결하자. 화면에 삼각형부터 그릴 줄 알아야 한다.

잘 모르지만 [learnopengl](learnopengl.com)에 나온 대로 우선 써 보았다. 코드는 다음과 같다.

```
#include <iostream>
#include "glfw3.h"


const char *vertexShaderSource = "#version 330 core\n"
    "layout (location = 0) in vec3 aPos;\n"
    "void main()\n"
    "{\n"
    "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
    "}\0";
const char *fragmentShaderSource = "#version 330 core\n"
    "out vec4 FragColor;\n"
    "void main()\n"
    "{\n"
    "   FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n"
    "}\n\0";


int main(void) {
	GLFWwindow* window;

	if (!glfwInit()) {
		return -1;
	}

	window = glfwCreateWindow(640, 480, "Hello world", NULL, NULL);
	if (!window) {
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);




	int vertexShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
	glCompileShader(vertexShader);

	int success;
	char infolog[512];
	glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfoLog(vertexShader, 512, NULL, infolog);
		std::cout << infolog << std::endl;
	}


	int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
	glCompileShader(fragmentShader);

	glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
	if (!success) {
		glGetShaderInfolog(fragmentShader, 512, NULL, infolog);
		std::cout << infolog << std::endl;
	}

	
	int shaderProgram = glCreateProgram();
	glAttachShader(shaderProgram, vertexShader);
	glAttachShader(shaderProgram, fragmentShader);
	glLinkeProgram(shaderProgram);

	glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
	if (!success) {
		glGetProgramInfolog(shaderProgram, 512, NULL, infolog);
		std::cout << infolog << std::endl;
	}

	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShader);


	


	float vertices[] = {
		0.5f, 0.5f, 0.0f,
		0.5f, -0.5f, 0.0f,
		-0.5f, -0.5f, 0.0f,
		-0.5f, 0.5f, 0.0f,
	};

	int indices[] = {
		0, 1, 3,
		1, 2, 3
	};

	unsigned int VBO, VAO, EBO;

	glGenVertexArrays(1, &VAO);
	glGenBuffers(1, &VBO);
	glGenBuffers(1, &EBO);

	glBindVertexArray(VAO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glBindVertexArray(0);





	while (!glfwWindowShouldClose(window)) {

		/* background of opengl */
		glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);

		/* program */
		glUseProgram(shaderProgram);
		glBindVertexArray(VAO);
		glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
		

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glDeleteVertexArrays(1, &VAO);
	glDeleteBuffers(1, &VBO);
	glDeleteBuffers(1, &EBO);


	glfwTerminate();

	return 0;
}
```

돌려봤는데 다음과 같이 나온다.

```
g++ -o test test.c -I./include -L./lib -lglfw3 -lm -ldl -lpthread -lGL
test.c: In function ‘int main()’:
test.c:37:21: error: ‘glCreateShader’ was not declared in this scope
  int vertexShader = glCreateShader(GL_VERTEX_SHADER);
                     ^~~~~~~~~~~~~~
test.c:37:21: note: suggested alternative: ‘vertexShader’
  int vertexShader = glCreateShader(GL_VERTEX_SHADER);
                     ^~~~~~~~~~~~~~
                     vertexShader
test.c:38:2: error: ‘glShaderSource’ was not declared in this scope
  glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
  ^~~~~~~~~~~~~~
test.c:38:2: note: suggested alternative: ‘vertexShaderSource’
  glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
  ^~~~~~~~~~~~~~
  vertexShaderSource
test.c:39:2: error: ‘glCompileShader’ was not declared in this scope
  glCompileShader(vertexShader);
  ^~~~~~~~~~~~~~~
test.c:43:2: error: ‘glGetShaderiv’ was not declared in this scope
  glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
  ^~~~~~~~~~~~~
test.c:43:2: note: suggested alternative: ‘glGetMapiv’
  glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
  ^~~~~~~~~~~~~
  glGetMapiv
test.c:45:3: error: ‘glGetShaderInfoLog’ was not declared in this scope
   glGetShaderInfoLog(vertexShader, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~
test.c:45:3: note: suggested alternative: ‘glGetString’
   glGetShaderInfoLog(vertexShader, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~
   glGetString
test.c:56:3: error: ‘glGetShaderInfolog’ was not declared in this scope
   glGetShaderInfolog(fragmentShader, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~
test.c:56:3: note: suggested alternative: ‘glGetMaterialiv’
   glGetShaderInfolog(fragmentShader, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~
   glGetMaterialiv
test.c:61:22: error: ‘glCreateProgram’ was not declared in this scope
  int shaderProgram = glCreateProgram();
                      ^~~~~~~~~~~~~~~
test.c:61:22: note: suggested alternative: ‘shaderProgram’
  int shaderProgram = glCreateProgram();
                      ^~~~~~~~~~~~~~~
                      shaderProgram
test.c:62:2: error: ‘glAttachShader’ was not declared in this scope
  glAttachShader(shaderProgram, vertexShader);
  ^~~~~~~~~~~~~~
test.c:62:2: note: suggested alternative: ‘vertexShader’
  glAttachShader(shaderProgram, vertexShader);
  ^~~~~~~~~~~~~~
  vertexShader
test.c:64:2: error: ‘glLinkeProgram’ was not declared in this scope
  glLinkeProgram(shaderProgram);
  ^~~~~~~~~~~~~~
test.c:64:2: note: suggested alternative: ‘glHistogram’
  glLinkeProgram(shaderProgram);
  ^~~~~~~~~~~~~~
  glHistogram
test.c:66:2: error: ‘glGetProgramiv’ was not declared in this scope
  glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
  ^~~~~~~~~~~~~~
test.c:66:2: note: suggested alternative: ‘glGetHistogram’
  glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
  ^~~~~~~~~~~~~~
  glGetHistogram
test.c:68:3: error: ‘glGetProgramInfolog’ was not declared in this scope
   glGetProgramInfolog(shaderProgram, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~~
test.c:72:2: error: ‘glDeleteShader’ was not declared in this scope
  glDeleteShader(vertexShader);
  ^~~~~~~~~~~~~~
test.c:72:2: note: suggested alternative: ‘vertexShader’
  glDeleteShader(vertexShader);
  ^~~~~~~~~~~~~~
  vertexShader
test.c:93:2: error: ‘glGenVertexArrays’ was not declared in this scope
  glGenVertexArrays(1, &VAO);
  ^~~~~~~~~~~~~~~~~
test.c:93:2: note: suggested alternative: ‘glGenTextures’
  glGenVertexArrays(1, &VAO);
  ^~~~~~~~~~~~~~~~~
  glGenTextures
test.c:94:2: error: ‘glGenBuffers’ was not declared in this scope
  glGenBuffers(1, &VBO);
  ^~~~~~~~~~~~
test.c:94:2: note: suggested alternative: ‘glReadBuffer’
  glGenBuffers(1, &VBO);
  ^~~~~~~~~~~~
  glReadBuffer
test.c:97:2: error: ‘glBindVertexArray’ was not declared in this scope
  glBindVertexArray(VAO);
  ^~~~~~~~~~~~~~~~~
test.c:97:2: note: suggested alternative: ‘glBindTexture’
  glBindVertexArray(VAO);
  ^~~~~~~~~~~~~~~~~
  glBindTexture
test.c:99:2: error: ‘glBindBuffer’ was not declared in this scope
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  ^~~~~~~~~~~~
test.c:99:2: note: suggested alternative: ‘glReadBuffer’
  glBindBuffer(GL_ARRAY_BUFFER, VBO);
  ^~~~~~~~~~~~
  glReadBuffer
test.c:100:2: error: ‘glBufferData’ was not declared in this scope
  glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
  ^~~~~~~~~~~~
test.c:105:2: error: ‘glVertexAttribPointer’ was not declared in this scope
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
  ^~~~~~~~~~~~~~~~~~~~~
test.c:105:2: note: suggested alternative: ‘glVertexPointer’
  glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
  ^~~~~~~~~~~~~~~~~~~~~
  glVertexPointer
test.c:106:2: error: ‘glEnableVertexAttribArray’ was not declared in this scope
  glEnableVertexAttribArray(0);
  ^~~~~~~~~~~~~~~~~~~~~~~~~
test.c:123:3: error: ‘glUseProgram’ was not declared in this scope
   glUseProgram(shaderProgram);
   ^~~~~~~~~~~~
test.c:123:3: note: suggested alternative: ‘shaderProgram’
   glUseProgram(shaderProgram);
   ^~~~~~~~~~~~
   shaderProgram
test.c:132:2: error: ‘glDeleteVertexArrays’ was not declared in this scope
  glDeleteVertexArrays(1, &VAO);
  ^~~~~~~~~~~~~~~~~~~~
test.c:132:2: note: suggested alternative: ‘glDeleteTextures’
  glDeleteVertexArrays(1, &VAO);
  ^~~~~~~~~~~~~~~~~~~~
  glDeleteTextures
test.c:133:2: error: ‘glDeleteBuffers’ was not declared in this scope
  glDeleteBuffers(1, &VBO);
  ^~~~~~~~~~~~~~~
test.c:133:2: note: suggested alternative: ‘glSelectBuffer’
  glDeleteBuffers(1, &VBO);
  ^~~~~~~~~~~~~~~
  glSelectBuffer
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 1
```

뭐가 없다고 많이 뜬다. 그래서 가장 첫 번째 함수인 `glCreateShader`함수를 찾아보기로 했다. 그래서 opengl 헤더 파일인 `gl.h`를 찾아보기로 했다.

우선 다음 명령어로 이 파일을 찾았다.

```
sudo find / -name "gl.h"
```

그래서 들어가봤는데, 역시나 `glCreateShader`는 선언되어 있지 않았다. 아마 이 함수들은 opengl 3.x 이후 버전에 추가된 함수들이기 때문에, 이를 위한 확장 파일을 읽혀야 하는 것 같았다. 찾아보니 `glad` 또는 `glew`등을 설치하라고 한다. `glew`는 이제 더 이상 업데이트가 되지 않기 때문에, `gl3w`라는 것을 사용해보기로 했다.

```
git clone https://github.com/skaslev/gl3w.git
```

이렇게 하면 `gl3w` 폴더가 생성된다. 그럼 안에 python script `gl3w_gen.py`라는 파일이 존재하는데, 이를 다음과 같이 돌리면 된다.

```
> python3 gl3w_gen.py
Downloading include/GL/glcorearb.h...
Downloading include/KHR/khrplatform.h...
Parsing glcorearb.h header...
Generating include/GL/gl3w.h...
Generating src/gl3w.c...
```

그렇게 하면 `include` 폴더 및 `src` 폴더 등등이 생긴다. `README`를 참고해서 프로젝트에 추가한다. `include` 폴더에는 헤더 파일들이 생성이 되었다. 그런데 `c` 소스 파일들은 어떻게 추가하는 것일까? 이것도 역시 오브젝트 파일로 만들어서 넣어야 하는것인가? 뭔지 몰라서 헤더 파일만 먼저 추가해보았다.

그리고 또한 소스 파일에도 `gl3w` 관련 함수들을 추가했다.

```
#include <iostream>
#include "GL/gl3w.h"
#include "glfw3.h"


const char *vertexShaderSource = "#version 330 core\n"
    "layout (location = 0) in vec3 aPos;\n"
    "void main()\n"
    "{\n"
    "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
    "}\0";
const char *fragmentShaderSource = "#version 330 core\n"
    "out vec4 FragColor;\n"
    "void main()\n"
    "{\n"
    "   FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n"
    "}\n\0";


int main(void) {
	GLFWwindow* window;

	if (!glfwInit()) {
		std::cout << "glfw init failed" << std::endl;
		return -1;
	}

	window = glfwCreateWindow(640, 480, "Hello world", NULL, NULL);
	if (!window) {
		std::cout << "glfw window creation failed" << std::endl;
		glfwTerminate();
		return -1;
	}

	glfwMakeContextCurrent(window);

	if (gl3wInit()) {
		std::cout << "gl3w init failed" << std::endl;
		glfwTerminate();
		return -1;
	}




	int vertexShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
	glCompileShader(vertexShader);

	int success;
	char infolog[512];
	glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
	if (!success) {
		std::cout << "shader compile error" << std::endl;
		std::cout << infolog << std::endl;
	}


	int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
	glCompileShader(fragmentShader);

	glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
	if (!success) {
		std::cout << "shader compile error" << std::endl;
	}

	
	int shaderProgram = glCreateProgram();
	glAttachShader(shaderProgram, vertexShader);
	glAttachShader(shaderProgram, fragmentShader);
	glLinkProgram(shaderProgram);

	glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
	if (!success) {
		std::cout << "program error" << std::endl;
	}

	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShader);


	


	float vertices[] = {
		0.5f, 0.5f, 0.0f,
		0.5f, -0.5f, 0.0f,
		-0.5f, -0.5f, 0.0f,
		-0.5f, 0.5f, 0.0f,
	};

	int indices[] = {
		0, 1, 3,
		1, 2, 3
	};

	unsigned int VBO, VAO, EBO;

	glGenVertexArrays(1, &VAO);
	glGenBuffers(1, &VBO);
	glGenBuffers(1, &EBO);

	glBindVertexArray(VAO);

	glBindBuffer(GL_ARRAY_BUFFER, VBO);
	glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

	glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);

	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
	glEnableVertexAttribArray(0);

	glBindBuffer(GL_ARRAY_BUFFER, 0);

	glBindVertexArray(0);





	while (!glfwWindowShouldClose(window)) {

		/* background of opengl */
		glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT);

		/* program */
		glUseProgram(shaderProgram);
		glBindVertexArray(VAO);
		glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
		

		glfwSwapBuffers(window);
		glfwPollEvents();
	}

	glDeleteVertexArrays(1, &VAO);
	glDeleteBuffers(1, &VBO);
	glDeleteBuffers(1, &EBO);


	glfwTerminate();

	return 0;
}
```

그랬더니 다음과 같이 나왔다.

```
g++ -o test test.c -I./include -L./lib -lglfw3 -lm -ldl -lpthread -lGL
test.c: In function ‘int main()’:
test.c:62:3: error: ‘glGetShaderInfolog’ was not declared in this scope
   glGetShaderInfolog(fragmentShader, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~
test.c:62:3: note: suggested alternative: ‘glGetShaderInfoLog’
   glGetShaderInfolog(fragmentShader, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~
   glGetShaderInfoLog
test.c:70:2: error: ‘glLinkeProgram’ was not declared in this scope
  glLinkeProgram(shaderProgram);
  ^~~~~~~~~~~~~~
test.c:70:2: note: suggested alternative: ‘glLinkProgram’
  glLinkeProgram(shaderProgram);
  ^~~~~~~~~~~~~~
  glLinkProgram
test.c:74:3: error: ‘glGetProgramInfolog’ was not declared in this scope
   glGetProgramInfolog(shaderProgram, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~~
test.c:74:3: note: suggested alternative: ‘glGetProgramInfoLog’
   glGetProgramInfolog(shaderProgram, 512, NULL, infolog);
   ^~~~~~~~~~~~~~~~~~~
   glGetProgramInfoLog
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 1
```

많이 줄었다. 오타도 보여서 바꾸었더니 결국 못 찾은 함수는 `glGetXXXInfolog` 같은 함수들이었다. 아무래도 `gl3w`가 필수적인 요소들만 넣은 라이브러리라서 그런 것 같다.

뭐 예상한 일이지만 다음과 같이 `undefined reference`가 많이 뜬다.


```
g++ -o test test.c -I./include -L./lib -lglfw3 -lm -ldl -lpthread -lGL
/tmp/cchJu0Xz.o: In function `main':
test.c:(.text+0x83): undefined reference to `gl3wInit'
test.c:(.text+0xa2): undefined reference to `gl3wProcs'
test.c:(.text+0xb6): undefined reference to `gl3wProcs'
test.c:(.text+0xd6): undefined reference to `gl3wProcs'
test.c:(.text+0xe7): undefined reference to `gl3wProcs'
test.c:(.text+0x161): undefined reference to `gl3wProcs'
/tmp/cchJu0Xz.o:test.c:(.text+0x175): more undefined references to `gl3wProcs' follow
collect2: error: ld returned 1 exit status
Makefile:2: recipe for target 'all' failed
make: *** [all] Error 1
```

결국 .c 파일들을 링크해주어야 하는 것이다.

다음과 같이 프로젝트 디렉토리를 만들어준 다음에,

```
.
├── include
│   ├── GL
│   │   ├── gl3w.h
│   │   └── glcorearb.h
│   ├── glfw3.h
│   └── KHR
│       └── khrplatform.h
├── lib
│   └── libglfw3.a
├── Makefile
├── src
│   ├── gl3w.c
│   ├── glfw_test.c
│   └── glut_test.c
├── test
└── test.c
```

여기에서 `Makefile`을 다음과 같이 수정했다.


```
all:
	g++ -o test test.c ./src/gl3w.c -I./include -L./lib -lglfw3 -lm -ldl -lpthread -lGL
clean:
	rm test
```

그렇게 했더니 컴파일이 완료됐다! 그런데 실행하니 화면이 안 켜지고 그냥 꺼진다.

이유는 알고 보니 `gl3wInit() 함수가 잘못 설정되었을 때 0이 아닌 수를 반환한다는 것이었다. 따라서 다음과 같은 조건문을 수정했다.

```
if (!gl3wInit()) { ...
```
를
```
if (gl3wInit()) { ...
```
로 바꾸었다.

그랬더니 화면이 잘 떴다. 그런데 다음과 같은 에러가 또 뜬다.

```
shader compile error

shader compile error
program error
```

위와 같은 아웃풋들은 모두 쉐이더를 만드는 상황에서 실패했다는 것이다.

`glGetShaderiv` 함수를 살펴보니, 넣는 파라미터값(여기에서는 `success`)가 성공하면 `GL_TRUE` 아니면 `GL_FALSE`를 반환한다고 했다. 그래서 코드를 다음과 같이 고쳐 보았다.

```
if (success == GL_FALSE) { ...
```

그랬는데도 모두 오류가 뜬다고 나온다. 그런데 내가 그리고 싶은 것은 제대로 나온다.

그리고 다시 살펴보니까 `glGetShaderInfoLog` 함수와 `glGetProgramInfoLog` 함수 모두 `gl3w.c` 함수에 존재했다. 그래서 다시 추가하고, 이를 사용해서 무엇이 문제인지를 체크해봤다. 새로 쓰여진 소스 코드는 다음과 같다. 

```
	int vertexShader = glCreateShader(GL_VERTEX_SHADER);
	glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
	glCompileShader(vertexShader);

	int success;
	char infolog[512];
	glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
	if (success == GL_FALSE) {
		glGetShaderInfoLog(vertexShader, 512, NULL, infolog);
		std::cout << "ERROR::SHADER::VERTEX\n" << infolog << std::endl;
	}


	int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
	glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
	glCompileShader(fragmentShader);

	glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
	if (success == GL_FALSE) {
		glGetShaderInfoLog(fragmentShader, 512, NULL, infolog);
		std::cout << "ERROR::SHADER::FRAGMENT\n" << infolog << std::endl;
	}

	
	int shaderProgram = glCreateProgram();
	glAttachShader(shaderProgram, vertexShader);
	glAttachShader(shaderProgram, fragmentShader);
	glLinkProgram(shaderProgram);

	glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
	if (success == GL_FALSE) {
		glGetProgramInfoLog(shaderProgram, 512, NULL, infolog);
		std::cout << "ERROR::PROGRAM\n" << infolog << std::endl;
	}

	glDeleteShader(vertexShader);
	glDeleteShader(fragmentShader);

```

이제 이것을 돌려보았더니 다음과 같은 아웃풋을 받았다.

```
ERROR::SHADER::VERTEX
0:1(10): error: GLSL 3.30 is not supported. Supported versions are: 1.10, 1.20, 1.30, 1.00 ES, 3.00 ES, 3.10 ES, and 3.20 ES

ERROR::SHADER::FRAGMENT
0:1(10): error: GLSL 3.30 is not supported. Supported versions are: 1.10, 1.20, 1.30, 1.00 ES, 3.00 ES, 3.10 ES, and 3.20 ES

ERROR::PROGRAM
error: linking with uncompiled/unspecialized shadererror: linking with uncompiled/unspecialized shader
```

결국 버전이 안 맞는다고 하는 것이기 때문에 다음과 같은 부분을 추가하여 opengl 버전을 설정했다. 

```
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
```

그랬더니 오류가 사라졌다.


이제 코드를 조금씩 공부해본다.

가장 먼저 extension library를 추가해야 한다. `glfw` 보다 먼저 넣어야 한다.
`glfw` documentation 에 다음과 같은 말이 있다.

> On some platforms supported by GLFW the OpenGL header and link library only expose older versions of OpenGL. The most extreme case is Windows, which only exposes OpenGL 1.2. The easiest way to work around this is to use an extension loader library. If you are using such a library then you should include its header before the GLFW header. This lets it replace the OpenGL header included by GLFW without conflicts.

즉 `glad`나 `gl3w`등과 같은 `extension library`는 `opengl`을 확장하게 도와주는데, 만약 `glfw`를 먼저 추가하게 되면 `opengl`을 먼저 추가되고 그 뒤에 다시 `opengl`을 추가하기 때문에 충돌이 일어나게 된다. `glfw`에서 `extension library`가 존재하면 `opengl`을 따로 추가하지 않는 것이다.

```
#include "GL/gl3w.h"
#include "glfw3.h"
```

처음 해야 하는 것은 `glfw`를 초기화 시키는 것이다.

```
	if (!glfwInit()) {
		std::cout << "glfw init failed" << std::endl;
		return -1;
	}
```

만약 초기화 설정이 실패할 경우에 `glfwTerminate`를 호출하고 돌아오기 때문에 실패하면 따로 불러줄 필요는 없다. 그것이 아니라면 프로그램이 끝나기 전에 `glfwTerminate`를 호출해야 한다.

만약 성공하면 `GLFW_TRUE`를 호출하고, 그렇지 않다면 `GLFW_FALSE`를 호출한다. 따라서 다음과 같이 쓰면 더 깔끔하다고 할 수 있다.


```
	if (glfwInit() == GLFW_FALSE) {
		std::cout << "glfw init failed" << std::endl;
		return 1;
	}
```

프로그램이 1을 반환하면 실패해서 반환하는 것이기 때문에 `return 1`을 해준다.

다음으로 볼 것은 `glfwWindowHint`이다. 여기에서 먼저 `opengl`과 `opengl es`를 비교하고 넘어가야 할 때이다. `opengl`은 전통적으로 사용하던 `glBegin` 과 `glEnd` 등을 쓰지만, `opengl es`는 `vertex buffer`를 사용한다.

`glfwWindowHint`는 처음 부분에 힌트의 종류, 그리고 두 번째는 힌트 그 자체를 가져간다.

우리가 여기에서 주는 힌트는 `GLFW_CONTEXT_VERSION_MAJOR`, `GLFW_CONTEXT_VERSION_MINOR` 등의 힌트이다. `opengl` 의 버젼은  4.6까지 나왔기 때문에 major를 4, minor를 6까지 설정할 수 있다. 지원되지 않는 버전을 사용하면 `window`를 생성할 때 에러가 난다. 


이제 할 것은 창 인스턴스를 만드는 것이다. 다음과 같은 함수를 사용하면 된다.

```
glfwCreateWidnow(int width, int height, const char* title, GLFWmonitor* monitor, GLFWwindow* share);
```

여기에서 뒤의 `monitor`와 `share`는 우선 신경쓰지 않아도 되므로, `NULL`로 해놓자.

위의 함수가 호출에 실패하게 되면, 반환 값은 없다.

다음에는 `opengl context`를 만들어주는 것이다. 다음과 같은 함수를 호출해주면 된다.

```
glfwMakeContextCurrent(window);
```

여기에서 `window` 객체를 매개변수로 던져 주어야 한다.

그 다음에 할 것은 opengl extension 라이브러리를 초기화시키는 것이다. 

```
gl3wInit()
```

여기에서 주의해야 할 것은 초기화가 성공하면 위의 함수들과는 달리 0을 반환한다는 것이다. 따라서 1이 나오는 경우에 glfw를 종료하고 프로그램을 종료해야 한다.

이제 모델을 만들어주기 전에, 이 모델이 사용할 shader를 만들어야 한다. shader를 만드는 방법은 다음과 같다.

```
GLuint glCreateShader(	GLenum shaderType);
```

이 함수는 매개변수로 `GL_VERTEX_SHADER`, `GL_GEOMETRY_SHADER`, `GL_FRAGMENT_SHADER` 등이 존재한다. 우리는 현재 `GL_VERTEX_SHADER`를 만드는 중이기 때문에 이를 매개변수로 던진다.

그리고 나서 받는 정수값은 이 셰이더의 아이디라고 할 수 있다.
이 아이디를 사용해서 우리가 작성한 셰이더를 직접 연결해주어야 한다. 셰이더는 나중에 알기로 하고, 다음과 같은 문자열을 미리 정의해 놓는다.

```
const char *vertexShaderSource = "#version 330 core\n"
    "layout (location = 0) in vec3 aPos;\n"
    "void main()\n"
    "{\n"
    "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
    "}\0";
```

이 소스를 다음과 같은 함수를 사용해서 연결시켜준다.

```
void glShaderSource(	GLuint shader,
 	GLsizei count,
 	const GLchar **string,
 	const GLint *length);
```

가장 먼저 가져가는 것은 아까 받은 아이디이고, 두번째는 셰이더의 개수이다. 우리의 경우에는 그냥 1일 넣으면 된다. 그 다음은 이 셰이더의 길이인데, 이 길이는 `NULL`로 넣을 수 있다.

이렇게 하면 우리가 작성한 셰이더가 우리가 생성한 셰이더 아이디와 연결이 된다.

다음은 그 셰이더를 컴파일을 해서 GPU가 이해할 수 있는 바이너리로 만들어주는 과정이다.

```
void glCompileShader(GLuint shader);
```

이 과정을 거치고 나서는 다음과 같이 그 셰이더가 제대로 만들어졌는지를 체크해야 한다.

```
void glGetShaderiv(	GLuint shader,
 	GLenum pname,
 	GLint *params);
```
여기에서 맨 처음은 셰이더의 아이디를 넣어주면 되고, 다음은 어떤 사항을 체크하고 싶은지를 쓰면 된다. 다음에는 매개변수의 주소를 달라고 하는데, 이 변수에다가 체크해달라고 한 사항의 성공 여부를 넣어주게 된다. enum으로 정의되어 있기는 한데, 이 값이 `GL_FALSE`이면 실패한 것이고, `GL_TRUE`이면 성공한 것이다.

만약 실패한 경우에 다음과 같은 함수를 사용해서 체크해주면 된다.

```
void glGetShaderInfoLog(	GLuint shader,
 	GLsizei maxLength,
 	GLsizei *length,
 	GLchar *infoLog);
```

이 함수는 처음에 아이디를 가져가고, 오류 정보를 저장할 배열을 만들고, 그 배열의 길이를 먼저 넣고, length는 널로 만들면 된다. 그 다음에는 우리가 저장할 그 메시지를 넣으면 된다.

이것을 `fragmentShader`에도 똑같이 한다. 이것들을 완료하면 이것들을 묶어서 program으로 만든다.

이때 사용하는 것은

```
GLuint glCreateProgram(void)
```

등이다. 여기에서는 어떤 매개변수도 주지 않는다. 우리가 만든 셰이더들을 이곳에 붙이는 작업을 한다. 

```
void glAttachShader(GLuint program, GLuint shader);
```

위 함수를 사용해서 두 셰이더를 만들어서 부착을 한다.

그리고 프로그램도 마찬가지로 다음 함수들을 사용해서 제대로 컴파일이 되었는지 체크한다.


```
glGetProgramiv, glGetProgramInfoLog
```
를 사용한다. 

그리고 나서는 프로그램을 만들었기 때문에 셰이더들을 삭제해도 된다.
```
glDeleteShader(shader)
```


