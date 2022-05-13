---
title: v1.3.0 Operator for Spinnaker
toc_hide: true
version: 01.03.00
description: Release notes for the open source Operator v1.3.0
---

## 2022/05/16 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

No known issues.

## Highlighted updates

Operator now supports Kubernetes versions greater than 1.21. The following
table outlines compatible versions of Operator, Kubernetes, and Spinnaker.

| Kubernetes Version         | Spinnaker Operator Version     | Spinnaker Version                |
| :------------------------- | :----------------------------- | :------------------------------- |
| < 1.21                     | <= 1.6.x                       | <= 1.28.0                        |
| >= 1.21                    | >= 1.7.x                       | All Supported Spinnaker Versions |

For guidance on upgrading the Operator, consult our {{< linkWithTitle "op-manage-operator.md" >}} guide.

### Armory Operator

* feat(core): upgrade to operator-sdk 0.18
