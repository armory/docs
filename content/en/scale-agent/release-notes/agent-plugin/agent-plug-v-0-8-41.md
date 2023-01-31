---
title: v0.8.41 Armory Agent Clouddriver Plugin (2022-01-25)
toc_hide: true
version: 00.08.41
date: 2022-01-25
---

## Improvements

* The list of namespaces is now available sooner. Upon initial registration with the Armory Agent, the list of namespaces of each account gets sent. Previously, they were received after the watching mechanism in Agent was finished. This change requires using the Armory Agent Service versions 1.0.3/0.6.14 or later.
