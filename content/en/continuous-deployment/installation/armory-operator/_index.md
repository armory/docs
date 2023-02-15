---
title: Deploy Armory Continuous Deployment or Spinnaker Using Kubernetes Operators
linkTitle: Armory Operators
weight: 2
no_list: true
description: >
  Armory provides Kubernetes Operators that make it easy to install, deploy, and upgrade Armory Continuous Deployment or Spinnaker. This section covers advantages, configuration, deployment, and migration from Halyard to the Operator.
aliases:
  - /docs/installation/operator/
---

{{< include "armory-license.md" >}}

## What are Kubernetes Operators for Spinnaker?

From the Kubernetes [Operator pattern docs](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/): "Operators are software extensions to Kubernetes that make use of custom resources to manage applications and their components." In other words, an Operator is a Kubernetes controller that manages a specific application using a custom resource. Both the proprietary Armory Operator and the open source [Spinnaker Operator for Kubernetes](https://github.com/armory/spinnaker-operator) are custom Kubernetes Operators that you can install in your cluster.

* The **Armory Operator** ![Proprietary](/images/proprietary.svg) extends the Spinnaker Operator's features by providing the ability to configure Armory Continuous Deployment's [features]({{< ref "continuous-deployment#what-is-armory-continuous-deployment">}}), such as Pipelines as Code and Policy Engine. The Armory Operator and Armory Continuous Deployment are closed source and not free to use.
* The **Spinnaker Operator** is a Kubernetes controller for deploying and managing Spinnaker. The Spinnaker Operator and Spinnaker are both open source and free to use.

## Advantages to using a Kubernetes Operator for Armory Continuous Deployment deployment

* Use a Kubernetes manifest to deploy and manage Armory Continuous Deployment or Spinnaker.
* Use `kubectl` to deploy, manage, and access Armory Continuous Deployment or Spinnaker like you would with any other app deployed on Kubernetes.
* Store and reference configuration secrets in one of the [supported secrets engines]({{< ref "continuous-deployment/armory-admin/secrets" >}}).
* Store your configuration in `git` for an auditable and reversible GitOps workflow.

## How the Armory Operator and the Spinnaker Operator work

The Operator is a custom controller of Kubernetes kind [`Deployment`](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/). The Operator works with a [Kubernetes custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) named `SpinnakerService` to deploy and manage Armory Continuous Deployment or Spinnaker in your cluster.

### `SpinnakerService` Custom Resource Definition

The `SpinnakerService` CRD declares the resource's names, the scope of the resource, and the structural schema of the `spinnakerservice.yml` [Kubernetes manifest](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/) that contains your Spinnaker configuration:

```yaml
apiVersion: apiextensions.k8s.io/v1beta1
kind: CustomResourceDefinition
metadata:
  name: spinnakerservices.spinnaker.io
spec:
  group: spinnaker.io
  names:
    kind: SpinnakerService
    listKind: SpinnakerServiceList
    plural: spinnakerservices
    shortNames:
    - spinsvc
    singular: spinnakerservice
  scope: Namespaced
```

You can view the entire `SpinnakerService` CRD in the public `spinnaker-operator` [repo](https://github.com/armory/spinnaker-operator/blob/master/deploy/crds/spinnaker.io_spinnakerservices_crd.yaml).

### Spinnnaker manifest

You have the following options for creating the Spinnaker manifest:

* Create the manifest YAML file yourself using an [example](https://github.com/armory/spinnaker-operator/blob/master/deploy/spinnaker/basic/spinnakerservice.yml) `spinnakerservice.yml` as a starting point.
* Create a collection of patch files that [Kustomize](https://kustomize.io/) uses to overwrite sections of the `spinnakerservice.yml` manifest. Kustomize is part of `kubectl`.

Regardless of the option you use to configure Spinnaker, the `spinnakerservice.yml` manifest specifies that the Kubernetes kind is `SpinnakerService`:

```yaml
apiVersion: spinnaker.io/{{< param "operator-oss-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
```

You can view the rest of the basic file in the `spinnaker-operator` [repo](https://github.com/armory/spinnaker-operator/blob/master/deploy/spinnaker/basic/spinnakerservice.yml).

At the highest level, when you use `kubectl` to apply the manifest:

1. `kubectl` parses `spinnakerservice.yml` and sees that the kind is `SpinnakerService`.
1. `kubectl` delegates manifest validation and deployment to the Operator.
1. The Operator validates the manifest and uses Halyard to deploy Spinnaker.

The Armory Operator's `SpinnakerService` CRD and Armory Continuous Deployment `SpinnakerService.yml` are slightly different than their open source counterparts so that `kubectl` knows to delegate to the Armory Operator.

## Comparison of the Spinnaker Operator and the Armory Operator

Use the Armory Operator if you want to deploy Armory Continuous Deployment and use its proprietary features.

{{% include "armory-operator/op-feature-compare.md" %}}

## {{% heading "nextSteps" %}}
* {{< linkWithTitle "system-requirements.md" >}}
* {{< linkWithTitle "op-quickstart.md" >}}
