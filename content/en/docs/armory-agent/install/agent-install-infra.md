---
title: Infra Mode Installation
linkTitle: Infra Mode
weight: 3
description: >
  Install Armory Agent as a proxy.
---

{{< figure src="/images/armory-agent/install-mode-agent.png"
caption="Armory Agent running in Infra mode for further performance and high availability of target clusters"
alt="Armory Agent running in Infra mode for further performance and high availability of target clusters" >}}

Install Armory Agent in Infra mode when you need additional redundancy and scale.  This leverages "Infra Node" clusters for shared services, such as load balancers, and for Agents that need a larger amount of resources for processing heavier workloads.  Armory Agent only needs to know the FQDN and port of the Armory Agent plugin and the destination Kubernetes API.