---
title: Deploy a Docker Image to Kubernetes
linkTitle: Deploy a Docker Image to Kubernetes
aliases:
  - /spinnaker/kubernetes_deployments/
  - /docs/spinnaker/kubernetes-deployments/
description: >
  Learn how to use Spinnaker's Kubernetes V2 provider to deploy your Docker image.
---

## Kubernetes Deployments
Spinnaker delegates the deployment of containers to Kubernetes. Kubernetes then proceeds with a rolling update deployment which is effectively a rolling blue/green deployment.
Pods are created in batches and when a pod is deemed [healthy](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/) it starts receiving traffic.

### Example
This example focuses on the manifest-based [Kubernetes V2 provider]({{< ref "kubernetes-v2" >}}).

We've defined a simple pipeline where we first define an artifact (a Docker image) with a version coming from a pipeline parameter.
You'd usually get the image from a trigger via container registry or a Jenkins job with the same result.

![image](/images/kubernetes_deployments_1.png)


The second step defines the deployment of that image. It's a simple "*Deploy (Manifest)*" stage. Here we're adding the static deployment manifest via a text field but you'd usually retrieve it as an artifact directly
or via a Helm bake stage.

{{% alert title="Note" %}}For more information, watch this video about [Deploying Helm Charts with Armory](https://youtu.be/u7QF2X4WzE8?t=360) -- Example of artifact promotion through environments managed by a single pipeline.{{% /alert %}}


![image](/images/kubernetes_deployments_2.png)

As a matter of fact, the deployment manifest is not entirely static: Spinnaker will replace the image name with the actual tagged name from the bound artifact.

Let's see how a new version of the container gets deployed with this pipeline:
![image](/images/rollingupdate-default.gif)


## Can we change how containers are deployed?
In our example so far, we observed that we go down to 3 running pods and up to 5 non *Terminating* pods existing simultaneously.
You actually have some control over how Kubernetes handles the pod creation.
Two [parameters](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#rolling-update-deployment) will help you:
- `maxSurge` sets a limit on how many pods can be created over the desired number of pods. Default is 25%.
- `maxUnavailable` sets a limit on how many pods can be non-running. Default is also 25%.

Let's modify our deployment manifest and ensure that we always have 4 pods running during deployment:

![image](/images/kubernetes_deployments_3.png)

Let's see how we deploy with our new configuration:
![image](/images/rollingupdate-0.gif)

We keep 4 pods running throughout the deployment and never more than 5 non *Terminating* pods (4 pods + 25%) existing at any given time.
