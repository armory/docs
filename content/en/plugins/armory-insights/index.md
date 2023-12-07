---
title: Armory Insights Plugin for Armory CD
linkTitle:  Armory Insights
description: >
  The Armory Insights Plugin for Armory Continuous Deployment automates the aggregation of successful pipeline count by day and makes the information available to query and visualize through an API.  
no_list: true
---

![Proprietary](/images/proprietary.svg) [![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}})

**Armory Continuous Deployment only**

## {{% heading "prereq" %}}

* Your Orca service uses a SQL backend. See [Orca configured with SQL backend]({{< ref "continuous-deployment/armory-admin/orca-sql-configure" >}}) for instructions.
* You're able to call Orca's service endpoint (by default `http://spin-orca:8083`)

## Compatibility matrix

| Armory CD Version | Armory Insights Plugin Version |
|-------------------|-----------------------------|
| 2.31.x            | 0.0.1 | 
| 2.30.x            | 0.0.1 | 
| 2.28.x            | 0.0.1   |

## Installation

### Configure the plugin

In your `spinnaker-kustomize-patches/plugins` directory, create an `insights-plugin.yml` file with the following contents:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      spinnaker:
        insights:
          jobs:
            pipelineStatusCount:
              cron: '1 1 1 * * *'              
        spinnaker:
          extensibility:
            repositories:
              repository:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
      orca:
        spinnaker:
          extensibility:
            plugins:
              Armory.Insights:
                version: <version>
                enabled: true
              extensions:
                armory.insights:
                  enabled: true
```

- `version`: Replace `<version>` with the plugin version compatible with your Spinnaker version.
- `insights.jobs.pipelinStatusCount.cron`: Replace with a cron expression that corresponds to the time of the day with lowest load. You can disable this field by using `-` as the expression. For example:
   
   ```yaml
   spec:
    spinnakerConfig:
      profiles:
        spinnaker:
          insights:
            jobs:
              pipelineStatusCount:
                cron: '-' 
   ```

### Install the plugin

1. Add the plugin patch to your Kustomize recipe's `patchesStrategicMerge` section. For example:

   {{< highlight yaml "linenos=table,hl_lines=13" >}}
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   
   namespace: spinnaker
   
   components:
     - core/base
     - core/persistence/in-cluster
     - targets/kubernetes/default
   
   patchesStrategicMerge:
     - core/patches/oss-version.yml
     - plugins/insights-plugin.yml
   
   patches:
     - target:
         kind: SpinnakerService
       path: utilities/switch-to-oss.yml
   {{< /highlight >}}

1. Apply the updates to your Kustomization recipe.

   ```bash
   kubectl apply -k <kustomization-directory-path>
   ```

## How to use the plugin

### API endpoint

`/insights/pipelines/statuses/count`

| Parameter | Type                  | Description                      | Optional | Default Value |
|-----------|-----------------------|----------------------------------|----------|---------------|
| from      | Date (yyyy-MM-dd)     | Starting Date                    | Yes      | 30 days ago   |
| to        | Date (yyyy-MM-dd)     | End Date                         | Yes      | Today         |
| limit     | Number                | Max Number of results            | Yes      | 1000          |
| offsetId  | Number                | Starting Id (Exclusive)          | Yes      | nil           |
| descOrder | Boolean               | Sort results in descending order | Yes      | false         |
| status    | SUCCEEDED \| TERMINAL | Status of the aggregate          | Yes      | SUCCEEDED     |

### JSON Response

```json
{
    "records": [
        {
            "id": [id],
            "status": "[status]",
            "date": [UNIX milliseconds],
            "count": [count],
            "day": "yyyy-MM-dd"
        },
        ...
    ],
    "limit": [limit],
    "count": [count],
    "from": "yyyy-MM-dd",
    "to": "yyyy-MM-dd"
}
```

#### Root object

| Field   | Type   | Description                          |
|---------|--------|--------------------------------------|
| records | Array  | Array of record objects              |
| limit   | Number | Limit on the number of records       |
| count   | Number | Total number of records              |
| from    | String | Start date for the record collection |
| to      | String | End date for the record collection   |

#### Record object

Each object in the `records` array has the following structure:

| Field  | Type   | Description                                             |
|--------|--------|---------------------------------------------------------|
| id     | Number | Unique identifier of the record                         |
| status | String | Status of the record (e.g., "SUCCEEDED")                |
| date   | Number | Date of the record in milliseconds since epoch          |
| count  | Number | Count associated with the record                        |
| day    | String | The day corresponding to the record (yyyy-MM-dd format) |

