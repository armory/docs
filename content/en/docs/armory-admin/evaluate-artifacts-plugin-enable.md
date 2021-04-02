---
title: Enable the Evaluate Artifacts Stage Plugin
description: >
  Enable the Evaluate Artifacts Stage plugin to add a stage to Armory Enterprise that makes it easy to evaluate SpEL expressions inside of Spinnaker™ artifacts.
aliases:
  - /docs/plugin-guide/plugin-evaluate-artifacts/
---

![Proprietary](/images/proprietary.svg)

## Overview

Armory’s Evaluate Artifacts plugin allows you to easily evaluate SpEL queries inside of any Spinnaker artifacts. Some artifacts, such as Kubernetes, support  using SpEL to read parameters from the Spinnaker context and inject them into an artifacts manifest at deploy time. Other stages, such as the Terraform Integration stage, do not support this out of the box. The Evaluate Artifacts Stage plugin adds supports for evaluating SpEL against any artifact within your Spinnaker pipeline.

For information about how to use the stage, see [Use the Evaluate Artifacts Stage]({{< ref "evaluate-artifacts-plugin-use.md" >}}).

## Setup

Add the following snippet to your Operator config, such as `spinnakerservice.yml`. Replace `<PLUGIN_VERSION>` with the version of the plugin that you want to use. Plugin versions can be found [here](#versions).

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
                      version: <PLUGIN_VERSION> # Replace with the version you want to use. Omit the 'v' when providing a version. For example, use 0.1.0, not v0.1.0
    
```

Then, deploy your updated Operator configuration using one of the following methods:

- The `deploy.sh` script if you use the [Armory kustomize repo](https://github.com/armory/spinnaker-kustomize-patches) to help manage your Operator configurations
- `kubectl -n <spinnaker-namespace> -f <operator-config>.yml​`


## Versions

- v0.1.0 - Improved the user experience. Execution errors for the stage now display in the UI
- v0.0.10 - Initial Release
