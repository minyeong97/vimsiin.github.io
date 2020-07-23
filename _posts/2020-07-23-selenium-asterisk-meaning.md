---
layout: post
title: selenium asterisk meaning
categories: []
---

`selenium`에서는 `*`(`asterisk`)를 사용하는데, 이는 대체로 많은 언어에서 사용하듯이 <다양한 태그가 모두 가능함>이라는 뜻이다. 따라서 다음과 같이 쓸 수 있다.

```python
element = \
	find_elements_by_xpath("//*[@id='some-id']")
```

로 하면, `id`가 `some-id`인 모든 태그들을 검색할 수 있다.
