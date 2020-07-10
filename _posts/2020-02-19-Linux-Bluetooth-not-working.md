---
layout: post
title: Linux Bluetooth not working
categories: [linux]
---

## 리눅스에서 블루투스가 안될 때

### 문제점

리눅스에서 블루투스 기기를 연결했으나 작동이 안될 때 다음과 같은 코드를 치면 된다.

```
% hciconfig hci0 sspmode 1
% hciconfig hci0 down
% hciconfig hci0 up
```
