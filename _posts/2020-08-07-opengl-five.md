---
layout: post
title: opengl five
categories: []
---

저번 시간에 이어서 `OpenGL`이 원격 서버에서 돌리는 것은 버전의 한계에 맞는 다는 것을 말했었다. 그러나 조금 더 찾아보니, `ssh -X`를 사용해서 원격 접속 후에 `x windows`를 실행시키는 것은 그래픽 프로그램의 명령을 `ssh`로 전달받아서, 이를 로컬 `X window server` 에서 `GLX`라는 것을 통해, 로컬 그래픽 명령어로 바꾸어주는 형태였다. 즉,,, 프로그램만 원격 서버에 있고, 모든 렌더링 작업을 로컬에서 하는 것이었다. 이것은 전혀 내가 원한 것이 아니었다. 처음에 이 `ssh -X`의 성능을 살펴보았을 때(`OpenGL`은 안됐고, 다른 `evince`같은 `pdf` 뷰어를 실행해봤다) 성능이 매우 안 좋았기 때문에 이 사실을 알고 나서 나는 매우 기뻐했다. 또한 `OpenGL`의 명령어를 변환해주는 `GLX` 명령어가 2.x 버전까지밖에 지원을 안 한다고 해서 실망을 했었는데, 찾아보니 내가 전혀 필요 없는 기능이었던 것이었다. 이것에 매우 기뻐하면서 원격 서버에서 렌더링을 하고, 그 결과를 전송받기만 하는 방법을 찾기 시작했다.

다양한 곳에서 다양한 답변을 얻을 수 있었는데, 대표적으로 보였던 것이 `Xpra`, `VirtualGL`, `Chromium`이었다. 나는 큰 이유 없이 가장 먼저 찾게 된 `Xpra`를 시도해보았다. 나머지 두개는 실행시켜보지도 않았다. 우선 `Xpra`의 홈페이지로 가보았다. 그곳에서 설치하는 방법을 알려주었는데, 리눅스 초보인 나로써는 매우 어려웠다.

그래서 `Xpra`를 설치하려고 한다. 우선 서버와 클라이언트 모두 설치해야 하기 때문에, 맥에 우선 설치를 시도했다. `dmg`와 `pkg`가 있었는데, `dmg`는 설치 할 때 프로그램에 손상이 되어 있다면서 설치가 안되었다. 그래서 `pkg`로 설치했더니 설치에 성공하였다. 이제 리눅스에 설치를 시도한다.

리눅스 설치는 생각보다 복잡했다. 우선 첫 번째로, 그들의 프로그램 다운로드 서버에 접속하기 위해서는 키가 필요하다고 한다. 그래서 키를 `curl`을 사용해서 설치한다. 그런데 설치를 할 때 `root` 권한으로 실행해야 했다. 잘 모르지만 `sudo` 를 붙이는 것만으로는 불가능했다. 따라서 `Sudo su -` 명령을 통해서 `root` 권한으로 실행해야 했다. 

```
sudo su -
apt-get install curl
curl https://winswitch.org/gpg.asc | apt-key -
echo "deb http://winswitch.org/ focal main" > /etc/apt/sources.list.d/winswitch.list
apt-get update
apt-get install xpra
```

자세한 이야기는 [xpra homepage](https://xpra.org/)에서 찾아볼 수 있다. 조금 복잡하지만 설치하는데에 성공했다. 이제는 구동을 시켜보아야 한다. 우선 리눅스 서버에서 이 `Xpra`를 실행시켜보기로 했다. 명령어가 너무 다양해서 헤멨지만, 그래도 간단한 명령어 몇개는 알 수 있게 되었다. 

```
xpra start --start=<path-to-your-program>
```

위의 명령어가 바로 특정 프로그램을 `Xpra` 서버로 변환시키는 것이다. 이렇게 되면 알아서 `detach`가 된다. 아래의 예는 나의 `./test` 프로그램을 실행시킨 예이다.

```
% xpra start --start=./test
Entering daemon mode; any further errors will be reported to:
  /run/user/1000/xpra/S19435.log
% Actual display used: :1
Actual log file name is now: /run/user/1000/xpra/:1.log
%
```

위와 같이 `Actual display used: :1` 이라고 나오는데, 이 디스플레이 번호를 잘 알아두어야 한다. 이렇게 실행을 시키고 나면, `local`에서 접속을 시도해야 한다. `mac`에서의 `Xpra` 인터페이스는 다음과 같이 생겼다.

![](https://lh3.googleusercontent.com/p2cOwlPOWMywgtctuPbLPf2d5U8RFHtuyMSzmrJQ3MUKro4abAKnfagPXi8n63Jl7fs6zduzv8Tt6SQ9b_4o95Dyc_PVtiWVv9f64PkrdZ8eyJA_OOWmUk9vzQScHEItJSt5ZmRDGw=w2400)

여기에서 `connect`를 선택하면 다음과 같은 창이 뜬다.

![](https://lh3.googleusercontent.com/Acq4iUsjtf02mPOaFfv4tv9HxIpqKpLKR3nj1M1nQ0tnxLvXNYCqaJ1iP0JSUqJdm7SqUhovAPOmFC5kyuIvNOLnf_a06EIIH_zb4YRHoFvuwNDYb8mjxavhXgBY7auOkbo7za4HKw=w2400)

여기에서 `ssh`를 선택하고, 아이디와 아이피와 포트 넘버를 순서대로 적고 마지막 칸에는 아까 봤던 디스플레이 번호를 적는다. 그리고 연결을 누르면, 다음과 같이 우리의 `OpenGL` 프로젝트가 뜨게 된다!

![](https://lh3.googleusercontent.com/k6qT8KnT0BUc1DL0QyR7ZHIRB8TjQ0DdGNxZQUwFSmJr628CjgEAs9lgrp9yHdWVA-2mfZjivcBO-uaOxk8YnuLMuS8ObIRJPfnZqHh1nY3iouSkWiGmlNxoMl30gMyf8ux9Axgjfw=w2400)

그런데... 문제는 내가 썼던 프로그램은 분명 안에 사각형이 흰색이 아닌 오렌지색갈이었는데, 이상하게 하얀 색갈로 떴다. 분명 이것을 보고, `OpenGL`은 시작에 성공하였지만, 특정 `shader`가 컴파일에 실패했다는 감이 왔다. 그런데 컴파일 에러가 뜨면 오류 메세지를 출력하도록 만들어놨었는데, `Xpra` 서버로 열기 때문에 바로 보이지 않았다. 따라서, 로그 파일을 뒤져볼 수 밖에 없었다. 그래서 위의 터미널에서 나왔던 `/run/user/1000/xpra/:1.log` 파일을 뒤져보았다. 그랬더니 과연 다음과 같은 오류 메세지가 나와 있었다.

```
Failed to compile vertex shader!
0:1(10): error: GLSL 3.30 is not supported. Supported versions are: 1.10, 1.20, 1.30, 1.00 ES, 3.00 ES, 3.10 ES, and 3.20 ES
```

역시 위와 같은 메세지들이 떠 있었다. 그래서 오래 찾은 겨로가 다음과 같은 `OpenGL` 버전 힌트를 넣었다. 

```
glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
```

위의 코드는 우리가 `OpenGL` 버전 3.3을 사용할 것이라고 이야기해주는 것이었다. 3.3 버전부터는 `OpenGL`의 버전과 `GLSL`의 버전이 동일하기 때문에, 이 버전만 써 주어도 되는 것 같다. 여기에서 중요한 것은 이 코드를 `glfwInit()` 함수 이후, `glfwCreateWindow()` 전에 써주어야 한다는 것이다. 

이렇게 했더니 드디어 제대로 컴파일 된 프로젝트가 화면 떳다.

![](https://lh3.googleusercontent.com/vatjRG1z7Y7Uo-bYIfczj_mfzD5xMHozFyAz5RhuVsRWAhdbyRFwVMax1huggoytiS2QWieqwzE6ekvLokmmFZJjYwNgDl6vBdQm9LN1l3xnmz2veEKvrK4Ol2wMknPYOAiGnbbCww=w2400)

