---
layout: post
title: vim find and replace
categories: [vim]
---

다음과 같이 vim 에서 무엇을 찾아서 그것을 해당하는 문자열로 바꾸고 싶을 경우에늗 다음과 같이 하면 된다.

```
:%s/old/new/g
```

`g`는 글로벌
