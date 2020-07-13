---
layout: post
title: 
categories: [git]
---

`github`에서 `ssh` 연결을 사용하면 매번 계정과 비밀번호를 치지 않아도 클론이나 푸쉬를 할 수 있다. 그것을 하기 위해선 다음과 같은 순서가 필요하다.

가장 먼저 홈 디렉토리에서(필수 사항은 아니다. 어차피 어디에 설치할지 물어보게 된다) 다음과 같은 명령을 실행한다.

```
% ssh-keygen -t rsa
```

사실은 그냥

```
% ssh-keygen
```
만 해도 된다.

그렇게 하면

```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/manmarli/.ssh/id_rsa):
```
위와 같은 반응이 나오게 된다. 홈 디렉토리에 설치하는 것이 제일 좋은 방법이기 때문에 그냥 `.`을 찍어주어도 되고 아니면 `~`하는 것도 나쁘지 않은 방법이다.

그렇게 하면 다음과 같이 비밀번호 설정을 물어본다. 컴퓨터에서 이 `rsa`키를 사용할 때 아무리 컴퓨터를 사용하는 사람이라도 비밀번호를 한번 물어보게 할 수 있다. 만약 비밀번호 설정을 하면 `github`에서 `ssh` 커넥션을 할 때 컴퓨터를 켜고 맨 처음 한 번만 물어보게 된다.

```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in ~ktop.
Your public key has been saved in ~ktop.pub.
The key fingerprint is:
SHA256:QBmljeVMEd6ZkaY/Ope6HokdGS3bepT+P6KMYuhzyYI manmarli@manmarli-900X3K
The key's randomart image is:
+---[RSA 2048]----+
|      o+*o..     |
|     ..X oo+     |
|      + Bo=      |
|       ..* .     |
|        S.+      |
|       o *o      |
|   . o..=.oo     |
|  E + * o=o.. .  |
|   ..= o==o..o.. |
+----[SHA256]-----+
```

그러면 완료된 것이다. 설치한 디렉토리에 `.ssh/` 폴더가 들어있게 된다. 그곳으로 들어가보면 다음과 같이 되어 있다.

```
.ssh/
├── id_rsa
├── id_rsa.pub
└── known_hosts
```

여기에서 `id_rsa`는 비밀키라서 소중하다. 여기에서 `id_rsa.pub`에 들어가보면 다음과 같이 키가 내장되어 있다.

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPJp45pz1Mk6JX1glUm/sOlj7T2iMwzd+WE23z9bEe6n5YEy9V34CyfhJhpmKVPnGY2+6ypvdM9emyEKeffcem9rSnimNWTPLFUWmm65P8BLQ0MZujs6Jj7copvMncqYxlgJT/YlnLEZvfPC0nebTgPfRYW73ycEbr7jjIO16owvlNonUPlsr/IbrK05/VTRGsoIZ26/UgtuG60sL1mP+sG71ZEO+fx0qBP/EWT626RFClig/NUK4AiFj7jyoGACLkX0USEjfrKhyvUdWDExGD4+ODDQK9Z4Z898KcLOomqYjA30GGwhwC5q5f9VU4nKo0So9p99GqDstyIkjqCZ11 manmarli@manmarli-900X3K
```

이 내용을 그대로 복사해서 `github`에 복사하면 된다. 이것은 어디에서 찾냐면 오른쪽 프로필 사진을 클릭하면 아래쪽에 `setting`가 있다. 여기에서 `SSH and GPG keys`를 선택하고 `New SSH key`를 누르고 그곳에 복사하면 된다. 그렇게 되면 그 공개키에 해당하는 비밀키를 소지하고 있는 컴퓨터에서 github에 접근할 수 있다.

그런데도 계속 비밀번호를 요구하는 것 같다면, 애초 연결을 `https`로 해놨기 때문이다. `github`에서는 연결을 하는 방식이 두 가지가 있는데, 한 가지는 `https`이고 다른 한 가지는 `ssh`이다. 비밀번호를 등록해놓았다고 하더라도 `https`를 사용하면 비밀번호를 요구하게 되므로, `ssh`를 사용해야 한다.
