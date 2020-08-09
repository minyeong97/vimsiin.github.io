---
layout: post
title: how to turn on remote gui xpra
categories: []
---

`xpra`는 원격으로 그래픽 인터페이스를 사용할 수 있게 만드는 도구이다. 이를 사용하면 어떤 화면도 가져와서 사용할 수 있다. 다음과 같은 명령어를 통해서 `xterm`등을 켜서, 그 쉘로 다른 프로그램들을 작동시킬 수 있다.

```
xpra start ssh://<host-name>@<host-ip>:<port>/ --start-child=xterm
```
