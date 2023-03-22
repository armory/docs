---
title: Armory CD Quickstart Script
linkTitle: Armory CD Quickstart
weight: 1
description: >
  Use an "all-in-one" script to install a basic Armory Continuous Deployment instance for evaluation.
aliases:
  - /continuous-deployment/installation/armory-operator/op-quickstart.md
draft: true
---

<!-- the deploy.sh script doesn't work but leaving this here for reference -->

## Quickstart overview 

This guide shows you how to install Armory CD using an install script that deploys the Armory Operator in cluster mode and then Armory CD. This is useful for a proofs of concept, but you should not use this script for a production environment.

## Objectives

1. Meet the requirements listed in the [{{% heading "prereq" %}}](#before-you-begin) section.
1. [Get the repo](#get-the-repo).
1. [Configure Armory CD](#configure-armory-cd).
1. [Deploy Armory CD](#deploy-armory-cd).

## {{% heading "prereq" %}}

* Make sure your environment meets or exceeds Armory CD [system requirements]({{< ref "continuous-deployment/installation/system-requirements" >}}).
* Make sure your Kubernetes version is compatible with the latest Armory Operator version.

  {{< include "armory-operator/operator-compat-matrix.md" >}}

## Get the repo

{{% include "armory-operator/spin-kust-repo.md" %}}

## Configure Armory CD

You can find a basic recipe for deploying Armory CD in `recipes/kustomization-minimum.yml`.

{{< github repo="armory/spinnaker-kustomize-patches" file="/recipes/kustomization-minimum.yml" lang="yaml" options="" >}}

* The `components` [section](https://kubectl.docs.kubernetes.io/guides/config_management/components/)
  contains paths to directories that define collections of Kubernetes resources.
* The `patchesStrategicMerge` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patchesstrategicmerge/) contains links to files that contain partial resource definitions. Kustomize uses these patch files to overwrite sections of components or resources, such as the `SpinnakerService` definition.

### What this recipe does

* Configures MinIO as the persistent storage provider (instead of Redis or cloud storage)

### What this recipe does not do

* Configure Clouddriver or other services to use a SQL backend
* Configure a LoadBalancer to expose Spinnaker services

### Update recipe symlink

Navigate to the root of your `spinnaker-kustomize-patches` directory. Update the `kustomization.yml` symlink to point to `recipes/kustomization-minimum.yml`:

```bash
ln -vfns ./recipes/kustomization-minimum.yml kustomization.yml
```

### Armory CD version

To change the Armory CD version, update `spec.spinnakerConfig.config.version` in `core/patches/version.yml`.

## Deploy Armory CD

The `deploy.sh` script does the following:

* Deploys the latest Armory Operator to the `spinnaker-operator` namespace.
* Uses the `recipes/kustomization-minimum.yml` recipe to deploy a basic Armory CD instance to the `spinnaker` namespace.

The install process creates the necessary Kubernetes roles and secrets.

{{< tabpane text=true right=true >}}
{{< tab header="**Environment**:" disabled=true />}}
{{% tab header="Cloud/Server" text=true %}}

Execute the all-in-one installation script:

```bash
./deploy.sh
```


{{% /tab %}}
{{% tab header="Laptop" text=true %}}

If you are installing Armory CD into a cluster running on your laptop, you may have to install the Armory Operator first due to lack of resources. 

{{< include "armory-operator/armory-op-install-cluster.md" >}}

After the Armory Operator has successfully deployed, set you can then run the `deploy` script, passing in a parameter to not install the Armory Operator:

```bash
export SPIN_OP_DEPLOY=0
./deploy.sh 
```
{{% /tab %}}
{{< /tabpane >}}

The script writes output to `deploy_log.txt`.

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

[Spinnaker Slack](https://join.spinnaker.io/) `#armory` channel.


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-manage-spinnaker.md" >}}
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-manage-operator.md" >}}
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/hal-op-migration.md" >}}