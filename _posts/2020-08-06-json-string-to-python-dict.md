---
layout: post
title: json string to python dict
categories: []
---

`json` 문자열이 존재하고, 이것을 `python` `dict`로 만들기 위해서는 다음과 같은 아주 간단한 과정만 거치면 된다.

```python
import json
the_dict = json.loads(the_json_string)
```
