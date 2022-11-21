---
title: v0.9.75 Armory Agent Clouddriver Plugin (2022-11-21)
toc_hide: true
version: 00.09.75

---

Feats:

- Closes agent connection when it stops receiving agent ping after kubesvc.cache.agentCleanupFrequencySeconds instead of when a stream interruption happens, this prevents unnecessary cleanup of resources when only the stream needs restarting.

Changes:

- Use different thread pool to handle agent disconnections
- Makes the heartbeat and cleanup more resilient
