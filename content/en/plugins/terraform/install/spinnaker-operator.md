---
title: Install Terraform Integration in Spinnaker (Spinnaker Operator)
linkTitle: Spinnaker - Operator
weight: 5
description: >
  Learn how to install Armory's Terraform Integration Plugin in a Spinnaker instance managed by the Spinnaker Operator.
---


## Overview of installing the plugin

In this guide, you use the Kustomize files in the [`spinnaker-kustomize-patches` repo](https://github.com/armory/spinnaker-kustomize-patches) to install the plugin. You do need to update the contents of some files.

### Compatibility



## {{% heading "prereq" %}}

* You are running open source Spinnaker.
* You manage your instance using the Spinnaker Operator and the `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches). If you are using Halyard, see {{< linkWithTitle "plugins/terraform/install/spinnaker-halyard.md" >}}.

## Find the files

You can find the Terraform Integration plugin files in the `spinnaker-kustomize-patches` repo's `plugins/oss/terraformer` directory.  

* `kustomization.yml`: Kustomize build file
* `deployment.yml`: `spin-terraformer` Deployment manifest
* `service.yml`: `spin-terraformer` Service manifest
* `terraformer-plugin-config.yml`: plugin installation
* `terraformer.yml`: config file
* `terraformer-local.yml`: config gile
* `spinnaker.yml`: Spinnaker service mapping 
* `versions` directory: contains version-specific values that Kustomize inserts into the manifest during generation

The `spinnaker-kustomize-patches/recipes` directory contains the example `kustomization-oss-terraformer.yml` recipe. You can use that recipe or copy the entries to your  recipe. This guide uses the `kustomization-oss-terraformer.yml` recipe for examples.

## Configure the service

### Set your Spinnaker version

Make sure the service version is compatible with your Spinnaker version.

You specify the version in the `patchesStrategicMerge` section of `plugins/oss/terraformer/kustomization.yml`. You can find supported versions in the `plugins/oss/terraformer/versions` directory. For example, if you are running Spinnaker 1.27.x, replace `./versions/v-1.28.yml` with `./versions/v-1.27.yml`.

```yaml
patchesStrategicMerge:
  - ./pac-plugin-config.yml
  - ./versions/v-1.28.yml
```

## Configure the plugin version

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

## Deploy

This step deploys the Terraformer service and installs the plugin. If you want to see the generated manifest before you deploy, execute `kubectl kustomize`.

Apply the updates to your Kustomization file.

```bash
kubectl apply -k <kustomization-directory-path>
```

## {{% heading "nextSteps" %}}

