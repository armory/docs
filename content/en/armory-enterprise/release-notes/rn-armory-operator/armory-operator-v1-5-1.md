---
title: v1.5.1 Armory Operator
toc_hide: true
version: 01.05.01
description: Release notes for Armory Operator v1.5.1
---

## 2021/07/21 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues
No known issues.

## Highlighted updates

This release fixes the canary validator issue that caused the Armory Enterprise deployment to fail when  `metadataCachingIntervalMS` was in the canary configuration. The deployment failed with the following error message in the Operator logs:

```text
json: cannot unmarshal number into Go struct field PrometheusCanaryServiceIntegration.metadataCachingIntervalMS of type bool
```

Users may choose to disable the canary validators by adding `spec.validation.providers.canary: false` to the Operator configuration.

### Armory Operator

* fix(canary/validator): Errors on MetadataCachingIntervalMS
* fix(canary/validator): Enable or disable canary validation
