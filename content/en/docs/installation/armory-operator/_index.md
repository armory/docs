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

"Operators are software extensions to Kubernetes that make use of custom resources to manage applications and their components." (Kubernetes [docs](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)). In other words, an Operator is Kubernetes controller that manages a specific application. Both the open source [Spinnaker Operator for Kubernetes](https://github.com/armory/spinnaker-operator) and the proprietary Armory Operator are Kubernetes Operators that you can install in your cluster.

* The **Spinnaker Operator** is an application-specific Kubernetes controller that deploys and manages Spinnaker. The Spinnaker Operator and Spinnaker are both open source and free to use.
* The ![Proprietary](/images/proprietary.svg) **Armory Operator** deploys and manages Armory Enterprise.  The Armory Operator extends the Spinnaker Operator's features by providing the ability to configure Armory Enterprise's features: Pipelines as Code, Policy Engine, Terraform integration, Vault secrets, and diagnostics. The Armory Operator and Armory Enterprise are closed source and not free to use.

## Advantages to using a Kubernetes Operator for Spinnaker deployment

* Use a Kubernetes manifest to deploy and manage Spinnaker.
* Use `kubectl` to deploy, manage, and access Spinnaker or Armory Enterprise like you would with any other application deployed on Kubernetes.
* Store Spinnaker secrets in one of the [supported secrets engines]({{< ref "secrets" >}}).
* Reference secrets stored in existing Kubernetes secrets in the same namespace as Spinnaker using the following syntax:
  * `encrypted:k8s!n:<secret name>!k:<secret key>` for a string value. This is added as an environment variable to the Spinnaker deployment.
  * `encryptedFile:k8s!n:<secret name>!k:<secret key>` for a file reference. Files come from a volume mount in the Spinnaker deployment.
* Store your configuration in `git` for an auditable and reversible GitOps workflow. You can use Spinnaker to deploy another instance of Spinnaker using a Pipeline trigger: `Pull Request --> Approval --> Configuration Merged --> Pipeline Trigger in Spinnaker --> Deploy Updated SpinnakerService`.

## How the Spinnaker Operator and the Armory Operator work

Both Operators use a [Kubernetes manifest](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/) to deploy either Spinnaker or Armory Enterprise. This manifest defines the configuration for your application. You have the following options for creating the manifest:

* Create the manifest YAML file yourself using an example `spinnakerservice.yml` as a starting point.
* Create a collection of [Kustomize](https://kustomize.io/) patches that `kubectl` compiles into a manifest.

You use `kubectl` to deploy and manage Spinnaker using the manifest or Kustomize patches that you create.

The Operator uses Halyard to manage Spinnaker. See {{< linkWithTitle "op-hal-config.md" >}} if you need to modify Halyard so you can use Armory Enterprise features.

## Comparison of the Spinnaker Operator and the Armory Operator

Most of the configuration is the same between the open source Spinnaker Operator and proprietary Armory Operator.

{{% include "armory-operator/op-feature-compare.md" %}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "op-quickstart.md" >}}
