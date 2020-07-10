---
layout: post
title: c inline assembly
categories: [cc++]
---

c 인라인 어셈블리를 살펴보자.

문법은 다음과 같다.

```
__asm__ __volatile__ (asms : output : input : clobber);
```

`__asm__`은 앞으로 쓸 코드가 어셈블리 코드라는 것을 알려준다.
`__volatile__`은 앞으로 쓸 코드를 최적화하지 말고 그대로 사용하라는 것이다.
`asms`은 실제 어셈블리 코드이다. 이 코드는 큰 따옴표 안에 쓴다.
`clobber`는 입력, 출력이 아니지만 변할 수 있는 값들을 쓴다.

어셈블리어를 쓸때 명령의 구분은 세미콜론(;)이나 개행(/n) 으로 한다.
