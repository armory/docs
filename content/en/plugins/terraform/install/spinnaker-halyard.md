---
title: Install Terraform Integration in Spinnaker (Halyard)
linkTitle: Spinnaker - Halyard
weight: 5
description: >
  Learn how to install Armory's Terraform Integration Plugin in a Spinnaker instance managed by Halyard. Terraform Integration enables your app developers to provision infrastructure using Terraform as part of their delivery pipelines.
---

## Overview of installing Terraform Integration

Installing the Terraform Integration plugin consists of these steps:

1. Install the service

   1. Configure Kubernetes permissions
   1. Configure the service
   1. Deploy the service
1. Install the plugin

### Compatibility

{{< include "plugins/terraform/compat-matrix.md" >}}

## {{% heading "prereq" %}}

You have read the [Terraform Integration Overview]({{< ref "plugins/terraform/_index.md" >}}).

**Spinnaker requirements**

* You are running open source Spinnaker.
* You manage your instance using Halyard. If you are using the Spinnaker Operator, see {{< linkWithTitle "plugins/terraform/install/spinnaker-operator.md" >}}

{{% alert title="Warning" color="warning" %}}
The examples in this guide are for a vanilla Spinnaker installation. You may need to adjust them for your environment.
{{% /alert %}}

{{< include "plugins/terraform/terraform-prereqs.md" >}}

## Configure Spinnaker

### Configure Redis

{{< include "plugins/terraform/config-redis.md" >}}

### Configure your artifact account

{{< include "plugins/terraform/config-artifact-acct.md" >}}

### Configure additional repos

{{< include "plugins/terraform/configure-optional-repos.md" >}}

## Install the service

### Configure Kubernetes permissions

The following manifest creates a ServiceAccount, ClusterRole, and ClusterRoleBinding. Apply the manifest in your `spinnaker` namespace.

{{< include "plugins/terraform/code/k8s-permissions.md" >}}

### Configure the service

Create a ConfigMap to contain your Terraformer Integration service configuration. Be sure to check the `spinnaker.yml` entry in the `data` section to ensure the values match your Spinnaker installation.

{{< include "plugins/terraform/code/terraform-config-map.md" >}}

### Deploy the service

Replace `<version>` with the Terraform Integration service version [compatible](#compatibility) with your Spinnaker version. 

{{< include "plugins/terraform/code/deployment.md" >}}

Apply the ConfigMap and Deployment manifests in your `spinnaker` namespace.

## Install the plugin

{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. Clouddriver can take an hour or more to restart if you have many accounts configured.

The Terraform plugin extends Deck, Gate, and Orca. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. Instead, follow the **Local Config** installation method, in which you configure the plugin in each extended service’s local profile.

{{% /alert %}}

The Pipelines-as-Code plugin extends Deck, Gate, and Orca. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Replace `<version>` with the plugin version [that's compatible with your Spinnaker instance].

1. Add the following to `gate-local.yml`:

   ```yaml
   proxies:
     - id: terraform
       uri: http://spin-terraformer:7088
       methods:
         - GET
   services:
     terraformer:
       enabled: true
       baseUrl: http://spin-terraformer:7088
   spinnaker:
     extensibility:
       plugins:
         Armory.Terraformer:
           enabled: true
           version: <version>
       repositories:
         terraformer:
           enabled: true
           url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
       deck-proxy:
         enabled: true
         plugins:
           Armory.Terraformer:
             enabled: true
             version: <version>
   ```

1. Add the following to `orca-local.yml`:

   ```yaml
   services:
     terraformer:
       enabled: true
       baseUrl: http://spin-terraformer:7088
   spinnaker:
     extensibility:
       plugins:
         Armory.Terraformer:
           enabled: true
           version: <version>
       repositories:
         terraformer:
           enabled: true
           url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   ```

1. Save your files and apply your changes by running `hal deploy apply`.

## {{% heading "nextSteps" %}}

{{< include "plugins/terraform/whats-next.md" >}}
