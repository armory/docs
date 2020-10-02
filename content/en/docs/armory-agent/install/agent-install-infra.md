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

Install Armory Agent in an infrastructure node cluster when you need additional redundancy and scale.  This approach allows the Armory Agent service to use  shared services such as load balancers. Additionally, the agent that need a larger amount of resources for processing heavier workloads.  Armory Agent only needs to know the FQDN and port of the Armory Agent plugin and the destination Kubernetes API.