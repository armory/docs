---
title: Configure Traffic Management Using LinkerD
linkTitle: LinkerD
description: >
  Configure your Armory CD-as-a-Service deployment to use LinkerD for traffic management.
aliases:
  - /cd-as-a-service/tasks/deploy/traffic-management/
---

## {{% heading "prereq" %}}

* You have read {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-management/smi-linkerd.md" >}}.
* In your target Kubernetes cluster, you have deployed LinkerD, a service mesh that complies with the [Service Mesh Interface (SMI) spec](https://github.com/servicemeshinterface/smi-spec).
* You know [how to create a CD-as-a-Service deployment config file]({{< ref "cd-as-a-service/tasks/deploy/create-deploy-config" >}}).

>CD-as-a-Service does not configure proxy sidecar injection.

## Configure traffic management

Add a top-level `trafficManagement.targets` section to your deployment file.

{{< include "cdaas/dep-file/tm-smi-config.md" >}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/reference/ref-deployment-file.md" >}}
