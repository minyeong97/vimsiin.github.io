---
layout: post
title: python how to apply single operation to every element in list
categories: []
---

만약 파이썬에서 리스트에 있는 모든 원소에 특정 작업을 수행하고 싶으면 다음과 같이 하는 것이 좋다.

```python
A = ... # already existing list a
B = [ op(a) for a in A ] # op() is the operation you want
```
