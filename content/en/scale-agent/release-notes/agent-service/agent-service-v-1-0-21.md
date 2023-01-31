---
title: v1.0.21 Armory Agent Service (2022-04-19)
toc_hide: true
version: 01.00.21
date: 2022-04-19
---

### Fixes

* Fixes increased CPU usage when using the `tokenCommand` setting for authenticating GRPC requests.
* Fixes an error introduced in the previous version (1.0.20) that could cause disconnections from clouddriver not able to recover under certain conditions.

### Known Issues

* Agent may be restarted because of a nil pointer deference error if the connection to clouddriver is lost before the initial account discovery is finished.
