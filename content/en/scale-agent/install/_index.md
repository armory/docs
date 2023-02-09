---
title: Get Started with the Armory Scale Agent for Spinnaker and Kubernetes
linkTitle: Get Started
description: >
  Learn how to install and configure the Armory Scale Agent for Spinnaker and Kubernetes in your Spinnaker and Armory CD environments.
weight: 1
---

## Compatibility matrix

{{< include "scale-agent/agent-compat-matrix.md" >}}

**@TODO Evaluation use case chart; all these guides should use Spinnaker service mode**

| Use Case | Guide | K8s Acct Config |
|:--- |:---- |:----- |
| Create Spinnaker instance and install the Scale Agent in the same cluster |  {{< linkWithTitle "scale-agent/install/quickstart.md" >}} | static in service config since there won't be any accounts in Clouddriver |
| Existing Spinnaker instance managed by Halyard | {{< linkWithTitle "scale-agent/install/install-spin.md" >}} | static in ConfigMap |
| Existing Spinnaker instance managed by the Spinnaker Operator |  | ?? |
| Existing Armory CD instance managed by the Armory Operator | {{< linkWithTitle "scale-agent/install/install-armory.md" >}} | ?? |

Base dynamic accounts features automatically enabled in plugin and service. Autoscan and interceptor features require Spinnaker 1.28+ and Clouddriver Account Management enabled - we can only enable those in the all-in-one Quickstart where we control Spinnaker version and Clouddriver configuration.

**@TODO Advanced use cases**

* plugin - Docker  {{< linkWithTitle "scale-agent/tasks/plugin-docker.md" >}}  currently in Tasks -> move to an advanced install dir??
   * Armory/Spinnaker Operator config - exists
   * Halyard config  ???
* service
   * modes (Spinnaker Service, Infrastructure, Agent)  {{< linkWithTitle "scale-agent/install/service-deploy/modes.md" >}} 
   * k8s manifests 
      * Spinnaker Service mode in {{< linkWithTitle "scale-agent/install/install-spin.md" >}}
      * Example of installing in different cluster and namespace  {{< linkWithTitle "scale-agent/install/service-deploy/kubectl.md" >}} -- needs more explanation; doesn't mention which mode this is
   * Helm chart {{< linkWithTitle "scale-agent/install/service-deploy/helm/index.md" >}}  (have not reviewed the content, which is old)
   * configuration -> buried right now in reference/config/service-options   {{< linkWithTitle "scale-agent/reference/config/service-options.md" >}}
   * account configuration and migration
      * buried right now in reference/config/service-options   {{< linkWithTitle "scale-agent/reference/config/service-options.md" >}}
      * a bit in the modes content  {{< linkWithTitle "scale-agent/install/service-deploy/modes.md" >}} 
      * and more in the dynamic accounts content




 I think all the k8s account configuration options should be explained in a single page (ie, don't separate dynamic accounts from static account config)     
