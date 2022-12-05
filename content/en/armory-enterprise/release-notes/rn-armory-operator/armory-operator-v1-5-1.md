---
title: v1.5.1 Armory Operator
toc_hide: true
version: 01.05.01
description: Release notes for Armory Operator v1.5.1
date: 2021-12-21
---

## 2021/12/21 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

No known issues.

## Highlighted updates

This release fixes the [canary validator issue]({{< ref "armory-operator-v1-4-0#known-issues" >}}) that caused the Armory Enterprise deployment to fail when  `metadataCachingIntervalMS` was in the canary configuration.

In addition to the fix, new functionality has been added that enables users to disable the canary validators by adding `spec.validation.providers.canary: false` to the Operator configuration.

### Armory Operator

* fix(canary/validator): Errors on MetadataCachingIntervalMS
* fix(canary/validator): Enable or disable canary validation
