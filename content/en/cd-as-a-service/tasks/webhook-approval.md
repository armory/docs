---
title: Configure a Webhook in the Deployment File
linktitle: Configure a Webhook
exclude_search: true
no_list: true
description: >
  Configure a webhook-based approval into your Armory CD-as-a-Service app deployment process.
---

## {{% heading "prereq" %}}


## How to configure a webhook in your deployment file

In your deployment file, you configure your webhook by adding a top-level `webhooks` section with the following information:

{{< prism lang="yaml"  line-numbers="true" >}}
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

{{% include "cdaas/dep-file/webhooks-fields.md" %}}

### Configuration examples

The first example configures a GitHub webhook that uses token authorization, with the token value configured as a Armory CD-as-a-Service secret. This webhook requires the callback URI be passed in the request body. The payload also contains an `environment` context variable that you pass in when invoking the webhook in your deployment file.

{{< prism lang="yaml" line-numbers="true" line="8, 16-17" >}}
webhooks:
  - name: myWebhook
    method: POST
    uriTemplate: https://api.github.com/repos/armory/docs-cdaas-demo/dispatches
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

The second example configures a webhook that is not accessible from the internet. The `networkMode` is set to `remoteNetworkAgent` and the `agentIdentifier` specifies which Remote Network Agent to use. The `agentIdentifier` value must match the **Agent Identifier** value listed on the **Agents** UI screen. The Authorization Bearer value is configured as a Armory CD-as-a-Service secret. Note that in this example, the callback URI is passed in the header.

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

In this example, there is a `security-scan` webhook that scans your deployed app. You have a blue/green deployment strategy in which you want to run that security scan on the preview version of your app before switching traffic to it. You add the `runWebhook` section to the `redirectTrafficAfter` section in your blue/green strategy configuration.

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

{{< prism lang="yaml" line-numbers="true" line="7-10" >}}
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

For in-depth examples, see the following tutorials:

* {{< linkWithTitle "webhook-github.md" >}}

