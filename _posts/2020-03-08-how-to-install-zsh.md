---
layout: post
title: how to install zsh
categories: [shell]
---

zsh 설치하는 방법

우선 먼저 다음을 해보았다.

```
$ sudo apt install zsh
```

그리고 현재 사용중인 `shell`이 무엇인지 체크했다.

```
$ echo $SHELL
/bin/bash
```

현재 사용중인 `shell`이 `bash`라고 외친다.

그러면 이제 `zsh`로 바꾸어야겠다. 그렇게 하기 위해선 `chsh` 명령어를 사용해야 하는데, 이러기 위해선 `zsh`가 어디에 설치되어 있느지를 알야 했다. 그런데 그거 어딨지

인터넷을 뒤지던 중에 다음을 발견했다.

```
$ which zsh
/usr/bin/zsh
```

이를 사용하면 `zsh`가 어디에 설치되어 있는지를 확인할 수 있다.

그러면 다음과 같이 명령어를 돌렸다.

```
$ chsh /usr/bin/zsh
chsh: user '/usr/bin/zsh' does not exist
```

안된다는데. 이렇게 쓰는게 아닌가 보다.

다시 조사를 좀 해보니 다음과 같이 `-s` 옵션을 넣는 것이 좋다는 것을 알았다.

```
$ chsh -s /usr/bin/zsh
chsh: user '/usr/bin/zsh' does not exist
```

이러니까 비밀번호를 요구하면서 완료가 되었다. 바뀌었는지 확인하기 위해 한 번 더

```
$ echo $SHELL
/bin/bash
```

?? 뭐지 왜 안 바뀌었지

혹시 몰라 `shell`을 껏다가 다시 켰다.

```
$ echo $SHELL
/bin/bash
```

그래도 안된다. 컴퓨터를 `reboot`

다행이다. `zsh`가 설치된 것을 알 수 있었다. 우선 `shell`의 프롬프트가 기본 `bash`의 `$`에서 `%`로 바뀌었기 때문이다. 그리고 처음 보는 화면이 반겼기 때문이다.

무슨 설정을 막하라고 하는데, 너무 복잡해서 그냥 나갔다.

홈 디렉토리 `~`에다가 `.zshrc` 파일을 만들고, 그 안에 설정을 넣었다.

우선 `tmux`를 자동으로 켜주기 위한 세팅

```
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
```

우선 아무것도 없이 위에 있는 것만 입력했다.

`shell`을 다시 켜니까 아주 잘 작동.

이제 스킨질을 시작해야 한다.

다음을 추가했다.

```
ZSH_THEME="agnoster"
```

이런 것들은 띄어쓰기에 민감하기 때문에 `whitespace`를 전혀 사용하지 않았다.

이제 테마가 적용되었는지 껐다가 키면

안된다.
테마를 사용하기 위해서는 `oh-my-zsh`라는 것을 설치해야 함.

다음 명령을 실행

```
% sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
zsh: command not found: curl
```

컴퓨터에 `curl`이 없다.

```
% sudo apt install curl -y
```

설치를 완료해주고 위의 명령을 다시 실행. 그렇게 한 다음 `shell`을 다시 실행.근데 뭔가가 이상하다.

하

다음부턴 무조건 `oh-my-zsh` 설치 후 `.zshrc`파일을 건드리도록. 이넘이 설치하다 모두 `overwrite`해버림.

다시 `tmux` 관련 사항 추가. 그리고 `ZSH_THEME` 항목을 다시 `agnoster`로 바꿈.

다시 껐다 켜니까 되긴 하는데 `agnoster`에 필요한 폰트가 존재하지 않음. 그것도 다음으로 설치

```
% sudo apt-get install fonts-powerline
```

이렇게 보면 초기 세팅이 매우 복잡한 것은 사실.

이렇게 됐으나 우분투의 극혐 군고구마 색갈 `shell`이 꼴보기가 싫다. 그래서 `shell`의 `edit>preference>colors`에서 `use colors from system theme`을 꺼준다. 그리고 내 마음대로 원하는 색갈을 지정해도 된다. 그런데 이것을 끄는 것 만으로도 극혐 군고구마가 사라진다. 

이제 `.zshrc` 파일에 `vi` 와 `vim`을 `nvim`으로 `alias` 해놓는다.

```
alias vi='nvim'
alias vim='nvim'
```

