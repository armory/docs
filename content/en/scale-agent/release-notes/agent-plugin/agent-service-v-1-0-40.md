---
title: v1.0.40 Armory Agent Service (2023-01-23)
toc_hide: true
version: 01.00.40
date: 2023-01-23
---

Changed:
* Now serverside apply sets default values from kubernetes 1.26.1 library (e.g. Deploy spec.containers[].containerPorts.protocol=TCP)
Added:
* Config flags: kuberentes.accounts[].skipManifestDefaults, kubernetes.accounts[].skipServerSideApply in order to allow users to fallback to client side apply without default values (Might be required for k8s clusters in version =<1.21)

