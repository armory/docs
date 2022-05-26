---
title: Get Started with Armory CD-as-a-Service
linktitle: Armory CD-as-a-Service
description: >
  Learn how to get started using Armory CD-as-a-Service to deploy apps to your Kubernetes clusters.
exclude_search: true
weight: 10
---

## How to get started using Armory CD-as-a-Service

The following steps should take less than 10 minutes to complete:

1. [Register for Armory CD-as-a-Service](#register-for-armory-cd-as-a-service).
1. [Create client credentials](#create-client-credentials).
1. [Install the Remote Network Agent](#install-the-rna) in your target deployment cluster.

## {{% heading "prereq" %}}

* You have reviewed the system requirements for using Armory CD-as-a-Service on the [Requirements]({{< ref "requirements.md" >}}) page.
* You have access to a Kubernetes cluster and have installed [kubectl]().
* You have installed [Helm](), which is used to install the Remote Network Agent.


## Register for Armory CD-as-a-Service

{{< include "cdaas/login-creds" >}}

Every user who wants to deploy to your clusters using Armory CD-as-a-Service must have an account. For information about inviting users, see {{< linkWithTitle "cd-as-a-service/tasks/iam/invite-users.md" >}}.

## Prepare your deployment target

You need to manually install the Remote Network Agent (RNA) to the target deployment cluster. Armory CD-as-a-Service uses the RNA on your deployment target to communicate with Armory's hosted cloud services and to initiate the deployment.

### Create client credentials

Create machine to machine client credentials for the various service accounts that you will need. These credentials are machine credentials that are meant for authentication when using Armory CD-as-a-Service programmatically. The credentials consist of a Client ID and a Client Secret. Make sure to keep the secret somewhere safe. You cannot retrieve secrets that you lose access to. You would need to create a new set of credentials and update any services that used the credentials that you are replacing.

> Armory recommends creating separate credentials for each cluster or service.

To get started, you need at least one service account to use for authentication between Armory CD-as-a-Service and your deployment target where a Remote Network Agent (RNA) is installed.

Create the client credentials for the RNA on your deployment target:

{{< include "cdaas/client-creds.md" >}}

</details>

### Install the Remote Network Agent

{{< include "cdaas/rna-install.md" >}}

## {{%  heading "nextSteps" %}}

Use the {{< linkWithTitle "cd-as-a-service/setup/cli.md" >}} guide to learn how to manually deploy an app using the CLI.
