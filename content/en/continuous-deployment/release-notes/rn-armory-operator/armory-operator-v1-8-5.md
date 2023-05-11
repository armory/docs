---
title: v1.8.5 Armory Operator
toc_hide: true
version: 01.08.05
description: Release notes for Armory Operator v1.8.5
date: 2023-05-11
---

## 2023-05-11 Release Notes

Upgrade the Operator using `kubectl replace`. See [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}) for details.

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

{{< include "known-issues/ki-operator-webhookerror.md" >}}

## Highlighted updates

* Updates the Alpine version of the Operator image to Alpine 3.17

### Armory Operator

chore(docker): update Alpine version to 3.17