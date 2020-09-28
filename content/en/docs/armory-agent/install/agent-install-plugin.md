---
title: Armory Agent Plugin Installation
linkTitle: Agent Plugin
weight: 3
description: >
  Install Armory Agent plugin.
---

Armory Agent plugin for Clouddriver is installed as a container. Installing the plugin creates the gPRC endpoint for communication with the Agent service.

   ```yaml
   namespace: spinnaker

   resources:
   - spinsvc.yaml

   patchesStrategicMerge:
      - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/clouddriver-plugin-<KUBESVC_VERSION>.yaml
      - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/kubesvc-plugin-config-<KUBESVC_VERSION