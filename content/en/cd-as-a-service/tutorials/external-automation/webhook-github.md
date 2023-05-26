---
title: Deploy a Sample App That Uses GitHub Webhook-Based Approval
linktitle: GitHub Webhook Approval
description: >
  Learn how to configure GitHub webhook-based approvals in your Armory CD-as-a-Service app deployment process.
categories: ["CD-as-a-Service"]
tags: ["Tutorials", "Webhooks", "GitHub"]
---

## Objectives

This tutorial shows you how to configure webhook-based approvals using GitHub.

You should have completed the {{< linkWithTitle "deploy-sample-app.md" >}} guide. You use the same `docs-cdaas-sample` repo that you forked and cloned as part of that tutorial.

## {{% heading "prereq" %}}

- You have read the webhook-based approvals [introductory page]({{< ref "webhook-approval" >}}).
- You are familiar with workflows and webhooks in GitHub.
  - [Workflows](https://docs.github.com/en/actions/using-workflows/)
  - [Webhooks and events](https://docs.github.com/en/developers/webhooks-and-events/webhooks/)

## Create credentials

You need to create credentials that enable GitHub and Armory CD-as-a-Service to connect to each other.

1. Create a personal access token in GitHub with **workflow** and **admin:repo_hook** permissions. See the GitHub [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) guide for instructions. Copy the token value for use in the next step.
1. Create a new secret in the CD-as-a-Service Console for the GitHub token you just created. Go to the **Secrets** > **Secrets** screen. Click the **New Secret** button.

   - **Name**: `github_personal_access_token`
   - **Replacement Value**: `<github_personal_access_token_value>`

   Replace `<gigithub_personal_access_tokenn_value>` with your token value. You use this secret when configuring your webhook in your deployment file.

1. [Create a new CD-as-a-Service credential]({{< ref "cd-as-a-service/tasks/iam/client-creds" >}}) for your webhook callback to use for CD-as-a-Service authentication. In the CD-as-a-Service Console, go to the **Access Management** > **Client Credentials** screen. Click the **New Credential** button. On the **Create New Client Credential** screen:

   - **Name**: `github_webhooks`
   - **Select Roles**: select `Deployments Full Access`

   Click **Create Credential**. Copy the **Client ID** and **Client Secret** values for use in the next step.

1. Create two GitHub repo secrets in your fork of the `docs-cdaas-sample` repo. See GitHub's [Creating encrypted secrets for a repository](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) for instructions. Your webhook callback uses the value of these secrets to authenticate to Armory CD-as-a-Service. Create your repo secrets with the following names and values:

    1. **Name**: CDAAS_CLIENT_ID **Value**: `<github_webhooks_client_id>`

       Replace `<github_webhooks_client_id>` with the value of the Client ID you created in the previous step.

    1. **Name**: CDAAS_CLIENT_SECRET **Value**: `<github_webhooks_client_secret>`

       Replace `<github_webhooks_client_secret>` with the value of the Client Secret you created in the previous step.

## Create the webhook event and workflow

>Be sure to enable workflows in your fork of the `docs-cdaass-sample` repo.

You can create a `repository_dispatch` webhook event when you want to trigger a workflow from outside of GitHub. Review the following GitHub `repository_dispatch` docs if you're unfamiliar with this type of webhook event:

- [Webhook events and payloads](https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads#repository_dispatch)
- [Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#repository_dispatch)
- [Create a repository dispatch event](https://docs.github.com/en/rest/repos/repos#create-a-repository-dispatch-event)

The `docs-cdaas-sample` repo contains a `basicPing.yml` webhook workflow file in the `.github/workflows` directory. The webhook workflow obtains an OAUTH token, extracts the callback URI, and sends a POST request to that callback URI.

You must include specific keys and values as detailed in the following sample:

{{< prism lang="yaml" line-numbers="true" line="5, 16-19, 24-28" >}}
name: basicPing Webhook Callback

on:
  repository_dispatch:
    types: basicPing

jobs:
  respond:
    name: Calls the callback being passed in
    runs-on: ubuntu-18.04
    steps:
      - name: getToken
        id: getToken
        uses: fjogeleit/http-request-action@master
        with:
          url: "https://auth.cloud.armory.io/oauth/token"
          method: "POST"
          customHeaders: '{ "Content-Type": "application/x-www-form-urlencoded" }'
          data: 'audience=https://api.cloud.armory.io&grant_type=client_credentials&client_id=${{ secrets.CDAAS_CLIENT_ID }}&client_secret=${{ secrets.CDAAS_CLIENT_SECRET }}'
      - name: callCallback
        id: callCallback
        uses: fjogeleit/http-request-action@master
        with:
          url: ${{ github.event.client_payload.callbackUri }}
          method: 'POST'
          bearerToken: ${{ fromJSON(steps.getToken.outputs.response).access_token }}
          customHeaders: '{ "Content-Type": "application/json" }'
          data: '{ "success": true, "mdMessage": "basickPing webhook success: ${{ github.event.client_payload.callbackUri }}" }'
      - name: show http response
        run: echo ${{ steps.callCallback.outputs.response }}
{{< /prism >}}
<br>
Note:

* `on.repository_dispatch.types`: User-supplied event type name. You use this name in the payload when you call this webhook event from Armory CD-as-a-Service.
* The `getToken` step fetches an OAUTH token from Armory CD-as-a-Service. The format for this API call is defined in [Retrieve an OAUTH token to use in your callback]({{< ref "webhook-approval#retrieve-an-oauth-token-to-use-in-your-callback">}}). The callback needs this OAUTH token to authenticate with Armory CD-as-a-Service.

   - In the `data` payload, you use the `CDAAS_CLIENT_ID` and `CDAAS_CLIENT_SECRET` GitHub repo secrets you created in the [Create credentials](#create-credentials) section.

* The `callCallback` step sends request with workflow results to Armory CD-as-a-Service. The format for this API call is defined in [Callback format]({{< ref "webhook-approval#callback-format">}}).

   - `url`: GitHub extracts the `callbackUri` from the HTTP Request that Armory CD-as-a-Service sent.
   - `method`: Rest API method is always `POST`
   - `bearerToken`:  GitHub extracts the `access_token` value from the `getToken` step's HTTP Response and inserts it here.
   - `customHeaders`: this is always `{ "Content-Type": "application/json" }`
   - `data`: this JSON payload must contain a `"true"` or `"false"` value for `"success"`. The `"mdMessage"` value should be user-friendly and meaningful.

## Configure the webhook in your deployment file

The `docs-cdaas-sample` repo contains a second deployment file called `deploy-webhook.yml` in the root directory. The `webhooks` section is at the bottom of the file.

The `uriTemplate` uses secrets instead of hardcoding the URI. If you don't want to create secrets, be sure to change to `uriTemplete` to use your GitHub org and repo. To create secrets using the CD-as-a-Service Console, go to **Secrets** > **Secrets** and create two new secrets:

1. **Name**: `github_org`; **Value**: the name of the GitHub org into which you forked the `docs-cdaas-sample` repo. This is either your business org, like 'armory', or your GitHub username.
1. **Name**: `github_repo`; **Value**: the name of the GitHub repo into which you forked the `docs-cdaas-sample` repo. This is most likely `docs-cdaas-sample`.

The following is an example of how to configure a GitHub webhook workflow:

{{< prism lang="yaml" line-numbers="true" line="2, 5-6, 8-10, 15-20" >}}
webhooks:
  - name: basicPing
    method: POST
    # replace this with the URI for your repo if you don't create secrets
    uriTemplate: https://api.github.com/repos/{{secrets.github_org}}/{{secrets.github_repo}}/dispatches
    networkMode: direct
    headers:
      - key: Authorization
        # The secret name must match the Armory CDaaS secret name for your GitHub access token
        value: token  {{secrets.github_personal_access_token}}
      - key: Content-Type
        value: application/json
    bodyTemplate:
      inline: >-
        {
        "event_type": "basicPing",
        "client_payload": {
            "callbackUri": "{{armory.callbackUri}}/callback"
            }
        }
    retryCount: 1
{{< /prism >}}
<br>
Note:

* `name`: User-supplied name, in this tutorial `basicPing`; you use this name when you insert configuration to call this webhook.
* `uriTemplate`: the format for this URI is in GitHub's [Create a repository dispatch event]. Since this is a template, you can insert secrets in place of hardcoding parts of the URI.
* `networkMode`: `direct` because the webhook endpoint is accessible via the internet
* `headers`: For the `Authorization` value, use `token #{{secrets.github_webhook_token}}`. The secret name matches the name you used in the [Create credentials](#create-credentials) section.
* `bodyTemplate.inline`: The format for this is defined in GitHub's [Create a repository dispatch event].

   - The `event_type` must match the `on.repository_dispatch.types` value in the `basicPing.yml` file.
   - The items in the `client_payload` dictionary depend on the functionality within the `basicPing.yml` file. The `basicPing` workflow looks for `callbackUri`. The `callbackUri` value is always `{{armory.callbackUri}}/callback`. Armory CD-as-a-Service dynamically generates and fills in `armory.callbackUri` at runtime.

## Call the webhooks in your deployment process

The `deploy-webhook.yml` calls the webhook workflows in the `constraints` section of the deployment target definition. Look for `runWebhook` entries such as the following:

{{< prism lang="yaml" line-numbers="true" line="8-9" >}}
staging:
  account: sample-rna-staging-cluster
  namespace: sample-staging
  strategy: rolling
  constraints:
    dependsOn: ["test"]
    afterDeployment:
      - runWebhook:
          name: basicPing
{{< /prism >}}

`runWebhook.name` must match the name you gave the webhook in the `webhooks` section.

## Deploy your updated process

The deployment process calls the `basicPing` webhook workflow when deploying to the `staging` target. The webhook must be successful for deployment to continue to the prod targets.

Navigate to your `docs-cdaas-sample` directory. Make sure you have logged in using the CLI (`armory login`).

Deploy the using the `deploy-webhook.yml` file.

```bash
armory deploy start -f deploy-webhook.yml
```

Output is similar to:

```bash
[2022-04-28T18:09:31-05:00] Deployment ID: 8c9e77fa-2543-4cdc-b12f-86c095974c7a
[2022-04-28T18:09:31-05:00] See the deployment status UI: https://console.cloud.armory.io/deployments/pipeline/8c9e77fa-2543-4cdc-b12f-86c095974c7a?environmentId=a8906e61-2388-4daa-b38e-4339390b9447
```

You can check deployment status by accessing the URL included in the output.

{{< figure width="100%" height="100%" src="/images/cdaas/tutorials/webhooks/webhook-success.jpg"  alt="BeforeDeployment webhook success"  caption="<center><i>The basicPing webhook succeeded so deployment continued.</i></center>">}}

To see what webhook failure looks like, go into your GitHub repo and change the `basicPing.yml` file line 28 like this:

{{< prism lang="yaml" line-numbers="true" line="28" >}}
name: Basic Ping Webhook Callback

on:
  repository_dispatch:
    types: basicPing

jobs:
  respond:
    name: Calls the callback being passed in
    runs-on: ubuntu-18.04
    steps:
      - name: getToken
        id: getToken
        uses: fjogeleit/http-request-action@master
        with:
          url: "https://auth.cloud.armory.io/oauth/token"
          method: "POST"
          customHeaders: '{ "Content-Type": "application/x-www-form-urlencoded" }'
          data: 'audience=https://api.cloud.armory.io&grant_type=client_credentials&client_id=${{ secrets.CDAAS_CLIENT_ID }}&client_secret=${{ secrets.CDAAS_CLIENT_SECRET }}'
      - name: callCallback
        id: callCallback
        uses: fjogeleit/http-request-action@master
        with:
          url: ${{ github.event.client_payload.callbackUri }}
          method: 'POST'
          bearerToken: ${{ fromJSON(steps.getToken.outputs.response).access_token }}
          customHeaders: '{ "Content-Type": "application/json" }'
          data: '{ "success": false, "mdMessage": "Webhook FAILURE: ${{ github.event.client_payload.callbackUri }}" }'
      - name: show http response
        run: echo ${{ steps.callCallback.outputs.response }}
{{< /prism >}}

Commit the change.

Deploy by running `armory start deploy -f deploy-webhook.yml`. Then check deployment status by accessing the URL included in the output. CD-as-a-Service cancels the deployment when it receives a failure message from the webhook.

{{< figure width="100%" height="100%" src="/images/cdaas/tutorials/webhooks/webhook-failure.jpg"  alt="BeforeDeployment webhook failure"  caption="<center><i>The basicPing webhook failed.</i></center>">}}

## {{% heading "nextSteps" %}}

{{< linkWithTitle "cd-as-a-service/troubleshooting/webhook.md" >}}


<!-- do not delete these. Markdown links used in the content. -->

[Create a repository dispatch event]: https://docs.github.com/en/rest/repos/repos#create-a-repository-dispatch-event