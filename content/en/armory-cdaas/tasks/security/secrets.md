---
title: Secrets
linktitle: Secrets
exclude_search: true
weight: 2
description: >
  Use secrets to integrate Armory's Project Borealis with external systems and tools.
---

## Overview of using secrets with external systems

Secrets allow Borealis to authenticate with external systems and tools during a deployment.

### Metric providers

You can store credentials for metric providers like New Relic, DataDog, or Prometheus as secrets.
Borealis uses these credentials to authenticate with your metric provider when querying for application metrics during a canary analysis.

### Kubernetes clusters

You can store long-lived Kubernetes authentication tokens as secrets.
Borealis uses these credentials to deploy, scale, and cache Kubernetes resources.

### GitHub actions

You can store GitHub Personal Access Tokens (PATs) as secrets.
You can configure a webhook to authenticate with a GitHub PAT to kick off GitHub Actions-based integration tests during a deployment.

## Create a secret

Follow these steps to create a secret:

1. Log into the [Armory Cloud Console](https://console.cloud.armory.io).
2. Click the **Secrets** tab.
3. Click **New Secret**.
4. Fill in the **Name** and **Value** fields. Use a descriptive name. You use the name to reference the secret in the Armory Cloud Console or in your app's deployment file.

Once created, a secret's raw value cannot be retrieved through Armory's API, UI, or CLI.

## Reference a secret

Borealis uses [mustache template syntax](https://mustache.github.io/mustache.5.html) to reference secrets.

Only variable tag types are supported.

You can reference a secret in any input field in Armory's Cloud Console or in the [Borealis Deployment YAML]({{< ref "ref-deployment-file" >}}).

Reference a secret with a `secrets.` prefix followed by the secret's name.
For example, if your secret is named `prod-cluster-token`, you can reference it in a form field or the Borealis YAML DSL
as `{{ secrets.prod-cluster-token }}`.

## Security

Secrets are [encrypted in transit and at rest]({{< ref "armory-cdaas/concepts/architecture#encryption-at-rest" >}}). They are additionally encrypted at rest with a per-tenant key using AES-256 encryption.