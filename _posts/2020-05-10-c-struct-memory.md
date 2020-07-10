---
layout: post
title: c struct memory
categories: [cc++]
---

struct의 포인터는 첫 번째 멤버의 포인터와 동일하고, 메모리에 적재될때 거꾸로 적재된다.

즉 하이 메모리가 위쪽, 로우 메모리가 아래쪽인 인텔 방식을 따르면, struct는 가장 아래를 가리키게 되고, 거기부터 첫 번재 멤버 변수, 두 번째 멤버 변수 하면서 올라가게 된다.
