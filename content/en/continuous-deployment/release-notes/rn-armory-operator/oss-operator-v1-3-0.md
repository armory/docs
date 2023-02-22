---
title: v1.3.0 Operator for Spinnaker
toc_hide: true
version: 01.03.00
description: Release notes for open source Operator v1.3.0
date: 2023-02-22
---

## 2023/02/22 Release Notes

## Security

Armory scans the codebase as we develop and release software. For information
about CVE scans for this release, contact your Armory account representative.

## Known Issues

No known issues.

## Highlighted updates

This release introduces support for Kubernetes versions greater than or equal
to 1.22. Please refer to the {{< linkWithTitle
"/continuous-deployment/installation/armory-operator/op-manage-operator.md" >}}
page for instructions on how to upgrade to the latest version. We recommend
upgrade your Operator installation before upgrading your Kubernetes cluster
beyond 1.21.

There are no other expected migration steps for this upgrade.

The following table outlines compatible versions of Operator, Kubernetes, and
Armory Enterprise:

{{% include "armory-operator/operator-compat-matrix.md" %}}

### Spinnaker Operator

* chore(dependency): update upstream oss halyard version.
* fix(build): kind unable to start control-plane
* chore(build): make sure forks can run tests, but not create releases
* fix(xform): transforming k8s secrets
* feat(operator): update files for the new API of k8s v1.22
* feat(lambda/validation): Validatation regarding the AWS Lambda using the GO
  SDK to get the Lambda Functions using the AWS provider credentials
