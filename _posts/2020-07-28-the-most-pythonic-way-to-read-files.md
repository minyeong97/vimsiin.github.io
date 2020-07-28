---
layout: post
title: the most pythonic way to read files
categories: []
---

가장 파이써닉하게 파일들을 읽고 쓸 수 있는 방법은 다음과 같다.

```python
with open('<file-name>', 'w') as f:
	data = f.read()
```

여기에서 파일을 읽는 세 가지 함수 `read()`, `readline()`, `readlines()` 를 비교해보자면, `read()`는 그냥 파일 전체를 다 불러오는 것이고, `readline()`은 호출할 때마다 한 줄 씩 불러와준다. `readlines()`는 줄 별로 분리해서 리스트를 만들어서 리턴해준다. `readline()`을 사용하는 방법은 다음과 같은 예시가 있다.

```python
while True:
	line = f.readline()
	if not line: break
	# do something
```
