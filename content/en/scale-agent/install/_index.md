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


| Use Case | Guide | K8s Acct Config | Mode |
|:--- |:---- |:----- |:-----|
| New Spinnaker instance managed by the Spinnaker Operator | {{< linkWithTitle "scale-agent/install/quickstart.md" >}} | Service's ConfigMap | [Spinnaker Service]({{< ref "/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |
| Existing Spinnaker instance managed by Halyard | {{< linkWithTitle "scale-agent/install/install-spin.md" >}} | Service's ConfigMap | [Spinnaker Service]({{< ref "/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |
| Existing Armory CD instance managed by the Armory Operator | {{< linkWithTitle "scale-agent/install/install-armory.md" >}} | Service's ConfigMap | [Spinnaker Service]({{< ref "/scale-agent/install/advanced/modes#spinnaker-service-mode" >}}) |

