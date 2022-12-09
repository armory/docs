---
title: Enable the Evaluate Artifacts Stage
description: >
  Enable the Evaluate Artifacts Stage plugin to add it to Armory Enterprise. The stage gives pipeline creators the ability to create base64 artifacts from text saved within a pipeline. The contents of the new artifact include the results of any SpEL expressions that are evaluated.
aliases:
  - /docs/plugin-guide/plugin-evaluate-artifacts/
---

![Proprietary](/images/proprietary.svg)

## Overview

Some artifact types and their associated stages, such as Kubernetes, support  using SpEL to read parameters from the Spinnaker context and inject them into an artifacts manifest at deploy time. Other stages, such as the Terraform Integration stage, do not support this out of the box. The Evaluate Artifacts Stage plugin adds supports for evaluating SpEL against any artifact within your Spinnaker pipeline.

For information about how to use the stage, see {{< linkWithTitle "evaluate-artifacts-stage-use.md" >}}.

## {{% heading "prereq" %}}

* If you are new to enabling plugins, read Spinnaker's [Plugin Users Guide](https://spinnaker.io/docs/guides/user/plugins-users/) to familiarize yourself with how plugins to Armory Enterprise work.
* The Evaluate Artifacts Stage requires Armory Enterprise 2.24.x or later (Spinnaker 1.24.x or later)


## Setup

{{< tabs name="enable-plugin" >}}

{{% tabbody name="Operator" %}}

Add the following snippet to your Spinnaker manifest, such as `spinnakerservice.yml`:

   ```yaml
    spec:
      spinnakerConfig:
        profiles:
          spinnaker:  
            spinnaker:  # This second `spinnaker` is required
              extensibility:
                plugins:
                  Armory.EvaluateArtifactsPlugin:
                    enabled: true
                    version: <PLUGIN_VERSION> # Replace with the version you want to use. For example, use 0.1.0.
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
                      version: <PLUGIN_VERSION> # Replace with the version you want to use. For example, use 0.1.0.
   ```

Keep the following in mind when using this configuration snippet:

* Make sure to include the nested `spinnaker` parameter. Both are required because of how Armory Enterprise consumes plugin configurations.
* Replace `<PLUGIN_VERSION>` on lines 10 and 22 with the version of the plugin that you want to use. Plugin versions can be found [here](#versions).

Then, deploy your updated Armory Enterprise configuration using one of the following methods:

- If you are using a single manifest file: `kubectl -n <namespace> apply -f <path-to-manifest-file>`
- If you are using Kustomize patches like the ones in the [Armory kustomize repo](https://github.com/armory/spinnaker-kustomize-patches), you need to apply the kustomization. Depending on how you have Kustomize installed (either directly or as part of `kubectl`), use one of the following commands:

   Kustomize is installed separately from `kubectl`:

   ```bash
   # The namespace is declared in kustomization.yml
   # Run this from the same directory as your kustomization.yml file
   kustomize build | kubectl  apply -f -
   ```

   Kustomize is bundled with `kubectl`:

   ```bash
   kubctl -n <namespace> apply -k <path-to-kustomize-directory>
   ```

{{% /tabbody %}}
{{< /tabs>}}

## Versions

- 0.1.1 - Update plugin to be compatible with Armory Enterprise 2.27.0 and later
- 0.1.0 - Improved the user experience. Execution errors for the stage now display in the UI.
- 0.0.10 - Initial Release

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "evaluate-artifacts-stage-use.md" >}}
