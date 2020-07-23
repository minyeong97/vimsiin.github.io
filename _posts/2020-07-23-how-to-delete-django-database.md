---
layout: post
title: how to delete django database
categories: []
---

`django`를 사용하다보면, 데이터베이스를 지워야 할 때가 있다. 이런 경우에 `django`의 데이터베이스를 지우는 방법은 다음과 같다.

가장 먼저 데이터베이스 그 자체를 지운다.

```bash
rm db.sqlite3
```

그 다음에는 각 `app`의 `migrations` 폴더에 들어가서 `__init__.py`를 제외하고 모두 삭제한다.
