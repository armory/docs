---
title: Armory Agent Plugin Installation
linkTitle: Agent Plugin
weight: 3
description: >
  Install Armory Agent plugin.
---

Armory Agent contains a plugin for Clouddriver. There is a file for the plugin itself and another for the plugin's configuration. If you don't need to modify those files, simply add the snippet below to your `kustomization.yaml` file, replacing `<version>` with the plugin version you are using. Installing the plugin creates the gPRC endpoint for communication with the Agent service.

   ```yaml
   namespace: spinnaker

   resources:
   - spinsvc.yaml # Spinnaker's configuration

   patchesStrategicMerge:
      - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/clouddriver-plugin-<version>.yaml
      - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/kubesvc-plugin-config-<version>.yaml
   ```


@TODO add section for deploying via Halyard

@TODO add section on configuring the plugin