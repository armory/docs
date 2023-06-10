---
title: Integrate a Metrics Provider
linkTitle: Integrate Metrics Provider
description: >
  Add metrics sources such as Prometheus, Data Dog, and New Relic for canary analysis in Armory Continuous Deployment-as-a-Service.
categories: ["Guides"]
tags: ["Strategy", "Canary", "Metrics"]
---

## Overview

Integrate your metrics provider with Armory CD-as-a-Service so that you can perform retrospective analysis of your deployment performance or use canary analysis as part of your deployment strategy.

Armory supports the following metrics providers:

- [Datadog](#datadog)
- [New Relic](#new-relic)
- [Prometheus](#prometheus)

## {{% heading "prereq" %}}

- You have installed one of the supported metrics providers.
- You have created a [secret]({{< ref "cd-as-a-service/tasks/secrets/secrets-create" >}}) for your provider's encrypted connection token:

   - Datadog: **API Key** and **Application Key**
   - New Relic: **API Key**
   - Prometheus: If you use username/password authentication, create a secret for the password. If you use a Bearer token, create a secret for the token.


## How to add a metrics provider

1. In the [CD-as-a-Service Console](https://console.cloud.armory.io/), navigate to **Canary Analysis** > **Integrations**.
1. Click on **New Integration**.

The **Type** drop-down on the **Metrics Source Integration Configuration** screen contains a list of supported metrics providers. Select your provider and fill in the required fields, which change based on selected provider.

### Datadog

- **Name**: A descriptive name for your metrics provider, such as the environment it monitors. You use this name in places such as your deploy file when you want to configure canary analysis as part of your deployment strategy.
- **Base URL**: Your Datadog instance URL; for example, `https://api.datadoghq.com/`.
- **API Key**: The key that your Datadog Agent uses to submit metrics and events to Datadog.
- **Application Key**: The key that grants permission for programmatic access to the Datadog API.   

For information about how to get the API Key and Application Key, see [DataDog documentation](https://docs.datadoghq.com/account_management/api-app-keys/).

### New Relic

- **Name**: A descriptive name for your metrics provider, such as the environment it monitors. You use this name in places such as your deploy file when you want to configure canary analysis as part of your deployment strategy.
- **Base URL**: Your New Relic instance URL; for example, `https://api.newrelic.com/graphql/`.
- **API Key**: The metrics integration requires access to Graph QL, so provide the User Key API key. For more information, see [User Key in the New Relic documentation](https://docs.newrelic.com/docs/apis/accounts-api/new-relic-user-key-api-key/).
- **Account ID**: Your New Relic account ID. For information about how to get this ID, see [Account ID in the New Relic documentation](https://docs.newrelic.com/docs/apis/accounts-api/new-relic-account-id/).

### Prometheus

- **Name**: A descriptive name for your metrics provider, such as the environment it monitors. You use this name in places such as your deploy file when you want to configure canary analysis as part of your deployment strategy.
- **Base URL**: Your Prometheus instance URL; for example, if Prometheus runs in the same cluster as the RNA and is exposed using HTTP on port 9090 through a service named `prometheus` in the namespace `prometheus-ns`, then the URL would be `http://prometheus.prometheus-ns:9090`.
- **Remote Network Agent**: The RNA that is installed in the Prometheus cluster if the cluster is not publicly accessible.
- **Authentication Type**: Select **None**, **Username/Password**, or **Bearer Token**.

   - If you selected **Username/Password**: Fill in the username for accessing Prometheus and select the password secret.
   - If you selected **Bearer Token**: Select the token secret from the drop-down list.


