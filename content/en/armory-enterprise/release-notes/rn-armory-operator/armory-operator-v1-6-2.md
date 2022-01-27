---
title: v1.6.2 Armory Operator
toc_hide: true
version: 01.06.02
description: Release notes for Armory Operator v1.6.2
---

## 2022/01/27 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

No known issues.

## Highlighted updates

Operator now supports the following configuration options for sidecars: `resources`,`readinessProbe`,  and `startupProbe`.

### Armory Operator

* feat(sidecars): Support resources and startup|readiness probes
* feat(artifacts/bitbucket): Support token credentials
* chore(halyard) Update halyard version