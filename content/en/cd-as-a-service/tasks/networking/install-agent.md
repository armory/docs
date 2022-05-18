---
title: Install a Remote Network Agent
linktitle: Install Agent
exclude_search: true
description: >
  Install a Remote Network Agent in your Kubernetes cluster.
---

<!--## Deployment targets

### Add a Kubernetes deployment target

[**Deployment Targets > Kubernetes**](https://console.cloud.armory.io/configuration/accounts/kubernetes)

For a deployment target to be available, you need to add it to Armory CD-as-a-Service.

How you add a deployment target depends on whether or not the Kubernetes cluster is accessible from the public internet. If it is, you add it through the **Configuration UI**, and no additional steps are needed. If it is not, you must first install a Remote Network Agent (RNA) on it and then add it through the **Configuration UI**.

For information about how to add a deployment target, see [Prepare your deployment target]({{< ref "get-started#prepare-your-deployment-target" >}}).
-->

## {{% heading "prereq" %}}

You have created client credentials. See the {{< linkWithTitle "cd-as-a-service/tasks/iam/client-creds.md" >}} guide for instructions.

## Install the Remote Network Agent

{{< include "cdaas/rna-install.md" >}}