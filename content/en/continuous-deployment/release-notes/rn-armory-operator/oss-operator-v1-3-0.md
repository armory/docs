---
title: v1.3.0 Operator for Spinnaker
toc_hide: true
version: 01.03.00
description: Release notes for open source Spinnaker Operator v1.3.0
date: 2023-02-22
---

## 2023/02/22 Release Notes

## Security

Armory scans the codebase before releasing software. Contact your Armory representative for information about CVE scans for this release.

## Known Issues

No known issues.

## Highlighted updates

This release introduces support for Kubernetes versions 1.22 and newer.

The following table outlines compatible versions of Kubernetes, the Armory Operator, Armory CD, the Spinnaker Operator, and Spinnaker:

{{% include "armory-operator/operator-compat-matrix.md" %}}

>Armory recommends upgrading your Operator installation before upgrading your Kubernetes cluster beyond 1.21. There are no other expected migration steps for this upgrade.


### Spinnaker Operator

* chore(dependency): update upstream open source Halyard version.
* fix(build): kind unable to start control-plane
* chore(build): make sure forks can run tests, but not create releases
* fix(xform): transforming k8s secrets
* feat(operator): update files for the new API of k8s v1.22
* feat(lambda/validation): Validation regarding the AWS Lambda using the GO
  SDK to get the Lambda Functions using the AWS provider credentials
