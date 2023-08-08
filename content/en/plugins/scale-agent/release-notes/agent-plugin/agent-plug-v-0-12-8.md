---
title: v0.12.8 Armory Agent Clouddriver Plugin (2023-07-19)
toc_hide: true
version: 00.12.08
date: 2023-07-19
---

### Feature:
* Add flag `kubesvc.heartbeat.enabled` defaults to `true`. Setting to false will make clouddriver rely con grpc connection instead of pings to consider a connection alive. Useful for remote agent configurations.

### Fixes:
* Prevent issue: Sometimes clouddriver treats recently established connections as expired when they haven't received a ping message yet
