---
title: v1.12.0 Armory Halyard
toc_hide: true
version: 01.12.00
description: Release notes for Armory Halyard v1.12.0
---

## 2021/05/07 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

{{% include "release-notes/gcs-hal-op.md" %}}

## Highlighted updates

### Docker artifacts

This release adds support for the `repositoriesRegex` field. Use the field to provide regex that specifies what repositories Clouddriver caches images from. This is useful if you add repos frequently. Any new repo that matches the regex gets cached automatically.

This feature requires Armory Enterprise 2.25.0 or higher. For more information, see [Docker Artifacts]({{< ref "artifacts-docker-connect.md" >}}).

## Armory-extended Halyard

- chore(build): Upgrade open source Halyard to 1.42.0
