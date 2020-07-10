---
layout: post
title: opengl vs opencl vs vulkan
categories: [opengl]
---

`opengl` vs `opencl` vs `vulkan`

도대체 이 세개는 무엇이 다른 것일까?

#### 1. opengl

그래픽 카드를 사용하기 위한 `api specification`이다. `api` 자체가 아니다. 즉 `chronos group`이 어떤 형식으로 작동할지 `declare`를 해놓고, 그 `implementation`은 그래픽 카드 제조회사들이 만든다. 그래서 그래픽 카드가 꽂혀 있으면 그래픽 카드 드라이버가 실제 `implementaion` 역할을 한다. 여기에 대응되는 것이 `direct3D`이다. 마이크로소프트가 만든 `specification`이다.

#### 2. opencl

이름이 비슷하지만 이것은 완전히 다른 것이다. 이것은 의외로 사과회사가 만들었다. 이것은 `open computing language`이다. 이는 병렬처리를 위해서 `gpu`를 `gpgpu(general purpose gpu` 처럼 쓰기 위한 것이다. 그래서 완전히 다르다. 현재는 사과회사가 이것을 버리고 `metal`을 사용중이다.

#### 3. vulkan

차세대 `opengl`이다. 훨씬 다양한 설정들을 할 수 있지만, 그에 따라 난이도가 매우 올라간다. 성능 향상에 도움이 많이 된다고 한다.
