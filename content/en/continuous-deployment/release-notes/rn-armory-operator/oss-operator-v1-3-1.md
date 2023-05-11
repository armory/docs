---
title: v1.3.1 Operator for Spinnaker
toc_hide: true
version: 01.03.01
description: Release notes for open source Spinnaker Operator v1.3.1
date: 2023-05-09
---

## 2023/05/09 Release Notes

Upgrade the Operator using `kubectl replace`. See [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}) for details.

## Security

Armory scans the codebase before releasing software. Contact your Armory representative for information about CVE scans for this release.

## Known Issues

No known issues.

## Highlighted updates

This release updates the Alpine base image version of the Spinnaker Operator and Halyard images to 3.17.

The following table outlines compatible versions of Kubernetes, the Armory Operator, Armory CD, the Spinnaker Operator, and Spinnaker:

{{% include "armory-operator/operator-compat-matrix.md" %}}

>Armory recommends upgrading your Operator installation before upgrading your Kubernetes cluster beyond 1.21. There are no other expected migration steps for this upgrade.


### Spinnaker Operator

* chore(docker): update alpine images operator + halyard (#292) (#293)