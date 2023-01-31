---
title: v0.9.84 Armory Agent Clouddriver Plugin (2023-01-25)
toc_hide: true
version: 00.09.84
date: 2023-01-25
---

Changes: 
- Add filter to process cache events just if the account is know and connected

Refactor:
- Agent and Clouddriver disconnection to ensure a account has just one agent doing caching
- Agent registration process to ensure don't have invalid assignments under `kubesvc_assignments` table
