---
title: Configure Traffic Management Using Istio
linkTitle: Istio
description: >
  Configure your deployment to use Istio for traffic management.
---

## {{% heading "prereq" %}}

* You have read {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-management/istio.md" >}}
* In your Kubernetes cluster, you have [installed the Istio](https://istio.io/latest/docs/setup/getting-started/). You do not need to deploy the VirtualService and DestinationRule resources. You configure those resources separately and as part of your CD-as-a-Service deployment. 
* You know how to configure Istio's [VirtualService](https://istio.io/latest/docs/reference/config/networking/virtual-service/) and associated [DestinationRule](https://istio.io/latest/docs/reference/config/networking/virtual-service/#Destination).

## Create your Istio resources manifest

Create an `istio-resources.yaml` manifest that defines your VirtualService and DestinationRule resources. Armory recommends one VirtualService with one DestinationRule for your deployment. CD-as-a-Service modifies these resources based on the [canary strategy]({{< ref "cd-as-a-service/reference/deployfile/ref-deployment-file#canary-fields" >}}) that you define in your deployment file. You can deploy these resources separately or as part of your CD-as-a-Service deployment.

## Configure your CD-as-a-Service deployment

Configure your Istio resources the `trafficManagement.targets` section of your deployment file.

{{% include "cdaas/dep-file/tm-istio-config.md" %}}

## Example resources and deployment files

{{% include "cdaas/deploy/istio-example.md" %}}




