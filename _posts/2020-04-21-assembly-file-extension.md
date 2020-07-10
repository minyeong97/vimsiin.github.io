---
layout: post
title: assembly file extension
categories: [linux]
---

어셈블리 코드 파일은 두가지가 있다.

`.S` 파일과 `.s`파일이다.

두 가지 파일은 서로 다르다.

`.s`파일은 순수한 어셈블리 코드로, 오브젝트로 바로 컴파일이 가능하다.
그런 반면 `.S`파일은 전처리기를 거쳐야 하는 어셈블리 코드로, `#define`이나 `#include`같은 것이 아직 존재할 수 있다. 어떻게 보면 `.sx`파일 확장자로도 볼 수 있다.
