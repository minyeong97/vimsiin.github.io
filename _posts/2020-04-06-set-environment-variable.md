---
layout: post
title: set environment variable
categories: [linux]
---

환경 변수를 현재 프로세스에서만 사용하고 싶다면 다음과 같이 쓰면 된다.

```
VARNAME="value"
```

다른 프로세스에도 사용하고 싶다면 다음과 같이 써야 한다.

```
export VARNAME="value"
```

그런데 현재 세션에서 끝난다. 만약에 지속적으로 적용시키고 싶다면 다음 파일을 수정한다.

```
sudo vim /etc/environment
```

여기에서는 `export` 키워드를 사용하지 않는다.

```
VARNAME="value"
```


