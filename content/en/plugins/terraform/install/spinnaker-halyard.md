---
title: Install Terraform Integration in Spinnaker (Halyard)
linkTitle: Spinnaker - Halyard
weight: 5
description: >
  Learn how to install Armory's Terraform Integration Plugin in a Spinnaker instance managed by Halyard.
---

## Installation overview

Installing the Terraform Integration plugin consists of these steps:

### Compatibility

{{< include "plugins/pac/compat-matrix.md" >}}

## {{% heading "prereq" %}}

* You are running open source Spinnaker.
* You manage your instance using Halyard. If you are using the Spinnaker Operator, see {{< linkWithTitle "plugins/terraform/install/spinnaker-operator.md" >}}


{{% alert title="Warning" color="warning" %}}
The examples in this guide are for a vanilla Spinnaker installation. You may need to adjust them for your environment.
{{% /alert %}}

## Install the plugin

{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. Clouddriver can take an hour or more to restart if you have many accounts configured.

The Pipelines-as-Code plugin extends Gate and Echo. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. Instead, follow the **Local Config** installation method, in which you configure the plugin in each extended service’s local profile.

{{% /alert %}}

The Pipelines-as-Code plugin extends Gate and Echo. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Replace `<version>` with the plugin version that's compatible with your Spinnaker instance.

1. Add the following to `gate-local.yml`:

   ```yaml
   spinnaker:
     extensibility:
       plugins:
         Armory.PipelinesAsCode:
           enabled: true
           version: <version>
       repositories:
         pipelinesAsCode:
           enabled: true
           url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   ```

1. Add the following to `echo-local.yml`:

   ```yaml
   armorywebhooks:
     enabled; true
     forwarding:
       baseUrl: http://spin-dinghy:8081
       endpoint: v1/webhooks
   spinnaker:
     extensibility:
       plugins:
         Armory.PipelinesAsCode:
           enabled: true
           version: <version>
       repositories:
         pipelinesAsCode:
           enabled: true
           url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   ```

   `armorywebhooks` config tells the service where to forward events it receives from the repo.

1. Save your files and apply your changes by running `hal deploy apply`.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/install/configure.md" >}}
