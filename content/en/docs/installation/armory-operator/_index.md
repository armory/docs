---
title: Deploy Spinnaker Using Kubernetes Operators
linkTitle: Armory Operators
weight: 1
no_list: true
description: >
  Armory provides Kubernetes Operators that make it easy to install, deploy, and upgrade Spinnaker or Armory Enterprise for Spinnaker. This section covers advantages, configuration, deployment, and migration from Halyard to the Operator.
aliases:
  - /docs/spinnaker/operator/
---

{{< include "armory-license.md" >}}

## What are Kubernetes Operators for Spinnaker?

From the Kubernetes [Operator pattern docs](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/): "Operators are software extensions to Kubernetes that make use of custom resources to manage applications and their components." In other words, an Operator is Kubernetes controller that manages a specific application using a custom resource. Both the open source [Spinnaker Operator for Kubernetes](https://github.com/armory/spinnaker-operator) and the proprietary Armory Operator are custom Kubernetes Operators that you can install in your cluster.

* The **Spinnaker Operator** is a Kubernetes controller for deploying and managing Spinnaker. The Spinnaker Operator and Spinnaker are both open source and free to use.
* The **Armory Operator** ![Proprietary](/images/proprietary.svg) extends the Spinnaker Operator's features by providing the ability to configure Armory Enterprise's [features]({{< ref "docs#what-is-armory-enterprise">}}), such as Pipelines as Code and Policy Engine. The Armory Operator and Armory Enterprise are closed source and not free to use.

## Advantages to using a Kubernetes Operator for Spinnaker deployment

* Use a Kubernetes manifest to deploy and manage Spinnaker or Armory Enterprise.
* Use `kubectl` to deploy, manage, and access Spinnaker or Armory Enterprise like you would with any other app deployed on Kubernetes.
* Store Spinnaker secrets in one of the [supported secrets engines]({{< ref "secrets" >}}).
* Reference secrets stored in existing Kubernetes secrets in the same namespace as Spinnaker using the following syntax:
  * `encrypted:k8s!n:<secret name>!k:<secret key>` for a string value. This is added as an environment variable to the Spinnaker deployment.
  * `encryptedFile:k8s!n:<secret name>!k:<secret key>` for a file reference. Files come from a volume mount in the Spinnaker deployment.
* Store your configuration in `git` for an auditable and reversible GitOps workflow. You can use Spinnaker to deploy another instance of Spinnaker using a Pipeline trigger: `Pull Request --> Approval --> Configuration Merged --> Pipeline Trigger in Spinnaker --> Deploy Updated SpinnakerService`.

## How the Spinnaker Operator and the Armory Operator work

The Operator is a custom controller of Kubernetes kind `Deployment`. The controller works with a [Kubernetes custom resource](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/) named `SpinnakerService` to deploy and manage Spinnaker in your cluster.

### `SpinnakerService` Custom Resource Definition

The `SpinnakerService` CRD declares the resource's names, the scope of the resource, and the structural schema of the `spinnakerservice.yml` [Kubernetes manifest](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/) that contains your Spinnaker configuration.

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

You can view the entire `SpinnakerService` CRD in the `spinnaker-operator` [repo](https://github.com/armory/spinnaker-operator/blob/master/deploy/crds/spinnaker.io_spinnakerservices_crd.yaml).

### Spinnnaker manifest

You have the following options for creating the Spinnaker manifest:

* Create the manifest YAML file yourself using an example `spinnakerservice.yml` as a starting point.
* Create a collection of patch files that [Kustomize](https://kustomize.io/) uses to overwrite sections of the `spinnakerservice.yml` manifest. Kustomize is part of `kubectl`.

Regardless of the option you use to configure Spinnaker, the `spinnakerservice.yml` manifest specifies that the Kubernetes kind is `SpinnakerService`.

```yaml
apiVersion: spinnaker.io/{{< param "operator-oss-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
```

You can view the rest of the basic file in the `spinnaker-operator` [repo](https://github.com/armory/spinnaker-operator/blob/master/deploy/spinnaker/basic/spinnakerservice.yml).

At the highest level, when you use `kubectl` to apply the manifest:

1. `kubectl` parses `spinnakerservice.yml` and sees that the kind is `SpinnakerService`.
2. `kubectl` delegates manifest validation and deployment to the Spinnaker Operator.
3. The Operator validates the manifest and uses Halyard to deploy Spinnaker.

The Armory Operator's `SpinnakerService` CRD and Armory Enterprise `SpinnakerService.yml` are slightly different than their open source counterparts so that `kubectl` knows to delegate to the Armory Operator.

## Comparison of the Spinnaker Operator and the Armory Operator

Use the Armory Operator if you want to deploy Armory Enterprise and use its proprietary features.

{{% include "armory-operator/op-feature-compare.md" %}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "op-quickstart.md" >}}
