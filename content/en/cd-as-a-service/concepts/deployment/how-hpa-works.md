---
title: "Horizontal Pod Autoscaling"
linktitle: "Horizontal Pod Autoscaling"
date: 2022-07-21T11:03:01-07:00
draft: false
description: >
  Automatically manage horizontal scaling for a Kubernetes deployment.
---

## {{% heading "prereq" %}}

- Have an available deployment, configured as described in {{< linkWithTitle "content/en/cd-as-a-service/setup/get-started.md" >}}.
- The Kubernetes cluster server must be version 1.23 or newer.

- The Kubernetes cluster must have a Metrics Server deployed and configured. 

 ## What is HPA?
 HPA scales a Kubernetes resource in reaction to changes in observed metrics. In simple terms, when the load increases the number of deployed pods is increased to meet the demand - automatically. The scale behavior is horizontal, rather than vertical, which means that rather than assigning an existing pod more memory or CPU to handle the incoming traffic new pods that identical instances of your application are created.

 An HPA resource has three components:
- A set of one or more metrics, each with a desired target value.
- A reference to a Kubernetes resource, typically a Deployment but any resource that supports the Scale API sub-resource (e.g., `ReplicaSet`, `StatefulSet`). The HPA scales this resource in response to changes in observed metrics.
- A minimum and maximum number of replicas.

HPA checks metrics as configured in the deployment file AT A DEFAULT 30 SEC intervals. When the threshold load is met the HPA increases or decreases the number of pods. 
 
 Kubernetes implements Horizontal Auto Scaling (HPA) as a control loop that runs intermittently. `HorizontalPodAutoscaler` controls the scale of a Deployment and its `ReplicaSet`. 
 
 HPA is not recommended for replication controllers. 
 
 HPA does not manage rolling updates by manipulating the replication controller. The deployment object manages the size of underlying replica sets. 

 **Example**
```
kubectl get hpa
```

 The sync interval is set by the `kube-controller-manager`. The default interval is 30 seconds. Change the default interval using the `horizontal-pod-autoscaler-sync-period` flag.

 **Example**
```
kubectl get hpa
```
The default HPA relative metrics tolerance is 10%.

**Example**
 ```
kubectl get hpa
```

The default delay is 3 minutes after an upscale event to allow metrics to stabilize. Change the default upscale delay period using the `horizontal-pod-autoscaler-upscale-delay` flag.

**Example**
```
kubectl get hpa
```

### Supported versions
Armory Continuous Deployment-as-a-Service supports the following HorizontalPodAutoscaler API versions:
- [v1](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v1/)
- [v2beta 1 and 2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2beta2/)
-  [v2](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/)
  
## How HPA works in Armory CD as a Service
When HPA is configured for an Armory Continuous Deployment-as-a-Service (CD as a Service) deployment the deployment is converted to a `ReplicaSet` and the HPA configuration file is automatically re-written to reference the generated `ReplicaSet` resource.

Armory CD as a Service freezes scaling behavior during a deployment.

**Example**
Consider a deployment to upgrade from the v1 to v2 version of your application. In this scenario the v1 application is running with 10 replicas and is scaled by HPA (min: 5 pods, max: 15 pods).
 - At the beginning of a deployment, the HPA is deleted. Your v1 application has 10 pods but no longer scales between 5 and 15 pods.
 - CD as a Service deploys the v2 instance of your application with 10 pods (20 total pods between v1 and v2).
 - At the end of the deployment, a new HPA resource is created to target the v2 application.
 - If the deployment needs to be rolled back, CDaaS deletes the v2 application and re-creates the original HPA.

See the example {{< linkWithTitle "content/en/cd-as-a-service/setup/get-started.md" >}}.

**Before deployment**

- Upgrade a database schema
- Custom approval process

**Within your deployment strategy**

- Check logs and system health
- Run custom tests

**After deployment**
Once CPU utilization drops to 0, the HPA automatically scales the number of replicas down to 1.

> Autoscaling the replicas may take a few minutes.

Run integration tests in a staging environment.
- Perform metric tests
- Run security scanners

**Check the current status of the `HorizontalPodAutoscaler`**
```
kubectl get hpa
```
## Roll back an HPA configured deployment
During a rollback, Armory CDaaS relies on the `kubectl.kubernetes.io/last-applied-configuration` annotation to re-create the HPA. 

> Do not delete this annotation between deployments. 

Manual or programmatic changes to the HPA configuration file between deployments (for example, changes to the HPA's min/max boundaries) may not be captured during a rollback.

Point to an HPA configuration file that references a Deployment resource in your manifests. An HPA configuration file can be assigned to each individual Deployment resource.

