---
title: v0.11.47 Armory Agent Clouddriver Plugin (2023-08-02)
toc_hide: true
version: 00.11.47
date: 2023-08-02
---

Features: 
- Notify agent that it could turn on the restart connection job if operations has not been received by it (enable since agent 1.0.59)
Changes: 
- Switch from thread pool executor to scheduled annotation for the agent liveness probe job; since it has better improvement
