---
layout: post
title: css basics
categories: [web]
---

### HTML5 에서 css 사용하기

`css`를 사용하는 간단한 방법은 다음과 같다.

우선 `HTML5`의 구조가 다음과 같다고 하자.

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Hello World</title>
  </head>
  <body>
    <h1>Hello World</h1>
    <p>안녕하세요! HTML5</p>
  </body>
</html>
```


그러면 다음과 같은 코드를 `<head>`에 추가해주면 된다.

```
<style>

h2 {
	color: red;
}
h1 {
	color: rgb(100, 134, 1);
}
body {
	background-color: rgb(0, 0, 240);
}
```

따라서 최종적으로 다음과 같이 될 것이다.


```
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Hello World</title>
	<style>
	
	h2 {
		color: red;
	}
	h1 {
		color: rgb(100, 134, 1);
	}
	body {
		background-color: rgb(0, 0, 240);
	}
  </head>
  <body>
    <h1>Hello World</h1>
    <p>안녕하세요! HTML5</p>
  </body>
</html>
```

### css id

만약 위의 경우처럼 모든 h2 들을 같은 스타일로 하지 않고 서로 다른 스타일로 하고 싶으면 어떨까?

이때는 `id`라는 것을 사용해야 한다. 이 `id`는 한 `html` 문서 내에 유일해야 한다. 다른 어떤 요소와도 스타일을 공유할 수 없는 것이다. 이것을 사용하려면 사용하려는 요소의 시작 태그 에 `id`를 추가해야 한다. 다음과 같이 말이다.

```
<h1 id="hello-world-header">Hello World</h1>
```

이때 `id`는 `whitespace`가 존재하면 안된다. 따라서 문장을 쓰기 위해서는 `-`를 사용해서 이어주어야 한다.

이제 저 아이디를 가진 스타일을 만들어 주어야 하는데 다음과 같이 하면 된다.

```
#hello-world-header {
	color: red;
}
```

여기에서 기존의 `style`과 다른 것은 `#`이라는 기호로 시작한다는 것이다.


### css class

위와 같이 오직 유일해야 한다면 좀 불편하다. 그것을 해결한 것이 class 이다. class를 사용하는 방법은 비슷하다. 이 경우에는 `class` 속성을 적용해주어야 한다.


```
<h1 class="hello-world-header">Hello World</h1>
```

그리고 style에 적용시켜줄 때에는 다음과 같이 `#` 대신에 `.`을 사용해야 한다.

```
.hello-world-header {
	color: red;
}
```
