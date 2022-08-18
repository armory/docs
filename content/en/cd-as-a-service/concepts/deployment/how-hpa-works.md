---
title: "Kubernetes HPA Deployments in CD-as-a-Service"
linktitle: "Kubernetes HPA"
description: >
  Learn how Armory Continuous Deployment-as-a-Service supports Kubernetes deployments with Horizontal Pod Autoscaling.
---

# Before you begin
Before you begin using an HPA in your CD-as-a-Service deployment, you should have:
- A working knowledge of Horizonal Pod Autoscaling in Kubernetes:
- Horizontal Pod Autoscaling (concept)
- HorizontalPodAutoscaler Walkthrough (tutorial)
- HorizontalPodAutoscaler API reference
- Kubernetes v1.10 or newer. Check the Kubernetes Release Notes for the Horizontal Pod Autoscaling features supported in your Kubernetes release.

{{< alert title="Tip" >}}Learn more about Kubernetes Horizontal Pod Autoscaling from the following Kubernetes Documentation topics:
- [Horizontal Pod Autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
- [HorizontalPodAutoscaler Walkthrough](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/){{< /alert >}}

# Horizontal Pod Autoscaling in CD-as-a-Service
When a client uses Armory CD-as-a-Service to deploy a Deployment resource,  CD-as-a-Service converts the Deployment to a ReplicaSet. Correspondingly, when a client provides an HPA to scale a Deployment resource, that HPA is automatically re-written to reference the generated ReplicaSet resource.

## Declare your Horizontal Pod Autoscaling configuration in the Deployment manifest
CD-as-a-Service requires your app's Horizontal Pod Autoscaling configuration be declared in a manifest.  Each Deployment resource can have its own HorizontalPodAutoscaler configuration.

> To check the current status of the `HorizontalPodAutoscaler` run `kubectl get hpa`.

## How Horizontal Pod Autoscaling works in CD-as-a-Service
Consider a deployment to upgrade the v1 version of a CD-as-a-Service app to a v2 release. In this scenario the v1 application is running with 10 replicas and is scaled with a minimum set to 5 pods and a maximum set to 15 pods.

1. When the deployment begins, the v1 `HorizontalPodAutoscaler` is deleted. The v1 app is running 10 pods, but no longer scales between 5 and 15 pods.
1. CD-as-a-Service deploys the v2 instance of the application with 10 pods (20 total pods between v1 and v2).
1. At the end of the deployment, a new `HorizontalPodAutoScaler` resource is created to target the v2 application. 
1. If you need to roll back your deployment, CD-as-a-Service deletes the v1 app and recreates the original `HorizontalPodAutoscaler`.

## Horizontal Pod Autoscaling during rollbacks
During a rollback, CD-as-a-Service relies on the `kubectl.kubernetes.io/last-applied-configuration` annotation to recreate the `HorizontalPodAutoscaler` configuration file. 

> Do not delete this annotation between deployments. CD-as-a-service may not capture any manual or programmatic changes you make to the `HorizontalPodAutoscaler` configuration file between deployment.

## Supported HorizontalPodAutoScaler versions
CD-as-a-Service supports the following Horizontal Pod Autoscaling API versions:
- [v1](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v1/)
- [v2 beta 1 and 2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2beta2/)
-  [v2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/)
