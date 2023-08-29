---
title: Uninstall the Scale Agent - Armory Continuous Deployment
linkTitle: Uninstall
weight: 99
---

## Uninstall the plugin

Remove the Scale Agent plugin manifest file entry from your `kustomization` file.

```yaml
bases:
  - agent-service
patchesStrategicMerge:
  - armory-agent/clouddriver-plugin-repo.yaml # or clouddriver-plugin-docker.yaml
```

Then execute:

```bash
 kustomize build </path/to/kustomize> | kubectl delete -f -
```

## Uninstall the service

You can use `kubectl` to delete all Scale Agent service's `Deployment` objects and their accompanying `ConfigMap` and `Secret`.