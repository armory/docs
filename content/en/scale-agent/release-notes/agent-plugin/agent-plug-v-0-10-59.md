---
title: v0.10.59 Armory Agent Clouddriver Plugin (2022-11-12)
toc_hide: true
version: 00.10.59

---

Fix issue that allow more than one agent do the caching for one same account.
The issue was because of more than one agent plugin instance trying to assign cache at the same time (concurrency issue). 
These release introduce locks over caching assignment process to give time for each thread to complete the task.
Could use the following properties to :
1. Specify how long to wait for try to get the lock; if it is being  use by other thread `kubesvc.locks.waitToGetMilliseconds`; the default value is 3000 (3 seconds)
2. Specify how long a thread could keep a lock `kubesvc.locks.cleanupFrequencyMilliseconds`; the default value is 3000 (3 seconds)
