---
title: Evaluate Artifacts Stage Plugin
toc_hide: true
exclude_search: true
description: >
  The Evaluate Artifacts Stage plugin adds a stage to Armory Enterprise that makes it easy to evaluate SpEL expressions inside of Spinnaker™ artifacts.
---

## Overview

Armory’s Evaluate Artifacts plugin allows you to easily evaluate SpEL queries inside of any Spinnaker artifacts. Historically some artifacts, such as Kubernetes, have supported leveraging SpEL in order to read parameters from the spinnaker context, and inject them into an artifacts manifest at deploy time. Other stages, such as Terraformer, have not supported this. The new Evaluate Artifacts stage supports evaluating SpEL against any artifact within your spinnaker pipeline.

## Requirements

This plugin requires :

- Armory 2.24.x or later (OSS Spinnaker 1.24.x or later)


## Setup

Add the following snippet to your Operator config, such as `spinnakerservice.yml`. Replace ‘<PLUGIN_VERSION>’ with the version of the plugin that you want to use. Plugin versions can be found [here](#release-notes).

```yaml
    spec:
      spinnakerConfig:
        profiles:
          spinnaker:
            spinnaker:
              extensibility:
                plugins:
                  Armory.EvaluateArtifactsPlugin:
                    enabled: true
                    version: <PLUGIN_VERSION> # Replace with the version you want to use
                repositories:
                  evaluateArtifacts:
                    url: https://raw.githubusercontent.com/armory-plugins/evaluate-artifacts-releases/master/repositories.json
          gate:
            spinnaker:
              extensibility:
                deck-proxy:
                  enabled: true
                  plugins:
                    Armory.EvaluateArtifactsPlugin:
                      enabled: true
                      version: <PLUGIN_VERSION> # Replace with the version you want to use
    
```

Then, deploy your updated Operator configuration using one of the following methods:

- The `deploy.sh` script if you use the [Armory kustomize repo](https://github.com/armory/spinnaker-kustomize-patches) to help manage your Operator configs
- `kubectl -n <spinnaker-namespace> -f <operator-config>.yml​`

## Usage

To use the stage, perform the following steps:

1. In the Armory Enterprise UI, navigate to the pipeline you want to modify.
2. Add the stage called **Evaluate Artifacts**’** stage to your pipeline.
3. Add an artifact to the stage.
4. Enter your artifact definition. When entering the definition, you can use a SpEL expression to parameterize it. 

## Examples

This example reads the parameter `moduleConfig` and parses it as JSON. Within that JSON, it reads the variable named `variable1` and injects it into the bucket.
```json
bucket  = "${#readJson(parameters['moduleConfig'])['variable1']}"
key     = "terraformer/tests/basic/terraform.tfstate"
region  = "us-west-2"
encrypt = false
profile = "prod"
```

If you run this pipeline and give the `moduleConfig` parameter the value `{ "variable1": "myBucketName"}`,
the stage evaluates to the following and stores the result as a base64 encoded artifact:

```json
bucket  = "myBucketName"
key     = "terraformer/tests/basic/terraform.tfstate"
region  = "us-west-2"
encrypt = false
profile = "prod"
```

## Known issues

As with other Artifact stages, Armory Enterpise has an issue where the UI state may not reflect the result of creating the artifact. When it changes from `In sync to the server` to the actions buttons, it tells you that whatever change happened to the artifacts has completed. Because of this it is recommended to save your pipeline before modifying the artifacts in this stage, and then immediately save it after modifying the artifact before making any other changes. This allows you to use the button state to ensure that your artifact configuration gets saved correctly.

## Release notes

- v0.0.10 - Initial Release
