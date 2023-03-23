---
title: Install Armory CD using the Armory Operator and Kustomize patches
linkTitle: Install Armory CD
weight: 1
description: >
  This guide describes how to deploy a basic Armory CD instance using the Armory Operator and Kustomize patches. You can use this instance as a starting point for configuring advanced features.
aliases:
  - /continuous-deployment/installation/armory-operator/op-config-kustomize.md  
  - /continuous-deployment/installation/armory-operator/op-quickstart.md
---

## Why use Kustomize patches for Armory CD configuration

{{< include "armory-operator/why-use-kustomize.md" >}}

## Objectives

1. Meet the requirements listed in the [{{% heading "prereq" %}}](#before-you-begin) section.
1. [Deploy the Armory Operator](#deploy-the-spinnaker-operator).
1. [Get the spinnaker-kustomize-patches repo](#get-the-spinnaker-kustomize-patches-repo) that contains the Kustomize patches.
1. [Configure Armory CD](#configure-armory-cd).
1. [Deploy Armory CD](#deploy-armory-cd).
1. [Port-forward](#port-forward-to-expose-spinnaker-services-locally) to expose Spinnaker services.
1. Explore [advanced config options](#advanced-config-options)

## {{% heading "prereq" %}}

### How Kustomize works

{{< include "armory-operator/how-kustomize-works.md" >}}

### Kustomize resources

You should familiarize yourself with Kustomize before you create patch files to configure Armory CD.

* Kustomize [Glossary](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/)
* Kustomize [introduction](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
* [Kustomization file overview](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/)

### Kubernetes requirements

{{% include "armory-operator/k8s-reqs.md" %}}

### Kubernetes compatibility matrix

{{< readfile file="/includes/armory-operator/operator-compat-matrix.md" >}}

## Deploy the Armory Operator 

Decide which Armory Operator release you need based on the compatibility matrix. Then install the Armory Operator in [cluster mode]({{< ref "continuous-deployment/installation/armory-operator#operator-installation-modes" >}}).

{{< include "armory-operator/armory-op-install-cluster.md" >}}

## Get the spinnaker-kustomize-patches repo

{{% include "armory-operator/spin-kust-repo.md" %}}

## Configure Armory CD

Follow these steps to configure Armory CD:

1. [Choose a `kustomization.yml` file](#choose-a-kustomization-file).
1. [Set the Armory CD version](#set-the-spinnaker-version).
1. [Verify the content of each resource file](#verify-resources).
1. [Verify the configuration contents of each patch file](#verify-patches).

### Choose a `kustomization` file

Before you begin configuring Armory CD, you need to choose or create a `kustomization.yml` file. The `kustomization.yml` specifies the namespace for Armory CD, a list of Kubernetes resources, and a list of patch files to
merge into the `spinnakerservice.yml` manifest file. 

#### Kustomization file breakdown

The `recipes/kustomization-minimum.yml` recipe contains the bare minimum that you need to install Armory CD.

{{< github repo="armory/spinnaker-kustomize-patches" file="/recipes/kustomization-minimum.yml" lang="yaml" options="" >}}

* The `components` [section](https://kubectl.docs.kubernetes.io/guides/config_management/components/) contains paths to directories that define collections of Kubernetes resources, such as: in-cluster Spinnaker persistence with Minio, Kubernetes
  Service Account, and patches to enable the cluster in Spinnaker.
* The `patchesStrategicMerge` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patchesstrategicmerge/) contains links to files that contain partial resource definitions. Kustomize uses these patch files to overwrite sections of components or resources, such as the `SpinnakerService` definition.
* The `transformers` section contains links to files that define Kustomize [_transformers_](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#transformer).

{{% alert title="Warning" color="warning" %}}
If you are in an air-gapped environment and are using MinIO to host the Armory
CD BOM, remove `core/persistence/in-cluster/minio.yml` from the list of resources to
prevent the accidental deletion of the bucket when calling `kubectl delete -k
.`.
{{% /alert %}}

There are several example kustomization files in the `recipes` directory. `kustomization-all.yml` lists the most common options. Most are commented out, so be sure to uncomment the features and software you want to install.

#### Set the kustomization file

The `kustomization.yml` file in the project root is a symlink to `recipes/kustomization-all.yml`, which contains patches for If you don't want to use `kustomization-all.yml`, choose a recipe that most closely resembles your use case and update the symlink:

```bash
 ln -vfns ./recipes/<your-chosen-kustomization>.yml kustomization.yml
 ```

Alternately, you can delete the symlink, move your desired Kustomization file from `recipes` to the top-level directory, and rename the file to `kustomization.yml`.

### Set the Armory CD version

In `spinnaker-kustomize-patches/core/patches/version.yml`, set the [Armory CD version]({{< ref "rn-armory-spinnaker" >}}) that you want to deploy, such as `{{< param "armory-version-exact" >}}`.

{{< prism lang="yaml" line="8" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: {{< param "armory-version-exact" >}}
{{< /prism >}}

### Verify resources

Read each file linked to from your chosen `kustomization.yml` file section to make sure that the Kubernetes resource as configured works with your environment.

### Verify patches

Read each file linked to in the `patchesStrategicMerge` section of the kustomization file that you choose. You may need to update each patch configuration with values specific to you and your environment. For example, the `kustomization-quickstart.yml` file described in the [Choose a `kustomization` file](#choose-a-kustomization-file) section links to `accounts/docker/patch-dockerhub.yml`. You need to update that patch file with your own DockerHub credentials.

Explore the patches in various folders to see if there are any that you want to use. Remember to list additional patches in the `patchesStrategicMerge` section of your `kustomization.yml` file.

### Secrets

If you want to store Armory CD secrets in Kubernetes, you should use a [Kustomize `secretGenerator`](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kustomize/) and define your secrets in the kustomization file for your component. 

## Deploy Armory CD

{{% include "armory-operator/deploy-spin-kust.md" %}}

## Expose Spinnaker services

If you haven't included a patch to expose Armory CD services, you need to `port-forward` to access the Armory CD UI and API.

Expose Deck for the UI:

```bash
kubectl port-forward svc/spin-deck 9000:9000 -n spinnaker
```

Expose Gate for the API:

```bash
kubectl port-forward svc/spin-gate 8084:8084 -n spinnaker
```

## Advanced configuration

<!-- this is lame. expand later -->

`spinnaker-patches-repo/recipes/kustomization-all.yml` contains many examples of advanced configuration.

## Help resources

* Contact [Armory Support](https://support.armory.io/) or use the [Spinnaker Slack](https://join.spinnaker.io/) `#armory` channel.
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-troubleshooting.md" >}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "continuous-deployment/installation/armory-operator/manage-armorycd.md" >}}
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-manage-operator.md" >}}
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/hal-op-migration.md" >}}

