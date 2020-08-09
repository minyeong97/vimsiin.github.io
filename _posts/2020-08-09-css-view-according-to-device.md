---
layout: post
title: css view according to device
categories: []
---

어떤 특정 디바이스에 따라서 보이고 싶은 방식이 다르다면, 다음과 같은 문법을 `css`에서 사용하면 가능하다.

```css
@ media only screen and (min-width: 700px) {
	body { ... }
	#some-id { ... }
	...
}

@ media only screen and (max-width: 1400px) {
	...
}
