---
title: "Syntax Highlighting"
draft: true
description: >
  Page to check how code renders based on highlight style in config.toml
---


## Notes


This depends on `prism_syntax_highlighting = true` in `config.toml`. You don't even get code copy without this. The problem is that if you don't comment out the param, any dark Chroma theme doesn't render correctly.

## Chroma highlighting

Code fences

Bash

```bash
kubectl create secret tls <clouddriver-secret-name> \
   --cert=<your-clouddriver-cert> --key=<your-clouddriver-key>
```

YAML

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

## Prism highlighting


Bash

{{% prism lang="bash" %}}
kubectl create secret tls <clouddriver-secret-name> \
   --cert=<your-clouddriver-cert> --key=<your-clouddriver-key>
{{% /prism %}}

YAML

{{% prism lang="yaml" %}}
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
{{% /prism %}}