---
title: v0.9.34 Armory Agent Clouddriver Plugin (2022-01-28)
toc_hide: true
version: 00.09.34
date: 2022-01-28
---

## Improvements
* Optimized performance of "GET /applications/{application}/serverGroups" request for large number of results, by splitting big queries into multiple smaller ones.

## Changes
* Response of "GET /armory/agents" replaces the "connected" field by "clouddriverAlive", which better represents the meaning of the entry.
