---
title: v0.13.9 Armory Agent Clouddriver Plugin (2023-08-02)
toc_hide: true
version: 00.13.09
date: 2023-08-02
---

Features: 
- Notify agent that it could turn on the restart connection job if operations has not been received by it (enable since agent 1.0.59)
Fixes:
- Prevent to deleting accounts and it's cache due to zero connections on `kubesvc_accounts` table; this work was delegated to cleanup job which delete expired accounts base on the `kubesvc.cache.accountCleanupFrequencySeconds` property (10 minutes by default)
Changes: 
- Switch from thread pool executor to scheduled annotation for the agent liveness probe job; since it has better improvement
