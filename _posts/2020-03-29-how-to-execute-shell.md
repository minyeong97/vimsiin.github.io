---
layout: post
title: how to execute shell
categories: [shell]
---

쉘 스크립트는 바로 실행할 수 없다. 다음과 같은 쉘 스크립트가 있다고 하자.

```
a.sh
```

그러면 다음과 같이 실행해야 한다.

```
./a.sh
```

그런데 그럼에도 불구하고 다음과 같은 결과가 나올 것이다.

```
zsh: permission denied: ./a.sh
```

즉 권한이 없다는 뜻인데 `sudo`로 실행해 보자.

```
sudo ./a/sh
```

그럼에도 다음과 같이 나온다.

```
sudo: ./a.sh: command not found
```

이럴 경우 다음과 같이 권한을 `chmod`로 바꾸어 주어야 한다.

```
chmod +x a.sh
```

위의 명령어는 모든 사용자에게 실행할 권한을 주는 파일이다. 이를 사용하면 다시 위의 명령어를 사용해서 쉘 스크립트를 실행시킬 수 있다.


