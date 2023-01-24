---
title: Traffic Management Using Istio
linkTitle: Istio
description: >
  Learn how CD-as-a-Service implements traffic management using Istio.
---

## {{% heading "prereq" %}}

* You are familiar with the following [Istio](https://istio.io/latest/) concepts:

  * [Traffic Management](https://istio.io/latest/docs/concepts/traffic-management/)
  * [Virtual Service configuration](https://istio.io/latest/docs/reference/config/networking/virtual-service/)

## How CD-as-a-Service shapes traffic

In the following example, you define a CD-as-a-Service deployment that uses a VirtualService and DestinationRoute:

{{< include "cdaas/deploy/istio-example.md" >}}

When you deploy your app, CD-as-a-Service modifies your VirtualService and DestinationRule, setting weights for `stable` and `canary` subsets based on the weights specified in your deployment strategy.  CD-as-a-Service also adds the `armory-pod-template-hash` label to the DestinationRule subsets for routing traffic to the pods of each ReplicaSet. 

{{< prism lang="yaml" line="13-17, 30-34" line-numbers="true" >}}
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
      weight: 10
    - destination: 
        host: reviews.istiodemo.svc.cluster.local
        subset: canary
      weight: 90
    name: http-route-reviews
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
      armory-pod-template-hash: gc6647
  - name: canary
    labels:
      app: reviews
      armory-pod-template-hash: cd6648
{{< /prism >}}

At the end of the deployment, CD-as-a-Service removes the lines it added so the resources look the same as before the deployment began. 

## Additional capabilities

* You have two options for deploying your VirtualService and DestinationRule Istio resources:

   1. Separately, before your CD-as-a-Service deployment
   1. As part of your CD-as-a-Service deployment, included in the same directory as your app manifest

* You can use a VirtualService that has more than one route as long as the route is named within the resource and specified in your deployment file.
* CD-as-a-Service supports both FQDN and short names in the `host` fields.


## {{%  heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/tasks/deploy/traffic-management/istio.md" >}}