---
title: Known Issues and Limitations

---

## Deployment fails with a blank namespace error

There is a known issue where deployments fail if you do not specify a namespace in `targets.<deploymentName>.namespace` in your deployment file even if your manifest specifies a namespace.

**Workaround**:

Define the namespace in your deployment file even if your manifest specifies a namespace.

## Manifest requirements

{{< include "known-issues/ki-borealis-manifest-limitation.md" >}}

## `armory.cloud` config block location

In Armory Enterprise 2.26.3, the location of where you put the `armory.cloud` block as well as an additional `plugins` block when configuring the Project Aurora Plugin is different from other versions. This issue affects both Operator and Halyard based installations of Armory Enterprise.

For more information, see the [known issues for Project Aurora]({{< ref "aurora-install#armorycloud-block-location" >}}).