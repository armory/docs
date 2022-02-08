---
title: Use Canary Analysis on your Deployment
linktitle: Canary Analysis
description: > 
  This guide walks you through deploying an app and Prometheus to the same Kubernetes cluster. Then, you perform a retrospective analysis on the performance of the app that you can then use to create canary analysis queries for subsequent deployments.s
weight: 10  
exclude_search: true
---

Performing retrospective analysis on a deployment is a great way to understand how your app is performing over a pre-defined time period. It is the first step to enabling automatic canary analysis where you create queries that control how canary deployments react based on metrics you consider important.

## {{% heading "prereq" %}}

This quick start assumes that you completed the prior two quick starts that taught you how to register a cluster with Borealis and how to deploy an app with the CLI.

To complete this quick start, you need the following:

- Access to a Kubernetes cluster where you can install the Remote Network Agent (RNA). This cluster acts as the deployment target for the sample app. You can reuse the clusters from the previous quick starts if you want. Or stand up new ones.
- Prometheus instance set up to monitor your Kubernetes clusters. Make sure your Prometheus instance meets the following requirements:

  - It scrapes pod annotations. (This is the default behavior.)
  - It is either accessible by the public internet or you have installed the Remote Network Agent on the cluster where it runs.
  - For information about how to install Prometheus, see the the [Prometheus documentation](https://prometheus.io/docs/prometheus/latest/installation/). 




## Add your metrics provider

1. In the **Configuration UI**, go to [**Canary Analysis > Integrations**](https://console.cloud.armory.io/configuration/metric-source-integrations/).
2. Select **New Integration.
   
   The examples in this guide use Prometheus as the metrics provider.

3. Complete the wizard:
  
   - **Type**: your metrics provider. This example uses Prometheus. The form options change based on your provider. For more information, see [Canary Analysis Integrations]({{< ref "borealis-configuration-ui#integrations" >}}).
   - **Name**: provide a descriptive name for your metrics provider, such as the environment it monitors. You use this name in places such as your deploy file when you want to configure canary analysis as part of your deployment strategy.
   - **Base URL**: the base URL for your Prometheus instance. This can be a private DNS if the RNA is installed in the Prometheus cluster.

   The paramters you need to provide depend on the metrics provider you choose. For more information, see [Canary Analysis Integrations]({{< ref "borealis-configuration-ui#integrations" >}}).

## Deploy your app

Use the Borealis CLI to deploy your app. 
Like you did in the [Get Started with the Borealis CLI Guide]({{< ref "borealis-cli-get-started" >}}), use the link that the CLI returns to navigate to your deployment and approve any manual judgment steps.


## Perform a retrospective analysis

1. In the **Configuration UI**, go to [**Canary Analysis > Retrospective Analysis**](https://console.cloud.armory.io/configuration/metric-source-integrations/).
2. Select the metric provider you just configured.
3. Add a **Query Template**. Use the following example:

   ```sql
   example query
   ```
   
   The query contains substitutable variables

4. Add **Key Value (KV) Pair** for the **Context**.
5. Run analysis
6. Click on a specific point in time on the graph for more information, including:

   - x
   - y
   - z
  
### Export a query

The Retrospective Analysis can take the query you provide and generate the YAML equivalent that you can use it in your deploy file.

1. Click **Export Queries for Armory Deployments**.
2. Copy the YAML.
3. Go to your deploy file.
4. Paste the YAML

## Add canary analysis to your deployment

Boreals supports manual and automated canary analysis. Armory recommends performing manual canary analysis until you have confidence that your queries are capturing what you want them to capture. When you hit that point, switch to automated canary analysis

Adding canary analysis to your deployment involves updating your deploy file to include the following:

- steps in your `strategy` block that perform canary analysis and define how it behaves
- an `analysis` block that describes what queries to use and how they are run. The YAML for the queries is what you can export from the UI.


### Update the `strategy` block

### Add `analysis` block



## Redeploy your app

Cmd to deploy the app w/ Borealis CLI

### Monitor your manual canary deployment

1. Go to UI.
2. Click on the deployment you just deployed.

### Go from manual to automated canary deployments