---
layout: post
title: i386 function call
categories: [hardware]
---

i386 즉 x86에서는 어떻게 함수 콜이 생성되는지 살펴보자.

먼저 그것을 알기 전에는 기존에 어떤 레지스터들이 씨피유 주변에 존재하는지 알아야 한다.

i386은 그나마 간단하기 때문에 다음과 같은 레지스터드만 존재한다.

가장 중요하다고 할 수 있는 프로그램 카운터(Program Counter PC)(i386에서는 EIP라고 부른다. Extenssive Instructoin Pointer)
스택 포인터인 ESP
스택의 프레임을 잡아주는 베이스 포인터, EBP
그 다음에 데이터를 영역 메모리를 관장하는 EDI, ESI

함수를 리턴할 때 리턴 값을 저장하는 EAX(덧셈의 결과를 저장할 때 쓰이기도 한다)
메모리의 주소를 저장하는 EBX  그 다음에 카운터를 하나씩 올리는 ECX, 역시 연산의 결과가 들어가는 EDX 등이 있다.

그러면 함수 콜이 있을 때 어떤 일이 있는지 보도록 하자.

어셈블리어를 살펴보면, 어떤 함수의 심볼 다음은 대부분 다음과 같이 이루어져 있다.

```
add:
	pushl %ebp
	movl %esp %ebp
	movl 8(%ebp) %edx
	movl 12(%ebp) %eax
	addl %edx %eax

main:
	pushl %ebp
	movl %esp %ebp
	subl $8 %esp
	movl $5 -4(%ebp)
	movl $10 -8(%ebp)
	call add
