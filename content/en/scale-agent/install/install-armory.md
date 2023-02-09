---
title: Install the Armory Scale Agent in Armory Continuous Deployment
linkTitle: Armory CD
weight: 10
description: >
  This guide shows you how to get started using the Scale Agent with an existing Armory Continuous Deployment instance. Configure the plugin and service in your Kustomize files and use the Armory Operator to deploy the Scale Agent components.
---

## How to get started using the Scale Agent with Armory Continuous Deployment

1. Ensure you meet the prerequisites outlined in the {{% heading "prereq" %}} section.
1. Decide how you are going to deploy the Scale Agent service. For evaluation, Armory recommends you deploy the service in the cluster where Spinnaker is running ("Spinnaker mode").
1. Decide how you are going to migrate Clouddriver accounts to the Scale Agent.
1. [Configure the Clouddriver plugin in your `clouddriver-local.yml` file and deploy using Halyard](#install-the-plugin). 
1. [Configure and deploy the Scale Agent service](#deploy-the-armory-scale-agent-service). You have two options:

   1. Use the provided manifests and `kubectl`.
   1. Use the Helm chart.
   

>This installation guide is designed for installing the Armory Scale Agent in a test environment. It does not include [mTLS configuration]({{< ref "configure-mtls" >}}), so the Armory Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}


* You have read the Scale Agent [overview]({{< ref "scale-agent" >}}).
* You use the Armory Operator to manage your Armory CD instance.

Be sure to choose the Scale Agent version that is compatible with your Armory CD version.

{{< include "scale-agent/agent-compat-matrix.md" >}}