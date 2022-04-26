---
title: Webhook-Based Approval
linktitle: Webhooks
exclude_search: true
no_list: true
description: >
  Integrate webhook-based approval into your app deployment.
---

## When you should use webhook-based approval

You can think of webhook-based approvals as a generic extensibility layer that enables you to call any API in any internet-accessible system. You can use a webhook to obtain a decision from a process that is external to Borealis.  

### Webhook use cases

**Before deployment**

- Upgrade a database schema
- Custom approval process

**Within your canary deployment strategy**

- Check logs and system health
- Run custom tests

**After deployment**

- Run integration tests in a staging environment
- Run security scanners

## How webhook-based approval works

In order to accommodate a long-running process, Borealis supports the asynchronous webhook with callback pattern. You define the webhook in your deployment file and add a webhook call in the `constraints` section of your deployment definition or in a canary step.

**Basic flow**

The deployment process:
1. Encounters a webhook call
1. Calls the external API
1. Pauses deployment while waiting for the callback
1. Receives and processes callback
   - Success: deployment proceeds
   - Failure: deployment rolls back

```mermaid
flowchart TB
   A["Deployment Starts"] --> B["Webhook Call Triggered<br>Deployment Pauses"]
   B --> C["External API"]
   subgraph "External Process"
   C["External API<br>Receives Request"] --> D
   D["Process Runs"] --> E[Callback to Deployment]
   end
   E[Callback to Deployment] --> F{"Did the external process<br>succeed or fail?"}
   F -- "Success: true" --> G["Deployment Continues"]
   F -- "Success: false" --> H["Deployment Rolls Back"]
```

{{% alert title="Important" color="Primary" %}}
- If you have a manual approval in your deployment constraint and the webhook callback returns failure, the deployment rolls back without waiting for the manual approval.
- If Borealis hasn't received the webhook callback within 24 hours, the process times out and deployment fails.
- If an `afterDeployment` webhook callback returns failure, deployment is canceled to all environments that depend on the current environment, _but the current environment is not rolled back_.
{{% /alert %}}

## How to configure a webhook

In your deployment file, you configure your webhook by adding a top-level `webhooks` section with the following information:

{{< prism lang="yaml" >}}
webhooks:
  - name: <webhook-name>
    method: <endpoint-method-type>
    uriTemplate: <endpoint-uri>
    networkMode: <network-mode>
    agentIdentifier: <remote-network-agent-id>
    headers:
      - key: Authorization
        value: <auth-type-and-value>
    bodyTemplate:
      inline: >-
      {
      }
    retryCount: <num-retries>
{{< /prism >}}

- `name`: the unique name of your webhook
  - `method`: (Required) REST API method type of the webhook
  - `uriTemplate`: (Required) webhook URL; supports placeholders that are replaced at runtime
  - `networkMode`: (Required) `direct` or `remoteNetworkAgent`; `direct` means a direct connection to the internet; if your webhook is not internet-accessible, use the `remoteNetworkAgent` as a proxy.
  - `agentIdentifier`: (Optional) Use when `networkMode` is `remoteNetworkAgent`; the Remote Network Agent identifier to use as a proxy; the identifier must match the **Agent Identifier** value listed on the **Agents** UI screen; if not specified, Borealis uses the Remote Network Agent associated with the environment account.
  - `headers`: (Optional) Request headers; the `Authorization` header is required if your webhook requires authorization.
     - _Templating is supported in the value of a header but not in the key_.
  - `bodyTemplate`: (Optional) the body of the REST API request; the inline content depends on the endpoint you are calling.
  - `retryCount`: (Optional; Default: 0) if the first connection attempt fails, the number of retries before failing and declaring that the webhook cannot be reached.

**Callback URI**

You must pass the callback URI as `{{armory.callbackUri}}/callback`. Borealis generates the value for `armory.callbackUri` and fills it in at runtime.

>Your callback must send `success: true` or `success: false` in its request body. Borealis looks for the `success` value to determine the webhook's success or failure.

### Configuration examples

The first example configures a GitHub webhook that uses token authorization, with the token value configured as a Borealis secret. This webhook requires the callback URI be passed in the request body.

{{< prism lang="yaml" line-numbers="true" line="8, 16" >}}
webhooks:
  - name: myWebhook
    method: POST
    uriTemplate: https://api.github.com/repos/aimeeu/borealis-demo/dispatches
    networkMode: direct
    headers:
      - key: Authorization
        value: token {{secrets.github_token}}
      - key: Content-Type
        value: application/json
    bodyTemplate:
      inline:  >-
        {
        "event_type": "webhookCallback",
        "client_payload": {
            "callbackUri": "{{armory.callbackUri}}/callback"
            "environment": "{{context.environment}}"
            }
        }
    retryCount: 3
{{< /prism >}}
</br>

The second examples configures a webhook that is not accessible from the internet. The `networkMode` is set to `remoteNetworkAgent` and the `agentIdentifier` specifies which Remote Network Agent to use. The `agentIdentifier` value must match the **Agent Identifier** value listed on the **Agents** UI screen. The Authorization Bearer value is configured as a Borealis secret. Note that in this example, the callback URI is passed in the header.

{{< prism lang="yaml" line-numbers="true" line="5-6, 9, 11" >}}
webhooks:
  - name: integration-tests
    method: POST
    uriTemplate: https://integrations.armory.io/tests/
    networkMode: remoteNetworkAgent
    agentIdentifier: test-rna
    headers:
      - key: Authorization
        value: Bearer {{secrets.test_token}}
      - key: Location
        value: {{armory.callbackUri}}/callback
      - key: Content-Type
        value: application/json
      - key: environment
        value: {{context.environment}}
    retryCount: 5
{{< /prism >}}


## How to trigger a webhook

You can trigger a webhook from the following areas:

- Deployment constraints: `beforeDeployment` and `afterDeployment`
- A canary step within a canary strategy
- The `redirectTrafficAfter` section of a blue/green strategy

You add a `runWebhooks` section where you want to trigger the webhook.

{{< prism lang="yaml" line-numbers="true" >}}
- runWebhook:
    name: <webhook-name>
    context: []
{{< /prism >}}

- `name`: (Required) webhook name; must match the name you gave your webhook in the `webhooks` configuration section.
- `context`: (Optional) dictionary; declare values to use in templates or headers.

### Deployment constraints

**Before deployment**

In this example, you have a webhook named `Update-Database-Schema`. You want to trigger this webhook before your app gets deployed. So you trigger the webhook in the `beforeDeployment` constraint of your environment deployment.

{{< prism lang="yaml" line-numbers="true" line="8-9" >}}
targets:
  dev:
    account: dev-cluster
    namespace: myApp-dev
    strategy: rolling-canary
    constraints:
      beforeDeployment:
        - runWebhook:
            name: Update-Database-Schema
{{< /prism >}}

App deployment proceeds only if the `Update-Database-Schema` callback sends a "success: true" message.

**After deployment**

In this example, you have a webhook named `Run-Integration-Tests`. You want to trigger this webhook after your app has been deployed to staging but before it gets deployed to production. So you trigger the webhook in the `afterDeployment` constraint of your staging environment deployment.

{{< prism lang="yaml" line-numbers="true" line="8-11" >}}
targets:
  staging:
    account: staging-cluster
    namespace: myApp-staging
    strategy: rolling-canary
    constraints:
      afterDeployment:
        - runWebhook:
            name: Run-Integration-Tests
            context:
              environment: staging
  prod:
    account: prod-cluster
    namespace: myApp-prod
    strategy: rolling-canary
    constraints:
      dependsOn: ["staging"]
{{< /prism >}}

Deployment to production proceeds only if the `Run-Integration-Tests` callback sends a "success: true" message.

### Blue/green strategy

In this example, this is a `security-scan` webhook that scans your deployed app. You have a blue/green deployment strategy in which you want to run that security scan on the preview version of your app before switching traffic to it. You add the `runWebhook` section to the `redirectTrafficAfter` section in your blue/green strategy configuration.

{{< prism lang="yaml" line-numbers="true" line="15-16" >}}
strategies:
  myBlueGreen:
    blueGreen:
      activeService: myApp-external
      previewService: myApp-preview
      redirectTrafficAfter:
        - analysis:
            interval: 7
            units: seconds
            numberOfJudgmentRuns: 1
            rollBackMode: manual
            rollForwardMode: automatic
            queries:
              - avgCPUUsage-pass
        - runWebhook:
            name: security-scan
{{< /prism >}}

Since tasks in the `redirectTrafficAfter` section run in parallel, both tasks in this example must be successful for deployment to continue. If the `analysis` task fails, rollback is manual. If the `runWebhook` task fails, rollback is automatic.

### Canary strategy

In this example, there is a `system-health` webhook that you want to trigger as part of your canary strategy. Add the `runWebhook` section to your `steps` configuration.

{{< prism lang="yaml" line-numbers="true" line="15-16" >}}
strategies:
  canary-rolling:
    canary:
      steps:
        - setWeight:
            weight: 25
        - runWebhook:
            name: system-health
            context:
              environment: staging
{{< /prism >}}


## {{% heading "nextSteps" %}}

For in-depth examples, see:

* {{< linkWithTitle "webhook-github.md" >}}
* {{< linkWithTitle "webhook-jenkins.md" >}}
* {{< linkWithTitle "webhook-lambda.md" >}}