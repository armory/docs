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

- The `deploy.sh` script if you use the [Armory kustomize repo](https://github.com/armory/spinnaker-kustomize-patches) to help manage your Operator configurations
- `kubectl -n <spinnaker-namespace> -f <operator-config>.yml​`

## Usage

To use the stage, perform the following steps:

1. In the Armory Enterprise UI, navigate to the pipeline you want to modify.
2. Add the stage called **Evaluate Artifacts** stage to your pipeline.
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

### Problem saving artifacts

You may run into an issue where it seems like artifacts (or changes to them) are not being saved even though you click **Save Changes**. This issue occurs because of how the UI handles updates to artifacts in relation to changes to other configurations.

To avoid this issue, use the following workflow when you want to modify artifacts in a stage:

1. Save any changes you have made to the pipeline before you modify artifacts.
2. Make changes to the artifacts for the stage.
3. Wait for the status in the bottom right of the UI to change from **In sync to the server** to the action buttons.
   This wait period is important. If you make other changes before the artifact is ready, the artifact will not be saved.
4. Save your changes.
5. Continue making other changes.

## Release notes

- v0.0.10 - Initial Release
