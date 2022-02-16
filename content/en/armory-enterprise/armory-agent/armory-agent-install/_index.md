---
title: "Armory Agent for Kubernetes Installation"
linkTitle: "Installation"
description: >
  Learn how to install the Armory Agent in your Kubernetes and Armory Enterprise environments.
weight: 30
no_list: true
aliases:
  - /armory-enterprise/armory-agent/armory-agent-quick/
  - /docs/armory-agent/armory-agent-quick/
---
![Proprietary](/images/proprietary.svg)

>This installation guide is designed for installing the Agent in a test environment. It does not include [mTLS configuration]({{< ref "agent-mtls" >}}), so the Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}

* You deployed Armory Enterprise using the [Armory Operator and Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions. The Agent plugin uses the SQL database to store cache data.
* You have a running Redis instance. The Agent plugin uses Redis to coordinate between Clouddriver replicas. Note: you need Redis even if you only have one Clouddriver instance.
* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).
* If you are running multiple Clouddriver instances, you have a running Redis instance. The Agent uses Redis to coordinate between Clouddriver replicas.
* You have an additional Kubernetes cluster to serve as your deployment target cluster.

### Networking requirements

Communication from the Agent service to the Clouddriver plugin occurs over gRPC port 9091. Communication between the service and the plugin must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Agent service and Clouddriver plugin.  

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## Installation overview

In this guide, you deploy the Agent service to your target cluster.

Installation steps:

1. Install the Clouddriver plugin. You do this in the cluster where you are running Armory Enterprise.

   1. Create the plugin manifest as a Kustomize patch.
   1. Create a LoadBalancer service Kustomize patch to expose the plugin on gRPC port `9091`.
   1. Apply the manifests.

1. Install the Agent service using a Helm chart or using `kubectl`.


## {{% heading "nextSteps" %}}

Install the Clouddriver plugin [using kubectl]({{< ref "install-agent-plugin" >}}).
</br>
</br>