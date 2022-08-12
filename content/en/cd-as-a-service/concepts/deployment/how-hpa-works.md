---
title: "Kubernetes Horizonal Pod Autoscaler deployments in CD-as-a-Service"
linktitle: "Kubernetes HPA"
description: >
  Learn how Armory Continuous Deployment-as-a-Service supports Kubernetes deployments with Horizontal Pod Autoscaling.
---

# Before you begin
Read the Kubernetes Documentation topics: 
- [Horizontal Pod Autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
- [HorizontalPodAutoscaler Walkthrough](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
 
# Horizontal Pod Autoscaling in CD-as-a-Service
Continuous Deployment-as-a-Service (CD-as-a-Service) converts `HorizontalPodAutoscaler` configured deployments to replica sets. The `HorizontalPodAutoscaler` configuration file is automatically re-written to reference the generated `ReplicaSet` resource. CD-as-a-Service freezes scaling behavior during a deployment.

> You must declare your HPA in a manifest file.

For example, consider a deployment to upgrade the v1 version of a CD-as-a-Service app to a v2 release. In this scenario the v1 application is running with 10 replicas and is scaled with a minimum set to 5 pods and a maximum set to 15 pods.

1. When the deployment begins the v1 `HorizontalPodAutoscaler` is deleted. The v1 app is running 10 pods, but no longer scales between 5 and 15 pods.
1. CD-as-a-Service deploys the v2 instance of the application with 10 pods (20 total pods between v1 and v2).
1. At the end of the deployment, a new `HorizontalPodAutoScaler` resource is created to target the v2 application. 
1. If you need to roll back your deployment, CD-as-a-Service deletes the v1 app and recreates the original `HorizontalPodAutoscaler`.

> To check the current status of the `HorizontalPodAutoscaler` run `kubectl get hpa`.

## What happens during a rollback
During a rollback, CD-as-a-Service relies on the `kubectl.kubernetes.io/last-applied-configuration` annotation to re-create the `HorizontalPodAutoScaler`. 

> Do not delete this annotation between deployments. CD-as-a-service may not capture any manual or programmatic changes you make to the `HorizontalPodAutoscaler` configuration file between deployment.

## Supported HPA versions
CD-as-a-Service supports the following Horizontal Pod Autoscaling API versions:
- [v1](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v1/)
- [v2 beta 1 and 2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2beta2/)
-  [v2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/)
