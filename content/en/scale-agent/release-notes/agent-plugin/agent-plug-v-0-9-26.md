---
title: v0.9.26 Armory Agent Clouddriver Plugin (2021-12-29)
toc_hide: true
version: 00.09.26
date: 2021-12-29
---

Namespaces and CustomResourceDefinitions are now cacheable even when
 `kubesvc.runtime.defaults.onlySpinnakerManaged` is set to `true`. This change allows the UI to show that information consistently regardless of how that property is configured.

