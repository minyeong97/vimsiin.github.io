---
layout: post
title: how to install fzf
categories: [shell]
---

`fzf`는 다용도로 사용할 수 있는 `fuzzy finder`이다. 대문자를 치기 귀찮음이나 중간 단어부터 검색하고 싶을 경우에 아주 용이하다. 그리고 우리나라 사람이 만들어서 국뽕이 차오르는 경험도 할 수 있다.

```
% git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

그럼 `alt+C`를 통해서 `cd fzf`를 사용할 수 있고, `vim`을 `vim $(fzf)` 처럼 사용하면 이를 이용해 검색을 할 수 있다.
