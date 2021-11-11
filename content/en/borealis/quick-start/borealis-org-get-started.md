---
title: Get Started with Project Borealis
linktitle: Get Started - Borealis
description: >
  To use Borealis, you must register for Armory's hosted cloud service and connect your deployment target to Armory cloud.
exclude_search: true
---

## {{% heading "prereq" %}}

Review the requirements for using Borealis on the [Requirements]({{< ref "borealis-requirements.md" >}}) page.

## Register for Armory Cloud services

{{< include "aurora-borealis/borealis-login-creds" >}}

Every user who wants to deploy to your clusters using Borealis must have an account. For information about inviting users, see [Invite users](#invite-users).

## Create client credentials

After you create an account, you can create machine-to-machine client credentials for the various service accounts that you will need. These credentials are machine credentials that are meant for authentication when using Borealis programmatically. The credentials consist of a client ID and a client secret. Make sure to keep the secret somewhere safe. You cannot retrieve secrets that you lose access to. You would need to create a new set of credentials and update any services that used the credentials that you are replacing.

> Armory recommends creating separate credentials for each cluster or service.

To get started, you need at least one service account to use for authentication between Borealis and your deployment target where a Remote Network Agent (RNA) is installed. For example, if you want to run the Borealis CLI in a Jenkins pipeline, create credentials for the deployment target and for the service account that you use with Jenkins.

To start, create the client credentials for the RNA on your deployment target:

{{< include "aurora-borealis/borealis-client-creds.md" >}}

## Prepare your deployment target

> Note that this step requires Helm.

Borealis uses the RNA on your deployment target to communicate with Armory's hosted cloud services and to initiate the deployment. Use the provided Helm command to install and configure the RNA.

{{< include "aurora-borealis/rna-install.md" >}}

## Next steps

Now that Borealis is configured for your deployment target, you can either try out deploying a sample app or invite more users.

### Deploy an app

Use the [Borealis Quickstart CLI Guide]({{< ref "borealis-cli-get-started.md" >}}) to learn how to manually deploy an app using the Borealis CLI.

### Invite users

For your users to get access to Borealis, you must invite them to your organization. This grants them access to the Cloud Console and the Status UI.

1. Navigate to the Cloud Console: https://console.cloud.armory.io.
2. In the left navigation, go to **Users** and select **Invite User**.
3. Provide the name and email address for the user you want to invite.
4. Send the inviation.