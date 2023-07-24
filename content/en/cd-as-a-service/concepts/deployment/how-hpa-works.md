---
title: "Kubernetes Horizontal Pod Autoscaling in Armory CD-as-a-Service"
linktitle: "Kubernetes HPA"
description: >
  Learn how Armory Continuous Deployment-as-a-Service implements Kubernetes Horizontal Pod Autoscaling.
categories: ["Concepts"]
tags: ["Deployment", "Kubernetes", "Horizontal Pod Autoscaling"]
---

## {{% heading "prereq" %}}

Before you begin using a Kubernetes HorizontalPodAutoscaler in your CD-as-a-Service deployment, you should have a working knowledge of Horizontal Pod Autoscaling in Kubernetes. Consult the following Kubernetes docs:

- [Horizontal Pod Autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
- [HorizontalPodAutoscaler Walkthrough](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)

## Where to create your HorizontalPodAutoscaler

You must create your app's HorizontalPodAutoscaler in a manifest. See [Creating the autoscaler declaratively](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/#creating-the-autoscaler-declaratively) for a manifest example. Each Deployment resource can have its own HorizontalPodAutoscaler.


## How Horizontal Pod Autoscaling works in CD-as-a-Service

When you deploy a Deployment resource, CD-as-a-Service converts the Deployment to a ReplicaSet. Correspondingly, when you declare a HorizontalPodAutoscaler to scale a Deployment resource, CD-as-a-Service automatically reconfigures that HorizontalPodAutoscaler to reference the generated ReplicaSet resource.

### What happens during a deployment

CD-as-a-Service freezes scaling behavior at the start of a deployment.

Consider a deployment to upgrade your app from v1 to v2. In this scenario, the v1 app is running with 10 Pods. Your HorizontalPodAutoscaler scales your app down to 5 Pods minimum or up to 15 Pods maximum.

1. When the deployment begins, CD-as-a-Service deletes the v1 HorizontalPodAutoscaler. Your v1 app has 10 Pods but no longer scales up or down.
1. CD-as-a-Service deploys the v2 instance of your app with 10 Pods. Now you have 20 total Pods between v1 and v2.
1. At the end of your v2 app deployment, CD-as-a-Service creates a new HorizontalPodAutoscaler resource to target your v2 app.

### What happens during a rollback

Since you can't roll back once a deployment has finished, scaling behavior is still frozen when a rollback begins.

CD-as-a-Service deletes the v2 app and v2 HorizontalPodAutoscaler and recreates the v1 HorizontalPodAutoscaler config file using the  `kubectl.kubernetes.io/last-applied-configuration` annotation. CD-as-a-Service then deploys your v1 app and HorizontalPodAutoscaler.

>Do not delete the `kubectl.kubernetes.io/last-applied-configuration` annotation between deployments or your rollback will fail. Additionally, CD-as-a-service may not capture any manual or programmatic changes you make to the HorizontalPodAutoscaler configuration file between deployments.

## Supported HorizontalPodAutoscaler API versions

- [v1](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v1/)
- [v2 beta 1 and 2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2beta2/)
-  [v2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/)
