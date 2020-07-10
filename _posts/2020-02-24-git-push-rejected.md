---
layout: post
title: git push rejected
categories: [git]
---

## Git push 할 때 rejected

### 문제점

현재 push 하려는 branch 가 이미 다른 사람 또는 따른 곳에서 수정되었고, push 를 하려면 우선 branch 를 merge 해야 한다.

### 해결책

우선 `pull`을 해서 remote의 내용과 merge 준비를 해야 한다. 이때 또 [에러](https://minyeongchung.github.io/posts/git/2020/02/24/fatal-refusing-to-merge-unrelated-histories/)가 날 가능성이 있다.

```
% git pull origin master
```

모든 `merge` 과정이 완료 되면 이제야 `push`를 할 수 있다.

```
% git push origin master
```
