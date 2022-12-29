---
title: Configure Traffic Management Using Istio
linkTitle: Istio
description: >
  Configure your deployment to use Istio for traffic management.
---

## {{% heading "prereq" %}}

* You have read {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-management/canary-istio.md" >}}
* In your Kubernetes cluster, you have [installed the Istio services](https://istio.io/latest/docs/setup/getting-started/) but not the `VirtualService` and `DestinationRule` resources. You configure those resources separately and as part of your CD-as-a-Service deployment. 
* You know how to configure a [`VirtualService`](https://istio.io/latest/docs/reference/config/networking/virtual-service/) and associated [`DestinationRule`](https://istio.io/latest/docs/reference/config/networking/virtual-service/#Destination).

## Create your Istio config manifest

Create an `istio-config.yaml` manifest that defines your `VirtualService` and `DestinationRule` resources. Armory recommends one `VirtualService` with one `DestinationRule` for your deployment because CD-as-a-Service modifies these resources based on the canary strategy that you define in your deployment file. You can deploy these resources separately or as part of your CD-as-a-Service deployment.



## Configure your CD-as-a-Service deployment

Your app's deployment file should define a canary strategy in addition to the Istio configuration.  In the `trafficManagement.targets` section of your deployment file, add your Istio resources.

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
        activeSubsetName: current  
        canarySubsetName: next     
{{< /prism >}}

`targets`: (Optional) comma-delimited list of deployment targets; if omitted, CD-as-a-Service applies the traffic management configuration to all targets.

`istio.virtualService.name`: 

`istio.virtualService.httpRouteName`: 

`istio.destinationRule`:  Optional if there is only one destination on the service.

`istio.destinationRule.name`: destinationRule.metadata.name

`istio.destinationRule.activeSubsetName`: (Optional)  #OPTIONAL (if only 1 active subset on DR)- virtualService.http.route[].destination.subset

`istio.destinationRule.canarySubsetName`: (Optional)  #OPTIONAL - virtualService.http.route[].destination.subset

## Example configs

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;width:100%;}
.tg td{border-color:black;border-style:solid;border-width:1px;padding:10px 5px;width:50%;}
.tg th{border-color:black;border-style:solid;border-width:1px;padding:10px 5px;width:50%;}
.tg .tg-73oq{border-color:#000000;text-align:left;vertical-align:top}
.tg .tg-0lax{text-align:left;vertical-align:top}
</style>
<div class="tg-wrap"><table class="tg">
<thead>
  <tr>
    <th class="tg-73oq">Istio Resources</th>
    <th class="tg-73oq">CD-as-a-Service Deployment</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0lax">
    {{< prism lang="yaml" line="5, 14 " line-numbers="true" >}}
#~/deployments/manifests/istio-config.yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
    - reviews
  http:
  - route:
    - destination:
        host: reviews.istiodemo.svc.cluster.local
        subset: stable
    name: reviews
---
apiVersion: networking.istio.io/v1alpha3
kind: DestinationRule
metadata:
  name: reviews
spec:
  host: reviews.istiodemo.svc.cluster.local
  subsets:
  - name: stable
    labels:
      app: reviews
{{< /prism >}}
    </td>
    <td class="tg-0lax">
    {{< prism lang="yaml" line=" " line-numbers="true">}}
# deployment.yaml
version: v1
kind: kubernetes
application: reviews
targets: 
  dev:
    account: dev
    namespace: istiodemo
		strategy: strategy1 
manifests:
  - path: ~/manifests/bookinfo/reviews-v3.yaml
strategies:
  strategy1:
    canary: 
      steps:
        - setWeight:
            weight: 10
        - pause:
            untilApproved: true
        - setWeight:
            weight: 57
        - pause:
            untilApproved: true
trafficManagement:
  - targets: ["dev"]
    istio:
    - virtualService: 
        name: reviews 
        httpRouteName: xyz
      destinationRule: 
        name: reviews 
        activeSubsetName: current
        canarySubsetName: next
{{< /prism >}}
    </td>
  </tr>
</tbody>
</table></div>

