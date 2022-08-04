---
title: v0.6.10 Armory Agent Service (2021-12-14)
toc_hide: true
version: 00.06.10
---

## Improvements

Added support for reading values in a map (in config files) when they are not specified as string values. You no longer have to enclose the map values in quotes although you still can.

Previously, when you added permissions to the Armory Agent like the following:

```yaml
permissions:
  READ:
    - 123567
    - 891234
  WRITE:
    - 123567
    - 891234
```

The permissions did not load because the Armory Agent expected strings and not numbers. You had surround the values with quotes like the following:
```
permissions:
  READ:
    - '123567'
    - '891234'
  WRITE:
    - '123567'
    - '891234'
```
