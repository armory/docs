---
title: Known Issues and Limitations
exclude_search: true
---

## Manifest requirements

Project Aurora and Borealis have the following constraints when deploying a manifest:

- The manifest must contain exactly 1 `Kubernetes Deployment` object within a single deployment file (Borealis) or Project Aurora Spinnaker Stage (Aurora).
- Deploying ReplicaSets is not  supported.
- Deploying Pods is not supported.

## `armory.cloud` config block location

In Armory Enterprise 2.26.3, the location of where you put the `armory.cloud` block when configuring the Project Aurora Plugin is different from other versions. This issue affects both Operator and Halyard based installations of Armory Enterprise.

For more information, see the [known issues for Project Aurora]({{< ref "aurora-install#armorycloud-block-location" >}}).