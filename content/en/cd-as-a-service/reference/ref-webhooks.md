---
title: Webhook Reference Guide
linkTitle: Webhooks
description: >
  Armory CD-as-a-Service supports the use of context variables during the execution of webhook steps.
---

## Webhook variables

You can use variables in the webhook templates you define in the `webhooks` block of your deployment for the follow fields: `webhooks.[].uriTemplate`, `webhooks.[].headers`, and `webhooks.[].bodyTemplate`. Armory provides a basic set of variables that can be used in addition to the context variables you provide.

{{< include "cdaas/dep-file/webhooks-variables.md" >}}

**Custom variables**

In addition to the Armory provided variables, you can define additional custom ones. These are added to the `strategies.<strategyName>.canary.steps.runWebhook.context` section of your deployment file:

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
              - <variableName>: <variableValue>
```

They need to be defined for each webhook step that references them.

In supported webhook fields, you reference them with the following format: `{{context.<variableName>}}`. For example, if you created a variable called `uri` to be used for `webhooks.[].uriTemplate`, you reference it in the query template with `{{context.uri}}`, so that `uriTemplate: {{context.uri}}` will be the address the webhook calls.