---
layout: post
title: How to force push git
categories: [git]
---

강제로 로컬에 있는 내용을 git 에 푸쉬를 할 수 있는 방법이 있다. 다음과 같이 하면 된다.

```
% git push origin master --force
```

여기에서 master 말고 자신이 원하는 다른 브랜치를 사용해도 좋다.

그리고 `--force` 는 `-f` 로 바꾸어서 쓸 수 있다.

```
% git push origin master -f
```

