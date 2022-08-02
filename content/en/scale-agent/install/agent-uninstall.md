---
title: Uninstall the Armory Agent
weight: 99
---

## Uninstall the plugin

Remove the Armory Agent plugin manifest file entry from your `kustomization` file.

{{< prism lang="yaml" line="4" >}}
bases:
  - agent-service
patchesStrategicMerge:
  - armory-agent/clouddriver-plugin.yaml
{{< /prism >}}

Then execute:

{{< prism lang="bash" >}}
 kustomize build </path/to/kustomize> | kubectl delete -f -
{{< /prism >}}

## Uninstall the Armory Agent

You can use `kubectl` to delete all Agent `Deployment` objects and their accompanying `ConfigMap` and `Secret`.