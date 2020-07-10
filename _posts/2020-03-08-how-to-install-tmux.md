---
layout: post
title: how to install tmux
categories: [shell]
---

`tmux`를 설치하는 방법.

다음 명령을 실행한다. 

```
% sudo apt install tmux
```

그런 다음에 `~/.tmux.conf`를 조정해준다. 내 설정은 [여기](https://github.com/vimsiin/my_conf.git)
그리고 쉘을 켤 때마다 자동으로 실행되게 하기 위해서는 다음 명령을 자신이 쓰고 있는 쉘의 `rc`파일에 추가

```
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
```


