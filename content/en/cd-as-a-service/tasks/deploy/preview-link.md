---
title: Create a Temporary Preview Link to a Deployed Service
linkTitle: Create Preview Links
description: >
  Create a temporary public preview link to a deployed service for testing.
categories: ["Guides"]
tags: ["Deployment", "Config", "Preview"]
---

## Overview

 Create a temporary public preview link to a deployed service to verify HTTP services after their deployment. The created link is generated with a cryptographically secure domain prefix and automatically expires after a configured time period.

You can use this step in both canary and blue-green deployment strategies.

 ## Expose your service

**Canary strategy**: add an `exposeServices` step to `strategies.<strategyName>.canary.steps` in your [deployment file]({{< ref "cd-as-a-service/reference/ref-deployment-file#strategiesstrategynamecanarystepsexposeservices" >}}).

**Blue/Green strategy**: add an `exposeServices` entry to `strategies.<strategyName>.redirectTrafficAfter` in your [deployment file]({{< ref "cd-as-a-service/reference/ref-deployment-file#strategiesstrategynamebluegreenredirecttrafficafterexposeservices" >}}).

{{< include "cdaas/deploy/preview-link-details.md" >}}

## Find your exposed service URL

### Customer Portal

The **Resources** section of your Deployment details page displays a clickable link to preview your service. CD-as-a-Service automatically creates the preview link right after the `exposeServices` step completes - no need to refresh the page. On the link itself there is a tooltip with the approximate remaining lifetime of the preview link.

CD-as-a-Service deactivates the link after the service preview expires.

### REST API

You can find your exposed URL by doing a `GET` to `https://api.cloud.armory.io/deploy-engine/deployments/{{deploymentID}}`.

You can find the `exposeServices` step in the strategy's `steps` collection. The `exposeServices` steps contains a `preview` object with the following keys:

* `previews`: map of `service-name:URL` objects
* `expiresAtIso8601`: the absolute timestamp of the preview link's expiration

### Webhook context

After the preview link is created, you can use it in context of the webhook action for current strategy. The link naming convention is `armory.preview.<service name>`.

If you have a long-running deployment, be suure to choose a long enough `ttl` for the service, so that the link passed to the webhook has not already expired.

## Example

If you configure the following in a canary strategy:

{{< prism lang="yaml"  line-numbers="true" >}}
...
steps:
...
- exposeServices:
    services:
      - sample-app-svc
    ttl:
      duration: 20
      unit: minutes
{{< /prism >}}

... and then deploy your app, you would see this in your deployment details:

{{< figure src="/images/cdaas/tasks/deploy/exposeServices-UI.png" alt="The preview link in the Resources section" >}}

If you query the REST API endpoint, you see results similar to:

{{< figure src="/images/cdaas/tasks/deploy/exposeServices-API.png" alt="The preview link in the REST API results" >}}

To reference an exposed service in your webhook, add a `runWebhook` step in your strategy and then add a `preview-link` in your webhook definition. For example:

{{< prism lang="yaml"  line-numbers="true" line="" >}}
...
steps:
...
- runWebhook:
    name: call-service
...
webhooks:
- name: call-service
  ... other webhook configuration properties
  bodyTemplate:
  inline: >-
  {
  "preview-link": "{{armory.preview.sample-app-svc}}"
  }
  {{< /prism >}}
