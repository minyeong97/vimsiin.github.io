---
layout: post
title: Tmux troubleshooting
categories: [shell]
---

### Tmux 관련된 몇가지 사항

#### .tmux.conf 파일을 수정했는데 아무것도 바뀌지 않는다.

분명 터미널을 다시 껐다가 켰는데도 안된다.

Tmux 는 zshrc 파일과 다르게 컴퓨터를 껐다가 켜야지 적용이 된다.

```
% reboot
```

#### Tmux 에서 복사하기

tmux 복사는 생각보다 훨씬 복잡하다. 우선 tmux 복사를 사용하기 전에 복사 모드를 선택해야 한다. 복사 모드는 다음과 같이 두 가지가 있다.

1. emacs mode
2. vi mode

기본으로는 emacs mode로 설정되어 있고 만약에 바꾸고 싶다면 다음을 `.tmux.conf` 파일에 추가해야 한다.

```
setw -g mode-keys vi
```

여기에서 `setw` 는 `set-window-option` 의 alias이다.

-g 옵션을 글로벌 옵션이고,

mode-keys 가 바로 우리가 설정하고 싶은 변수이다. 이 변수는 기본적으로 emacs 로 설정되어 있고, 우리가 vi를 써주면 바꿀 수 있다.

이런 설정이 완료되고 나서는 복사를 진행할 수 있다.

tmux 에서 복사하는 방법은 먼저 `<prefix> + [` 를 눌려서 `copy mode`로 들어가야 한다.

이후에 화살표를 사용해서 원하는 곳으로 이동한 다음에, 그곳에서 `space` 를 눌러서 선택 모드로 들어가야 한다. emacs의 경우에는 `C-space`이다. 선택 한 뒤에 `Enter` (emacs 는 `Alt-W`) 를 눌러서 복사를 완료한다.

이때 복사는 또 tmux 전용 buffer에 저장된다. 따라서 이 복사된 내용은 그냥 tmux 내에서만 사용이 가능한 것이다.

이것을 광역 clipboard에 복사를 하려면 우선 xclip 을 설치해야 한다.

```
% sudo apt-get install -y xclip
```

설치를 완료 한 후에 `.tmux.conf` 파일에 다음을 추가해주면 된다.

```
bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -sel clip -i"
```

복잡하지만 해석을 하자면 다음과 같다.

`bind`: bind-keys 의 alias이다.

`-T`: 어떤 테이블의 키를 변경할지에 대한 옵션이다. 이때 우리는 `copy-mode`를 `vi`로 설정을 해놓았기 때문에 이에 해당하는 테이블을 사용해야 한다. 이때는 `copy-mode-vi`이다.

`Enter`: vi mode 에서는 `Enter`로 복사를 한다고 했으므로, 이 키를 여기다 쓴다.

`send-keys`: key press를 에뮬레이트 해주는 것이다.

`-X`: copy mode 에게 command를 보내는 옵션이다

`copy-pipe-and-cancel`: 우리가 하고 싶은 명령. 즉 복사하고 다시 기본 쉘 모드로 돌아가는 것.

`"xclip -sel clip -i"`: 우리가 복사할 때 전송할 명령. 즉 xclip을 사용해서 광역 clipboard에 복사하는 것이다.

