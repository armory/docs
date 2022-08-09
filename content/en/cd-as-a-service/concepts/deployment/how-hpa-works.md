---
title: "Kubernetes HPA deployments in CD-as-a-Service"
linktitle: "Kubernetes HPA"
description: >
  Learn how Armory Continuous Deployment-as-a-Service supports Kubernetes deployments with Horizontal Pod Autoscaling.
---
 # What is HPA?
 Kubernetes Horizontal Pod Autoscaling (`HPA`) scales deployments based on workload. When the load increases, new pods are generated on the deployed cluster. With `HPA`, the cluster is scaled horizontally by increasing the number of deployed pods on the cluster, rather than vertically increasing memory or CPU of an existing pod. When the workload decreases the cluster is scaled back down to the configured minimum number of replicas as defined in the deployment file.

 - `HorizontalPodAutoscaler` controls the scale of a deployment and its `ReplicaSet`. 
 - The minimum and maximum number of replicas is defined in the deployment file. 
 - The default sync interval is 30 seconds. The sync interval is set by the `kube-controller-manager`. 
 - The default interval is modified using the `horizontal-pod-autoscaler-sync-period` flag. 
 - The default delay is 3 minutes after an upscale event to allow metrics to stabilize. Change the default upscale delay period using the `horizontal-pod-autoscaler-upscale-delay` flag.
 - With `HPA` configured, the deployment object manages the size of underlying replica sets. `HPA` does not manage rolling updates by manipulating the replication controller. 
  > `HPA` is not recommended for replication controllers. 

To learn more about `HPA`, read these Kubernetes Documentation topics: 
- [Horizontal Pod Autoscaling](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/)
- [HorizontalPodAutoscaler Walkthrough](https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/)
 
# HPA in CD-as-a-Service
Continuous Deployment-as-a-Service (CD-as-a-Service) converts `HPA` configured deployments to replica sets. The `HPA` configuration file is automatically re-written to reference the generated `ReplicaSet` resource. CD-as-a-Service freezes scaling behavior during a deployment.

> To check the current status of the `HorizontalPodAutoscaler` run `kubectl get hpa`.

For example, consider a deployment to upgrade the `v1` version of a CD-as-a-Service app to a `v2` release. In this scenario the `v1` application is running with 10 replicas and is scaled by `HPA` with a minimum set to 5 pods and a maximum set to 15 pods.

 1. When the deployment begins the `v1` `HPA` is deleted. The `v1` app is running 10 pods, but no longer scales between 5 and 15 pods.
 2. CD-as-a-Service deploys the `v2` instance of the application with 10 pods (20 total pods between `v1` and `v2`).
 3.  At the end of the deployment, a new `HPA` resource is created to target the v2 application. 
 4.  If you need to roll back your deployment, CD-as-a-Service deletes the `v2` app and recreates the original `HPA`.

## What happens during a rollback
During a rollback, CD-as-a-Service relies on the `kubectl.kubernetes.io/last-applied-configuration` annotation to re-create the `HPA`. 

> Do not delete this annotation between deployments. CD-as-a-service may not capture any manual or programmatic changes you make to the `HPA` configuration file between deployment.

## Supported HPA versions
CD-as-a-Service supports the following `HorizontalPodAutoscaler` API versions:
- [v1](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v1/)
- [v2beta 1 and 2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2beta2/)
-  [v2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/)
