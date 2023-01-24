---
title: v1.0.40 Armory Agent Service (2023-01-23)
toc_hide: true
version: 01.00.40
date: 2023-01-23
---

Changed:
* Now serverside apply sets default values from kubernetes 1.26.1 library (for example Deploy's spec.containers[].containerPorts.protocol=TCP)
Added:
* Config flags: kuberentes.accounts[].skipManifestDefaults, kubernetes.accounts[].skipServerSideApply to opt to use client side apply without default values (Might be required for kubernetes clusters in version =<1.21)

