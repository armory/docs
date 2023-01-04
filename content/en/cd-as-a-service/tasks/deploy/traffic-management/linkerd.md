---
title: Configure Traffic Management Using LinkerD
linkTitle: LinkerD
description: >
  Configure your deployment to use LinkerD for traffic management.
aliases:
  - /cd-as-a-service/tasks/deploy/traffic-management/
---

## {{% heading "prereq" %}}

- You are familiar {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-management/smi-linkerd.md" >}}.
- In your target Kubernetes cluster, you must install a service mesh that complies with the [Service Mesh Interface (SMI) spec](https://github.com/servicemeshinterface/smi-spec). See the list of [supported service mesh products]({{< ref "cd-as-a-service/concepts/deployment/traffic-management#supported-service-mesh-products" >}}) that have been tested with Armory CD-as-a-Service.

>CD-as-a-Service does not configure proxy sidecar injection.

## Configure traffic management

Add a top-level `trafficManagement.targets` section to your deployment file.

{{% include "cdaas/dep-file/tm-smi-config.md" %}}
