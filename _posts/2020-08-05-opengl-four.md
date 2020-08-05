---
layout: post
title: opengl four
categories: []
---

원격으로 서버에 접속해서 사용하다보니, `opengl` 개발이 조금 더 어려워졌다. 우선 `ssh` 서버 접속에서 `gui` 세션이 가능한지가 가장 큰 문제였다. 보니 `ssh`에는 그런 기능이 이미 있었다. 따라서 우리가 이를 해결하려면 다음과 같이 하면 되었다.

우선 첫 번째로, `server` 컴퓨터의 `/etc/ssh/ssh_config` 파일에서 다음 항목을 다음과 같이 고치자

```
# X11Forwarding no
```
를
```
X11Forwarding yes
```
로, 앞에 주석을 제거하고, `no`를 `yes`로 바꾸자. 이렇게 하고, 다음과 같이 접속할 때 특정 옵션들을 켜주면 된다.

```
ssh -X -Y -P <port-number> <user>@<ip-addr>
```

여기에서 `-X` 옵션은 앞으로 `gui` 인터페이스를 받겠다는 의미이고, `-Y`는 `client`의 `X` 윈도우가 오랜 시간이 지나면 `sleep`하는데, 이를 방지하기 위한 것이다. 이렇게 하면 대표적인 화면들을 뜨게 된다. 그러나 우리의 `opengl` 프로젝트를 띄워보면, 그렇게 나오지 않는다. 

```
libGL error: No matching fbConfigs or visuals found
libGL error: failed to load driver: swrast
gl3w init failed
```

먼저 구글링을 통해서 어떤 것이 문제인지 체크해보자. 많은 이야기들이 있으나, 몇 가지 드라이버들이 존재하지 않아서 그런 것 같다고 한다.

```
sudo apt-get install -y mesa-utils libgl1-mesa-glx
```

그러나 이런 패키지들을 설치해도 되지 않는다. 계속 구글링을 해본 결과 `GLX`(포워딩을 해주는 `X11`을 위한 `OpenGL` 확장자)가 `OpenGL` 버전 2.x 대까지밖에 지원을 하지 않기 때문에 3.x 버전들은 사용할 수 없다는 것이다. 현재 나의 코드는 모두 3.x이기 때문에 이를 우회할 방법은 당분간 없는 듯 하다.
