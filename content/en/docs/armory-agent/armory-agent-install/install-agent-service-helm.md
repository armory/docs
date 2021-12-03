---
title: "Armory Agent Service Installation Using a Helm Chart"
linkTitle: "Install Service - Helm"
description: >
  Use a Helm chart to install the Armory Agent service in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

## Chart overview

- Exposes all settings for installing the Agent service.
- Enables you to easily deploy the Agent service with default configuration using a single command.
- Ability to customize the service settings in a file or via the command line.

Connecting to Armory Cloud services is enabled by default. Armory Cloud services is required for some features to function and affects how you configure the Agent service installation. If you want to connect to Armory Cloud services, you must include your Armory Cloud client ID and secret. You can disable connecting to Armory Cloud services by setting a gPRC URL instead of providing your Armory Cloud services credentials.


## {{% heading "prereq" %}}

1. You have [installed the Clouddriver plugin]({{< ref "install-agent-plugin" >}}).
1. You are familiar with [Helm](https://helm.sh/) and have installed v3.6.3+.
1. You have added or updated the Armory charts repo in your Kubernetes environment.

   To add the Armory chart repo, execute the following command:

   ```bash
   helm repo add armory-charts http://armory.jfrog.io/artifactory/charts
   ```

   If you have previously added the chart repo, update it with the following commands:

   ```bash
   helm repo update
   helm upgrade armory-agent armory-charts/agent-k8s-full
   ```


## Quickstart

{{< tabs name="agent-install-quickstarts" >}}
{{< tab name="Agent Mode" include="frag-helm-agent-mode" >}}
{{< tab name="Infrastructure Mode" include="frag-helm-infra-mode" >}}
{{< /tabs >}}




## Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## Uninstall

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "agent-troubleshooting.md" >}} page if you run into issues.
* Learn how to {{< linkWithTitle "agent-monitoring.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "agent-mtls.md" >}}
* Read about {{< linkWithTitle "agent-permissions.md" >}}