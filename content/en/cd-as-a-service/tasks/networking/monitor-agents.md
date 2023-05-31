---
title: Monitor Installed Remote Network Agents
linktitle: Monitor Agents
description: >
  Monitor Remote Network Agents using the Armory CD-as-a-Service console.
categories: ["Guides"]
tags: [ "Networking", "Remote Network Agent"]
---

## Monitor connected agents

[**Networking > Agents**](https://console.cloud.armory.io/configuration/agents)

The **Agents** page shows you the list of agents that are connected if the credentials they use have the `connect:agentHub` scope.

> Note that you may see a "No Data" message when first loading the **Agents** page even if there are successfully connected RNAs.

The Agent Hub (Armory's hosted cloud service) and the RNA on your clusters perform periodic healthchecks to ensure that the connection between the Agent Hub and your target deployment cluster is working. If the healthcheck fails, the RNA is removed from the list. When a subsequent check passes, the RNA and its cluster are added back to the list with the **Connected At** column showing when the connection was re-established.

{{< figure src="/images/cdaas/ui-rna-status.jpg" alt="The Connected Remote Network Agents page shows connected agents and the following information: Agent Identifier, Agent Version, Connection Time when the connection was established, Last Heartbeat time, Client ID, and IP Address." >}}

