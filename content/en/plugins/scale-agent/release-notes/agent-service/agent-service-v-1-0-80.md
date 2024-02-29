---
title: v1.0.80 Armory Agent Service (2024-02-27)
toc_hide: true
version: 01.00.80
date: 2024-02-27
---

### Fixes
- Better support for correct resolution of kinds with the same name and different API group.

> This fix is important in k8s engines like OpenShift where different kinds have the same name such as Ingress.
