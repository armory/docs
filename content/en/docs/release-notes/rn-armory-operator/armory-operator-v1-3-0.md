---
title: v1.3.0 Armory Operator
toc_hide: true
version: 01.03.00
description: Release notes for Armory Operator v1.3.0
---

## 2021/06/30 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues
No known issues.

## Breaking changes

### Spinnaker Accounts CRD
The `spinnakeraccounts.spinnaker.io` CRD is not longer supported by this release, now you need to install `armoryaccounts.spinnaker.armory.io` CRD and rename your existing accounts. 


## Highlighted updates

### Support Diagnostics

This release adds support for the `Support Diagnostics` service for Armory Enterprise. 

This feature requires you to have diagnostics enabled within your `SpinnakerService`. For more information, see [Configure Support Diagnostics for Armory Enterprise]({{< ref "diagnostics-configure.md" >}}).

### Armory Operator

* feat(debug): send debug information when reconcile spinsvc
