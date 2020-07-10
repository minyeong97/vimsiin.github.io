---
layout: post
title: iMac recovery
categories: [life]
---

집에 고장난 애플 아이맥을 고치려고 한다.

먼저 부팅을 해보았더니 로딩 화면만 계속 나오고 켜지지 않는다.

`Command+R`을 눌러서 디스크 유틸리티로 들어갔다. 그곳에서 하드디스크를 선택하고 `First aid`를 선택했는데 언마운트하고 작업하다가 오류가 났다. 오류 코드는 8이다.

우선 어떤 작업이든 하려면 백업을 해야 하는데 나는 외장하드가 존재하지 않는다. 

그냥 디스크나 볼륨에 대해서 이것 저것 알아본 것은 쓴다.

### Mount

어떤 디스크를 운영체제가 접근하여 사용자로 하여금 쓰고 읽는 것을 가능하게 만들어주는 것을 마운트라고 한다. 그리고 그러지 못하는 만드는 것을 언마운트라고 한다. 데이터를 보호하고 사용하던 공간을 늘리거나 등의 일을 할 때에는 꼭 마운트를 해야 한다.

### Partioning

파티션은 다음과 같이 `GPT`와 `MBR`이 있다. 

`MBR`은 `Master Boot Record`로 최대 2Tb까지 채울 수 있다. 총 4개의 파티션을 만들 수 있으며, 부팅 파티션은 한개만 만들 수 있다. `Bios`나 `Uefi`에서 모두 확인할 수 있다.

`GPT`는 `Guid Partition Table`는 최대 용량이 8제타바이트,(800억 테라바이트)까지 가능하다. 사용자가 128개까지의 파티션을 만들 수 있으며, 부팅 파티션의 개수도 제한이 없다. 기본 Bios에서는 확인할 수 없다.

### 맥 리커버리

시도했지만 다음과 같은 메세지가 떴다.

```
The volume Macintosh HD could not be verified completely.
File system check exit code is 8.
Restoring the original state found as mounted.
Problem -69842 occurred while restoring the original mount state.
File system verify or repair failed.
Operation failed.
```

