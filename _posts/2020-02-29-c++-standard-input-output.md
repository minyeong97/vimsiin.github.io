---
layout: post
title: c++ standard input output
categories: [cc++]
---

### 기억해야 할 것

`cin`에서는 모든 whitespace 들을 무시한다. 즉 띄어쓰기, 엔터, 탭(' ', '/n', '/t') 등을 무시한다.

#### 확실하지 않은 것

확실하지는 않지만 터미널에서 `standard input`을 할 때 입력 버퍼로 보내는 신호는 `/n`이 하는 것 같다.

### iostream

우리가 평소에 상요하던 `iostream`은 `istream`과 `ostream`을 포함한다. 각각에는 `cin`와 `cout`이 정의되어 있다. 지금까지 보기에는 이들은 독립적인 객체이고, 이들은 각각 `istream`에 있는 `istream` 클래스와 `ostream`에 있는 `ostream` 클래스의 instance인 것이다. 

각각에는 다음과 같은 함수들이 정의되어 있다.

```
istream& operator>> (int$ val);
```

그렇기 때문에 다양한 값들을 input으로 받을 수 있다.
