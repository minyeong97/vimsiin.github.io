---
layout: post
title: css borders
categories: [web]
---

만약 테두리를 보이게 하고 싶으면 다음과 같이 할 수 있다.

```
border: <border-width> <border-style> <border-color>
```

예를 들어 다음과 같이 쓸 수 있다.

```
div {
	border: medium solid black;
}
```

| border-width | 설명 |
| - | - |
| fixed | 2px 등으로 설정할 수 있다 |
| thin | 얇게. 1~2px |
| medium | 중간 정도. 3~4px |
| thick | 두껍게. 5~6px |

| border-style | 설명 |
| -  | -  |
| none | 보이지 않는다. 기본 설정 |
| solid | 실선 |
| dotted | 점선 |
| dashed | 기다란 점선 |


`border-style`은 더 존재하지만 대표적으로 이렇게 있다.
만약 한쪽만을 설정하고 싶으면 `border`대신에 `border-top`, `border-bottom`, `bottom-left`, `bottom-right`등을 사용할 수 있다


