---
title: v1.0.23 Armory Agent Service (2022-07-05)
toc_hide: true
version: 01.00.23

---

Fixes: 
1. Prevent connection data race. Behavior is now more consistent in flaky internet connection
2. Terminates old grpc stream when account changes are detected; fixing problem with accounts added on the fly not being recognized
