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
No known issues.

## Highlighted updates

### New registrationId label for SpinnakerService Status
This release adds the new `registrationId` label under the status section on the `spinnakerservices.spinnaker.armory.io` CRD, You will need to install the latest CRD in order to see this feature working.

In order to visualize the new label, you can use the following command `kubectl -n spinnaker get spinsvc`.

### Armory Operator

* feat(validators): add prometheus canary validator
* feat(validators): add aws canary validator
* feat(validator): add clouddriver ha validation
* feat(registration-id): add registration id
