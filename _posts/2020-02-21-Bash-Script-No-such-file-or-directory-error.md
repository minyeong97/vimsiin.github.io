---
layout: post
title: Bash Script No such file or directory error
categories: [shell]
---

## Bash Script: No such file or directory 에러

문법에 문제가 전혀 없는데 위와 같은 문제가 뜰 때에는 다음을 의심해 보아야 한다.

```
#!/usr/bin/env bash
```
위와 같이 써야 하는 줄을

```
#!usr/bin/env bash
```
또는
```
#!/usr/bin/env/ bash
```
으로 쓰지 않았는지 확인해보자.

