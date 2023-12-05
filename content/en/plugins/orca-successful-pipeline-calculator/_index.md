---
title: Orca-Successful-Pipeline-Calculator
linkTitle: Pipelines-as-Code
description: >
  Armory SPE Calculator automates the aggregation of Successful Pipeline count by day and makes the information available to query and visualize through an API 
no_list: true
---

![Proprietary](/images/proprietary.svg) [![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}})

## Requirements
- [Orca configured with SQL backing](https://docs.armory.io/continuous-deployment/armory-admin/orca-sql-configure/) 

## Installation With Spinnaker Operator
Create `insights-plugin.yml` with the following contents:
```yaml
apiVersion: spinnaker.io/v1alpha2
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
              cron: '1    1    1    *    *    *'
              fetch:
                limit: 1000
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
- `insights.jobs.pipelinStatusCount.cron`: Replace with a cron expression that corresponds to the time of the day with lowest load. It can be disabled by using `-` as an expression.
- `insights.jobs.pipelineStatusCount.fetch.limit`: Indicates how many records are read at a time from `orca.pipelines`, adjust based on performance (Defaults to 1000).

### [API Usage]({{< linkWithTitle "plugins/orca-successful-pipeline-calculator/usage/api.md" >}})

