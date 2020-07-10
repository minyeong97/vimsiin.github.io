---
layout: post
title: jupyter init
categories: [python]
---

주피터 노트북을 실행시키는 방법은 다음과 같다.

먼저 가상환경을 실행시켜야 한다.
가상환경을 실행시키기 위해서는 다음과 같은 명령어를 쳐야 한다.

```
python -m venv <venv-name>
```
`<venv-name>`는 아무것으로 해도 좋다. 여기에서 `python-venv`를 설치해야 할 수 도 있다.

```
sudo apt install python3-venv
```

그렇게 하면 가상환경이 만들어진다. 이 가상환경을 실행시킨다.

```
source ./<venv-name>/bin/activate
```

그러면 프롬프트 앞에 `(<venv-name>)`과 같이 나오게 된다.

중요한 것은 이 가상환경을 실행한 다음에 그곳에다가 `jupyter`를 설치해야 한다는 것이다.
주피터는 파이썬 모듈이기 때문에 가상환경을 먼저 실행하고 실행해야 한다. 그러지 않으면 모듈들을 설치해도 주피터가 알아듣지 못하게 된다.

따라서 다음과 같은 명령을 통해서 주피터를 설치한다.

```
pip3 install jupyter
```

설치가 끝나고 나서는 다음과 같이 실행시켜준다

```
jupyter notebook
```
