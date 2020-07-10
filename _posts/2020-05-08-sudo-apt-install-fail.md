---
layout: post
title: sudo apt install fail
categories: [linux]
---

만약 평범하게 sudo apt install을 때렸는데 안되는 경우가 발생하고 다음과 같은 오류가 뜨게 되면

```
E: Could not get lock /var/lib/dpkg/lock-frontend - open (11: Resource temporarily unavailable)
E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
```

다음을 시행하면 된다.

```
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo dpkg --configure -a
```

근데 여기에서 마지막을 시행하면 다음과 같은 에러가 뜰 때가 있다.

```
dpkg: error: dpkg frontend is locked by another process
```

이것을 해결하기 위해서 다음과 같이 해야 한다.

```
lsof /var/lib/dpkg/lock
ps cax | grep dpkg
```

이렇게 하고 dpkg에 대한 pid가 나오면, 그것을 사용해서 다음을 해야 한다.

```
sudo kill <pid>
#wait
sudo rm /var/lib/dpkg/lock
```
을 하면 완료된다.
