---
title: Spinnaker Plugins
linkTitle: Spinnaker Plugins
description: >
  This section contains guides for products that extend Spinnaker<sup>TM</sup> and Armory Continuous Deployment functionality.
---

## Plugin compatibility matrix

| Plugin | Spinnaker | Armory CD |
|:-------|:--------|:--------|
| [Armory CD-as-a-Service]({{< ref "/plugins/cdaas-spinnaker" >}}) | 1.24+ | 2.24+ |
| [Kubernetes Custom Resource Status Check]({{< ref "/plugins/plugin-k8s-custom-resource-status" >}}) | 1.27+ | 2.27+ |
| [Policy Engine]({{< ref "/plugins/policy-engine" >}}) | 1.26+ | 2.26+ |
| [Scale Agent]({{< ref "/plugins/scale-agent" >}}) | 1.26+ | 2.26+ |

See individual plugin sections for detailed version compatibility.


## How to install plugins

Each plugin section contains installation instructions. However, you should be aware of the following points regarding installation:

* **Spinnaker managed by Halyard**

  The open source Spinnaker [Plugin User Guide](https://spinnaker.io/docs/guides/user/plugins-users/) shows you how to install plugins using the Halyard CLI. When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin repository, and checks if a plugin extension exists for itself. Each service restarting is not ideal for large Spinnaker installations due to service restart times. 
  
  Armory recommends configuring the plugin in the extended service's local profile.

* **Spinnaker or Armory CD managed by Armory's corresponding Operator**

  The Spinnaker Operator and Armory Operator add plugin repository configuration only to the extended services.

  






