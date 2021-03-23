---
title: Deploy Spinnaker using the Operator
linkTitle: Quickstart
weight: 2
description: >
  Create a Kubernetes manifest for Spinnaker and deploy using the Operator.
---

{{< include "armory-operator/os-operator-blurb.md" >}}

## Requirements for using the Spinnaker or Armory Operator

Before you use start, ensure you meet the following requirements:

* You have knowledge of [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/), which use custom resources to manage applications and their components.
* You understand the concept of [managing Kubernetes resources using manifests](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/).
* Your Kubernetes cluster runs version 1.13 or later. If you do not have a cluster already, consult guides for [Google](https://cloud.google.com/kubernetes-engine/docs/quickstart), [Amazon](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html), or [Microsoft](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal) clouds.
* You have enabled admission controllers in Kubernetes (`-enable-admission-plugins`).
* You have `ValidatingAdmissionWebhook` enabled in `kube-apiserver`. Alternatively, you can pass the `--disable-admission-controller` parameter to the to the `deployment.yaml` file that deploys the operator.
* You have administrator rights to install the Custom Resource Definition (CRD) for Operator.

## Operator installation options

The Operator has `basic` and `cluster` installation modes. The option you use depends on how you want to deploy Spinnaker.


|                                                           |Basic Mode | Cluster Mode |
|:-------------------------------------------------------- |:------------------:|:---------------:|
| Must deploy Spinnaker in the same namespace as the Operator   |      &#9989;       |    &#10060;     |
| Can deploy Spinnaker to multiple namespaces<br>(requires Kubernetes ClusterRole)                 |      &#10060;      |     &#9989;     |
| Configure Spinnaker using a single manifest file            |      &#9989;       |     &#9989;     |
| Configure Spinnaker using Kustomize patches            |      &#9989;       |     &#9989;     |
| Perform pre-flight checks to prevent misconfiguration             |     &#10060;       |     &#9989;     |



## {{% heading "installOperator" %}}
{{% include "armory-operator/installation.md" %}}

## Deploy a Spinnaker instance using Operator in `basic` mode



## {{% heading "configKustomizeInstallArmory" %}}
{{% include "armory-operator/kustomize-patches.md" %}}
