---
title: Install Pipelines as Code in Spinnaker
linkTitle: Install - Spinnaker
weight: 5
description: >
  Learn how to install Armory's Pipelines and Code plugin in Spinnaker.
---

## {{% heading "prereq" %}}

## Install the plugin

You have the following options for installing the Pipelines as Code plugin:

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

{{% tab header="Spinnaker Operator"  %}}

You can find the files to install the Pipelines as Code plugin in the [spinnaker-kustomize-patches repository](https://github.com/armory/spinnaker-kustomize-patches/blob/master/plugins/oss/pipeline-as-a-code/pac-plugin-config.yml).

1. In `pac-plugin-config.yml`, make sure the `version` number is compatible with your Spinnaker instance.

   <details><summary><strong>Show the manifest</strong></summary>
   {{< github repo="armory/spinnaker-kustomize-patches" file="plugins/oss/pipeline-as-a-code/pac-plugin-config.yml" lang="yaml" options="" >}}
   </details><br />

1. Add the plugin directory in the `components` section of your kustomization file. For example:

   ```yaml
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization

   namespace: spinnaker

   components:
	   - core/base
	   - core/persistence/in-cluster
	   - targets/kubernetes/default
     - plugins/oss/pipeline-as-a-code

   patchesStrategicMerge:
     - core/patches/oss-version.yml

   patches:
     - target:
         kind: SpinnakerService
       path: utilities/switch-to-oss.yml
   ```

1. Apply the manifest using `kubectl`.

{{% /tab %}}

{{% tab header="Local Config" %}}

The Pipelines as Code plugin extends Gate and Echo. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

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

* {{< linkWithTitle "plugins/pipelines-as-code/configure.md" >}}