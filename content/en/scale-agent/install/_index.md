---
title: Get Started with the Armory Scale Agent for Spinnaker and Kubernetes
linkTitle: Get Started
description: >
  Learn how to install and configure the Armory Scale Agent for Spinnaker and Kubernetes in your Spinnaker and Armory CD environments.
weight: 1
no_list: true
aliases:
  - /scale-agent/install/install-agent-plugin/
---

## Compatibility matrix

{{< include "scale-agent/agent-compat-matrix.md" >}}


| Installation Use Case | Guide | Plugin Install| Service Deploy | K8s Acct Config | Mode |
|:--- |:---- |:----- |:-----|:----- |:-----|
| Create a new Spinnaker instance managed by the Spinnaker Operator | {{< linkWithTitle "scale-agent/install/quickstart.md" >}} | Plugin repository configured in a Kustomize patch | Kustomize patches | Service's ConfigMap | [Spinnaker Service]({{< ref "/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |
| Use an existing Spinnaker instance managed by Halyard | {{< linkWithTitle "scale-agent/install/install-spin.md" >}} | Plugin repository configured in `clouddriver-local` file| Kubernetes manifests | Service's ConfigMap | [Spinnaker Service]({{< ref "/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |
| Use an existing Armory CD instance managed by the Armory Operator | {{< linkWithTitle "scale-agent/install/install-armory.md" >}} | Plugin repository configured in a Kustomize patch | Kustomize patches | Service's ConfigMap | [Spinnaker Service]({{< ref "/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |

