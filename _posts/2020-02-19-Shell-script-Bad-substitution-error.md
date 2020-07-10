---
layout: post
title: Shell script Bad substitution error
categories: [shell]
---

## 쉘 스크립트 실행할 때 Bad substitution error 가 나는 이유

### 문제점
분명 bash script를 잘 짜고 실행을 시켰는데 다음과 같은 에러가 뜬다.

```
#test.sh

string='yank yank'
modified_string={string// /-}
```

```
% ./test.sh
% ./test.sh: 2: ./test.sh: Bad substitution
```

절대 틀릴 문법이 아닌데 이런 에러가 뜬다. {} 안에 쓴 것은 문자열의 특정 부분을 교체해달라는 건데 잘못되었다고 뜬다. 왜 그런 걸까

### Shell의 구조

우리가 알만한 것까지 거슬러 올라가보자.

가장 먼저 sh가 있다. 물론 이전에도 Mashey Shell이 있었지만, 우리가 잘 아는 bash의 기원인 shell이 sh이다. 이 쉘의 정식 이름은 Bourne Shell이다(Stephen Bourne이라는 사람이 만들었다). 이 쉘은 역사적인 쉘이기 때문에 대부분의 unix 계열 컴퓨터들은 모두 /bin/sh 로 존재한다. 실제로 sh를 사용하지 않더라도 기본 탑재 shell을 연동시켜놓는다. 우분투의 경우 dash를 sh로 연결시켜 놓았다. 다음과 같이 쳐보면 알 수 있다.

```
% man sh
```
```
DASH(1)
NAME
	dash - command interpreter (shell)
```
두 번째로 우리가 잘 아는 bash가 있다. 이 bash는 sh를 기반으로 Brain Fox가 만든 쉘이다. 그래서 이름이 Bourne Again SHell 이므로 bash이다. bash는 현재 우분투에서 사용자 interaction을 하는 shell로 정해져있다.

세 번째로 bash와 비슷한 시기에 만들어진 ash가 있다. 이는 Kenneth Almquist 가 유닉스를 위해 만든 가벼운 shell로 그의 이름을 따서 Almquist SHell, 즉 ash이다. 이를 1997년에 Herbert Xu가 이 쉘을 Debian으로 port 하고 이름을 Debian Almquist SHell로 정해서 dash가 되었다. 이 쉘은 기능은 적었지만 매우 가벼웠기 때문에 점차 많은 시스템들이 os 부트용으로 도입하기 시작했고 마침내 우분투도 2006년에 기본 쉘인 /bin/sh로 연동시켜놨다.

> 여러가지 쉘들은 문법과 기능이 달라서 스크립트에 맞는 쉘로 돌려줘야 한다.

### 그래서 어떤 상황인가

문제를 야기하는 이유는 우분투에서 사용하는 쉘이 두 가지이기 때문이다.

1. dash: /bin/sh
2. bash: interactive shell

우리가 bash를 사용하듯 쉘을 작성하고 정작 우분투는 쉘 스크립트를 기본 sh인 dash로 실행하기 때문에 문제가 발생하는 것이다. 

### 그만하고 그럼 해결책은

스크립트의 맨 위에 어떤 쉘을 사용할지를 알려주면 된다. 이를 shebang이라고 하는데 이는 #!로 시작하는 구문이기 때문이다. (sharp + bang)
```
#!/usr/bin/env bash
```
이는 기본 sh로 돌리지 말고 bash를 사용해서 돌리라는 것이다.
