---
layout: post
title: ctags setting
categories: [linux]
---

`ctags`를 사용하려면 다음을 `.vimrc`에 포함시켜야 한다.

```
set tags=./tags,tags;$HOME
```

그리고 컴퓨터를 껐다가 켜야 한다.

```
reboot
```
