---
layout: post
title: django multiple foreignKey and manyToMany
categories: []
---

만약 `django`에서 `Foreign Key` 또는 `Many To Many` 등의 필드등을 여러개를 사용하면, `python manage.py makemigrations` 와 `python manage.py migrate`에서 이상한 오류가 난다. 이를 해결하기 위해선 다음과 같은 작업을 해주어야 한다.

```python
class SampelModel(models.Model):
	memberOne = ManyToManyField(<Model-Class-name>, \
		related_name=<name>, related_query_name=<query_name>)
	memberTwo = ManyToManyField(<Model-Class-name>, \
		related_name=<name>, related_query_name=<query_name>)
```

이때 주의해야 하는 것은, `related_name`은 서로 다 다르게 써야 한다는 것이다. 그리고 `related_query_name`도 역시 마찬가지로 서로 다 다르게 써야 오류가 나지 않는다.
