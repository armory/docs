---
title: Agent Mode Installation
linkTitle: Agent Mode
weight: 3
description: >
  Install Armory Agent where your applications run.
---

{{< figure src="/images/armory-agent/install-mode-agent.png"
caption="<i>Armory Agent running in Agent mode locally on the target Kubernetes cluster</i>"
alt="Armory Agent running in Agent mode locally on the target Kubernetes cluster" >}}


Armory Agent runs in the Kubernetes cluster where Spinnaker deploys the applications.  This allows the Kubernetes service accounts to stay within the target cluster. Communication is done over gRPC.