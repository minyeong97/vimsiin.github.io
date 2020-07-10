---
layout: post
title: how to install pip
categories: [python]
---

파이썬에서 `pip`을 설치하는 방법

다음 일것 같지만 아니다.
```
sudo apt install pip
```

사실은 다음이다.

```
sudo apt install python-pip
```

`pip`은 `python2`를 위한 것이고, `pip3`는 `python3`를 위한 것이다. `pip3`를 설치하기 위해서는 다음과 같이 해야 한다.

```
sudo apt install python3-pip
```

