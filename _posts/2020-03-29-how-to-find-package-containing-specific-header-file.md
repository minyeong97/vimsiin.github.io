---
layout: post
title: how to find package containing specific header file
categories: [linux]
---

우선 `apt-file`이 존재해야 한다.

```
sudo apt install apt-file
```

그 다음에 다음과 같은 명령을 사용해서 찾으면 된다.

```
sudo apt-file search "<header-file-name.h>"
```

때론 캐쉬가 비어 있을 수 있다. 따라서 다음을 사용해서 업데이트를 하자.

```
sudo apt update
```
