---
layout: post
title: fatal refusing to merge unrelated histories
categories: [git]
---

## git 에서 pull 할 때 위와 같은 에러가 난다.

### 문제점

Remote 와는 전혀 다른 로컬 git 프로젝트에서 remote를 pull 하려고 할 때 생기는 에러이다. 생길 수 있는 시나리오는 다음과 같이 두 가지 정도이다.

1. remote의 것을 clone 해서 작업을 하고 있었지만, 어떤 이유에서인지 .git 디렉토리가 수정되었거나 삭제되면, git은 이 두 프로젝트가 서로 다른 프로젝트처럼 생각한다.
2. 아예 다른 프로젝트를 로컬에서 따로 작업하고 있다가 remote 에서 pull 을 시도하는 경우

### 해결책
#### --allow-unrelated-histories 를 사용하는 방법

위와 같은 시나리오를 아예 만들지 않는 것이 제일 좋겠지만, 다음과 같이 해결할 수 있다.

```
% git pull origin master --allow-unrelated-histories
```

#### git fetch 를 사용하는 방법

```
% git fetch --all
% git reset --hard origin/master
```

만약 다른 branch 를 가져오고 싶다면 다음과 같이 branch 의 이름을 가져오면 된다.

```
% git reset --hard origin/<branch_name>
```


