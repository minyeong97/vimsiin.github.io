---
layout: post
title: selenium find tag by text
categories: []
---

`selenium`에서는 태그의 `id`나 아니면 `class`등으로 원하는 태그를 찾아냈다. 그런데 가끔씩 어떤 텍스트가 스여져 있는 태그를 찾고 싶을 때도 있을 것이다. 그런 경우에는 다음과 같은 문법을 사용해서 찾으면 된다.

```python
element = find_elements_by_xpath \
	("//*[contains(text(), '<the-text-i-want-to-search>')]")
```

이제 우리가 원하는 텍스트를 변수에 넣고 이를 찾기 위해서는 다음과 같이 변형할 수 있다.

```python
the_string = 'click'

element = find_elements_by_xpath \
	("//*[contains(text(), '{}')]".format(the_string)
```

여기에서 주의할 것은, 큰 따옴표가 작은 따옴표가 있는 `string`은 따옴표 관련해서 parsing이 잘못될 수 있다.
