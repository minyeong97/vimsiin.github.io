---
layout: post
title: Django image
categories: []
---

`django`에서 이미지를 넣는 방법은 조금 복잡하다. `django`는 모든 파일들을 모듈화해서 확인하기 때문에, 특정한 파일의 경로를 정적으로 찾아갈 수 없다. 따라서 `django`에서는 다음과 같은 일들을 차례로 해주어야 한다.

### 1. Django setting

가장 먼저 해야 할 것은 `django`의 설정을 바꾸어야 하는 것이다. 프로젝트 폴더 안에 있는 `settings.py` 파일을 열어서, 다음과 같은 줄을 추가해야 한다.

```python
STATIC_URL = '/static/'
```

### 2. Create Directory

각 앱의 디렉토리에 `static/` 경로를 만들어준 다음에, 내가 원하는 이미지 또는 정적 데이터를 위치시킨다.

### 3. Html format

`HTML` 템플렛의 맨 위에 다음과 같은 것을 쓴다.
```html
{% load static %}
```

그런 다음 이미지 태그를 만들 때 다음과 같이 만든다.

```html
<img src="{% static 'img/123.jpg' %}">
```

이때 작은 따옴표 안에 적는 경로는 방금 우리가 생성한 `static/`안에 있는 상대경로이다.
