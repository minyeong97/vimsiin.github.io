---
layout: post
title: about jekyll categories
categories: [web]
---

jekyll에서 카테고리를 설정하는 방법은 다음과 같다. 먼저 `post`를 쓸때 `YAML`에 다음을 추가한다. 

```
categories: [web]
```

이러하기 때문에 `YAML`은 최종적으로 다음과 같이 보일 것이다.

```
---
layout: post
title: about jekyll categories
categories: [web]
---
```

이렇게 하면 `jekyll`에서는 자동적으로 `site.categories`에 내가 매 `post`에 적어놓았떤 `web`같은 카테고리들을 저장해 놓는다.

이 `site.categories`는 다음과 같이 구성되어 있다. 우리는 다음과 같은 `liquid`구문으로 안에 있는 카테고리들을 순회할 수 있다.

```
 for category in site.categories 
```

여기에서 `category`는 길이가 2인 배열인데, 이 배열 중 `category[0]`는 그 카테고리의 이름을 포함하고 있고, `category[1]`는 그 카테고리 안에 있는 포스트들의 배열이다. 그래서 그 카테고리 안에 있는 포스트들을 다음과 같이 `liquid`로 순회할 수 있다.

```
 for post in category[1] 
```

물론 위의 구문은 그 위의 구문과 `nested`로 구성해야 한다. 그리고 `liquid`에서 다음으로 `for`문을 끝내야 하는 것도 알아야 한다.

```
 endfor 
```

