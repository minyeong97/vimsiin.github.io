---
layout: post
title: unary increment on pointer
categories: [cc++]
---

I didn't install Hanguel on my Virtual Box Ubuntu emulator.
So I record in English.

If you are trying to linear-traverse an array, you might think of incrementing the pointer by 1

```
int *p = ...
```

and you might think the unary increment operator might work.

```
p++;
```

but it doesn't. You must use binary add operator

```
p = p + 1;
```

I do not know why.
