---
title: Get Started with Canary Analysis
linktitle: Canary Analysis
description: > 
  This guide walks you through using canary analysis on the app you deployed in the Get Started with the CLI to Deploy Apps guide. Yu perform a retrospective analysis on the performance of the app that you can create canary analysis queries for subsequent deployments.s
weight: 10  
exclude_search: true
---

Performing retrospective analysis on a deployment is a great way to understand how your app is performing over a pre-defined time period. It is the first step to enabling automatic canary analysis where you create queries that control how canary deployments react based on metrics you consider important.

The examples in this guide use Prometheus as the metrics provider.

## {{% heading "prereq" %}}

This quick start assumes that you completed the prior two quick starts that taught you how to register a cluster with Borealis and how to deploy an app with the CLI.

To complete this quick start, you need the following:

- Access to a Kubernetes cluster where you can install the Remote Network Agent (RNA). This cluster acts as the deployment target for the sample app. You can reuse the clusters from the previous quick starts if you want. Or stand up new ones.
- A Prometheus instance set up to monitor your Kubernetes clusters. Keep the following in mind:

  - Armory recommends and the example queries require the flag `"prometheus.io/scrape": "true"`. (This is the default behavior.) This flag instructs Prometheus to collect all Kubernetes annotations, which allow you to reference the annotations that Borealis injects as part of your query.
   
   If you install Prometheus with Helm, this is example command includes the required flag:

   ```yaml
   helm install prometheus prometheus-community/kube-prometheus-stack --set kube-state-metrics.metricAnnotationsAllowList[0]=pods=[*]
   ```

  - It is either accessible by the public internet or you have installed the Remote Network Agent (RNA).

   For information about how to install Prometheus, see the the [Prometheus documentation](https://prometheus.io/docs/prometheus/latest/installation/). 


## Add your metrics provider

Borealis can run queries against metrics providers that you add. The results are examined as part of canary analysis steps in the deploy file.

1. In the **Configuration UI**, go to [**Canary Analysis > Integrations**](https://console.cloud.armory.io/configuration/metric-source-integrations/).
2. Select **New Integration.

   The examples in this guide use Prometheus as the metrics provider.

3. Complete the wizard:
  
   The parameters you need to provide depend on the metrics provider you choose. For more information, see [Canary Analysis Integrations]({{< ref "borealis-configuration-ui#integrations" >}}).

   The following fields are for a Prometheus integration:

   - **Type**: (Required) Your metrics provider. This example uses Prometheus. The form options change based on your provider. For more information, see [Canary Analysis Integrations]({{< ref "borealis-configuration-ui#integrations" >}}).
   - **Name**: (Required) A descriptive name for your metrics provider, such as the environment it monitors. You use this name in places such as your deploy file when you want to configure canary analysis as part of your deployment strategy.
   - **Base URL**: (Required) The base URL for your Prometheus instance. This can be a private DNS if the Remote Network Agent (RNA) is installed in the Prometheus cluster.
   - **Remote Network Agent**: (Optional) The RNA that can access the Prometheus instance. Select the identifier for the RNA from the dropdown.
   - **Authentication Type**: (Required) Either none, username/password, or bearer token.

## Perform a retrospective analysis



1. In the **Configuration UI**, go to [**Canary Analysis > Retrospective Analysis**](https://console.cloud.armory.io/configuration/metric-source-integrations/).
2. Select the metric provider you just configured.
3. Select a time range that includes when you deployed your app.
4. Add a **Query Template**. Use the following example:

   - **Name**: containerCPUSeconds
   - **Upper Limit**: The upper limit for the query. If the results exceed this value, the deployment is considered to be a failure.
   - **Lower Limit**: The lower limit for the query. If the results fall below this value, the deployment is considered to be a failure.
   - **Query Template**:

   ```sql
   avg (avg_over_time(container_cpu_system_seconds_total{job="kubelet"}[${promQlStepInterval}]) * on (pod)  group_left (annotation_app)
        sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="${replicaSetName}"})
        by (annotation_app, pod)) by (annotation_app)
   ```

   - The query contains variables that are automatically injected during canary analysis, but  you must manually provide them during retrospective analysis. 
   - `promqlStepInterval` automatically updates based off the time between queries to be the current duration for the query to aggregate over. 
   - `replicaSetName` will be set to the name of the ReplicaSet that Borealis created for this app version. It's used to differentiate between the current and next version of the app.

   You can add multiple Query Templates.

5. Add **Key Value (KV) Pair** for the **Context**. The key value pairs for your  For the sample query, you need to add the following Key Value Pairs:

  - **Key**: `promqlStepInterval`

    **Value**: Provide an integer

  - **Key**: `replicaSetName`

    **Value**: The name of the ReplicaSet that got created when you deployed the app in *Get Started with the CLI to Deploy Apps guide*.

5. Run the analysis.
6. Click on a specific point in time on the graph for more information, including:

   - x
   - y
   - z
  
### Export and add a query

The Retrospective Analysis can take the query you provide and generate the YAML equivalent that you can use it in your deploy file.

1. Click **Export Queries for Armory Deployments**. This creates the YAML block for the `analysis` portion of a deploy file.
2. Insert the YAML block into your deploy file at the bottom. For example:

   ```yaml
   analysis:
     queries:
      - name: containerCPUSeconds
        upperLimit: 100
        lowerLimit: 1
        queryTemplate: >-
          avg
          (avg_over_time(container_cpu_system_seconds_total{job="kubelet"}[${promQlStepInterval}])
          * on (pod)  group_left (annotation_app)
          sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="${replicaSetName}"}) by (annotation_app, pod)) by (annotation_app)
   ```

The `containerCPUSeconds` query is now available for you to use in the `steps` block of your deploy file to perform canary analysis.

## Add canary analysis to your deployment

Boreals supports manual and automated canary analysis. Manual canary analysis allows you to review the canary results until you have confidence that your queries are making good decisions around service health. 

Adding canary analysis to your deployment involves updating your deploy file to include the following:

- An `analysis` block that describes what queries to use and how they are run. The YAML for the queries is what you can export from the UI. You did this in [Export and add a query](#export-and-add-a-query).
- Steps in your `strategy` block that perform canary analysis and define how it behaves.

In your `analysis` step, you can configure the following options:

```yaml
strategies:
  <strategyName>
    canary:
      steps:
        ...
        - analysis:
            interval: <integer> # How long each sample of the query gets summarized over
            unit: <seconds|minutes|hours> # The unit for the interval: 'seconds', 'minutes' or 'hours'.
            numberOfJudgmentRuns: <integer> # How many times the queries get run.
            # rollBackMode: <manual|automatic> # Optional Defaults to 'automatic' if omitted. Uncomment to require a manual review before rolling back if automated analysis detects an issue.
            # rollForwardMode: <manual|automatic> # Optional. Defaults to 'automatic' if omitted. Uncomment to require a manual review before continuing deployment if automated analysis determines the application is healthy.
            queries: # Specify a list of metrics to check. Reference them by the name you assign in analysis.queries.
              - <queryName>
        - setWeight:
            weight: <integer>
```

For example: 

```yaml
- analysis:
    interval: 7 # How long each sample of the query gets summarized over
    units: seconds # The unit for the interval: 'seconds', 'minutes' or 'hours'.
    numberOfJudgmentRuns: 1 # How many times the queries get run.
    # rollBackMode: manual # Optional Defaults to 'automatic' if omitted. Uncomment to require a manual review before rolling back if automated analysis detects an issue.
    # rollForwardMode: manual # Optional. Defaults to 'automatic' if omitted. Uncomment to require a manual review before continuing deployment if automated analysis determines the application is healthy.
    queries: # Specify a list of metrics to check. Reference them by the name you assign in analysis.queries.
    - containerCPUSeconds
- setWeight:
  # The percentage of pods that should be running the canary version for this step. Set it to an integer between 0 and 100, inclusive.
  weight: 100
```

For example, this analysis step

1. In your deploy file, go to the `strategies.<strategyName>.canary.steps` section.
2. Create a new strategy named `canary-deploy-strat`.
3. 
4. Add one or more `analysis` steps to the `steps` section of a strategy. You can create a new strategy or update an existing strategy.
5. Verify that your `targets` block uses the strategy that includes the `analysis` steps.

## Redeploy your app

Cmd to deploy the app w/ Borealis CLI

### Monitor your manual canary deployment

1. Go to UI.
2. Click on the deployment you just deployed.

### Go from manual to automated canary deployments