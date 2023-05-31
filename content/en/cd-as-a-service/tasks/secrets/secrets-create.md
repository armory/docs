---
title: Create and Reference Secrets
linktitle: Create Secrets
description: >
  Use secrets to integrate Armory CD-as-a-Service with external systems and tools.
aliases:
  - /cd-as-a-service/tasks/iam/secrets-create/
categories: ["Guides"]
tags: [ "Access", "Secrets"]
---


## Create a secret

Follow these steps to create a secret:

1. Log into the [CD-as-a-Service Console](https://console.cloud.armory.io).
1. Click the **Secrets** tab.
1. Click **New Secret**.
1. Fill in the **Name** and **Value** fields. Use a descriptive name.

You use the name to reference the secret in the CD-as-a-Service Console or in your app's deployment file.

Once created, a secret's raw value cannot be retrieved through Armory's API, UI, or CLI.


## Reference a secret

Armory CD-as-a-Service uses [mustache template syntax](https://mustache.github.io/mustache.5.html) to reference secrets.

Only variable tag types are supported.

You can reference a secret in any input field in the CD-as-a-Service Console or in the [deployment YAML]({{< ref "ref-deployment-file" >}}).

Reference a secret with a `secrets.` prefix followed by the secret's name. For example, if your secret is named `prod-cluster-token`, you can reference it in a form field or the deployment YAML DSL as `{{ secrets.prod-cluster-token }}`.


