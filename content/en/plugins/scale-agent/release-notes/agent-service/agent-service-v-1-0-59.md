---
title: v1.0.59 Armory Agent Service (2023-08-02)
toc_hide: true
version: 01.00.59
date: 2023-08-02
---

### Features:
- Restart the connection to clouddriver agent plugin, if agent has not been receiving any operation in the last `clouddriver.keepAliveOperationSeconds` property specified seconds. To enable this feature, need to: update agent plugin version >= (0.13.9|0.12.10|0.11.47), and put a value different than zero on `clouddriver.keepAliveOperationSeconds` agent property