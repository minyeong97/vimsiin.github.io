---
layout: post
title: selenium get sibling tag
categories: []
---

`selenium`에서는 다양한 방법으로 태그를 찾을 수 있다. 그런데 가끔 찾기 어려운 태그가 있다. 이런 태그는 다음과 같은 관계를 가지고 있으면 찾기 쉽다. 태그 1이 우리가 찾고 싶은 태그이고, 태그 2는 태그 1과 항상 밀접관 관련성이 존재한다. 그런데 태그 1은 찾기 힘들고 태그 2는 찾기 쉽다면, 태그 2를 먼저 찾고, 태그 1을 찾는 것이 효율적일 것이다. `selenium`에서는 다음과 같이 형제 태그를 찾는 방법을 알려준다.

```python
find_elements_by_xpath("//p[@id='something']/following-sibling::p")
```

당연히 여기에서 중요한 것은 `following-sibling::<tag>` 부분이라고 할 수 있다. 이를 활용해서 형제 태그를 찾을 수 있다.
