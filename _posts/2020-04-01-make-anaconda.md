---
layout: post
title: make anaconda
categories: [python]
---

왜 제목을 make anaconda라고 했는지는 모르겠지만, 아나콘다를 설치하는 방법이다.

아나콘다는 파이썬 모듈 등과 주피터 노트북을 포함하는 데이터과학 통합 패키지이다. 설치를 하려면 다음과 같이 해야 한다.

아나콘다의 홈페이지에 가서 그곳의 쉘 스크립트를 다운 받는다. 다운 받은 후에 `chmod`를 사용해서 사용허가를 받아야한다.

```
sudo chmod +x <anaconda-shell-script-file.sh>
```

이를 사용해서 모든 사용자가 실행 권한을 가지게 된다. 그러면 다음과 같이 실행하면 된다.

```
./<anaconda-shell-scipt-file.sh>
```
