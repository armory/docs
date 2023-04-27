---
title: Install Pipelines-as-Code in Spinnaker
linkTitle: Spinnaker - Halyard
weight: 5
description: >
  Learn how to install Armory Pipelines and Code in a Spinnaker instanced managed by Halyard.
---

## Installation overview

Installing Pipelines-as-Code consists of these steps:

1. [Deploy the service](#deploy-the-service) in the same Kubernetes cluster as Spinnaker.
1. [Install the plugin](#install-the-plugin) into Spinnaker. 

## {{% heading "prereq" %}}

* You are familiar with with Pipelines-as-Code [architecture]({{< ref "plugins/pipelines-as-code/architecture" >}}).
* You have created a personal access token in your repo so the Pipelines-as-Code service can fetch your dinghyfiles.
* You have installed kubectl.
* You have permissions to create ServiceAccount, ClusterRole, and ClusterRoleBinding objects in your cluster.


## Configure permissions

The following manifest creates a ServiceAccount, ClusterRole, and ClusterRoleBinding. Apply the manifest in your `spinnaker` namespace.

{{< readfile file="/static/code/plugins/pac/k8s-permissions.yml" code="true" lang="yaml" >}}

## Configure the service

{{< readfile file="/static/code/plugins/pac/dinghy-config-map.yml" code="true" lang="yaml" >}}

### Configure your repo

{{< readfile file="/includes/plugins/pac/before-enable-repo.md" >}}


{{< tabpane text=true >}}
{{% tab header="GitHub"  %}}
{{< readfile file="/includes/plugins/pac/config-github.md" >}}
{{% /tab %}}
{{% tab header="Bitbucket/Stash"  %}}
{{< readfile file="/includes/plugins/pac/config-bitbucket.md" >}}
{{% /tab %}}
{{% tab header="GitLab"  %}}
{{< readfile file="/includes/plugins/pac/config-gitlab.md" >}}
{{% /tab %}}
{{< /tabpane >}}

## Deploy the service

Replace `<version>` with the Pipelines-as-Code service version compatible with your Spinnaker version. 

{{< readfile file="/static/code/plugins/pac/deployment.yml" code="true" lang="yaml" >}}

Apply the ConfigMap and Deployment manifests in your `spinnaker` namespace.

## Install the plugin

You have the following options for installing the Pipelines-as-Code plugin:

* Spinnaker Operator
* Local Config
* Halyard

{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. Clouddriver can take an hour or more to restart if you have many accounts configured.

The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. Instead, follow the **Local Config** installation method, in which you configure the plugin in each extended service’s local profile.

The Spinnaker Operator adds configuration only to extended services.
{{% /alert %}}

{{< tabpane text=true right=true >}}

{{% tab header="**Install Method**:" disabled=true /%}}

{{% tab header="Local Config" %}}

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
         pipelinesAsCode:
           url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   ```

1. Add the following to `echo-local.yml`:

armorywebhooks config tells the service where to forward events it receives from the repo
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
         pipelinesAsCode:
           url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   ```

1. Save your files and apply your changes by running `hal deploy apply`.
{{% /tab %}}

{{% tab header="Halyard" %}}

1. Add the plugins repository

   ```bash
   hal plugins repository add pipelinesascode \
    --url=https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   ```

   This creates the following entry in your `.hal/config`:

   ```yaml
   repositories:
      pipelinesascode:
         enabled: true
         url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   ```

1. Add the plugin
   
   Replace `<version>` with the plugin version that's compatible with your Spinnaker instance.
   
   ```bash
   hal plugins add Armory.PipelinesAsCode --version=<version> --enabled=true
   ```

   For example, if you specified version 0.0.5, Halyard creates the following entry in your `.hal/config` file: 

   ```yaml
   spinnaker:
      extensibility:
         plugins:
            Armory.PipelinesAsCode:
               id: Armory.PipelinesAsCode
               enabled: true
               version: 0.0.5
   ```
{{% /tab %}}
{{< /tabpane >}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/install/configure.md" >}}