---
title: v1.0.45 Armory Agent Service (2023-02-27)
toc_hide: true
version: 01.00.45
date: 2023-02-27
---

Refactor:
- the process that make sure old caching events are not send to the agent plugin.

The refactor was apply after notice that the [agent version 1.0.41](https://github.com/armory-io/agent-k8s/releases/tag/v1.0.41) could introduce a delay on agent registration if there are too many old caching  events pending.
