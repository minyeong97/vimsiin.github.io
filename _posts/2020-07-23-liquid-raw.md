---
layout: post
title: liquid raw
categories: []
---

`jekyll`을 사용하다보면, `liquid`에 관련해서 사용할 일이 많아진다. 이것은, `HTML` 을 유동적으로 생성해주는 추가 기능이라고 생각하면 된다. 그래서, 블로그에 글을 쓸 때에 예시 또는 코드를 보여주려는 목적으로 `liquid` 명령어를 쓰게 되면, 렌더러가 그것을 해석하라는 뜻으로 받아들여서 문자를 문자대로 받아들이지 않는다. 이를 위해서는 `liquid`의 `raw`기능을 사용해야 한다.


블로그에서는 이것을 사용하지 못하므로, 한글로 적도록 하겠다.

```
중간괄호 퍼센트기호 raw 퍼센트기호 중간괄호

// 내가 원하는 liquid 문법

중간괄호 퍼센트기호 endraw 퍼센트기호 중간괄호
```