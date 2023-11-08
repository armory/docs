---
title: v1.8.6 Armory Operator
toc_hide: true
version: 01.08.08
description: Release notes for Armory Operator v1.8.8
date: 2023-05-11
---

## 2023-11-08 Release Notes

Upgrade the Operator using `kubectl replace`. See [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}) for details.

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

{{< include "known-issues/ki-operator-webhookerror.md" >}}

## Highlighted updates

* Removed CVE-2022-22965 by upgrading org.springframework:spring-core, org.springframework:spring-beans and org.springframework:spring-webmv to the version 5.3.18

### Armory Operator

chore(dependencies): updated operator armory-halyard version to 1.12.0-2c14811-operator
