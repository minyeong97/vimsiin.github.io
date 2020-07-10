---
layout: post
title: linux zip hangul crash
categories: [linux]
---

만약 한글 관련 `zip`파일을 압축해제했는데 이상한 문자들이 많이 등장한다면, 다음을 사용해서 해결할 수 있다.


```
unzip -O cp949 filename.zip
```
