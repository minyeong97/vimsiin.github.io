---
layout: post
title: NeoVim ESC Lag
categories: [vim]
---

## NeoVim 사용시 ESC 느린 반응 고치기

### 문제점
NeoVim 사용할 때 Insert Mode -> Normal Mode 로 돌아갈 때 약간의 시간 지연이 생긴다.

### 해결책
다음 코드를 ~/.vimrc 파일 또는 NeoVim 설정파일 마지막에 추가해주면 된다.

```bash
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif
```

tmux를 사용하고 있다면 다음 코드를 ~/.tmux.conf 파일 마지막에 추가하면 된다.
```bash
set -sg escape-time 0
```

추가: 만약 추가했는데 안된다면 tmux와 shell을 껐다가 켜보자.
