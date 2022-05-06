---
title: Configure Service Mesh Traffic Management
linktitle: Configure Traffic Management
description: >
  Configure canary strategy traffic management using a service mesh.
exclude_search: true
---

## Canary deployments using service mesh traffic management

When you deploy using a traditional pod-ratio canary strategy, the percentage of traffic flowing to each version of your app is determined by the relative number of pods running each version. Armory CDaaS scales pods up and down to achieve the desired traffic weight.

If you don't want to tie traffic weights to the number of running pods, you can manage traffic using a service mesh that implements the Service Mesh Interface's [TrafficSplit spec](https://github.com/servicemeshinterface/smi-spec/blob/main/apis/traffic-split/v1alpha4/traffic-split.md). The TrafficSplit resource weights traffic between versions of your app.


Using a service mesh with your canary strategy provides the following benefits:

* **Granular traffic weights**: you can direct 1% of traffic to the new version of your software, regardless of the current number of running pods.
* **Instantaneous weight shifts and rollbacks**: since the traffic weights are implemented by the service mesh, you won't need to wait for pods to scale up or down during a traffic weight change or rollback.

## {{% heading "prereq" %}}

In your target Kubernetes cluster, you must install a service mesh that complies with the [Service Mesh Interface (SMI) spec](https://github.com/servicemeshinterface/smi-spec). See the list of [supported service mesh products](#supported-service-mesh-products) that have been tested with Armory CDaaS.

>CDaaS does not configure proxy sidecar injection.


## Configure traffic management

Add a top-level `trafficManagement` section to your deployment file.

{{< prism lang="yaml" line-numbers="true" line="" >}}
trafficManagement:
  - targets: ["<target>"]
    smi:
      - rootServiceName: "<rootServiceName>"
        canaryServiceName: "<rootServiceName>-canary"
        trafficSplitName: "<rootServiceName>"
{{< /prism >}}

* `targets`: (Optional) comma-delimited list of deployment targets; if omitted, the traffic configuration block is applied to all targets.
   * `smi`
      * `rootServiceName`: (Required) the name of a Kubernetes `Service`; the SMI `TrafficSplit` spec defines a root service as the fully-qualified domain name (FQDN) used by apps to communicate with your service. The FQDN should exist at the time of deployment. Its service selector should target a Kubernetes `Deployment` resource in your deployment's manifests.     
      * `canaryServiceName`: (Optional) If @TODO
      * `trafficSplitName`: (Optional) CDaaS uses the provided name when generating an SMI `TrafficSplit`


## Supported service mesh products

* [Linkerd](https://linkerd.io/)