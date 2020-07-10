---
layout: post
title: LFB and LFE
categories: [hardware]
---

어셈블리를 하다 보면 다음과 같은 것들을 볼 수 있따.

```
.LFB1
```
또는
```
.LFE3
```

이것들을 모두 디버깅을 위해 존재하는 라벨들이다. 즉 함수가 시작되고 끝나는 지점을 알기 위해 넣어놓은 것이다.

LFB 는 FUNCTION_BEGIN_LABEL 이고, LFE 는 FUNCTION_END_LABEL으로 정의되어 있다. 그리고 함수가 쓰여져 있는 순서대로 번호를 부여받아서, LFB0 LFB1 등의 순으로 되어 있다.
