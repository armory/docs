---
title: Configure Spinnaker Using Kustomize
linkTitle: Config Using Kustomize
weight: 10
description: >
  This guide describes how to configure Spinnaker or Armory Enterprise using Kustomize patches.
---
{{< include "armory-operator/os-operator-blurb.md">}}

## Why use Kustomize patches for Spinnaker configuration

{{< include "armory-operator/why-use-kustomize.md" >}}

## How Kustomize works

{{< include "armory-operator/how-kustomize-works.md" >}}

## Kustomize resources

You should familiarize yourself with Kustomize before you create patch files to configure Spinnaker.

* Kustomize [Glossary](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/)
* Kustomize [introduction](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
* Kustomize [installation](https://kubectl.docs.kubernetes.io/installation/kustomize/)
* [Kustomization file overview](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/)

## Spinnaker Kustomize patches repo

Armory maintains the `spinnakaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches), which contains common configuration options for Spinnaker and Armory Enterprise. This gives you a reliable starting point when adding and removing Armory Enterprise or Spinnaker features.

{{% alert title="Patch Warning" color="warning" %}}
All of the patches in the repo are for configuring Armory Enterprise. To use the patches to configure open source Spinnaker, you must change `spinnaker.armory.io` in the `apiVersion` field to `spinnaker.io`. This field is on the first line in a patch file.
{{% /alert %}}

To start, create your own copy of the `spinnaker-kustomize-patches` repository
by clicking the `Use this template` button:

![button](/images/kustomize-patches-repo-clone.png)

Once created, clone this repository to your local machine.

## Configure Spinnaker

Follow these steps to configure Spinnaker:

1. [Choose a `kustomization.yml` file](#choose-a-kustomization-file).
1. (Optional) If you are deploying open source Spinnaker, [change the `apiVersion` in each patch file](#change-the-apiversion).
1. [Set the Spinnaker or Armory Enterprise version](#set-the-spinnaker-version).
1. [Verify the content of each resource file](#verify-resources).
1. [Verify the configuration contents of each patch file](#verify-patches).

### Choose a `kustomization` file

Before you begin configuring Spinnaker, you need to choose a `kustomization.yml` file. The `kustomization.yml` specifies the namespace for Spinnaker, a list of Kubernetes resources, and a list of patch files to merge into the Spinnaker manifest file. For example, the `recipes/kustomization-quickstart.yml` contains the following:

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

# Namespace where spinnaker and all its infrastructure will be installed.
# NOTE: If changed, also change it in all ClusterRoleBinding namespace references.
namespace: spinnaker

resources:
  - spinnakerservice.yml             # (Mandatory). Base spinnaker manifest
  - infrastructure/minio.yml         # Self hosted minio, a S3 compatible data store
  - infrastructure/redis.yml
  - accounts/kubernetes/spin-sa.yml  # Kubernetes service account needed by patch-kube.yml

patchesStrategicMerge:
  - persistence/patch-minio.yml   # (Mandatory). Persistence to store spinnaker applications and pipelines
  - persistence/patch-redis.yml
  - expose/patch-lb.yml                 # Automatically expose spinnaker
  - accounts/kubernetes/patch-kube.yml  # Kubernetes accounts
  - accounts/docker/patch-dockerhub.yml # Docker accounts
```

The `resources` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/resource/) contains links to files that define Kubernetes resources: Minio, Redis, and a Kubernetes Service Account.

The `patchesStrategicMerge` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patchesstrategicmerge/) contains links to files that contain partial or complete resource definitions. Kustomize uses these patch files to overwrite sections of the `spinnakerservice.yml` file.

There are multiple `kustomization` examples in the `recipes` directory. Choose the one that most closely resembles your use case. Alternately, you can modify an existing `kustomization.yml` file to include only the patch files you want if none of the examples contains the right patches for your use case.

Update the link in the top-level `kustomization.yml` to point to the `kustomization` file you want to use.

### Change the `apiVersion`

>This step is required only if you are deploying open source Spinnaker.

The first line in each patch file defines the `apiVersion`:

```yaml
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version">}}
```

Change `spinnaker.armory.io` to `spinnaker.io` if you are deploying open source Spinnaker.

### Set the Spinnaker version

In `spinnaker-kustomize-patches/spinnakerservice.yml`, set the [Spinnaker version](https://spinnaker.io/community/releases/versions/) or [Armory Enterprise version]({{< ref "rn-armory-spinnaker" >}}) that you want to deploy, such as `1.25.3` or `2.25.0`.

{{< prism lang="yaml" line="8" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    # ------- Main config section, equivalent to "~/.hal/config" from Halyard
    config:
      version: 1.25.3
{{< /prism >}}


### Verify resources

Read each file linked to in the `resources` section to make sure that the Kubernetes resource as configured will work with your environment.

### Verify patches

Read each file linked to in the `patchesStrategicMerge` section. You may need to update each configuration with values specific to you and your environment. For example, the `kustomization-quickstart.yml` file described in the [Choose a `kustomization` file](#choose-a-kustomization-file) section links to `accounts/docker/patch-dockerhub.yml`. You need to update that patch file with your own DockerHub credentials.

Store secret literals in `secrets/secrets.env` and secret files in `secrets/files` if you want to store Spinnaker secrets in Kubernetes.

## Deploy Spinnaker

{{% include "armory-operator/deploy-spin-kust.md" %}}

## {{% heading "nextSteps" %}}

* See the [Manifest Reference]({{< ref "op-manifest-reference" >}}) for configuration options by section.
* Learn how to [manage]({{< ref op-manage-spinnaker >}}) your Spinnaker instance.
* See the {{< linkWithTitle "op-troubleshooting.md" >}} guide if you encounter issues.
