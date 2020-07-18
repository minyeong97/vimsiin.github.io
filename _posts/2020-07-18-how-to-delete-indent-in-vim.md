---
layout: post
title: how to delete indent in vim
categories: []
---

`vim`은 다양한 방면에서 편리함을 준다. 특히 단축키와 관련된 기능들은 적응되면 그 어떤 툴 보다도 엄청난 생산성을 제공해준다. 몇가지 단축키들은 숨겨져서 찾기 어려운 경우도 많다. 그 중 대표적인 것이 `indent`에 관련한 것이다. 비쥬얼스튜디오에서는 `block selection`이 아주 잘 되어 있기 때문에 사각형 형태로 텍스트를 쉽게 선택하고 바꿀 수 있다. 물론 `vim`에서도 그런 기능이 `Ctrl + V`로 존재하지만, 어떤 경우에 먹히지 않는 경우가 있다. 그중 대표적인 것이 `indent deletion`이다.

![](https://lh3.googleusercontent.com/3dwggp9gY13k3SDjQwx-WKiIhUL3zuj6fCLjAKycwILpXBbypoEjLdRpzrkdDVFMToFNfV3YgZQX8GRJJSt4-JpuQaq8RD_qISOVUZ8QBUADTnIal8WMzurlYLHbJ9Qka-RQyOFkBQ=w2400)

만약 위와 같은 파이썬 코드에서 `indent`를 모두 삭제하고 싶으면, `block selection`을 하게 되면 먹히지 않는다. 방법은 `<`또는 `>` 단축키를 사용하는 것이다. `line selection`인 `Shift + V`를 사용해서 원하는 부분을 선택하고, 위의 단축키를 사용해서 `indent`를 바꿀 수 있다.

![](https://lh3.googleusercontent.com/V9zCQKtN9zo3umhRljXPXeZVw0g5PZulwPcF9psIP4FB0sEFzSq4DGHF5QMEMD5xClljr1aPFQuZum87vxn64w3gsi-meSTJ3wlKjVGrzTmt9-ZLPcn6gv-nrl04daaAb-P6PuH46g=w2400)
