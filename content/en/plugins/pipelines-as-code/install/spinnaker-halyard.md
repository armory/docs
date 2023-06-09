---
title: Install Pipelines-as-Code in Spinnaker (Halyard)
linkTitle: Spinnaker - Halyard
weight: 5
description: >
  Learn how to install Armory Pipelines-as-Code in a Spinnaker instanced managed by Halyard.
---

## Installation overview

Installing Pipelines-as-Code consists of these steps:

1. [Configure Kubernetes permissions](#configure-kubernetes-permissions).
1. [Configure the Pipelines-as-Code service](#configure-the-service).
1. [Deploy the Pipelines-as-Code service](#deploy-the-service) in the same Kubernetes cluster as Spinnaker.
1. [Install the plugin](#install-the-plugin) into Spinnaker. 

### Compatibility

{{< include "plugins/pac/compat-matrix.md" >}}

## {{% heading "prereq" %}}

* You are running open source Spinnaker.
* You manage your instance using Halyard. If you are using the Spinnaker Operator, see {{< linkWithTitle "plugins/pipelines-as-code/install/spinnaker-operator.md" >}}
* You have permissions to create ServiceAccount, ClusterRole, and ClusterRoleBinding objects in your cluster.

{{% alert title="Warning" color="warning" %}}
The examples in this guide are for a vanilla Spinnaker installation. You may need to adjust them for your environment.
{{% /alert %}}

## Configure Kubernetes permissions

The following manifest creates a ServiceAccount, ClusterRole, and ClusterRoleBinding. Apply the manifest in your `spinnaker` namespace.

{{< include "plugins/pac/code/k8s-permissions.md" >}}

## Configure the service

Create a ConfigMap to contain your Dinghy service configuration. Be sure to check the `spinnaker.yml` entry in the `data` section to ensure the values match your Spinnaker installation.

{{< include "plugins/pac/code/dinghy-config-map.md" >}}

### Configure your repo

{{< include "plugins/pac/before-enable-repo.md" >}}

{{< tabpane text=true right=true  >}}
{{% tab header="**Version Control**:" disabled=true /%}}
{{% tab header="GitHub"  %}}
{{< include "plugins/pac/config-github-spinnaker.md" >}}
{{< include "plugins/pac/config-github-common.md" >}}
{{% /tab %}}
{{% tab header="Bitbucket/Stash"  %}}
{{< include "plugins/pac/config-bitbucket-spinnaker.md" >}}
{{< include "plugins/pac/config-bitbucket-common.md" >}}
{{% /tab %}}
{{% tab header="GitLab"  %}}
{{< include "plugins/pac/config-gitlab-spinnaker.md" >}}
{{< include "plugins/pac/config-gitlab-common.md" >}}
{{% /tab %}}
{{< /tabpane >}}


## Deploy the service

Replace `<version>` with the Pipelines-as-Code service version [compatible](#compatibility) with your Spinnaker version. 

{{< include "plugins/pac/code/deployment.md" >}}

Apply the ConfigMap and Deployment manifests in your `spinnaker` namespace.

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
