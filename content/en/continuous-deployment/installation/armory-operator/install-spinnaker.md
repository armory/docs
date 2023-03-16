---
title: Install Spinnaker using the Spinnaker Operator and Kustomize patches
linkTitle: Install Spinnaker
weight: 5
description: >
  This guide describes how to deploy a basic Spinnaker instance using the Spinnaker Operator and Kustomize patches. You can use this basic instance for testing or as a starting point for configuring advanced features.
---

## Why use Kustomize patches for Spinnaker configuration

{{< include "armory-operator/why-use-kustomize.md" >}}

See {{< linkWithTitle "continuous-deployment/installation/armory-operator/hal-op-migration.md" >}} if you have an existing Halyard-managed Spinnaker instance that you want to migrate to management using the Spinnaker Operator.

## Objectives

1. Meet the requirements listed in the [{{% heading "prereq" %}}](#before-you-begin) section.
1. [Deploy the Spinnaker Operator](#deploy-the-spinnaker-operator).
1. [Get the spinnaker-kustomize-patches repo](#get-the-spinnaker-kustomize-patches-repo).
1. [Configure Spinnaker](#configure-spinnaker).
1. [Deploy Spinnaker](#deploy-spinnaker).
1. [Port-forward](#port-forward-to-expose-spinnaker-services-locally) to expose Spinnaker services.
1. Explore [advanced config options](#advanced-config-options)

## {{% heading "prereq" %}}

### How Kustomize works

{{< include "armory-operator/how-kustomize-works.md" >}}

### Kustomize resources

You should familiarize yourself with Kustomize before you create patch files to configure Armory Continuous Deployment.

* Kustomize [Glossary](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/)
* Kustomize [introduction](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
* [Kustomization file overview](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/)

### Kubernetes requirements

* You are familiar with [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/), which use custom resources to manage applications and their components.
* You understand the concept of [managing Kubernetes resources using manifests](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/).
* You have read how Armory's operator [deploys Spinnaker]({{< ref "/continuous-deployment/installation/armory-operator#how-the-armory-operator-and-the-spinnaker-operator-work" >}}).
* You have a cluster with at least least 4 cores and 16GB of RAM available.


## Deploy the Spinnaker Operator 

Decide which Spinnaker Operator release you need based on the compatibility matrix:

{{< include "armory-operator/operator-compat-matrix.md" >}}

{{< tabpane text=true right=true >}}
{{< tab header="**Operator Mode**:" disabled=true />}}
{{% tab header="Cluster" text=true %}}
{{< include "armory-operator/spin-op-install-cluster.md" >}}
{{% /tab %}}
{{% tab header="Basic" text=true %}}
{{< include "armory-operator/spin-op-install-basic.md" >}}
{{% /tab %}}
{{< /tabpane >}}


## Get the spinnaker-kustomize-patches repo

{{% include "armory-operator/spin-kust-repo.md" %}}

## Configure Spinnaker

You can find a basic recipe for deploying Spinnaker in `recipes/kustomization-oss-minimum.yml`.

{{< github repo="armory/spinnaker-kustomize-patches" file="/recipes/kustomization-oss-minimum.yml" lang="yaml" options="" >}}

* The `components` [section](https://kubectl.docs.kubernetes.io/guides/config_management/components/)
  contains paths to directories that define collections of Kubernetes resources.
* The `patchesStrategicMerge` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patchesstrategicmerge/) contains links to files that contain partial resource definitions. Kustomize uses these patch files to overwrite sections of components or resources, such as the `SpinnakerService` definition.
* The `patches` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patches/) is a list of files that Kustomize executes to add or replace fields on resources. The `utilities/switch-to-oss.yml` patch instructs Kustomize to replace `apiVersion: spinnaker.armory.io/v1alpha2` with `apiVersion: spinnaker.io/v1alpha2` in the SpinnakerService manifest.

### What this recipe does

* Configures MinIO as the persistent storage provider (instead of Redis or cloud storage)

### What this recipe does not do

* Configure Clouddriver or other services to use a SQL backend
* Configure a LoadBalancer to expose Spinnaker services

See [Advanced config options](#advanced-config-options) for how to modify your kustomization file.

### Spinnaker version

To change the Spinnaker version, update `spec.spinnakerConfig.config.version` in `core/patches/oss-version.yml`.

## Deploy Spinnaker

Execute all commands from the root of `spinnaker-kustomize-patches`.

1. Set the kustomize recipe.

   The `kustomization.yml` file in the project root is a symlink to `recipes/kustomization-all.yml`.  Update to point to `recipes/kustomization-oss-minimum.yml`.

   ```bash
   ln -vfns ./recipes/kustomization-oss-minimum.yml kustomization.yml
   ```

1. Create the namespace

   ```bash
   kubectl create ns spinnaker
   ```

1. (Optional) Verify the Kustomize build output.

   ```bash
   kubectl kustomize
   ```

   This prints out the contents of the manifest file that Kustomize built based on your `kustomization.yml` file.

1. Apply the manifest:

   ```bash
   kubectl apply -k .
   ```

1. (Optional) Watch installation progress.

   ```bash
   kubectl -n spinnaker get spinsvc spinnaker -w
   ```

## Expose Spinnaker services

Because the minimum recipe doesn't expose Spinnaker services, you need to `port-forward` to access the Spinnaker UI and API.

Expose Deck for the UI:

```bash
kubectl port-forward svc/spin-deck 9000:9000 -n spinnaker
```

Expose Gate for the API:

```bash
kubectl port-forward svc/spin-gate 8084:8084 -n spinnaker
```

Alternately, you can follow your cloud provider's guide for publicly exposing an app.

## Access the Spinnaker UI

If you used `port-forward`, you can access the UI at `http://localhost:9000`.

## Help resources

[Spinnaker Slack](https://join.spinnaker.io/) `#kubernetes-operator` channel.

## Advanced configuration

Explore the `spinnaker-patches-repo` for examples of advanced configuration.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-manage-spinnaker.md" >}}
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-manage-operator.md" >}}
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/hal-op-migration.md" >}}
