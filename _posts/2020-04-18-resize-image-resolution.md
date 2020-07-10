---
layout: post
title: resize image resolution
categories: [linux]
---

먼저 `imagemagick`를 깔아야 한다.

```
sudo apt install imagemagick
```

그 후에 다음과 같이 한다.

```
convert <image_name>.png -resize 600x300 <changed_name>.png
```
