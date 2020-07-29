---
layout: post
title: how to dump data from django database
categories: []
---

`django`를 사용하다가 장고의 데이터베이스 속에 있는 데이터를 받아오고 싶으면 당므과 같은 명령을 사용하면 된다.

```python
python3 manage.py dumpdata <app-name>.<model-name> --indent 4 \
	> <file-name>.json
```

다른 포맷으로도 프린트할 수 있지만, default는 `json`이다.
