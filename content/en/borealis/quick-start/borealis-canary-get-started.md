---
title: Use Canary Analysis on your Deployment
linktitle: Canary Analysis
description: > 
  This guide walks you through deploying an app and Prometheus to the same Kubernetes cluster. Then, you perform a retrospective analysis on the performance of the app that you can then use to create canary analysis queries for subsequent deployments.s
weight: 10  
exclude_search: true
---

Performing retrospective analysis on a deployment is a great way to understand how your app is performing over a pre-defined time period. It is the first step to enabling automatic canary analysis where you create queries that control how canary deployments for your apps react based on metrics you consider important.

For this quick start, you can either use the demo app and Prometheus instance that is part of that setup process or your app and Prometheus instance. The examples on this page use the demo app and Prometheus instance.

## {{% heading "prereq" %}}

This quick start assumes that you completed the prior two quick starts that taught you how to register a cluster with Borealis and how to deploy an app with the CLI.

To complete this quick start, you need the following:

- Access to a Kubernetes cluster where you can install the Remote Network Agent (RNA) and Prometheus. This cluster also acts as the deployment target for the sample app.
- Client ID and a client secret for the Remote Network Agent. Generate the credentials in the [**Client Credentials** page](https://console.cloud.armory.io/configuration/credentials).
- Prometheus installed on your target deployment clusters. For information about how to install Prometheus, see the the [Prometheus documentation](https://prometheus.io/docs/prometheus/latest/installation/). Make sure that your Prometheus instance ues the default configuration where pod annotations get scraped.

You can reuse the clusters from the previous quick starts if you want. Or stand up new ones.


## Add your metrics provider

1. In the **Configuration UI**, go to [**Canary Analysis > Integrations**](https://console.cloud.armory.io/configuration/metric-source-integrations/).
2. Select **New Integration.
3. Complete the wizard:
  
   - **Type**: your metrics provider. This example uses Prometheus. The form options change based on your provider. For more information, see [Canary Analysis Integrations]({{< ref "borealis-configuration-ui#integrations" >}}).
   - **Name**: provide a descriptive name for your metrics provider, such as the environment it monitors. You use this name in places such as your deploy file when you want to configure canary analysis as part of your deployment strategy.
   - **Base URL**: the base URL for your Prometheus instance. This can be a private DNS if the RNA is installed in the Prometheus cluster.

## Deploy your app

Use the Borealis CLI to deploy your app. Like you did in the Get Started with the Borealis CLI Guide, use the link that the CLI returns to navigate to your deployment and monitor it.

## Perform a retrospective analysis

1. In the **Configuration UI**, go to [**Canary Analysis > Retrospective Analysis**](https://console.cloud.armory.io/configuration/metric-source-integrations/).
2. Select the metric provider you just configured.
3. Add **Query Template**. Use the following example:

   ```sql
   example query
   ```

4. Add **Key Value (KV) Pair** for the **Context**.
5. Run analysis
6. Click on a specific point in time on the graph for more information, including:

   - x
   - y
   - z
  
### Export a query

The Retrospective Analysis can take the query you provide and generate the YAML for it so that you can use it in your deploy file.

1. Click **Export Queries for Armory Deployments**.
2. Copy the YAML.
3. Go to your deploy file.
4. Paste the YAML

## Add the canary analysis to your deploy file

### Update your `strategy`

### Add `analysis` block

Adding manual or automated canary analysis to your deployment involves

Armory recommends performing manual canary analysis until you have confidence that your queries are capturing what you want them to capture. When you hit that point, switch to automated canary analysis

### Redeploy your app

Cmd to deploy the app w/ Borealis CLI

## Monitor your manual canary deployment

Go to the Armory Deployments Status UI.