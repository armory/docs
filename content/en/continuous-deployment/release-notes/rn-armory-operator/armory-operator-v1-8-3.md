---
title: v1.8.3 Armory Operator
toc_hide: true
version: 01.08.03
description: Release notes for Armory Operator v1.8.3
date: 2023-01-23
---

## 2023-01-23 Release Notes

Upgrade the Operator using `kubectl replace`. See [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}) for details.


## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

Armory Operator may fail to start in some EKS clusters. Please upgrade to Armory Operator v1.8.4.  

{{< include "known-issues/ki-operator-webhookerror.md" >}}

## Highlighted updates

* Helm chart support for basic-mode installation pattern

### Armory Operator

chore(helm): Add support for namespace-scoped RBAC.