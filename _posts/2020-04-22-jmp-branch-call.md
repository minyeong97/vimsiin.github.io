---
layout: post
title: jmp branch call
categories: [hardware]
---

jmp branch call 의 세 가지는 무엇이 어떻게 다른 것일까?

먼저 call은 자동으로 eip를 저장해두기 때문에 반드시 불렀을 때 ret을 만나야 한다.

그러나 jmp는 아무 조건 없이 그냥 eip가 그곳으로 가는 것이라고 생각하면 된다.

branch는 jmp와는 살짝 다른 것이 아주 가까운 거리에 있는 인스터럭션으로 가라는 뜻이다.
