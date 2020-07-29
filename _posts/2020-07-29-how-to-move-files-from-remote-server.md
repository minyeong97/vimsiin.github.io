---
layout: post
title: how to move files from remote server
categories: []
---

원격 서버에서 파일을 가지고 오는 방법은 `scp` 명령어이다. 이 명령어를 사용하면 내 컴퓨터에 원격 서버로 또는 원격 서버에서 내 컴퓨터로 파일을 가지고 올 수 있다. 파일을 가지고 올 때에는 다음과 같이 사용하면 된다.

```
scp -P <port-num> <user>@<ip-addr>:<absolute-directory-to-file> \
	<relative-local-directory>
```

파일을 보내고 싶을 때에는 순서를 바꾸면 된다.

```
scp -P <port-num> <directory-to-file> \
	<user>@<ip-addr>:<absolute-directory>
```

폴더를 보내고 싶을 때에는 리컬젼 옵션을 보내야 한다. `-r`옵션을 포트 번호 뒤에 붙여 주면 된다.
