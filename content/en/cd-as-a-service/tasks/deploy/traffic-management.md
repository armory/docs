---
title: Configure Traffic Management Using a Service Mesh
linktitle: Configure Traffic Management
description: >
  Configure service mesh traffic management for your deployment.
exclude_search: true
---

## {{% heading "prereq" %}}

- You are familiar {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-mgmt.md" >}}.

- In your target Kubernetes cluster, you must install a service mesh that complies with the [Service Mesh Interface (SMI) spec](https://github.com/servicemeshinterface/smi-spec). See the list of [supported service mesh products]({{< ref "traffic-mgmt#supported-service-mesh-products" >}}) that have been tested with Armory CD-as-a-Service.

>CD-as-a-Service does not configure proxy sidecar injection.

## Configure traffic management

Add a top-level `trafficManagement` section to your deployment file.

{{< prism lang="yaml" line-numbers="true" line="" >}}
trafficManagement:
  - targets: ["<target>"]
    smi:
      - rootServiceName: "<rootServiceName>"
        canaryServiceName: "<rootServiceName>-canary"
        trafficSplitName: "<rootServiceName>"
    kubernetes:
      - activeService: "<activeServiceName>"
        previewService: "<previewServiceName>"
{{< /prism >}}

{{% include "cdaas/dep-file/traffic-mgmt-fields.md" %}}
