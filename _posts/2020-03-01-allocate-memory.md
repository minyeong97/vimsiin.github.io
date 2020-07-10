---
layout: post
title: allocate memory
categories: [cc++]
---

### 힙에서 메모리를 할당 받는 방법

외워라 외워라 외워라 X 3

#### c

```
int the_size = 10;

int *pointer = (int*)malloc(sizeof(int) * the_size);

// do something with the memory 

free(pointer);
```

c에서 사용할 때의 주의 사항이라면 어떤 형태의 배열로 받는지 `malloc`은 전혀 알 수 가 없기 때문에 어떤 형을 받는지에 대한 정보도 알려주어야 한다. 그래서 `sizeof(int)`를 사용하는 것이다. 그리고 또한 그 포인터는  `void *` 형태이기 때문에 그것을 맞는 포인터 형으로 변환해주어야 한다는 것도 있다.

`malloc`의 삼촌인 `calloc`도 소개한다. 

```
int the_size = 10;

int *pointer = (int*)calloc(the_size, sizeof(int));

// do something with the memory 

free(pointer);
```

`calloc` 함수와 같은 경우는 먼저 개수를 인자로 받아간 다음에, 각 개수에 해당하는 크기를 반환한다.


#### c++

```
int the_size = 10;

int *pointer = new int[the_size];

// do something with the memory 

delete[] pointer;
```

malloc 보다는 조금 더 편리해진 감이 없지않아 있다.
