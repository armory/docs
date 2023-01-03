---
title: Configure Traffic Management Using Istio
linkTitle: Istio
description: >
  Configure your deployment to use Istio for traffic management.
---

## {{% heading "prereq" %}}

* You have read {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-management/istio.md" >}}
* In your Kubernetes cluster, you have [installed the Istio](https://istio.io/latest/docs/setup/getting-started/). You do not need to deploy the VirtualService and DestinationRule resources. You configure those resources separately and as part of your CD-as-a-Service deployment. 
* You know how to configure a [VirtualService](https://istio.io/latest/docs/reference/config/networking/virtual-service/) and associated [DestinationRule](https://istio.io/latest/docs/reference/config/networking/virtual-service/#Destination).

## Create your Istio resources manifest

Create an `istio-resources.yaml` manifest that defines your VirtualService and DestinationRule resources. Armory recommends one VirtualService with one DestinationRule for your deployment.CD-as-a-Service modifies these resources based on the [canary strategy]({{< ref "cd-as-a-service/reference/deployfile/ref-deployment-file#canary-fields" >}}) that you define in your deployment file. You can deploy these resources separately or as part of your CD-as-a-Service deployment.

## Configure your CD-as-a-Service deployment

In the `trafficManagement.targets` section of your deployment file, add your Istio resources.

{{< prism lang="yaml" line=" " >}}
# deployment.yaml
... 
trafficManagement:
  - targets: ["<target-name>"]
    istio:
    - virtualService: 
        name: <virtualService-metadata-name>
        httpRouteName: <virtualService-http-route-name>
      destinationRule: 
        name: <destinationrule-metadata-name>               
        activeSubsetName: stable  
        canarySubsetName: canary     
{{< /prism >}}

`targets`: (Optional) comma-delimited list of deployment targets; if omitted, CD-as-a-Service applies the traffic management configuration to all targets.

`istio.virtualService.name`: 

`istio.virtualService.httpRouteName`: 

`istio.destinationRule`:  Optional if there is only one destination on the service.

`istio.destinationRule.name`: destinationRule.metadata.name

`istio.destinationRule.activeSubsetName`: (Optional)  #OPTIONAL (if only 1 active subset on DR)- virtualService.http.route[].destination.subset

`istio.destinationRule.canarySubsetName`: (Optional)  #OPTIONAL - virtualService.http.route[].destination.subset

## Example resources and deployment files

{{< include "cdaas/deploy/istio-example.md" >}}


### Mapping

