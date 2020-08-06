---
layout: post
title: how to convert list to string
categories: []
---

우리는 때때로 리스트가 있으면 이것을 문자열로 변환해야 할 때가 존재한다. 그런 경우에는, 문자열을 리스트로 만들어주는 `split`과는 반대 메소드인 `join`을 사용하면 된다.

```python
the_list = ['1', '2', '3']
the_string = "".join(the_list)
# the_string == "123"
```

간혹 리스트가 문자열이 아닌 경우에는 변환을 해주어야 한다.


```python
the_list = [1, 2, 3]
the_string = "".join(str(e) for e in the_list)
# the_string == "123"
```


