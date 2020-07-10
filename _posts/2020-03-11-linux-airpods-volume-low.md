---
layout: post
title: linux airpods volume low
categories: [linux]
---

에어팟을 리눅스에 연결했는데 볼륨이 너무 작다 싶으면 다음을 해보면 된다.

```
sudo vim /lib/systemd/system/bluetooth.service
```

그 파일 안에서 다음을

```
ExecStart=/usr/lib/bluetooth/bluetoothd
```

다음과 같이 수정한다.

```
ExecStart=/usr/lib/bluetooth/bluetoothd --noplugin=avrcp
```

그리고 다시 시작해주면 된다.

```
sudo systemctl daemon-reload
sudo systemctl restart bluetooth
```
