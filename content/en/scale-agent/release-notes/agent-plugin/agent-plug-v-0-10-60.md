---
title: v0.10.60 Armory Agent Clouddriver Plugin (2022-11-21)
toc_hide: true
version: 00.10.60
date: 2022-11-21
---

Features:

- Close Agent connection when it stops receiving Agent ping after `kubesvc.cache.agentCleanupFrequencySeconds` instead of when a stream interruption happens. This prevents unnecessary cleanup of resources when only the stream needs restarting.

Changes:
- Use different thread pool to handle Agent disconnections.
- Make the heartbeat and cleanup more resilient.

