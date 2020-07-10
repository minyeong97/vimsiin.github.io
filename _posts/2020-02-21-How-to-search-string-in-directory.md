---
layout: post
title: How to search string in directory
categories: [linux]
---

### 한 디렉토리 내에서 특정 문자열이 있는지 검사하기

가장 상위 디렉토리에서 다음 명령어를 치면 된다. 

```
% grep -rn -e 'pattern'
```

-r option: recursive
-n option: line number
-e option: pattern option

