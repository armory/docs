---
title: Secrets
linktitle: Secrets

description: >
  Use secrets to integrate Armory CD-as-a-Service with external systems and tools.
---

## Overview of using secrets with external systems

Secrets allow Armory CD-as-a-Service to authenticate with external systems and tools during a deployment.

### Metrics providers

You can store credentials for metrics providers like New Relic, DataDog, or Prometheus as secrets. Armory CD-as-a-Service uses these credentials to authenticate with your metric provider when querying for application metrics during a canary analysis.

### Kubernetes clusters

You can store long-lived Kubernetes authentication tokens as secrets.
Armory CD-as-a-Service uses these credentials to deploy, scale, and cache Kubernetes resources.

### GitHub actions

You can store GitHub Personal Access Tokens (PATs) as secrets.
You can configure a webhook to authenticate with a GitHub PAT to kick off GitHub Actions-based integration tests during a deployment.

## Security

Secrets are [encrypted in transit and at rest]({{< ref "cd-as-a-service/concepts/architecture#encryption-at-rest" >}}). They are additionally encrypted at rest with a per-tenant key using AES-256 encryption.


## {{% heading "nextSteps" %}}

{{< linkWithTitle "cd-as-a-service/tasks/iam/secrets-create.md" >}}