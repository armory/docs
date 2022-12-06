---
title: v1.0.3 Armory Agent Service (2022-01-25)
toc_hide: true
version: 01.00.03

---

## Improvements

* The list of namespaces is now available sooner. Upon initial registration with the Armory Agent, the list of namespaces of each account gets sent. Previously, they were received after the watching mechanism in Agent was finished. This change requires using the Armory Agent Plugin version 0.10.17/0.9.33/0.8.41 or later.

## Fixes

* Fixed an issue where deployments of CRDs with version `v1beta1` were failing because Agent tried to deploy with version `v1` instead.
