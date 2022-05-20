---
title: Get Started with Canary Deployment
linktitle: Canary Deployment
description: >
  This guide walks you through using canary analysis on the app you deployed in the Get Started with the CLI to Deploy Apps guide. You perform a retrospective analysis on the app. Then, you use those queries to create canary analysis steps for subsequent deployments.
weight: 40  
exclude_search: true
---

Performing retrospective analysis on a deployment is a great way to understand how your app is performing over a predefined time period. It is the first step to enabling automatic canary analysis where you create queries that control how canary deployments react based on metrics you consider important.

The examples in this guide use Prometheus as the metrics provider.

## {{% heading "prereq" %}}

You have completed the following guides:

1. {{< linkWithTitle "cd-as-a-service/setup/get-started.md" >}}
1. {{< linkWithTitle "cd-as-a-service/setup/cli.md" >}}

You need the following to work through this guide:

- Access to a Kubernetes cluster where you can install the Remote Network Agent (RNA). This cluster acts as the deployment target for the sample app. You can reuse the clusters from the previous quick starts if you want. Or stand up new ones.
- A Prometheus instance set up to monitor your Kubernetes clusters. Keep the following in mind:

  - Armory recommends your Prometheus instance uses the following settings: `"prometheus.io/scrape": "true"` (on by default) and `kube-state-metrics.metricAnnotationsAllowList[0]=pods=[*]` (collect annotations). These  flags instruct Prometheus to collect all Kubernetes annotations, which allow you to reference the annotations that Armory CD-as-a-Service injects as part of your query.

   If you install Prometheus with Helm, this example command includes the required flag:

   ```yaml
   helm upgrade --install prometheus prometheus-community/kube-prometheus-stack --set 'kube-state-metrics.metricAnnotationsAllowList[0]=pods=[*]'
   ```

  - It is either accessible by the public internet or you have installed the Remote Network Agent (RNA) in the same cluster.

   For information about how to install Prometheus, see the the [Prometheus documentation](https://prometheus.io/docs/prometheus/latest/installation/).


## Add your metrics provider

Armory CD-as-a-Service can run queries against metrics providers that you add. The results are examined as part of canary analysis steps in the deploy file.

1. In the **Configuration UI**, go to [**Canary Analysis > Integrations**](https://console.cloud.armory.io/configuration/metric-source-integrations/).
2. Select **New Integration**.

   The examples in this guide use Prometheus as the metrics provider.

3. Complete the wizard:

   The parameters you need to provide depend on the metrics provider you choose. For more information, see the {{< linkWithTitle "cd-as-a-service/tasks/canary/add-integrations.md" >}} guide.

   The following fields are for a Prometheus integration:

   - **Type**: (Required) Your metrics provider. This example uses Prometheus. The form options change based on your provider.
   - **Name**: (Required) A descriptive name for your metrics provider, such as the environment it monitors. You use this name in places such as your deploy file when you want to configure canary analysis as part of your deployment strategy.
   - **Base URL**: (Required) The base URL for your Prometheus instance. If Prometheus runs in the same cluster as the RNA and is exposed using HTTP on port 9090 through a service named `prometheus` in the namespace `prometheus`, then use `http://prometheus.prometheus:9090`. (This can be a private DNS only if the RNA is installed in the same cluster as the Prometheus instance.)
   - **Remote Network Agent**: (Optional) The RNA that is installed in the Prometheus cluster if the cluster is not publicly accessible. Select the identifier for the RNA from the dropdown.
   - **Authentication Type**: (Required) Select **None**, **Username/Password**, or **Bearer Token**.

      - If you selected **Username/Password**: Fill in the username for accessing Prometheus and select the password secret.
      - If you selected **Bearer Token**: Select the token secret from the drop-down list.

## Perform a retrospective analysis

Retrospective analysis is the starting point to creating queries so that you can perform canary analysis on your deployments. The UI gives you a structured way to create a query and test it against previous deployments. When ready, you can export it so that you can add the query to your deploy file easily.

1. In the **Configuration UI**, go to [**Canary Analysis > Retrospective Analysis**](https://console.cloud.armory.io/configuration/metric-source-integrations/).
2. Select the metric provider you just configured.
3. Select a time range that includes when you deployed your app.
4. Add a **Query Template**. Use the following example:

   - **Name**: avgCPUUsage
   - **Upper Limit**: The upper limit for the query. If the results exceed this value, the deployment is considered to be a failure. Set this to `10000`.
   - **Lower Limit**: The lower limit for the query. If the results fall below this value, the deployment is considered to be a failure. Set this to `0`.
   - **Query Template**:

      ```
      avg(avg_over_time(container_cpu_system_seconds_total{job="kubelet"}[{{armory.promQlStepInterval}}]) * on (pod) group_left (annotation_app)
      sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="{{armory.replicaSetName}}"}) by (annotation_app, pod)) by (annotation_app)
      ```

      - **The query must return a single result**. Automated canary analysis does not support queries that return multiple values. See [Query template requirements]({{< ref "ref-queries#query-template-requirements" >}}) for restrictions and provider examples.
      - The query contains variables that are automatically injected during canary analysis, but you must manually provide some of them during retrospective analysis.
        - Time related variables like `armory.promqlStepInterval` are automatically substituted by Armory CD-as-a-Service. For a full list, see the {{< linkWithTitle "cd-as-a-service/tasks/canary/retro-analysis.md" >}} guide.
        - `armory.replicaSetName` needs to be set to the name of the ReplicaSet that Armory CD-as-a-Service created for this app version. It's used to differentiate between the current and next version of the app. Do this in the next step where you add key/value pairs.

5. Add **Key Value (KV) Pair** for the **Context**. The key value pairs for your  For the sample query, you need to add the following key value Pair:

  - **Key**: `replicaSetName`

    **Value**: The name of the ReplicaSet that was created when you deployed the app in *Get Started with the CLI to Deploy Apps* guide.

6. Run the analysis. If the results fall within the upper and lower limits you set, the deployment is considered a success.

### Export and add a query to your deploy file

The Retrospective Analysis can take the query you provide and generate the YAML equivalent that you can use it in your deploy file.

1. From the analysis screen, select **Go back to Analysis Configuration**.
2. Click **Export Queries for Armory Deployments**. This creates the YAML block for the `analysis` portion of a deploy file.
3. Insert the YAML block into your deploy file at the bottom. For example:

   ```yaml
   analysis:
     queries:
      - name: avgCPUUsage
        upperLimit: 10000
        lowerLimit: 0
        queryTemplate: >-
          avg (avg_over_time(container_cpu_system_seconds_total{job="kubelet"}[{{armory.promQlStepInterval}}]) * on (pod)  group_left (annotation_app)
          sum(kube_pod_annotations{job="kube-state-metrics",annotation_deploy_armory_io_replica_set_name="{{armory.replicaSetName}}"})
          by (annotation_app, pod)) by (annotation_app)
   ```

For a detailed explanation of these fields, see the [Deployment File Reference]({{< ref "ref-deployment-file#analysis" >}})

The `avgCPUUsage` query is now available for you to use in the `steps` block of your deploy file to perform canary analysis.

## Add canary analysis to your deployment

Armory CD-as-a-Service supports manual and automated canary analysis. Manual canary analysis allows you to review the canary results until you have confidence that your queries are making good decisions around service health.

Adding canary analysis to your deployment involves updating your deploy file to include the following:

- An `analysis` block that describes what queries to use and how they are run. The YAML for the queries is what you can export from the UI. You did this in [Export and add a query to your deploy file](#export-and-add-a-query-to-your-deploy-file).
- Steps in your `strategy` block that perform canary analysis and define how it behaves.

1. In your deploy file, go to the `strategies` section.
2. Create a new strategy named `canary-deploy-strat` like the following:

   ```yaml
   strategies:
    canary-deploy-strat
      canary:
        steps:
          - setWeight:
              weight: 50
          - analysis:
              interval: 10
              unit: seconds
              numberOfJudgmentRuns: 3
              rollBackMode: manual
              rollForwardMode: manual
              queries: # The queries to run
                - avgCPUUsage
          - setWeight:
              weight: 75
          - analysis:
              interval: 10
              unit: seconds
              numberOfJudgmentRuns: 3
              rollBackMode: manual
              rollForwardMode: manual
              queries:
                - avgCPUUsage
   ```

   For a detailed explanation of these fields, see the [Deployment File Reference]({{< ref "ref-deployment-file#strategies" >}})

   This strategy deploys the app to 50% of the cluster and then performs a canary analysis with the following characteristics:

   - The interval for each run of the query is 10 seconds.
   - The number of runs of the query is 3.
   - Rolling a deployment back or forward is done manually through the Armory Deployments Status UI.
   - It uses the query `containerCPUSeconds`.

   The strategy then deploys the app to 75% of the cluster and then performs a canary analysis. After the roll forward is approved, Armory CD-as-a-Service deploys the app to 100% of the cluster.

3. Change the value of  `targets.<targetName>.strategy` for one or more of your deployment targets to `canary-deploy-strat`.

   ```yaml
   ...
   targets:
     <targetName>:
       account: <agentIdentifier>
       namespace: <namespace>
       strategy: canary-deploy-strat
    ...
    ```
4. Save the file

## Redeploy your app

Make a change to your app, such as the number of replicas, and redeploy it with the CLI:

```bash
armory deploy start  -f <your-deploy-file>.yaml
```

Monitor the progress and approve the canary steps in the UI.

### Go from manual to automated

Once you have confidence in your queries, switching from manual approvals of canary steps to automatic approvals involves updating the `analysis` steps in your strategy. You can either comment out the `rollBackMode` and `rollForwardMode` fields or set them to `automatic`. Subsequent deployments using the updated deploy file will progress the deployment automatically if the canary analysis steps pass.
