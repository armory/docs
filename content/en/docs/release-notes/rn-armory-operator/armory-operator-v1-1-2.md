---
title: v1.1.2 Armory Operator
toc_hide: true
version: 01.01.02
---

## 09/30/2020 Release Notes

## Known Issues
No known issues.

### Armory Operator

* chore(release): upgrade to oss operator 1.1.2
* chore(license): update LICENSES
* fix(helm): solve error assigning version to Helm Chart
* feat(ubi): add build for ubi images

### Spinnaker Operator

* fix(ingress): Support ingress with load balancer IP (GCE/bare metal)
* chore(halyard): Update halyard version.
* fix(validation): Validation Kubernetes accounts using the context passed on Spinnaker Service.
* refactor(status): Introducing a better way to check spinnaker health validating correct status of each pod.
