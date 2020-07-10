---
layout: post
title: filesystem hierarchy comparison
categories: [linux]
---

### Os 의 파일 시스템 계층 구조 비교

각 운영체제마다 파일 계층 구조가 조금씩 다르다. 알아보자.

#### Linux

| 파일 이름 | 하는 역할 |
| - | - |
| / | root directory |
| /bin/ | single user mode로 컴퓨터를 실행할 때 필요한 최소한의 실행파일들... cat, ls, cp 등 많이 사용하지 않는다.  |
| /sbin/ | 컴퓨터가 boot 할 때 필요한 실행 파일들 |
| /lib/ | /bin/ 이 사용할 라이브러리 파일들이 존재한다 |
| /etc/ | 컴퓨터의 설정 파일들이 위치해 있는 폴더 |
| /home/ | 컴퓨터의 사용자 디렉토리. 대체로 별도의 파티션에 존재한다고 한다 |
| /usr/ | 읽기 전용 사용자의 데이터가 있는 파일. 주로 사용자들의 어플리케이션등이 존재한다. |

여기에서 `/usr/` 파일 아래에는 또 다양한 디렉토리들이 존재한다.

| 파일 이름 | 하는 역할 |
| - | - |
| /usr/bin/ | 모든 사용자의 비필수 명령어 바이너리 |
| /usr/sbin/ | system binary. 비필수적이며, 네트워크 데몬들이 이곳에 존재한다. |
| /usr/lib/ | /usr/bin/ 또는 /usr/sbin/ 이 필요한 라이브러리들이 이곳에 저장된다. |
| /usr/local/ | 우리가 앱이나 바이너리를 설치하면 이곳에 설치된다. 따로 bin/, lib/, share/ 등이 존재한다. |
| /usr/include/ | 표준 `include` 파일들이 여기에 존재한다. |

#### Windows

#### MacOs

