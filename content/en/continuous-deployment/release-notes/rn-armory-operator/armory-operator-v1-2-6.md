---
title: v1.2.6 Armory Operator
toc_hide: true
version: 01.02.06
description: Release notes for Armory Operator v1.2.6
date: 2021-05-07
---

## 2021/05/07 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

{{% include "release-notes/gcs-hal-op.md" %}}

## Highlighted updates

### Docker artifacts

This release adds support for the `repositoriesRegex` field. Use the field to provide regex that specifies what repositories Clouddriver caches images from. This is useful if you add repos frequently. Any new repo that matches the regex gets cached automatically.

This feature requires Armory Continuous Deployment 2.25.0 or higher. For more information, see [Docker Artifacts]({{< ref "artifacts-docker-connect.md" >}}).

### Armory Operator

* chore(release): upgrade to oss operator 1.2.5
