---
layout: post
title: more css text tags
categories: [web]
---

### css 텍스트 관련 tag들

다음과 같이 기본적으로 몇 가지가 존재한다.

| property | 하는 역할 |
| - | - |
| font-family | 폰트 종류 또는 구체적인 폰트 그 자체를 의미 |
| font-size | 폰트의 크기. 픽셀로 정할 수도 있고, 상대적으로 정할 수도 있다. 픽셀로는 px 단위를 사요하고, 상대적인 단위로는 em을 사용한다 |
| font-weight | 폰트를 볼드나 이탤릭체로 만들 때 사용한다 |
| font | 위와 같은 property들을 한 번에 쓸 때 사용한다 |

#### font 사용 법

만약에 다음과 같은 css style이 있다고 하자.

```
body {
	font-family: sans-serif;
	font-size: 1.5em;
	font-weight: bold;
}
```

그러면 위와 같은 코드는 다음과 같이 고칠 수 있다.

```
body {
	font: sans-serif 1.5em bold;
}
```

이를 `shorthand`라고 한다.

#### 다른 태그들 더 알아보기


| property | 하는 역할 |
| - | - |
| text-align | 텍스트를 왼쪽, 중간, 오른쪽에 배열할지 정하는 것이다 |
| text-height | 줄간 간격을 정하는 것. 역시 em과 같이 상대적으로 정할 수 있다 |
| text-decoration | 밑줄 등을 정할 수 있다 |

#### 브라우저에서 링크 표현하는 방법 바꾸기

브라우저에서는 링크를 주로 파란색에 밑줄을 그은 것으로 표현한다. 그런데 css를 활용하면 이것을 바꿀 수 있다. 다음과 같이 `<a>` 태크를 css 로 style 해주면 되는 것이다.

```
a {
	text-decoration: none;
}
```

이와 같이 하면 더 이상 링크를 밑줄 치지 않는다.
