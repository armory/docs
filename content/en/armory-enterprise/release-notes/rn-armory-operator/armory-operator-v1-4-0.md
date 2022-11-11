---
title: v1.4.0 Armory Operator
toc_hide: true
version: 01.04.00
description: Release notes for Armory Operator v1.4.0
---

## 2021/07/21 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

{{% include "release-notes/operator/canary-deploy-fail.md" %}}

## Highlighted updates

### New `registrationId` label for SpinnakerService status
This release adds the new `registrationId` label, used for identifying your Armory Enterprise cluster, under the status section on the `spinnakerservices.spinnaker.armory.io` CRD. You need to install the latest CRD in order to see this feature working.

Execute `kubectl -n spinnaker get spinsvc` to see the new label after you have installed the latest CRD.

### Armory Operator

* feat(validators): add prometheus canary validator
* feat(validators): add aws canary validator
* feat(validator): add clouddriver ha validation
* feat(registration-id): add registration id
