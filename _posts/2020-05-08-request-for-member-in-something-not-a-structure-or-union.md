---
layout: post
title: request for member in something not a structure or union
categories: [cc++]
---

제목 그대로이다. request for member '<var>' in something not a structure or union

오류가 뜨면, 필시 structure의 포인터를 사용해서 멤버를 접근하려는 상태인 것이다.

그런데, 이때 -> operator를 사용하지 않고, . 포인터를 사용했기 때문이다.
