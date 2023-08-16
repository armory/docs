---
title: Install Terraform Integration in Spinnaker (Spinnaker Operator)
linkTitle: Spinnaker - Operator
weight: 3
description: >
  Learn how to install Armory's Terraform Integration Plugin in a Spinnaker instance managed by the Spinnaker Operator. Terraform Integration enables your app developers to provision infrastructure using Terraform as part of their delivery pipelines.
---

## Overview of installing Terraform Integration

In this guide, you use the Kustomize files in the [`spinnaker-kustomize-patches` repo](https://github.com/armory/spinnaker-kustomize-patches) to install the plugin. You do need to update the contents of some files.

1. [Configure Spinnaker](#configure-spinnaker)
1. [Get the Terraform Integration installation files](#get-the-terraform-integration-installation-files)
1. [Configure the service](#configure-the-service)
1. [Configure the plugin](#configure-the-plugin)
1. [Deploy Terraform Integration](#deploy-terraform-integration)

### Compatibility

{{< include "plugins/pac/compat-matrix.md" >}}

## {{% heading "prereq" %}}

You have read the [Terraform Integration Overview]({{< ref "plugins/terraform/_index.md" >}}).

**Spinnaker requirements**

* You are running open source Spinnaker.
* You manage your instance using the Spinnaker Operator and the `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches). If you are using Halyard, see {{< linkWithTitle "plugins/terraform/install/spinnaker-halyard.md" >}}.

{{< include "plugins/terraform/terraform-prereqs.md" >}}

## Configure Spinnaker

### Configure Redis

{{< include "plugins/terraform/config-redis.md" >}}

### Configure your artifact account

{{< include "plugins/terraform/config-artifact-acct.md" >}}

### Configure additional repos

{{< include "plugins/terraform/configure-optional-repos.md" >}}

## Get the Terraform Integration installation files

You can find the Terraform Integration service and plugin files in the `spinnaker-kustomize-patches` repo's `plugins/oss/terraformer` directory.  

* `kustomization.yml`: Kustomize build file
* `deployment.yml`: `spin-terraformer` Deployment manifest
* `service.yml`: `spin-terraformer` Service manifest
* `terraformer-plugin-config.yml`: plugin installation
* `terraformer.yml`: config file
* `terraformer-local.yml`: config file for [Named Profiles]({{< ref "plugins/terraform/install/configure#named-profiles" >}})
* `spinnaker.yml`: Spinnaker service mapping 
* `versions` directory: contains version-specific values that Kustomize inserts into the manifest during generation

The `spinnaker-kustomize-patches/recipes` directory contains the example `kustomization-oss-terraformer.yml` recipe. You can use that recipe or copy the entries to your recipe. This guide uses the `kustomization-oss-terraformer.yml` recipe for examples.

## Configure the service

Make sure the service version is compatible with your Spinnaker version.

You specify the version in the `patchesStrategicMerge` section of `plugins/oss/terraformer/kustomization.yml`. You can find supported versions in the `plugins/oss/terraformer/versions` directory. For example, if you are running Spinnaker 1.27.x, replace `./versions/v-1.28.yml` with `./versions/v-1.27.yml`.

```yaml
patchesStrategicMerge:
  - ./pac-plugin-config.yml
  - ./versions/v-1.28.yml
```

## Configure the plugin

In `terraformer-plugin-config.yml`, make sure the `version` number is compatible with your Spinnaker instance.

```yaml
...
        spinnaker:
          extensibility:
            plugins:
              Armory.Terraformer:
                enabled: true
                version: &pluginversion 0.0.1
```

For example, if you want to use plugin version 0.0.2, your `version` value would be `&pluginversion 0.0.2`.

## Deploy Terraform Integration

This step deploys the Terraformer service and installs the plugin. If you want to see the generated manifest before you deploy, execute `kubectl kustomize`.

Apply the updates to your Kustomization file.

```bash
kubectl apply -k <kustomization-directory-path>
```

## {{% heading "nextSteps" %}}

{{< include "plugins/terraform/whats-next.md" >}}