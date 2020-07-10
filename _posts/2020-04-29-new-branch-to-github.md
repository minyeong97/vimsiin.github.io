---
layout: post
title: new branch to github
categories: [git]
---

만약 새로운 브랜치를 만들고, 그것을 remote에 올리고 싶다면??

```
git checkout -b <branch-name>
```
을 한 뒤에 수저을 한다.

그 다음에 다음과 같이
```
git push -u origin <branch-name>
```

을 하면 된다.
