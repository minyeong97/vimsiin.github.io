---
layout: post
title: What is LD_LIBRARY_PATH
categories: [cc++]
---

## 도대체 LD_LIBRARY_PATH 가 뭔데

어떤 파일이 컴파일 될 때 참조하는 라이브러리 path이다.

여기에서 LD 는 GNU에서 사용하는 Linker를 의미한다. 실제로 LD는 Executable을 만드는 과정 중에서 가장 나중에 작동하는 프로그램 이름이다. 근데 도대체 왜 LD 인가?

LD 는 애초에 Linker였다. Link Editor로도 불렸는데, 이때 줄임말이 LE이면 이미 사용되고 있던 Less than Equal(<=, 즉 이하)와 충돌이 생겨서 다음 철자인 Link eDitor로 LD로 불렀다고 한다.
