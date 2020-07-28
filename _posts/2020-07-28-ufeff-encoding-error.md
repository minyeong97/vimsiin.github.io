---
layout: post
title: ufeff encoding error
categories: []
---

만약 어떤 파일을 불러왔는데, 파일의 앞에 `\ufeff`같은 것이 붙어 있다면? 이것은 인코딩 에러이다. 이런 에러를 해결하기 위해서는 파이썬에서 파일을 열 때 인코딩을 다르게 해주면 된다.

 ```python
 with open('<file-name>', 'w', encoding='utf-8-sig') as f:
 	# do something
```
