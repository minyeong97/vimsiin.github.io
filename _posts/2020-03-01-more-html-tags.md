---
layout: post
title: more html tags
categories: [web]
---

### 더 많은 HTML 태크 알아보기

#### Internal page link

다른 페이지로 링크를 걸어 놓는 것은 다음과 같이 한다고 배웠다. 

```
<a href="https://google.com">Google</a>
```

그러면 `Internal Link`는 어떻게 해결할까? 이도 역시 `id`를 사용해서 활용한다.

다음과 같이 원하는 요소에 `id`를 추가해놓는다.

```
<h2 id="happy-yanking>Happy Yanking</h2>
```

그런 다음에 링크로 만들고 싶은 요소를 다음과 같이 만든다.

```
<a href="#happy-yanking">hy</a>
```

여기에서 주의해야 할 점은 `id`앞에 `#`가 들어간다는 것이다.
