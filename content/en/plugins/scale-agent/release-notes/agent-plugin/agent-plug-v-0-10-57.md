---
title: v0.10.57 Armory Agent Clouddriver Plugin (2022-10-25)
toc_hide: true
version: 00.10.57
date: 2022-10-25
---

Fix to cache namespaces independent of the `kubesvc.runtime.defaults.onlySpinnakerManaged` property value. This change allows agent plugin to retrieve all connected accounts using the `GET /credentials` endpoint.
