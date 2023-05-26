---
title: Configure Traffic Management Using Istio
linkTitle: Istio
description: >
  Configure your Armory CD-as-a-Service deployment to use Istio for traffic management.
categories: ["CD-as-a-Service"]
tags: ["Guides", "Deployment", "Traffic Management", "Istio", "Setup"]
---

## {{% heading "prereq" %}}

* You have read {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-management/istio.md" >}}
* You have [installed Istio](https://istio.io/latest/docs/setup/getting-started/) in your target cluster. 
* You know how to configure Istio's [VirtualService](https://istio.io/latest/docs/reference/config/networking/virtual-service/) and associated [DestinationRule](https://istio.io/latest/docs/reference/config/networking/virtual-service/#Destination).
* You know [how to create a CD-as-a-Service deployment config file]({{< ref "cd-as-a-service/tasks/deploy/create-deploy-config" >}}).

>CD-as-a-Service does not configure proxy sidecar injection.

## Create your Istio resources manifest

Create a manifest that defines your VirtualService and DestinationRule resources. Armory recommends one VirtualService with one DestinationRule for your deployment. CD-as-a-Service modifies these resources based on the [canary strategy]({{< ref "cd-as-a-service/reference/ref-deployment-file#canary-fields" >}}) that you define in your deployment file. You can deploy these resources separately or as part of your CD-as-a-Service deployment.

## Configure your CD-as-a-Service deployment

Configure your Istio resources in the `trafficManagement.targets` section of your deployment file.

{{< include "cdaas/dep-file/tm-istio-config.md" >}}

## Example resources and deployment files

In this example, you deploy an app called "reviews".  You define your Istio resources in `istio-resources.yaml` and deploy that manifest as part of your app deployment.

{{< include "cdaas/deploy/istio-example.md" >}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/reference/ref-deployment-file.md" >}}