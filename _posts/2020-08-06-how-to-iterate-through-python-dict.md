---
layout: post
title: how to iterate through python dict
categories: []
---

`python` `dict`에서 각 아이템을 순회하고 싶다면, `items()`라는 메소드를 사용하면 된다. 이 메소드는 `key`, `value` 값을 튜플로 돌려준다.

```python
for key, value in the_dict.items():
	print(key, value)
```
