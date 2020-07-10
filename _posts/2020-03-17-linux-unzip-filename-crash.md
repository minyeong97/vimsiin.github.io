---
layout: post
title: linux unzip filename crash
categories: [linux]
---

리눅스에서 압출파일을 해제했는데 파일 이름들이 깨지는 경우.

윈도우에서의 한글 문자셋은 `cp949`인데, 리눅스에서는 `UTF-8`을 사용하기 때문이다.

따라서 `unzip`을 할 때 다음과 같이 인코딩 옵션을 주면 된다.

```
% unzip -O cp949 filename.zip
```
