---
title: GitHub Webhook-Based Approvals Tutorial
linktitle: GitHub
exclude_search: true
description: >
  Learn how to configure webhook-based approvals using GitHub webhooks.
---

## Objectives

This tutorial shows you how to configure webhook-based approvals using GitHub.


## {{% heading "prereq" %}}

- You have read the webhook-based approvals [introductory page]({{< ref "cdaas-webhooks" >}}).
- You are familiar with workflows and webhooks in GitHub.
  - [Webhooks and events](https://docs.github.com/en/developers/webhooks-and-events/webhooks/about-webhooks)
  - [Workflows]()

This tutorial assumes you have completed the {{< linkWithTitle "deploy-demo-app.md" >}} guide. You will use the same `docs-cdaas-demo` repo that you forked and cloned as part of that tutorial.

## Create credentials

You need to create credentials that enable GitHub and Borealis to connect to each other.

1. Create a personal access token in GitHub with **workflow** and **admin:repo_hook** permissions. See the GitHub [Creating a personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) guide for instructions. Copy the token value for use in the next step.
1. Create a new secrect in the Armory Cloud console for the GitHub token you just created. Go to the **Secrets** > **Secrets** screen. Click the **New Secret** button.

   - **Name**: `github_webhook_token`
   - **Replacement Value**: `<github_token_value>`

   Replace `<github_token_value>` with your token value. You use this secret when configuring your webhook in your deployment file.

1. Create a new Borealis credential for your webhook callback to use to authenticate to Borealis. In the Armory Cloud Console, go to the **Access Management** > **Client Credentials** screen. Click the **New Credential** button. On the **Create New Client Credential** screen:

   - **Name**: `github_webhooks`
   - **Preconfigured Scope Group**: select `Deployments using Spinnaker`

   Click **Create Credentials**. Copy the **Client ID** and **Client Secret** values for use in the next step.

1. Create two GitHub repo secrets in your fork of the `docs-cdaas-demo` repo. See the GitHub [Creating encrypted secrets for a repository](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository) guide for instructions. Your webhook callback uses the value of these secrets to authenticate to Borealis. Create your repo secrets with the following names and values:

    1. **Name**: CDAAS_CLIENT_ID **Value**: `<github_webhooks_client_id>`

       Replace `<github_webhooks_client_id>` with the value of the Client ID you created in the previous step.

    1. **Name**: CDAAS_CLIENT_SECRET **Value**: `<github_webhooks_client_secret>`

       Replace `<github_webhooks_client_secret>` with the value of the Client Secret you created in the previous step.

## Create the webhook event and workflow

You can create a `repository_dispatch` webhook event when you want to trigger a workflow from outside of GitHub. Review the following GitHub `repository_dispatch` docs if you're unfamiliar with this type of webhook event:

- [Webhook events and payloads](https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads#repository_dispatch)
- [Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#repository_dispatch)
- [Create a repository dispatch event](https://docs.github.com/en/rest/repos/repos#create-a-repository-dispatch-event)

The `docs-cdaas-demo` repo contains a webhook file called `basicPing.yml` in the `.github/workflows` directory. The workflow defined in the file is deliberately simple and for tutorial purposes only. It gets an OAUTH token, extracts the callback URI, and sends a POST request to that callback URI.

{{< prism lang="yaml" line-numbers="true" line="5, 15-19, 23-28" >}}
name: Basic Ping

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
          data: '{ "success": true, "mdMessage": "Webhook was successful: ${{ github.event.client_payload.callbackUri }}" }'
      - name: show http response
        run: echo ${{ steps.callCallback.outputs.response }}
{{< /prism >}}
<br>
Note:

* `on.repository_dispatch.types`: User-supplied event type name. You use this name in the payload when you call this webhook event from Borealis.
* The `getToken` step fetches an OAUTH token from Borealis. The format for this API call is defined in [Retrieve an OAUTH token to use in your callback]({{< ref "cdaas-webhook-approval#retrieve-an-oauth-token-to-use-in-your-callback">}}). The callback needs this OAUTH token to authenticate with Borealis.

   - In the `data` payload, you use the `CDAAS_CLIENT_ID` and `CDAAS_CLIENT_SECRET` GitHub repo secrets you created in the [Create credentials](#create-credentials) section.

* The `callCallback` step sends request with workflow results to Borealis. The format for this API call is defined in [Callback format]({{< ref "cdaas-webhook-approval#callback-format">}}).

   - `url`: GitHub extracts the `callbackUri` from the HTTP Request that Borealis sent.
   - `method`: Rest API method is always `POST`
   - `bearerToken`:  GitHub extracts the `access_token` value from the `getToken` step's HTTP Response and inserts it here.
   - `customHeaders`: this is always `{ "Content-Type": "application/json" }`
   - `data`: this JSON payload must contain a `"true"` or `"false"` value for `"success"`. `"mdMessage"` value should be user-friendly and meaningful.

## Configure the webhook in your deployment file

The `docs-cdaas-demo` repo contains a second deployment file called `deploy-webhook.yml` in the root directory. The `webhooks` section is at the bottom of the file.

The `uriTemplate` uses secrets instead of hardcoding the URI. In the Armory Cloud console, got to **Secrets** > **Secrets** and create two new secrets:

1. **Name**: `github_org`; **Value**: the name of the GitHub org into which you forked the `docs-cdaas-demo` repo. This is either your business org, like 'armory', or your GitHub username.
1. **Name**: `github_repo`; **Value**: the name of the GitHub repo into which you forked the `docs-cdaas-demo` repo. This is most likely `docs-cdaas-demo`.

{{< prism lang="yaml" line-numbers="true" line="2, 4, 5, 9, 15-17" >}}
webhooks:
  - name: basicPing
    method: POST
    # replace this with the URI for your repo
    uriTemplate: https://api.github.com/repos/{{secrets.github_org}}/{{secrets.github_repo}}/dispatches
    networkMode: direct
    headers:
      - key: Authorization
        # The secret name must match the Borealis secret name for your GitHub access token
        value: token  {{secrets.github_webhook_token}}
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
    retryCount: 3
{{< /prism >}}
<br>
Note:

* `name`: User-supplied name, in this tutorial `basicPing`; you use this name when you insert configuration to call this webhook.
* `uriTemplate`: the format for this URI is in GitHub's [Create a repository dispatch event](https://docs.github.com/en/rest/repos/repos#create-a-repository-dispatch-event). Since this is a template, you can insert secrets in place of hardcoding parts of the URI.
* `networkMode`: `direct` because the webhook endpoint is accessible via the internet
* `headers`: For the `Authorization` value, use `token #{{secrets.github_webhook_token}}`. The secret name matches the name you used in the [Create credentials](#create-credentials) section.
* `bodyTemplate.inline`: The format for this is defined in GitHub's [Create a repository dispatch event](https://docs.github.com/en/rest/repos/repos#create-a-repository-dispatch-event).

   - The `event_type` must match the `on.repository_dispatch.types` value in the `basicPing.yml` file.
   - The items in the `client_payload` dictionary depend on the functionality within the `basicPing.yml` file. The `basicPing` workflow looks for `callbackUri`. The `callbackUri` value is always `{{armory.callbackUri}}/callback`. Borealis dynamically generates and fills in `armory.callbackUri` at runtime.

## Call the webhook in your deployment process

The `deploy-webhook.yml` calls the `basicPing` webhook in two places. The first is in a `beforeDeployment` constraint in the `prod-us` and `prod-eu` targets.

{{< prism lang="yaml" line-numbers="true" line="12-13, 21-22" >}}
targets:
...
prod-us:
  account: demo-rna-prod-us-cluster
  namespace: demo-prod-us
  strategy: mycanary
  constraints:
    dependsOn: ["staging"]
    beforeDeployment:
      - pause:
          untilApproved: true
      - runWebhook:
          name: basicPing
prod-eu:
  account: demo-rna-prod-eu-cluster
  namespace: demo-prod-eu
  strategy: myBlueGreen
  constraints:
    dependsOn: ["staging"]
    beforeDeployment:
      - runWebhook:
          name: basicPing
{{< /prism >}}

Deployment to `prod-us` requires manual approval and a successful webhook result, whereas deployment to `prod-eu` only requires a successful result.

The second place that deployment calls the webhook is within a canary strategy configuration.

{{< prism lang="yaml" line-numbers="true" line="15-16" >}}
strategies:
  mycanary:
    canary:
      steps:
        - setWeight:
            weight: 25
        - analysis:
            interval: 7
            units: seconds
            numberOfJudgmentRuns: 1
            rollBackMode: manual
            rollForwardMode: automatic
            queries:
              - avgCPUUsage-pass
        - runWebhook:
            name: basicPing
        - setWeight:
            weight: 50
        - analysis:
            interval: 7
            units: seconds
            numberOfJudgmentRuns: 3
            rollBackMode: manual
            rollForwardMode: manual
            queries:
              - avgCPUUsage-fail
              - avgCPUUsage-pass
        - setWeight:
            weight: 100
{{< /prism >}}

## Deploy your updated process

Navigate to your `docs-cdaas-demo` directory. Make sure you have logged in using the CLI (`armory login`).

Deploy the using the `deploy-webhook.yml` file.

```bash
armory deploy start -f deploy-webhook.yml
```

Output is similar to:

```bash
[2022-04-28T18:09:31-05:00] Deployment ID: 8c9e77fa-2543-4cdc-b12f-86c095974c7a
[2022-04-28T18:09:31-05:00] See the deployment status UI: https://console.cloud.armory.io/deployments/pipeline/8c9e77fa-2543-4cdc-b12f-86c095974c7a?environmentId=a8906e61-2388-4daa-b38e-4339390b9447
```

Deployment to `prod-us` requires manual approval but deployment to `prod-eu` is based on the result of the `basicPing` webhook.

You can check deployment status by accessing the URL included in the output.

{{< figure width="100%" height="100%" src="/images/borealis/tutorials/webhooks/webhook-success.png"  alt="BeforeDeployment webhook success"  caption="<center><i>The basicPing webhook succeeded so deployment continued.</i></center>">}}

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

Make sure to manually approve the `prod-us` deployment in the Armory Cloud console before you redeploy.

Deploy by running `armory start deploy -f deploy-webhook.yml`. Then check deployment status by accessing the URL included in the output.

{{< figure width="100%" height="100%" src="/images/borealis/tutorials/webhooks/webhook-fail.png"  alt="BeforeDeployment webhook failure"  caption="<center><i>The basicPing webhook failed so deployment was cancelled.</i></center>">}}

## Troubleshooting

@TODO need to add where to look when a webhook fails - GitHub Actions tab to see if GH got the call? What if GH didn't get the call? What if the issue is on Borealis end?

### `404: Not Found`

```
404 Not Found: [{"message":"Not Found","documentation_url":"https://docs.github.com/rest/reference/repos#create-a-repository-dispatch-event"}]', type='org.springframework.web.client.HttpClientErrorException$NotFound', nonRetryable=false
```

This is a confusing error that occurs if the user is not authenticated. Make sure you include your GitHub access token in the request header.



