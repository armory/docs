---
title: v1.8.0 Armory Operator
toc_hide: true
version: 01.08.00
description: Release notes for Armory Operator v1.8.0
date: 2022-12-19
---

## 2022-12-19 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

No known issues.

## Highlighted updates

Operator now supports Config Maps as a data source. 

```apiVersion: v1
kind: ConfigMap
metadata:
  name: halyard-config-map
data:
  config: |
    halyard:
      configSourceType: secret # or configMap
```
Operator now allows the option to use a different Regex Engine when structuring ignore patterns -- enabling this feature flag allows for negative lookahead. 

```
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true
          dinghyIgnoreRegexp2Enabled: true
```

### Armory Operator

* chore(secrets): Add SecretOrConfigMapData type
* feat(secrets): Add the secrets extracting from ConfigMap
* chore(halyard): bump halyard, add dinghyIgnoreRegexp2Enabled feature