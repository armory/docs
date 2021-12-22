---
title: v1.4.1 Armory Operator
toc_hide: true
version: 01.04.01
description: Release notes for Armory Operator v1.4.1
---

## 2021/07/24 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

When canary validators are enabled and users add `metadataCachingIntervalMS` to the canary configuration, deployment fails with the following error message in the Operator logs:

```text
json: cannot unmarshal number into Go struct field PrometheusCanaryServiceIntegration.metadataCachingIntervalMS of type bool
```

**Workaround**

None.

**Affected versions:** Armory Operator 1.4.1, Halyard 1.12

**Fixed versions:** Armory Operator 1.5.1


## Highlighted updates

This release updated two of the libraries that the Operator uses:
- `krb5-libs` to 1.18.4-r0
- Halyard to 1.12.0-0422a50-operator

### Armory Operator

* chore(halyard): update halyard-version
* chore(halyard): fix krb5-libs version

