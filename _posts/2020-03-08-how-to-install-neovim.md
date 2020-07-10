---
layout: post
title: how to install neovim
categories: [vim]
---

`neovim` 설치하는 방법. `neovim`은 글로벌 `yank`같은 것을 허락하기 때문에 편리하다. 무엇보다 테마질을 하기 편해서 좋다.

이것을 설치하기 위해서는 

```
% sudo add-apt-repository ppa:neovim-ppa/unstable
% sudo apt-get update
% sudo apt-get install neovim
```

`neovim`의 실행은 다음으로 가능하다.

```
% nvim
```

여기에 들어가보면

```
:help nvim
```

을 사용해서 도움을 받을 수 있다. 만약 `.vimrc` 세팅 파일을 사용하고 싶다면 `~/.config/nvim/init.vim 파일에 다음을 추가하면 된다.

```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

이제 해야 할 것은 `vundle`을 설치하는 것이다.

```
% git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
```

이를 통해 플러그인들을 설치할 수 있다.


