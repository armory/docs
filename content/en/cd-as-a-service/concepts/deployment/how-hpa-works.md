---
title: "Autoscaling a Kubernetes deployment with HPA"
linktitle: "Horizontal Pod Autoscaling"
date: 2022-07-21T11:03:01-07:00
draft: false
description: >
  Automatically manage horizontal scaling for a Kubernetes deployment.
---

## {{% heading "prereq" %}}

Make sure you have a deployment configured as described in {{< linkWithTitle "content/en/cd-as-a-service/setup/get-started.md" >}}.

> The Kubernetes cluster server must be version 1.23 or newer.

 Review the following topics for more a more complete understanding of deployment scaling options:

- {{< linkWithTitle "ref-deployment-file.md" >}}

 ## What is HPA
 HPA scales a Kubernetes resource in reaction to changes in observed metrics. The scale behavior is horizontal, rather than vertical: the HPA scales a resource by adding or removing identical instances of your application. Kubernetes implements Horizontal Auto Scaling (HPA) as a control loop that runs intermittently. `HorizontalPodAutoscaler` controls the scale of a Deployment and its `ReplicaSet`. The interval is set by the `--horizontal-pod-autoscaler-sync-period` parameter to the `kube-controller-manager`. The default interval is 15 seconds (it is not a continuous process).
  
An HPA resource has three components:
- A set of one or more metrics, each with a desired target value.
- A reference to a Kubernetes resource, typically a Deployment but any resource that supports the Scale API sub-resource (e.g., ReplicaSet, StatefulSet). The HPA scales this resource in response to changes in observed metrics.
- A minimum and maximum number of replicas.

 ### Supported versions
Armory Continuous Deployment-as-a-Service supports the following HorizontalPodAutoscaler API versions:
- [v1](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v1/)
- [v2beta 1 and 2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2beta2/)
-  [v2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/)

  
## Using HPA autoscaling
When a client uses Armory Continuous Deployment-as-a-Service (CDaaS) to deploy a resource, it converts the deployment to a `ReplicaSet`. When the client provides an HPA to scale a deployed resource, the HPA is automatically re-written to reference the generated `ReplicaSet` resource.

Armory CDaaS freezes scaling behavior during a deployment. For example, consider a deployment to upgrade from the v1 to v2 version of your application:
> Your v1 application is running with 10 replicas and is scaled by an HPA (min: 5 pods, max: 15 pods).
 - At the beginning of a deployment, the HPA is deleted. Your v1 application has 10 pods but no longer scales between 5 and 15 pods.
 - CDaaS deploys the v2 instance of your application with 10 pods (20 total pods between v1 and v2).
 - At the end of the deployment, CDaaS deploys a new HPA resource that targets your v2 application.
 - If the deployment needs to be rolled back, CDaaS deletes the v2 application and re-creates the original HPA.

## Configuring HPA

To autoscale a deployement using HPA set the following parameters in the .yaml configuration file:
- `--horizontal-pod-autoscaler-sync-period`
- ``
- ``
- ``
CDaaS deploys the v2 instance of the application with 10 pods (20 total pods between v1 and v2).
At the end of the deployment, CDaaS deploys a new HPA resource that targets the new v2 application.
If the deployment needs to be rolled back, CDaaS deletes the v2 application and re-creates the original HPA.

**Before deployment**

- Upgrade a database schema
- Custom approval process

**Within your deployment strategy**

- Check logs and system health
- Run custom tests

**After deployment**
Once CPU utilization dropped to 0, the HPA automatically scaled the number of replicas back down to 1.

> Autoscaling the replicas may take a few minutes.

Run integration tests in a staging environment.
- Perform metric tests
- Run security scanners

**Check the current status of the `HorizontalPodAutoscaler`**
```
kubectl get hpa
```
## Rolling back an HPA configured deployment
During a rollback, Armory CDaaS relies on the `kubectl.kubernetes.io/last-applied-configuration` annotation to re-create the HPA. 

> Do not delete this annotation between deployments. 

Manual or programmatic changes to the HPA configuration file between deployments (for example, changes to the HPA's min/max boundaries) may not be captured during a rollback.

To use an HPA point to an HPA configuration file that references a Deployment resource in your manifests. 

> Each Deployment resource can have its own HPA.
