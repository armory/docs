---
title: Enable the Evaluate Artifacts Stage Plugin
description: >
  Enable the Evaluate Artifacts Stage plugin to add a stage to Armory Enterprise that makes it easy to evaluate SpEL expressions inside of Spinnaker™ artifacts.
aliases:
  - /docs/plugin-guide/plugin-evaluate-artifacts/
---

![Proprietary](/images/proprietary.svg)

## Overview

Armory’s Evaluate Artifacts plugin allows you to easily evaluate SpEL queries inside of any Spinnaker artifacts. Some artifact types and their associated stages, such as Kubernetes, support using SpEL to read parameters from the Spinnaker context and inject them into an artifacts manifest at deploy time. Other stages, such as the Terraform Integration stage, do not support this out of the box. The Evaluate Artifacts Stage plugin adds supports for evaluating SpEL against any artifact within your Spinnaker pipeline.

For information about how to use the stage, see [Use the Evaluate Artifacts Stage]({{< ref "evaluate-artifacts-plugin-use.md" >}}).

## Setup

{{< tabs name="enable-plugin" >}}

{{% tab name="Operator" %}}

This is the song that never ends

```
regular code block
```

prism code block. this is taken from the Halyard tab, and it's working in there

   {{< prism lang=yaml line="6" >}}
   spinnaker:
     extensibility:
       plugins:
         Armory.EvaluateArtifactsPlugin:
           enabled: true
            version: <PLUGIN_VERSION> # Replace with the version you want to use. Omit the 'v' when providing a version. For example, use 0.1.0, not v0.1.0.
       repositories:
         evaluateArtifacts:
           url: https://raw.githubusercontent.com/armory-plugins/evaluate-artifacts-releases/master/repositories.json
   {{< /prism >}}

{{% /tab %}}

{{% tab name="Halyard" %}}

1. Add the Evaluate Artifacts repository to your Armory Enterprise instance:

   ```bash
   hal plugins repository add evaluate-artifacts-releases --url https://raw.githubusercontent.com/armory-plugins/   evaluate-artifacts-releases/master/repositories.json
   ```

2. Add the plugin config to your `~/.hal/default/profiles/orca-local.yml` file:

   {{< prism lang=yaml line="6" >}}
   spinnaker:
     extensibility:
       plugins:
         Armory.EvaluateArtifactsPlugin:
           enabled: true
            version: <PLUGIN_VERSION> # Replace with the version you want to use. Omit the 'v' when providing a version. For example, use 0.1.0, not v0.1.0.
       repositories:
         evaluateArtifacts:
           url: https://raw.githubusercontent.com/armory-plugins/evaluate-artifacts-releases/master/repositories.json
   {{< /prism >}}

   Make sure to replace `PLUGIN_VERSION` with the version of the plugin you want to use. Plugin versions can be found [here](#versions).

3. Enable the stage in the UI in :

   {{< prism lang=yaml line="8" >}}
   spinnaker:
     extensibility:
      deck-proxy:
        enabled: true
        plugins:
          Armory.EvaluateArtifactsPlugin:
            enabled: true
            version: <PLUGIN_VERSION> # Replace with the version you want to use. Omit the 'v' when providing a version. For example, use 0.1.0, not v0.1.0.
      repositories:
        evaluateArtifacts:
          url: https://raw.githubusercontent.com/armory-plugins/evaluate-artifacts-releases/master/repositories.json
   {{< /prism >}}

   Make sure to replace `PLUGIN_VERSION` with the version of the plugin you want to use. Plugin versions can be found [here](#versions).

{{% /tab %}}
{{< /tabs >}}

## Versions

- v0.1.0 - Improved the user experience. Execution errors for the stage now display in the UI.
- v0.0.10 - Initial Release


   {{< prism lang=yaml line="4-5, 10, 22" >}}
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
                         version: <PLUGIN_VERSION> # Replace with the version you want to use. Omit the 'v' when providing a version. For example, use 0.1.0, not v0.1.0.
   {{< /prism >}}