---
layout: post
title: html css content align horizontally
categories: []
---

만약 어떤 `div`안에 다른 `div`들이 가로롤 배열되고 싶다고 한다면, 그것을 어떻게 해야할까? 이것은 `css`로만 가능하다. 다음과 같은 `html`이 있다고 하자.


```html
<div class="parent">
	<div class="child"> </div>
	<div class="child"> </div>
	<div class="child"> </div>
</div>
```

이렇게 되면, `div`들은 세로로 배열된다. 이를 가로로 배열하기 위해서는 `css`를 사용해서 다음과 같이 하면 된다.

```css
.child {
	float: left;
}

.parent::after {
	content: "";
	clear: both;
	display: table;
}
```


