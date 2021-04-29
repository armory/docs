---
title: Configure Armory Enterprise Using Kustomize
linkTitle: Config Using Kustomize
weight: 5
description: >
  This guide describes how to configure Armory Enterprise or Spinnaker using Kustomize patches.
---
{{< include "armory-operator/os-operator-blurb.md">}}

## Why use Kustomize patches for Spinnaker configuration

{{< include "armory-operator/why-use-kustomize.md" >}}

## How Kustomize works

{{< include "armory-operator/how-kustomize-works.md" >}}

{{% include "armory-operator/kust-ver-note.md" %}}

## Kustomize resources

You should familiarize yourself with Kustomize before you create patch files to configure Armory Enterprise.

* Kustomize [Glossary](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/)
* Kustomize [introduction](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
* [Kustomization file overview](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/)

## Kubernetes requirements

{{% include "armory-operator/k8s-reqs.md" %}}

## Spinnaker Kustomize patches repo

Armory maintains the `spinnakaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches), which contains common configuration options for Armory Enterprise or Spinnaker. This gives you a reliable starting point when adding and removing features.

{{% alert title="Patch Warning" color="warning" %}}
All of the patches in the repo are for configuring Armory Enterprise. To use the patches to configure open source Spinnaker, you must change `spinnaker.armory.io` in the `apiVersion` field to `spinnaker.io`. This field is on the first line in a patch file.
{{% /alert %}}

To start, create your own copy of the `spinnaker-kustomize-patches` repository
by clicking the `Use this template` button:

![button](/images/kustomize-patches-repo-clone.png)

Once created, clone this repository to your local machine.

## Configure Armory Enterprise

Follow these steps to configure Armory Enterprise:

1. [Choose a `kustomization.yml` file](#choose-a-kustomization-file).
1. (Optional) If you are deploying open source Spinnaker, [change the `apiVersion` in each patch file](#change-the-apiversion).
1. [Set the Armory Enterprise (or Spinnaker) version](#set-the-spinnaker-version).
1. [Verify the content of each resource file](#verify-resources).
1. [Verify the configuration contents of each patch file](#verify-patches).

### Choose a `kustomization` file

Before you begin configuring Armory Enterprise, you need to choose or create a `kustomization.yml` file. The `kustomization.yml` specifies the namespace for Armory Enterprise, a list of Kubernetes resources, and a list of patch files to merge into the `spinnakerservice.yml` manifest file. For example, the `recipes/kustomization-quickstart.yml` file contains the following:

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

* The `resources` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/resource/) contains links to files that define Kubernetes resources: Minio, Redis, and a Kubernetes Service Account.

* The `patchesStrategicMerge` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patchesstrategicmerge/) contains links to files that contain partial or complete resource definitions. Kustomize uses these patch files to overwrite sections of the `spinnakerservice.yml` file.

`spinnaker-kustomize-patches/kustomization.yml` is a symlink that points to `spinnaker-kustomize-patches/recipes/kustomization-minimum.yml`. There are multiple `kustomization` examples in the `recipes` directory. Choose the one that most closely resembles your use case and link to it. Alternately, you can delete the symlink, move your desired Kustomization file from `recipes` to the top-level directory, and rename the file to `kustomization.yml`.


### Change the `apiVersion`

>This step is required only if you are deploying open source Spinnaker.

The first line in each patch file defines the `apiVersion`:

```yaml
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version">}}
```

Change `spinnaker.armory.io` to `spinnaker.io` if you are deploying open source Spinnaker.

### Set the Armory Enterprise version

In `spinnaker-kustomize-patches/core_config/patch-version.yml`, set the [Armory Enterprise version]({{< ref "rn-armory-spinnaker" >}}) or [Spinnaker version](https://spinnaker.io/community/releases/versions/) that you want to deploy, such as `{{< param "armory-version-exact" >}}` (Armory Enterprise) or `1.25.3` (Spinnaker).

{{< prism lang="yaml" line="8" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    # ------- Main config section, equivalent to "~/.hal/config" from Halyard
    config:
      version: {{< param "armory-version-exact" >}}
{{< /prism >}}

Add `core_config/patch-version.yml` to your `kustomization.yml` file in the `patchesStrategicMerge` section.

### Verify resources

Read each file linked to in the `resources` section to make sure that the Kubernetes resource as configured works with your environment.

### Verify patches

Read each file linked to in the `patchesStrategicMerge` section. You may need to update each patch configuration with values specific to you and your environment. For example, the `kustomization-quickstart.yml` file described in the [Choose a `kustomization` file](#choose-a-kustomization-file) section links to `accounts/docker/patch-dockerhub.yml`. You need to update that patch file with your own DockerHub credentials.

Explore the patches in various folders to see if there are any that you want to use. Remember to list additional patches in the `patchesStrategicMerge` section of your `kustomization.yml` file.

### Secrets

If you want to store Spinnaker secrets in Kubernetes, store secret literals in `secrets/secrets.env` and secret files in `secrets/files` .

## Deploy Armory Enterprise

{{% include "armory-operator/deploy-spin-kust.md" %}}

## Help resources

{{% include "armory-operator/help-resources.md" %}}

## {{% heading "nextSteps" %}}

* See the [Manifest Reference]({{< ref "op-manifest-reference" >}}) for configuration options by section.
* Learn how to [manage]({{< ref op-manage-spinnaker >}}) your Spinnaker instance.
* See the {{< linkWithTitle "op-troubleshooting.md" >}} guide if you encounter issues.
