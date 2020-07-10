---
layout: post
title: Linux DD command
categories: [linux]
---

## 리눅스 DD 명령어

### DD 명령어

```
% man dd
DD(1)
NAME
		dd - convert and copy a file
		...
```

리눅스 도움 명령어 man을 사용해서 dd를 찾아보면 위와 같이 나온다.
즉 dd 명령어는 파일을 복사하거나 변환할 때 사용하는 명령어이다.

### 사용법
```
% dd if=/dev/hwrng of=hwrng-test-data.bin bs=1024 count=1024
```

if 옵션: input file로 읽어들일 파일을 쓴다

of 옵션: output file로 출력할 파일을 쓴다

bs 옵션: bytes로 크기를 정한다

count 옵션: 반복할 횟수를 정한다


### 왜 사용하냐

리눅스에는 cp 명령어가 있는데 왜 사용하냐라고 생각할 수 있는데, 위의 예시에 있는 if에 있는 /dev/hwrng 파일을 사용하기 위해서이다.
이 파일은 사실 파일이 아니고, 컴퓨터에 있는 하드웨어 모듈을 사용하는 드라이버이다. 이 것을 사용하기 위해서는 dd 명령어를 사용해야 한다.
