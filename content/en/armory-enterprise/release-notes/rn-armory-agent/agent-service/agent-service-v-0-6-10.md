---
title: v0.6.10 Armory Agent Service (2021-12-14)
toc_hide: true
version: 00.06.10
---

Add support to read values of a map yaml configuration when they are not specified as string values.
For example before when you add permission to agent like this : 

```
permissions:
  READ:
    - 123567
    - 891234
  WRITE:
    - 123567
    - 891234
```
The permissions will be not load and it is because the values was expected to be strings not numbers;
a quick solution to this was surround the values with quotes as following:
```
permissions:
  READ:
    - '123567'
    - '891234'
  WRITE:
    - '123567'
    - '891234'
```
