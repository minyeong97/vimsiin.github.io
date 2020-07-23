---
layout: post
title: django model is not showing up after adding to model
categories: []
---

`django`를 하다가 또 하는 많은 실 수 중에 `admin`에게 모델을 허용하지 않는 것이 있다. 분명 `model.py`에 새로운 모델 추가 또는 업데이트 했는데, `admin` 사이트에는 전혀 보이지 않는 것이다. 이는 `admin`사이트에 모델을 허용해줘야 하는 것이다. 그래서 `app`의 `admin.py` 파일에 모델을 추가하고, 다음과 같은 내용을 넣어야 한다. 

```python
from django.contrib import admin
from .models import Model1, Model2 

admin.site.register(Model1)
admin.site.register(Model2)
```

화이팅!

