---
title: v0.11.21 Armory Agent Clouddriver Plugin (2022-11-12)
toc_hide: true
version: 00.11.21

---

Prevents unexpected account caching.

The issue occurred because more than a single clouddriver instance was trying to request caching to agent at the same time (concurrency issue).
These release introduces locks around the caching assignment process to give time for each thread to complete the task, the locks auto expire so there isn't a deadlock risk (see below).

The following properties allow to adjust this mechanism:
1. `kubesvc.locks.waitToGetMilliseconds` specifies how long to wait for another thread to finish assignments before trying to get the lock, the default value is 3000 (3 seconds).
2. `kubesvc.locks.cleanupFrequencyMilliseconds` specifies how long a thread could keep a lock, the default value is 3000 (3 seconds).
