---
title: v1.2.5 Operator for Spinnaker
toc_hide: true
version: 01.02.05
description: Release notes for open source Operator v1.2.5
date: 2021-05-07
---

## 2021/05/07 Release Notes

Upgrade the Operator using `kubectl replace`. See [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}) for details.


## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known Issues
No known issues.

## Highlighted updates

### Docker artifacts

This release adds support for the `repositoriesRegex` field. Use the field to provide regex that specifies what repositories Clouddriver caches images from. This is useful if you add repos frequently. Any new repo that matches the regex gets cached automatically.

This feature requires Armory Continuous Deployment 2.25.0 or higher. For more information, see [Docker Artifacts]({{< ref "artifacts-docker-connect.md" >}}).

### Spinnaker Operator

* feat(validation): Add a CloudFoundry validation.
* chore(halyard): Update halyard version.
