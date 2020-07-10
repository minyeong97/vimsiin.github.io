---
layout: post
title: cscope is opening vi
categories: [linux]
---

사용하고 있는 `cscope`가 자꾸 `vi`를 열고 있다면 다음과 같은 것을 해보는 것이 좋다.

다음 파일을 sudo 권한으로 연다.

```
sudo vim /etc/environment
```

그곳에서 다음과 같은 환경 변수를 추가해준다.

```
EDITOR=nvim
```

여기에서 `EDITOR` 말고도 `CSCOPE_EIDTOR`로 `cscope`만 설정할 수 있다.

이때 컴퓨터를 `reboot`해야지 적용된다. 아무리 `source`해도 안먹히니 주의하자.
