---
title: v1.8.1 Armory Operator
toc_hide: true
version: 01.08.01
description: Release notes for Armory Operator v1.8.1
date: 2022-12-19
---

## 2022-12-19 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

{{< include "known-issues/ki-operator-webhookerror.md" >}}

## Highlighted updates

Operator now supports disabling the Admission Controller.

### Armory Operator

fix(helm): Adding disable-admission-controller option to Helm chart