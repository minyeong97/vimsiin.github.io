---
layout: post
title: c++ file input output
categories: [cc++]
---

파일 입출력을 하기 위해선 다음과 같이 해야 한다.

```
FILE* fp = fopen("filename.txt", "w");
fputs(fp, "%s", "hello");
fclose(fp);
```

참고로 파이썬에선 다음과 같이 한다.

```python
f=open("filename.txt", "w")
f.write('hello')
f.close()
```
