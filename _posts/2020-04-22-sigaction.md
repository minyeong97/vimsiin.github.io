---
layout: post
title: sigaction
categories: [linux]
---


POSIX에서 정의한 sigaction이라는 것은 도대체 왜 쓰고 어떻게 쓰는 것인지를 알아보도록 하자.

sigaction이라는 것은 운영체제가 받는 시그널(예를 들면 인터럽트 시그널 등)을 가지고 어떻게 대응할지를 우리가 결정하게 해주는 구조체이다.

이 구조체를 잠시 살펴보면

```
<signal.h>
struct sigaction {
	void (*sa_handler)(int);
	sigset_t sa_mask;
	int sa_flags;
};
```

로 구체화되어 있다(이것보다 더 많을 수 있지만 핵심적인 것만 모았다)

여기에서 sa_handler는 특정 시그널을 받았을 때 호출할 함수의 포인터를 의미한다. 그리고 sa_mask는 이 시그널을 처리하는 과정에서 블록할(즉 무시할) 시그널들을 구체화할 수 있다.

sa_mask는 그러나 sigemptyset이라는 함수를 활용하여 초기화해야 한다.

그리고  sa_flags는 이 시그널을 처리할 때 옵션들을 설정할 수 있다. 이 옵션들은 따로 찾아보길 바란다.


