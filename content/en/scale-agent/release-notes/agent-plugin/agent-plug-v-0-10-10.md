---
title: v0.10.10 Armory Agent Clouddriver Plugin (2021-12-29)
toc_hide: true
version: 00.10.10
date: 2021-12-29
---

## Improvements

Namespaces and CustomResourceDefinitions are now cacheable even when
 `kubesvc.runtime.defaults.onlySpinnakerManaged` is set to `true`. This change allows the UI to show that information consistently regardless of how that property is configured.
