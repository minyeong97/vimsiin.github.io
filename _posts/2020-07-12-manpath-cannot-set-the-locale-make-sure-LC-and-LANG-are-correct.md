---
layout: post
title: manpath cannot set the locale make sure LC and LANG are correct
categories: []
---

서버를 접속했을 때 이러한 문구가 뜨면서 프롬프트가 시작된다. 매번 터미널을 열어서 서버에 접속할 때마다 나오기 때문에 빨리 고쳐주어야 하는 문제였다. 먼저 `manpath`라고 하는 것은 `man`이라는 프로그램이 실행될 수 있도록 파일을 찾아주는 프로그램이다. 즉 각 프로그램에 대한 설명 파일을 locate하는 데에 필요한 프로그램이라는 것이다. 무슨 이유엔가 언어 설정이 필요한 모양이다. 이것을 해결하기 위해서는 다음과 같은 것을 차례로 하면 된다.

### 1. 명령어 입력

```
$ sudo locale-gen "ko_KR.UTF-8"
$ sudo dpkg-reconfigure locales
```

### 2. 파일 수정

다음 파일을 수정해야 한다.

```
$ sudo vi /etc/default/locale
```

이 파일 안에를 다음과 같이 수정해야 한다.

```
LANG=ko_KR.UTF-8
LC_ALL=ko_KR.UTF-8
LC_NUMERIC="ko_KR.UTF-8"
LC_TIME="ko_KR.UTF-8"
LC_MONETARY="ko_KR.UTF-8"
LC_PAPER="ko_KR.UTF-8"
LC_NAME="ko_KR.UTF-8"
LC_ADDRESS="ko_KR.UTF-8"
LC_TELEPHONE="ko_KR.UTF-8"
LC_MEASUREMENT="ko_KR.UTF-8"
LC_IDENTIFICATION="ko_KR.UTF-8"
```

### 서버 재부팅
```
$ sudo reboot
```
