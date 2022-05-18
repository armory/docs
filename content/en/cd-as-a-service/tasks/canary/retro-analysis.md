---
title: Construct Retrospective Analysis Queries for Canary Analysis
linktitle: Construct Queries
description: >
  Learn how to construct retrospective analysis queries that you can then use for your canary strategy.
exclude_search: true
---

## Overview

Use the **Retrospective Analysis** UI to help you to construct queries. You can then test those queries by running them against previous deployments. Once you've created a query that meets your needs, export it to generate YAML that you can use in your deploy file.

## {{% heading "prereq" %}}

You need to integrate your Metrics provider. See the {{< linkWithTitle "cd-as-a-service/tasks/canary/add-integrations.md" >}} guide for details.

## How to
To perform retrospective analysis, you need to provide the following:

- **Metrics Provider**: The metrics provider that you want to use.
- **Analysis Range**: The time range that you want to analyze.
- **Queries**: One or more query templates to use for the analysis. For the query template, you need the following:
   - Name: Provide a descriptive name
   - Upper Limit:
   - Lower Limit:
   - Query Template
- **Context**: Key/Value pair for the substitutable template variables in your query templates.

Armory supports the following time related variables out of the box:

- `armory.startTimeIso8601`
- `armory.startTimeEpochSeconds`
- `armory.startTimeEpochMillis`
- `armory.endTimeIso8601`
- `armory.endTimeEpochSeconds`
- `armory.endTimeEpochMillis`
- `armory.intervalMillis`
- `armory.intervalSeconds`
- `armory.promQlStepInterval`

You do not need to provide these variables in the context.

In addition to these time related variables, there are a special set can be used. You must add these manually as part of the context when performing retrospective analysis, but they are automatically substituted in queries that are part of your deploy file.

- `armory.deploymentId`
- `armory.applicationName`
- `armory.environmentName`
- `armory.replicaSetName`

You can also add your own custom variables as key/value pairs. If you want to use these custom variables, you need to add them to [`strategies.<strategyName>.<strategy>.steps.analysis.context` section in your deployment file]({{< ref "ref-deployment-file#strategiesstrategynamestrategystepsanalysiscontext" >}}).
