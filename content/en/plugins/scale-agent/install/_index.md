---
title: Get Started with the Armory Scale Agent for Spinnaker and Kubernetes
linkTitle: Get Started
description: >
  Learn how to configure and install the Armory Scale Agent for Spinnaker and Kubernetes in your Spinnaker and Armory CD environments.
weight: 1
no_list: true
aliases:
  - /scale-agent/install/install-agent-plugin/
---

## Compatibility matrix

{{< include "scale-agent/agent-compat-matrix.md" >}}

## Basic installation use cases

| Installation Use Case | Guide | Plugin Install| Service Deploy | K8s Acct Config | Mode |
|:--- |:---- |:----- |:-----|:----- |:-----|
| Create a new Spinnaker instance managed by the Spinnaker Operator | {{< linkWithTitle "plugins/scale-agent/install/quickstart.md" >}} | Plugin repository configured in a Kustomize patch | Kustomize patches | Service's ConfigMap | [Spinnaker Service]({{< ref "/plugins/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |
| Use an existing Spinnaker instance managed by Halyard | {{< linkWithTitle "plugins/scale-agent/install/install-spin.md" >}} | Plugin repository configured in `clouddriver-local` file| Kubernetes manifests | Service's ConfigMap | [Spinnaker Service]({{< ref "/plugins/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |
| Use an existing Armory CD instance managed by the Armory Operator | {{< linkWithTitle "plugins/scale-agent/install/install-armory.md" >}} | Plugin repository configured in a Kustomize patch | Kustomize patches | Service's ConfigMap | [Spinnaker Service]({{< ref "/plugins/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |

## Advanced installation use cases

| Use Case | Guide |
|:--- |:---- |
| Plugin as a Docker image | {{< linkWithTitle "plugins/scale-agent/install/advanced/plugin-docker.md" >}} |
| Service using a Helm chart | {{< linkWithTitle "plugins/scale-agent/install/advanced/service-deploy/helm/index.md" >}} |
| Service deploy modes - Spinnaker Service, Infrastructure, Agent | {{< linkWithTitle "plugins/scale-agent/install/advanced/modes.md" >}} |
| Service configuration | {{< linkWithTitle "plugins/scale-agent/install/advanced/config-service.md" >}} |


## Scale Agent reference

* {{< linkWithTitle "plugins/scale-agent/reference/config/plugin-options.md" >}}
* {{< linkWithTitle "plugins/scale-agent/reference/config/service-options.md" >}}