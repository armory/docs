---
title: Configuration UI
description: >
  Administer your Borealis instance, including inviting users, managing deployment targets, and generating secrets.
exclude_search: true
---


## Access Management

### Manage secrets

[**Access Management > Client Credentials**](https://console.cloud.armory.io/configuration/credentials)

Manage the secrets that you use for the Remote Network Agent (RNA) and to grant programmatic access to Borealis, such as when you configure the GitHub Action.

Note that secrets are Armory Cloud environment specific.

### Invite users

[**Access Management > Users**](https://console.cloud.armory.io/configuration/users)

For your users to get access to Borealis, you must invite them to your organization. This grants them access to the  Borealis UI. Depending on their permissions, they may have access to the **Configuration UI** and the **Status UI**. 

You need their name and email. Note that the email domain must match your organization's format. For example, users that work for Acme (which uses `username@acme.com`) must have `@acme.com` email addresses. They are automatically added to your organization once they accept the invite and complete the sign up.

1. Navigate to the Cloud Console: https://console.cloud.armory.io/configuration/users.
2. Provide the name and email address for the user you want to invite.
3. Send the invitation.

They can access the UI after completing the signup process.

## Deployment targets

### Add a Kubernetes deployment target

[**Deployment Targets > Kubernetes**](https://console.cloud.armory.io/configuration/accounts/kubernetes)

For a deployment target to be available, it needs to be added to Borealis. Note that deployment targets are Armory Cloud environment specific.

How you add a deployment target depends on whether or not the Kubernetes cluster is accessible from the public internet. If it is, you add it through the **Configuration UI**, and no additional steps are needed. If it is not, you must first install a Remote Network Agent (RNA) on it and then add it through the **Configuration UI**.

For information about how to add a deployment target, see [Prepare your deployment target]({{< ref "borealis-org-get-started#prepare-your-deployment-target" >}}).

## Networking

### Monitor connected agents

[**Networking > Agents**](https://console.cloud.armory.io/configuration/agents)

The Agents page shows you the list of client credentials with the scope `connect:agentHub` and the deployment targets associated with those credentials.

