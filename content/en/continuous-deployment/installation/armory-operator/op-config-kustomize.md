---
title: Configure Armory Continuous Deployment Using Kustomize
linkTitle: Config Using Kustomize
weight: 5
description: >
  This guide describes how to configure Armory Continuous Deployment or Spinnaker using Kustomize patches.
---
{{< include "armory-operator/os-operator-blurb.md">}}

## Why use Kustomize patches for Spinnaker configuration

{{< include "armory-operator/why-use-kustomize.md" >}}

## How Kustomize works

{{< include "armory-operator/how-kustomize-works.md" >}}

{{% include "armory-operator/kust-ver-note.md" %}}

## Kustomize resources

You should familiarize yourself with Kustomize before you create patch files to configure Armory Continuous Deployment.

* Kustomize [Glossary](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/)
* Kustomize [introduction](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
* [Kustomization file overview](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/)

## Kubernetes requirements

{{% include "armory-operator/k8s-reqs.md" %}}

## Spinnaker Kustomize patches repo

{{% include "armory-operator/spin-kust-repo.md" %}}

## Configure Armory Continuous Deployment

Follow these steps to configure Armory Continuous Deployment:

1. [Choose a `kustomization.yml` file](#choose-a-kustomization-file).
1. (Optional) If you are deploying open source Spinnaker, [change the `apiVersion` in each patch file](#change-the-apiversion).
1. [Set the Armory Continuous Deployment (or Spinnaker) version](#set-the-spinnaker-version).
1. [Verify the content of each resource file](#verify-resources).
1. [Verify the configuration contents of each patch file](#verify-patches).

### Choose a `kustomization` file

Before you begin configuring Armory Continuous Deployment, you need to choose or create a
`kustomization.yml` file. The `kustomization.yml` specifies the namespace for
Armory Continuous Deployment, a list of Kubernetes resources, and a list of patch files to
merge into the `spinnakerservice.yml` manifest file. For example, the
`recipes/kustomization-minimum.yml` file contains the following:

{{< github repo="armory/spinnaker-kustomize-patches" file="/recipes/kustomization-minimum.yml" lang="yaml" options="" >}}

* The `components`
  [section](https://kubectl.docs.kubernetes.io/guides/config_management/components/)
  contains paths to directories that define collections of Kubernetes
  resources, such as: in-cluster Spinnaker persistence with Minio, Kubernetes
  Service Account and patches to enable the cluster in Spinnaker.

* The `patchesStrategicMerge`
  [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patchesstrategicmerge/)
  contains links to files that contain partial resource
  definitions. Kustomize uses these patch files to overwrite sections of
  components or resources, such as the `SpinnakerService` definition.

`spinnaker-kustomize-patches/kustomization.yml` is a symlink that points to
`spinnaker-kustomize-patches/recipes/kustomization-all.yml`. There are
multiple `kustomization` examples in the `recipes` directory. Choose the one
that most closely resembles your use case and link to it. Alternately, you can
delete the symlink, move your desired Kustomization file from `recipes` to the
top-level directory, and rename the file to `kustomization.yml`.

{{% alert title="Warning" color="warning" %}}
If you are in an air-gapped environment and are using MinIO to host the Armory
Continuous Deployment BOM, remove `core/persistence/in-cluster/minio.yml` from the list of resources to
prevent the accidental deletion of the bucket when calling `kubectl delete -k
.`.
{{% /alert %}}

### Choose Open Source Spinnaker

>This step is required only if you are deploying open source Spinnaker.

Add the following patch to your `kustomization.yml` file:

```yaml
patches:
  - target:
      kind: SpinnakerService
    path: utilities/switch-to-oss.yml
```

### Set the Armory Continuous Deployment version

In `spinnaker-kustomize-patches/core/patches/version.yml`, set the [Armory
CD version]({{< ref "rn-armory-spinnaker" >}}) or [Spinnaker
version](https://spinnaker.io/community/releases/versions/) that you want to
deploy, such as `{{< param "armory-version-exact" >}}` (Armory Continuous Deployment) or
`1.25.3` (Spinnaker).

{{< highlight yaml "linenos=table,hl_lines=8" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: {{< param "armory-version-exact" >}}
{{< /highlight >}}

### Verify resources

Read each file linked to from your chosen `kustomization.yml` file section to
make sure that the Kubernetes resource as configured works with your
environment.

### Verify patches

Read each file linked to in the `patchesStrategicMerge` section. You may need to update each patch configuration with values specific to you and your environment. For example, the `kustomization-quickstart.yml` file described in the [Choose a `kustomization` file](#choose-a-kustomization-file) section links to `accounts/docker/patch-dockerhub.yml`. You need to update that patch file with your own DockerHub credentials.

Explore the patches in various folders to see if there are any that you want to use. Remember to list additional patches in the `patchesStrategicMerge` section of your `kustomization.yml` file.

### Secrets

If you want to store Spinnaker secrets in Kubernetes, we recommend using
[Kustomize
generators](https://kubernetes.io/docs/tasks/configmap-secret/managing-secret-using-kustomize/).

## Deploy Armory Continuous Deployment

{{% include "armory-operator/deploy-spin-kust.md" %}}

## Help resources

{{% include "armory-operator/help-resources.md" %}}

## {{% heading "nextSteps" %}}

* See the [Manifest Reference]({{< ref "op-manifest-reference" >}}) for configuration options by section.
* Learn how to [manage]({{< ref op-manage-spinnaker >}}) your Spinnaker instance.
* See the {{< linkWithTitle "op-troubleshooting.md" >}} guide if you encounter issues.
