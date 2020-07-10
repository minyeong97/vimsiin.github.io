---
layout: post
title: About chmod
categories: [shell]
---

## Chmod 에 관하여

chmod는 다음과 같이 사용할 수 있다.

```
% chmod 700 test.txt
```

가장 첫 자리는 유저에게, 두 번째 자리는 그룹에게, 세 번째 자리는 그 외 사용자 권한에 대한 숫자이다.

이와 다르게 다음과 같이 사용할 수 도 있다

```
% chmod u+r test.txt
```
위의 코드는 유저에게 읽는 권한을 추가로 부여해준다는 뜻이다.

다음과 같이 'a'를 사용하여 모든 대상(user, group, others)에게 변활를 줄 수 있다.

```
% chmod a=w test.txt
```
