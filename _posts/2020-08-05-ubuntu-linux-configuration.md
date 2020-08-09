---
layout: post
title: ubuntu linux configuration
categories: []
---

또또또 무한 로그인에 걸렸다. 리눅스의 고질적인(리눅스 커널이 아닌 우분투의 윈도우 시스템 문제라고 알려져 있다) 문제이다. 회사에서 잠시 일했을 때에도 툭하면 같이 일하던 사람들의 리눅스가 무한 로그인 문제에 빠지게 되었다. 최근에 나도 그런 경험을 겪었다. 원래 `ssh` 서버만 열어놓고 사용하기 때문에 `gui` 인터페이스가 작동되지 않아도 충분히 사용 가능해서 고치지 않았지만, 그래픽 관련 프로젝트를 수행하게 되어 잠시동안만이라도 화면을 봐야했던 나로써는 불가피하게 이를 해결해야 했다.

다양한 해결방법들이 나와있지만, 가장 빠른 방법은 진짜 그대로 다시 까는 것이다. 해결 방법을 살펴보면 무슨 `nVidia` 그래픽 드라이버 문자라니(나는 심지어 `AMD` 그래픽 카드를 사용하고 있었다) 등등의 말들이 올라와 있어서 가장 빠른 방법은 다시 까는 것이라고 생각했다.

### 1. 우분투를 까는 방법

먼저 `usb`나 메모리 장치를 준비한다(나는 `usb`도 없어서 카메라의 `SD` 카드를 뽑아서 썼다). 우분투 사이트에 접속해서(구글에 우분투라고 치면 바로 들어갈 수 있는 사이트) 우분투의 `iso` 버전을 다운 받는다. 그렇게 하고, `rufus`라고 하는 프로그램을 설치해서 이 `iso`를 우리의 메모리 장치에 넣는다. 컴퓨터를 재부팅하고 다시 켜질 때 `F2` 또는 `DEL`로 `BIOS` 새팅에 접근하고, 우리가 방금 설치한 우분투의 메모리 카드를 가장 높은 우선순위로 설정한다. 그렇게 한 다음에 부팅을 하면 우분투 설치 화면이 나온다. 잘 따라서 설치하면 우분투가 설치 완료된다.

### 2. ssh 설치

먼저 `sudo`로 `ssh`를 설치한 다음에(블로그에 ssh 설치 방법이 있으니 검색 하길 바란다) 다음과 같은 명령어로 항상 켜놓게 만든다.

```
sudo apt install openssh-server
sudo service ssh start
sudo systemctl enable ssh
```

### 3. curl, git, zsh 설치

```
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
이렇게 했는데 만약 쉘이 아직 `bash`이면, 다음 명령을 실행한다.
```
chsh -s $(which zsh)
sudo reboot
```
이제 필요한 기타 도구들을 모두 설치한다.
```
sudo apt-get install curl git tree ctags make cmake g++ locate apt-file tmux
```

### 4. nvim 설치

```
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
```

`nvim`을 설치 한 후에는 `nvim`을 열고, 안에서 `:nvim help`을 치면 설명이 나오지만, `~/.config/nvim/init.vim`이라는 파일에 다음과 같은 내용을 치면, `vimrc` 파일을 사용할 수 있게 된다.

```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

이 파일 안에 무엇을 쓰게 될 지는 `github`에 올려놓았다. 그러나 모든 것의 설치가 끝난 다음에 쓰는 것이 좋다. 이 다음으로 해야 하는 것은 `vundle`을 설치하는 것이다.

```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

### 5. 설정파일 가져오기

`.tmux.conf` 파일과 `.zshrc` 파일과 `.vimrc` 파일을 모두 `github`에서 받아온다.

### 6. 블로그 운영을 위해

이 블로그를 운영해야 하므로, 

```
sudo apt-get install ruby-full build-essential zlib1g-dev
gem install jekyll bundler
```

