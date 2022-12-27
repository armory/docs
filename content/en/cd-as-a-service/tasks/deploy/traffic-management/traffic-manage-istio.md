---
title: Configure Traffic Management Using Istio
linkTitle: Istio
description: >
  Configure your deployment to use Istio for traffic management.
aliases:
  - /cd-as-a-service/tasks/deploy/traffic-management/
---

## {{% heading "prereq" %}}

* You have read {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-management/canary-istio.md" >}}
* In your Kubernetes cluster, you have [installed the Istio services](https://istio.io/latest/docs/setup/getting-started/) but not the `VirtualService` and `DestinationRule` resources. You configure those resources separately. 

