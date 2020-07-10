---
layout: post
title: how to modify file by replacing string
categories: [linux]
---

### 한 파일 내에서 특정 문자열을 바꾸고 싶은 경우

위와 같은 경우 다음 명령어를 사용하면 된다.

```
% sed -i -e 's/abc/xyz/g' test.txt
```

#### SED

sed 는 stream editor 의 약자로, ed와 동일하지만 전체 파일을 대상으로 실행할 수 있다.

-i option: inplace로, 그 파일 자체를 modify하는 옵션이다. 만약 다음과 같이 없으면,

```
% sed -e 's/abc/xyz/g' test.txt
```
cat 명령어를 실행한 것처럼 그냥 터미널에 출력만 되고 끝난다.

-e 옵션: 바꾸고자 하는 액션들을 넣어주는 옵션이다. 이 경우에는 's/abc/xyz/g'가 바로 이 옵션의 파라미터이다.

#### 's/<바꿀 단어>/<바꾼 단어>/g'

위의 argument는 's/abc/xyz/g'와 같이 사용할 수 있는데 abc를 xyz로 바꾸는 명령어이다.
vim에서 사용하는 명령어와 비슷하다.
