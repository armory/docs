---
---

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

* `name`: the unique name of your webhook

* `method`: (Required) REST API method type of the webhook

* `uriTemplate`: (Required) webhook URL; supports placeholders that are replaced at runtime

* `networkMode`: (Required) `direct` or `remoteNetworkAgent`; `direct` means a direct connection to the internet; if your webhook is not internet-accessible, use the `remoteNetworkAgent` as a proxy.

* `agentIdentifier`: (Optional) Use when `networkMode` is `remoteNetworkAgent`; the Remote Network Agent identifier to use as a proxy; the identifier must match the **Agent Identifier** value listed on the **Agents** UI screen; if not specified, Armory CD-as-a-Service uses the Remote Network Agent associated with the environment account.

* `headers`: (Optional) Request headers; the `Authorization` header is required if your webhook requires authorization. Also supports use of `context` and `armory` provided variables.

* `bodyTemplate`: (Optional) the body of the REST API request; the inline content depends on the endpoint you are calling.

* `retryCount`: (Optional; Default: 0) if the first connection attempt fails, the number of retries before failing and declaring that the webhook cannot be reached.

* `disableCallback`: (Optional; Default: false) if set to `true`, Armory CD-as-a-Service does not wait for a callback before moving on to the next deployment step.

**Callback URI**

You must pass the callback URI as `{{armory.callbackUri}}/callback`. Armory CD-as-a-Service generates the value for `armory.callbackUri` and fills it in at runtime.


<!--  top of file must have the two lines of --- followed by a blank line or Hugo throws a compile error due to the embedded Prism shortcode -->
<!-- Do not "include" using the "%" version! -->

#### Webhook context variables

You can use variables in the webhook templates you define in the `webhooks` block of your deployment for the follow fields: `webhooks.[].uriTemplate`, `webhooks.[].headers`, and `webhooks.[].bodyTemplate`. 

**Armory-provided context variables**

Armory provides the following variables for every webhook execution: 

| Variable                 | Annotation                          | Environment variable      | Notes                                                                       |
|--------------------------|-------------------------------------|---------------------------|-----------------------------------------------------------------------------|
| applicationName          | `deploy.armory.io/application`      | `ARMORY_APPLICATION_NAME` | Added as annotation resources and as environment variables on  pods*        |
| deploymentId             | `deploy.armory.io/deployment-id`    | `ARMORY_DEPLOYMENT_ID`    | Added as annotation resources and as environment variables on  pods*        |
| environmentName          | `deploy.armory.io/environment`      | `ARMORY_ENVIRONMENT_NAME` | Added as annotation resources and as environment variables on  pods*        |
| replicaSetName           | `deploy.armory.io/replica-set-name` | `ARMORY_REPLICA_SET_NAME` | Added as annotation resources and as environment variables on  pods*        |
| accountName              | -                                   | -                         | The name of the account (or agentIdentifier) used to execute the deployment |
| namespace                | -                                   | -                         | The namespace resources are being deployed to                               |

Prefix the variable with `armory` and surround with `{{}}`. For example, to use `applicationName`, add `{{armory.applicationName}}` to the webhook query template.

**Custom context variables**

Add your custom variables to the `strategies.<strategyName>.canary.steps.runWebhook.context` section of your deployment file:

```
strategies:
  ...
    canary:
      steps:
        ...
        - runWebhook:
            name: <webhookName>
            ...
            context:
              <variableName>: <variableValue>
```

You need to configure your custom variables for each webhook step that references them.

In supported webhook fields, you reference them with the following format: `{{context.<variableName>}}`. For example, if you create a variable called `uri` for `webhooks.[].uriTemplate`, you reference it in `webhooks.[].bodyTemplate` with `{{context.uri}}`, so that `uriTemplate: {{context.uri}}` is the address the webhook calls.