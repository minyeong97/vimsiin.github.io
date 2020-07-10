---
layout: post
title: how to initialize array with certian value
categories: [cc++]
---

### 배열을 특정한 값으로 초기화시키기

마음에 안들지만 다음과 같은 해결책이 존재한다. 

```
std::fill_n(array, 100, -1);
```

사실은 그냥 직접 배열을 순회하는 것이 더 좋다.

```
for (int i = 0; i < 100; i++) {
	array[i] = -1;
}
```

사실 좋은 방법이 없다.
