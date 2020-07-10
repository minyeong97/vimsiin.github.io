---
layout: post
title: secure shell
categories: [shell]
---

오늘은 `ssh`에 대해서 알아보자.

우선 `openssh-server`를 깔아야 한다.

```
% sudo apt install openssh-server
Reading package lists... Done
Building dependency tree
Reading state information... Done
openssh-server is already the newest version (1:7.6p1-4ubuntu0.3).
The following packages were automatically installed and are no longer required:
  fonts-liberation2 fonts-opensymbol gir1.2-geocodeglib-1.0 gir1.2-gst-plugins-base-1.0 gir1.2-gstreamer-1.0
  gir1.2-gudev-1.0 gir1.2-udisks-2.0 grilo-plugins-0.3-base gstreamer1.0-gtk3 libboost-date-time1.65.1
  libboost-filesystem1.65.1 libboost-iostreams1.65.1 libboost-locale1.65.1 libcdr-0.1-1 libclucene-contribs1v5
  libclucene-core1v5 libcmis-0.5-5v5 libcolamd2 libdazzle-1.0-0 libe-book-0.1-1 libedataserverui-1.2-2 libeot0
  libepubgen-0.1-1 libetonyek-0.1-1 libexiv2-14 libfreerdp-client2-2 libfreerdp2-2 libgc1c2 libgexiv2-2
  libgom-1.0-0 libgpgmepp6 libgpod-common libgpod4 liblangtag-common liblangtag1 liblirc-client0 liblua5.3-0
  libmediaart-2.0-0 libmspub-0.1-1 libodfgen-0.1-1 libqqwing2v5 libraw16 librevenge-0.0-0 libsgutils2-2 libssh-4
  libsuitesparseconfig5 libvncclient1 libwinpr2-2 libxapian30 libxmlsec1 libxmlsec1-nss lp-solve
  media-player-info python3-mako python3-markupsafe syslinux syslinux-common syslinux-legacy usb-creator-common
Use 'sudo apt autoremove' to remove them.
0 upgraded, 0 newly installed, 0 to remove and 81 not upgraded.
```

이미 설치 되어 있다. 검색을 하던 와중에 `ssh` 프로그램을 사용하는 사람도 있고 `openssh-server`를 사용하는 사람도 있는 것 같다.

`apt search`를 사용해서 `ssh`에 대해서 알아보자.

```
% apt search ssh
```

그랬더니 아주 긴 결과를 내뱉었는데, 다음이 그 중에 있었다.

```
openssh-client/bionic-updates,bionic-security,now 1:7.6p1-4ubuntu0.3 amd64 [installed,automatic]
  secure shell (SSH) client, for secure access to remote machines

openssh-client-ssh1/bionic 1:7.5p1-10 amd64
  secure shell (SSH) client for legacy SSH1 protocol

openssh-known-hosts/bionic,bionic 0.6.2-1 all
  download, filter and merge known_hosts for OpenSSH

openssh-server/bionic-updates,bionic-security,now 1:7.6p1-4ubuntu0.3 amd64 [installed]
  secure shell (SSH) server, for secure access from remote machines

openssh-sftp-server/bionic-updates,bionic-security,now 1:7.6p1-4ubuntu0.3 amd64 [installed,automatic]
  secure shell (SSH) sftp server module, for SFTP access from remote machines
```

의존성을 체크해보니 다음과 같이 `openssh-server` 뿐만 아니라 `openssh-client`도 설치한다는 것이다.

마찬가지로 `openssh-server`를 검색해보니

```
% apt search openssh-server
```

```
 ~  apt search openssh-server
Sorting... Done
Full Text Search... Done
openssh-server/bionic-updates,bionic-security,now 1:7.6p1-4ubuntu0.3 amd64 [installed]
  secure shell (SSH) server, for secure access from remote machines
```

딱히 의존성이 없는 것 같다.


결국 `ssh`를 설치하면 `openssh-server`를 설치하게 되는 것이다.

따라서

```
% sudo apt install ssh
```

만 하면 될 것이다.

이제 서버를 시작해야 한다. 그러기 위해선 다음 명령어를 쳐야 한다.

```
% sudo service ssh start
```

그런 다음 실행되는 상황을 살펴보자.

```
% service ssh start
```

