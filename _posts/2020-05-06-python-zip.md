---
layout: post
title: python zip
categories: [python]
---

python zip은 어떻게 사용하는 것인가?

만약 두 리스트가 있다고 하자.

```
x = [1, 2, 3, 4, 5]
y = [0.1, 0.2, 0.3, 0.4, 0.5]
```

여기에서 하나씩 짝을 짓고 싶다면 다음과 같이 하면 된다.

```
for a, b in zip(x, y):
	print(a, b)
```


