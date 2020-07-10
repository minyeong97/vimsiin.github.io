---
layout: post
title: swap function
categories: [cc++]
---

### 유명한 swap function

멍청한 내 대가리를 깨져도 이걸 못 외우니 적어둔다.

#### c

```
void swap(int *a, int *b) {
	int temp = *a;
	*a = *b;
	*b = temp;
}
```

사용 방법은 포인터를 던져주면 된다.

```
int a, b;

a = 10; b = 15;
swap(&a, &b);
```

#### c++

```
void swap(int &a, int &b) {
	int temp = a;
	a = b;
	b = temp;
}
```

사용 방법은 그냥 변수를 던져주면 된다.

```
int a, b;

a = 10; b = 15;
swap(a, b);
```

