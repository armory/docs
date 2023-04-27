---
title: Query Reference Guide
linkTitle: Queries
description: >
  Armory CD-as-a-Service has different requirements for how queries are formatted and what kind of data can get returned based on the metrics provider you use for automated canary analysis. This guide provides basic information about what Armory CD-as-a-Service needs for each provider.

---

## Automated canary analysis

When Armory CD-as-a-Service performs automated canary analysis, Armory CD-as-a-Service runs queries against a metrics provider to either progress a deployment or roll it back based on thresholds you set. Armory CD-as-a-Service supports the following metrics providers:

- Datadog
- New Relic
- Prometheus

For information about using queries in your deploy file, see the following resources:

- [Add queries to your deploy file]({{< ref "ref-deployment-file#analysisqueries" >}})
- [Use a query in a deployment step]({{< ref "ref-deployment-file#strategiesstrategynamestrategystepsanalysis" >}})

## Query variables

You can use variables in the query templates you define in the `analysis.queries.queryTemplate` block of your deployment file. Armory provides a basic set of variables that can be used for all the metrics providers, but you can configure additional ones.

### Armory provided variables

Armory provides some metrics by default on all canary analysis requests. These variables are all prefixed with `armory` and are surrounded by `{{}}`. For example, to use `applicationName` variable that Armory supplies, you use the following snippet in the query template: `{{armory.applicationName}}`.

Armory provides the following variables:

| Variable                 | Annotation                          | Environment variable      | Notes                                                                       |
|--------------------------|-------------------------------------|---------------------------|-----------------------------------------------------------------------------|
| applicationName          | `deploy.armory.io/application`      | `ARMORY_APPLICATION_NAME` | Added as annotation resources and as environment variables on  pods*        |
| deploymentId             | `deploy.armory.io/deployment-id`    | `ARMORY_DEPLOYMENT_ID`    | Added as annotation resources and as environment variables on  pods*        |
| environmentName          | `deploy.armory.io/environment`      | `ARMORY_ENVIRONMENT_NAME` | Added as annotation resources and as environment variables on  pods*        |
| replicaSetName           | `deploy.armory.io/replica-set-name` | `ARMORY_REPLICA_SET_NAME` | Added as annotation resources and as environment variables on  pods*        |
| accountName              | -                                   | -                         | The name of the account (or agentIdentifier) used to execute the deployment |
| namespace                | -                                   | -                         | The namespace resources are being deployed to                               |
| promQlStepInterval       | -                                   | -                         | Used to aggregate PromQL functions to a single value                        |
| intervalSeconds          | -                                   | -                         | Length of the current query interval in seconds                             |
| intervalMillis           | -                                   | -                         | Length of the current query interval in milliseconds                        |
| endTimeEpochMillis       | -                                   | -                         | Exact end time of the current query interval in epoch milliseconds format   |
| endTimeEpochSeconds      | -                                   | -                         | Exact end time of the current query interval in epoch seconds format        |
| endTimeIso8601           | -                                   | -                         | Exact end time of the current query interval in ISO 8601 format             |
| startTimeEpochMillis     | -                                   | -                         | Exact start time of the current query interval in epoch milliseconds format |
| startTimeEpochSeconds    | -                                   | -                         | Exact start time of the current query interval in epoch seconds format      |
| startTimeIso8601         | -                                   | -                         | Exact start time of the current query interval in ISO 8601 format           |
| preview.`<service name>` | -                                   | -                         | URL to the `Service` resource exposed via `exposeServices` step**           |

`*`If you are using a metrics implementation like [Micrometer](https://micrometer.io/), make sure to configure it to report these metrics to your metrics provider.

`**`Service preview links are scoped to the strategy and `afterDeployment` constraints section. Do consider adjusting preview link's TTL property, otherwise you may end up 
serving links which have already expired. 


### Custom variables

In addition to the Armory provided variables, you can define additional custom ones. These are added to the `strategies.<strategyName>.canary.steps.analysis.context` section of your deployment file:

```
strategies:
  ...
    canary:
      steps:
        ...
        - analysis:
            ...
            context:
              - <variableName>: <variableValue>
```

They need to be defined for each analysis step that uses a query referencing them.

In query templates, you reference them with the following format: `{{context.<variableName>}}`. For example, if you created a variable called `owner`, you reference it in the query template with `{{context.owner}}`.

## Query template requirements

Regardless of metrics provider, all queries require the following:

- **Must return a single result**. Automated canary analysis does not support queries that return multiple values
- Must be defined in `analysis.queries.queryTemplate`

### Datadog queries

Datadog queries cannot be a time-series query. This means that you need to include the `.rollup(method, {{armory.intervalSeconds}})` method in your query.

For more information on Datadog queries, see [the Datadog documentation](https://docs.datadoghq.com/tracing/trace_explorer/query_syntax/).

#### Sample Datadog query

```sql
avg:jvm.memory.used{name:{{armory.applicationName}}
  AND {{armory.replicaSetName}}}.rollup(avg, {{armory.intervalSeconds}}) / avg:jvm.memory.max{name:{{armory.applicationName}}
  AND {{armory.replicaSetName}}}.rollup(avg, {{armory.intervalSeconds}}) * 100
```

### New Relic queries

New Relic queries must meet the following requirements:

* Must include an `UNTIL` clause in your query that specifies the start and end of the canary interval
	* For example, include a clause similar to the following clause: `SINCE '{{armory.startTimeIso8601}}' UNTIL '{{armory.endTimeIso8601}}`
* Cannot contain the ‘TIMESERIES’ clause

For information on New Relic’s Query Language, see the [New Relic documentation](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/introduction-nrql-new-relics-query-language/).

#### Sample New Relic query

```sql
SELECT average(jvm.memory.used) / average(jvm.memory.max) * 100 FROM Metric
  WHERE name = '{{armory.applicationName}}' AND replicaSetName = '{{armory.replicaSetName}}'
  SINCE '{{armory.startTimeIso8601}}' UNTIL '{{armory.endTimeIso8601}}'
```

### Prometheus queries

Prometheus queries must return results as a time stamp value pair.

For information on Prometheus queries, see [the Prometheus documentation](https://prometheus.io/docs/prometheus/latest/querying/basics/).

##### Sample Prometheus query

```sql
avg(avg_over_time(jvm_memory_used_bytes{app="{{armory.applicationName}}",replicaSet="{{armory.replicaSetName}}"}[{{armory.promQlStepInterval}}])) /
  avg(avg_over_time(jvm_memory_max_bytes{app="{{armory.applicationName}}",replicaSet="{{armory.replicaSetName}}"}[{{armory.promQlStepInterval}}])) * 100
```