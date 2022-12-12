---
title: Enable the Policy Engine Plugin in Armory Continuous Deployment or Spinnaker
linkTitle: Enable the Policy Engine Plugin
weight: 1
description: >
   Enable the Policy Engine plugin and connect it to your OPA server. When enabled, you can write policies that the Policy Engine enforces during save time, runtime validation, or when a user interacts with Armory Continuous Deployment.
---

![Proprietary](/images/proprietary.svg)

## {{% heading "prereq" %}}

* You have read the introductory Policy Engine [content]({{< ref "policy-engine-enable" >}}).
* You have [deployed an Open Policy Agent (OPA) server]({{< ref "policy-engine-enable#deploy-an-opa-server" >}}).
* You have access to the internet to download the plugin.
* You have identified the Policy Engine plugin that is compatible with your version of Armory Continuous Deployment or Spinnaker.
* If you are using Spinnaker, you are familiar with [installing and using plugins](https://spinnaker.io/docs/guides/user/plugins-users/) in Spinnaker.

### Supported versions

{{< include "policy-engine/plugin-compat-matrix.md" >}}

## How to enable the Policy Engine plugin

You have three options for enabling the Policy Engine plugin:

1. [Armory Operator or Spinnaker Operator](#armory-operator-or-spinnaker-operator)
1. [Spinnaker services local files](#spinnaker-services-local-files) (Spinnaker only)
1. [Halyard](#halyard) (Spinnaker only)

### Armory Operator or Spinnaker Operator              

You can enable the Policy Engine plugin using the Armory Operator or the Spinnaker Operator and the sample manifest, which is in the [spinnaker-kustomize-patches repository](https://github.com/armory/spinnaker-kustomize-patches/blob/master/armory/patch-policy-engine-plugin.yml).

* The sample manifest is for the Armory Operator and Armory CD. If you are using the Spinnaker Operator and Spinnaker, you must replace the `apiVersion` value "spinnaker.armory.io/" with "spinnaker.io/". For example:

  * Armory Operator: `apiVersion: spinnaker.armory.io/v1alpha2`
  * Spinnaker Operator: `apiVersion: spinnaker.io/v1alpha2`

* In the `gate.spinnaker.extensibility.deck-proxy.plugins.Armory.PolicyEngine.version` entry, make sure to replace the version number listed after `&version` with the version of the plugin you want to use. For example, if you are using Armory CD 2.27.x (Spinnaker 1.27.x), you would use version 0.2.1:

   {{< prism lang="yaml" line="12" >}}
   gate:
     spinnaker:
        extensibility:
         plugins:
           Armory.PolicyEngine:
              enabled: true
         deck-proxy:
           enabled: true
          plugins:
             Armory.PolicyEngine:
                enabled: true
                version: &version 0.2.1
   {{< /prism>}}

<details><summary>Show the manifest</summary>
{{< github repo="armory/spinnaker-kustomize-patches" file="/armory/patch-policy-engine-plugin.yml" lang="yaml" options="" >}}
</details>

#### Optional settings
##### Timeout settings

You can configure the amount of time that the Policy Engine waits for a response from your OPA server. If you have network or latency issues, increasing the timeout can make Policy Engine more resilient. Use the following config to set the timeout in seconds: `spec.spinnakerConfig.profiles.spinnaker.armory.policyEngine.opa.timeoutSeconds`. The default timeout is 10 seconds if you omit the config.

##### JSON validation

You can configure strict JSON validation as a boolean in `spec.spinnakerConfig.profiles.dinghy.jsonValidationDisabled`:


{{< prism lang="yaml" >}}
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        jsonValidationDisabled: <boolean>
{{< /prism >}}

The config is optional. If omitted, strict validation is on by default. When strict validation is on, existing pipelines may fail if any JSON is invalid.

### Spinnaker services local files

{{% alert title="Warning" color="warning" %}}
The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. To avoid each service restarting and downloading the plugin, do not add the plugin using Halyard. Instead, configure the plugin in the service’s local file.
{{% /alert %}}

The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. You must create or update the service's local file in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

1. Add the following to `gate-local.yml`, `orca-local.yml`, `front50-local.yml`, and `clouddriver.yml`:

   {{< prism lang="yaml" >}}
   armory:
      policyEngine:
         failOpen: false
         opa:
            # Replace with the actual URL to your Open Policy Agent deployment
            baseUrl: http://localhost:8181/v1/data
            # Optional. The number of seconds that the Policy Engine will wait for a response from the OPA server. Default is 10 seconds if omitted.
            # timeoutSeconds: <integer>
    spinnaker:
       extensibility:
          plugins:
             Armory.PolicyEngine:
                enabled: true
             policyEngine:
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
    {{< /prism >}}

1. Save your files and apply your changes by running `hal deploy apply`.

### Halyard

{{% alert title="Warning" color="warning" %}}
The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to each service. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. Clouddriver can take an hour or more to restart if you have many accounts configured.
{{% /alert %}}

1. Add the plugins repository

   {{< prism lang="bash" >}}
   hal plugins repository add policyEngine \
    --url=https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   {{< /prism >}}

   This creates the following entry in your `.hal/config`:

   {{< prism lang="yaml" >}}
   repositories:
      policyEngine:
         enabled: true
         url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   {{< /prism >}}

1. Add the plugin
   
   Be sure to replace `<version>` with the version that's compatible with your Spinnaker instance.
   {{< prism lang="bash" >}}
   hal plugins add Armory.PolicyEngine --version=<version> --enabled=true
   {{< /prism >}}

   If you specified version 0.2.2, Halyard creates the following entry in your `.hal/config` file: 
   {{< prism lang="yaml" >}}
   spinnaker:
      extensibility:
         plugins:
            Armory.PolicyEngine:
               id: Armory.PolicyEngine
               enabled: true
               version: 0.2.2
   {{< /prism >}}

1. Apply the changes by executing `hal deploy apply`. 


## Release notes

<details><summary>Show the release notes</summary>

* 0.2.2 - Fixed bug for createApplication button with Spinnaker 1.28, to be included in 2.28 release
* 0.2.1 - Fixed bug with the projects tab on deck for Armory Continuous Deployment 2.27.1 and later
* 0.2.0 - Update plugin to be compatible with Armory Continuous Deployment 2.27.0 and later.
* 0.1.6 - The Policy Engine Plugin is now generally available.
  * If you are new to using the Policy Engine, use the plugin instead of the extension project.
  * Entitlements using API Authorization no longer requires at least one policy. Previously, if you had no policies set, Policy Engine prevented any action from being taken. Now, Entitlements for Policy Engine allows any action to be taken if there are no policies set.
* 0.1.4 - Adds the `opa.timeoutSeconds` property, which allows you to configure how long the Policy Engine waits for a response from the OPA server.
* 0.1.3 - Fixes an issue introduced in v0.1.2 where the **Project Configuration** button's name was changing when Policy Engine is enabled.
* 0.1.2  - Adds support for writing policies against the package `spinnaker.ui.entitlements.isFeatureEnabled` to show/hide the following UI buttons:
  * Create Application
  * Application Config
  * Create Project
* 0.0.25 - Fixes an unsatisfied dependency error in the API (Gate) when using SAML and x509 certificates. This fix requires Armory Continuous Deployment 2.26.0 later.
* 0.0.19 - Adds forced authentication feature and fixes NPE bug
* 0.0.17 - Initial plugin release

</details>

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/_index.md" >}}