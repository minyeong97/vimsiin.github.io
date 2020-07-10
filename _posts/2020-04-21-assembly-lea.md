---
layout: post
title: assembly lea
categories: [hardware]
---


`lea`는 `load effective address`라는 뜻이다.

그런데 하는 것은 정작 덧셈 뺄셈 정도 밖에 없다. 사실 그것이 다니까

```
lea 10(%ebp) %eax
```

라는 것은 겱구 `%ebp`에 있는 값에 10을 더한 다음에 `%eax`에 넣으라는 뜻이다.
