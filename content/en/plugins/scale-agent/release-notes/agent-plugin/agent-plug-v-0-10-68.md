---
title: v0.10.68 Armory Agent Clouddriver Plugin (2023-01-25)
toc_hide: true
version: 00.10.68
date: 2023-01-25
---

Changes:
- Enhance filter to process cache events only if the account is known and connected.

Refactor:
- Agent and Clouddriver disconnection to ensure accounts with only one agent doing caching.
- Agent registration process to ensure there aren't invalid assignments under `kubesvc_assignments` table.