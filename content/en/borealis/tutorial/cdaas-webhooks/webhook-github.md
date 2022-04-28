---
title: GitHub Webhook-Based Approvals Tutorial
linktitle: GitHub
exclude_search: true
description: >
  Learn how to configure webhook-based approvals using GitHub webhooks.
---

## Objectives

This tutorial show you how to configure webhook-based approvals using GitHub webhooks.


## {{% heading "prereq" %}}

- You have read the webhook-based approvals [introductory page]({{< ref "cdaas-webhooks" >}}).
- You are familiar with webhooks in GitHub. See GitHub's [Webhooks and events](https://docs.github.com/en/developers/webhooks-and-events/webhooks/about-webhooks) guide for details.

This tutorial assumes you have completed the {{< linkWithTitle "deploy-demo-app.md" >}} guide. You will use the same `docs-cdaas-demo` repo that you forked and cloned as part of that tutorial.

## Create credentials

You need to create credentials that enable GitHub and Borealis to connect to each other.

1. Create a personal access token in GitHub with **workflow** and **admin:repo_hook** permissions. See the GitHub [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) guide for instructions. Copy the token value for use in the next step.
1. Create a new secrect in the Armory Cloud console for the GitHub token you just created. Go to the **Secrets** > **Secrets** screen. Click the **New Secret** button.

   - **Name**: `github_webhook_token`
   - **Replacement Value**: `<github_token_value>`

   Replace `<github_token_value>` with your token value. You use this secret when configuring your webhook in your deployment file.

1. Create a new Borealis credential for your webhook callback to use to authenticate to Borealis. In the Armory Cloud console, go to the **Access Management** > **Client Credentials** screen. Click the **New Credential** button. On the **Create New Client Credential** screen:

   - **Name**: `github_webhooks`
   - **Preconfigured Scope Group**: select `Deployments using Spinnaker`

   Click **Create Credentials**. Copy the **Client ID** and **Client Secret** values for use in the next step.

1. Create two GitHub repo secrets in your fork of the `docs-cdaas-demo` repo. See the GitHub [Creating encrypted secrets for a repository](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) guide for instructions. Your webhook callback uses the value of these secrets to authenticate to Borealis. Create your repo secrets with the following names and values:

    1. **Name**: BOREALIS_CLIENT_ID **Value**: `<github_webhooks_client_id>`

       Replace `<github_webhooks_client_id>` with the value of the Client ID you created in the previous step.

    1. **Name**: BOREALIS_CLIENT_SECRET **Value**: `<github_webhooks_client_secret>`

       Replace `<github_webhooks_client_secret>` with the value of the Client Secret you created in the previous step.


## Create the webhook



## Troubleshooting

### `404: Not Found`

```
404 Not Found: [{"message":"Not Found","documentation_url":"https://docs.github.com/rest/reference/repos#create-a-repository-dispatch-event"}]', type='org.springframework.web.client.HttpClientErrorException$NotFound', nonRetryable=false
```

This is a confusing error that occurs if the user is not authenticated.