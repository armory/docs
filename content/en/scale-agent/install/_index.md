---
title: Get Started with the Armory Scale Agent for Spinnaker and Kubernetes
linkTitle: Get Started
description: >
  Learn how to install and configure the Armory Scale Agent for Spinnaker and Kubernetes in your Spinnaker and Armory CD environments.
weight: 1
---

## Compatibility matrix

{{< include "scale-agent/agent-compat-matrix.md" >}}

**@TODO** Install paths


1. all-in-one spinnaker/plugin/service all in same cluster and namespace as spinnaker
1. using an existing spinnaker instance -> install plugin and same cluster and namespace as spinnaker (spinnaker service mode/infrastructure mode)
1. using an existing spinnaker instance -> install plugin in spinnaker, install service in different cluster(s)  (use provided K8s manifests or helm chart for service(s))
1. using an existing CDSH instance -> install plugin and service in same cluster and namespace as CDSH (spinnaker service mode/infrastructure mode) -> all files should be in kustomize repo and have recipe for this (or tell user how to modify their existing recipe)
1. using an existing CDSH instance -> install plugin in CDSH, install service in different cluster(s)  (use provided K8s manifests or helm chart for service(s))


**@TODO Evaluation use case chart; all these guides should use Spinnaker service mode**

| Use Case | Guide | K8s Acct Config |
|:--- |:---- |:----- |
| Create Spinnaker instance and install the Scale Agent in the same cluster |  {{< linkWithTitle "scale-agent/install/quickstart.md" >}} | static in service config since there won't be any accounts in Clouddriver |
| Existing Spinnaker instance managed by Halyard | {{< linkWithTitle "scale-agent/install/install-spin.md" >}} | static in ConfigMap |
| Existing Spinnaker instance managed by the Spinnaker Operator |  | ?? |
| Existing Armory CD instance managed by the Armory Operator | {{< linkWithTitle "scale-agent/install/install-armory.md" >}} | ?? |

Base dynamic accounts features automatically enabled in plugin and service. Autoscan and interceptor features require Spinnaker 1.28+ and Clouddriver Account Management enabled - we can only enable those in the all-in-one Quickstart where we control Spinnaker version and Clouddriver configuration.

**@TODO Advanced use cases**

* plugin - Docker  {{< linkWithTitle "scale-agent/install/advanced/plugin-docker.md" >}} 
   * Armory/Spinnaker Operator config - exists
   * Halyard config  ???
* service
   * modes (Spinnaker Service, Infrastructure, Agent)  {{< linkWithTitle "scale-agent/install/advanced/modes.md" >}}
   * k8s manifests
      * Spinnaker Service mode in {{< linkWithTitle "scale-agent/install/install-spin.md" >}}
      * Example of installing in different cluster and namespace  {{< linkWithTitle "scale-agent/install/advanced/service-deploy/kubectl.md" >}} -- needs more explanation; doesn't mention which mode this is
   * Helm chart {{< linkWithTitle "scale-agent/install/advanced/service-deploy/helm/index.md" >}}  (have not reviewed the content, which is old)
   * configuration -> pulled out of reference/config/service-options and put into new page install/advanced/config-service
   * account configuration and migration
      * new page install/advanced/config-service
      * a bit in the modes content  {{< linkWithTitle "scale-agent/install/advanced/modes.md" >}}
      * and more in the dynamic accounts content




 I think all the k8s account configuration options should be explained in a single page (ie, don't separate dynamic accounts from static account config)     
