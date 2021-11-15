---
title: Known Issues and Limitations
weight: 9999
exclude_search: true
---

## Manifest requirements

{{< include "known-issues/ki-borealis-manifest-limitation.md" >}}

## `armory.cloud` config block location

In Armory Enterprise 2.26.3, the location of where you put the `armory.cloud` block when configuring the Project Aurora Plugin is different from other versions. This issue affects both Operator and Halyard based installations of Armory Enterprise.

For more information, see the [known issues for Project Aurora]({{< ref "aurora-install#armorycloud-block-location" >}}).