---
title: Armory Continuous Deployment-as-a-Service Configuration UI
linkTitle: Configuration UI
description: >
  Administer your Armory CD-as-a-Service instance, including inviting users, managing deployment targets, and generating secrets.
exclude_search: true
---


## Access Management

### Manage secrets

[**Access Management > Client Credentials**](https://console.cloud.armory.io/configuration/credentials)

Manage the secrets that you use for the Remote Network Agent (RNA) and to grant programmatic access to Armory CD-as-a-Service, such as when you configure the GitHub Action.

Note that secrets are Armory CD-as-a-Service environment specific.

### Invite users

[**Access Management > Users**](https://console.cloud.armory.io/configuration/users)

For your users to get access to Armory CD-as-a-Service, you must invite them to your organization. This grants them access to the  Armory CD-as-a-Service UI. Depending on their permissions, they may have access to the **Configuration UI** and the **Status UI**.

You need their name and email. Note that the email domain must match your organization's format. For example, users that work for Acme (which uses `username@acme.com`) must have `@acme.com` email addresses. They are automatically added to your organization once they accept the invite and complete the sign up.

1. Navigate to the CD-as-a-Service Console: https://console.cloud.armory.io/configuration/users.
2. Provide the name and email address for the user you want to invite.
3. Send the invitation.

They can access the UI after completing the signup process.

## Canary Analysis

### Integrations

[**Canary Analysis > Integrations**](https://console.cloud.armory.io/canary-analysis/integrations)

Integrate your metrics provider with Armory CD-as-a-Service so that you can perform retrospective analysis of your deployment performance or use canary analysis as part of your deployment strategy.

Armory supports the following metrics providers:

- [Datadog](#datadog)
- [New Relic](#new-relic)
- [Prometheus](#prometheus)

To configure one of them, select **New Integration** and complete the form. The information you need depends on the metrics provider.

#### Datadog

To configure DataDog, you need the following:

- **Base URL**: For example, `https://api.datadoghq.com/`.
- **API Key**: The key that your Datadog Agent uses to Datadog Agent to submit metrics and events to Datadog.
- **Application Key**: The key that grants permission for programmatic access to the Datadog API.

For information about how to get the API Key and Application Key, see [DataDog documentation](https://docs.datadoghq.com/account_management/api-app-keys/).

#### New Relic

To configure New Relic, you need the following:

- **Base URL**: For example, `https://api.newrelic.com/graphql/`.
- **API Key**: The metrics integration requires access to Graph QL, so provide the User Key API key. For more information, see [User Key in the New Relic documentation](https://docs.newrelic.com/docs/apis/accounts-api/new-relic-user-key-api-key/).
- **Account ID**: Your New Relic account ID. For information about how to get this ID, see [Account ID in the New Relic documentation](https://docs.newrelic.com/docs/apis/accounts-api/new-relic-account-id/).

#### Prometheus

To configure Prometheus, you need the following:

- **Base URL**: If Prometheus runs in the same cluster as the RNA and is exposed using HTTP on port 9090 through a service named `prometheus` in the namespace `prometheus-ns`, then the URL would be `http://prometheus.prometheus-ns:9090`.
- **Remote Network Agent**: The RNA that is installed on the Prometheus cluster if the cluster is not publicly accessible.
- **Authentication Type**: The username/password or bearer token if authentication is used.

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
