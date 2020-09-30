---
title: Cluster Mode Installation
linkTitle: Cluster Mode
weight: 3
description: >
  Install Armory Agent where Spinnaker<sup>TM</sup> is running.
---

{{< figure src="/images/armory-agent/install-mode-cluster.png"
caption="Armory Agent for Kubernetes running in cluster mode"
alt="Armory Agent for Kubernetes running in Cluster mode" >}}


Armory Agent for Kubernetes runs in the same cluster as the Armory Platform or open source Spinnaker.  This is a good option if you have a shared services team that wants the performance gains but also wants to still control Kubernetes service account access.