---
title: Armory Continuous Deployment-as-a-Service Configuration UI
linkTitle: Configuration UI
description: >
  Administer your Armory CD-as-a-Service instance, including inviting users, managing deployment targets, and generating secrets.
exclude_search: true
---












### Retrospective Analysis

Use the **Retrospective Analysis** page to help you construct queries that you can use for canary analysis by running them against previous deployments. Once you've created a query that meets your needs, export it to generate YAML that can be used in your deploy file.

To perform retrospective analysis, you need to provide the following:

- **Metrics Provider**: The metrics provider that you want to use. For information about adding a metrics provider, see Integrations[#integrations].
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

<!--## Deployment targets

### Add a Kubernetes deployment target

[**Deployment Targets > Kubernetes**](https://console.cloud.armory.io/configuration/accounts/kubernetes)

For a deployment target to be available, you need to add it to Armory CD-as-a-Service.

How you add a deployment target depends on whether or not the Kubernetes cluster is accessible from the public internet. If it is, you add it through the **Configuration UI**, and no additional steps are needed. If it is not, you must first install a Remote Network Agent (RNA) on it and then add it through the **Configuration UI**.

For information about how to add a deployment target, see [Prepare your deployment target]({{< ref "get-started#prepare-your-deployment-target" >}}).
-->
## Networking

### Monitor connected agents

[**Networking > Agents**](https://console.cloud.armory.io/configuration/agents)

The **Agents** page shows you the list of agents that are connected if the credentials they use have the `connect:agentHub` scope.

> Note that you may see a "No Data" message when first loading the **Agents** page even if there are successfully connected RNAs.

The Agent Hub (Armory's hosted cloud service) and the RNA on your clusters perform periodic healthchecks to ensure that the connection between the Agent Hub and your target deployment cluster is working. If the healthcheck fails, the RNA is removed from the list. When a subsequent check passes, the RNA and its cluster are added back to the list with the **Connected At** column showing when the connection was re-established.

{{< figure src="/images/cdaas/ui-rna-status.jpg" alt="The Connected Remote Network Agents page shows connected agents and the following information: Agent Identifier, Agent Version, Connection Time when the connection was established, Last Heartbeat time, Client ID, and IP Address." >}}
