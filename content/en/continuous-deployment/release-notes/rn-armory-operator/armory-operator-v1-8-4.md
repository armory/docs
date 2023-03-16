---
title: v1.8.4 Armory Operator
toc_hide: true
version: 01.08.04
description: Release notes for Armory Operator v1.8.4
date: 2023-01-23
---

## 2023-01-23 Release Notes

Upgrade the Operator using `kubectl replace`. See [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}) for details.

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

{{< include "known-issues/ki-operator-webhookerror.md" >}}

## Highlighted updates

* Resolves the issue that prevented Armory Operator from starting in some EKS clusters.

### Armory Operator

chore(dependency): update upstream Halyard version