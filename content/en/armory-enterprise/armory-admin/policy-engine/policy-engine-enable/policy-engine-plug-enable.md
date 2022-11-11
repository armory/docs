---
title: Enable Policy Engine Plugin in Armory Enterprise
linkTitle: Enable Policy Engine Plugin
weight: 1
description: "Enable the Policy Engine Plugin and connect it to your OPA server. When enabled, you can write policies that the Policy Engine enforces during save time, runtime validation, or when a user interacts with Armory Enterprise."
---

![Proprietary](/images/proprietary.svg)

## Before you start

Make sure the following requirements are met:

* If you are [migrating from the Policy Engine Extension]({{< ref "policy-engine-enable#migrating-to-the-policy-engine-plugin" >}}), make sure you have turned off the extension.
* You have an OPA server available. For more information, see [Deploy an OPA server]({{< ref "policy-engine-enable#deploy-an-opa-server" >}}).
* Access to the internet to download the plugin.

## Setup

You can enable the Policy Engine Plugin using the Armory Operator.

You can use the sample configuration to install the plugin, but keep the following in mind:

- Make sure to replace the version number listed after `&version` with the version of the plugin you want to use. For a list of supported versions for each Enterprise release, see [Release notes](#release-notes).



<details><summary>Show the manifest</summary>

This manifest is in the [`spinnaker-kustomize-patches` repository](https://github.com/armory/spinnaker-kustomize-patches/blob/master/armory/patch-policy-engine-plugin.yml).

{{< github repo="armory/spinnaker-kustomize-patches" file="/armory/patch-policy-engine-plugin.yml" lang="yaml" options="" >}}


### Optional settings
#### Timeout settings

You can configure the amount of time that the Policy Engine waits for a response from your OPA server. If you have network or latency issues, increasing the timeout can make Policy Engine more resilient. Use the following config to set the timeout in seconds: `spec.spinnakerConfig.profiles.spinnaker.armory.policyEngine.opa.timeoutSeconds`. The default timeout is 10 seconds if you omit the config.

#### JSON validation

You can configure strict JSON validation as a boolean in `spec.spinnakerConfig.profiles.dinghy.jsonValidationDisabled`:


```yaml
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        jsonValidationDisabled: <boolean>
```

The config is optional. If omitted, strict validation is on by default.

> When strict validation is on, existing pipelines may fail if any JSON is invalid.

</details>




## Release notes

* 0.2.2 - Fixed bug for createApplication button with Spinnaker 1.28, to be included in 2.28 release
* 0.2.1 - Fixed bug with the projects tab on deck for Armory Enterprise 2.27.1 and later
* 0.2.0 - Update plugin to be compatible with Armory Enterprise 2.27.0 and later.
* 0.1.6 - The Policy Engine Plugin is now generally available.
  * If you are new to using the Policy Engine, use the plugin instead of the extension project.
  * Entitlements using API Authorization no longer requires at least one policy. Previously, if you had no policies set, Policy Engine prevented any action from being taken. Now, Entitlements for Policy Engine allows any action to be taken if there are no policies set.
* 0.1.4 - Adds the `opa.timeoutSeconds` property, which allows you to configure how long the Policy Engine waits for a response from the OPA server.
* 0.1.3 - Fixes an issue introduced in v0.1.2 where the **Project Configuration** button's name was changing when Policy Engine is enabled.
* 0.1.2  - Adds support for writing policies against the package `spinnaker.ui.entitlements.isFeatureEnabled` to show/hide the following UI buttons:
  * Create Application
  * Application Config
  * Create Project
* 0.0.25 - Fixes an unsatisfied dependency error in the API (Gate) when using SAML and x509 certificates. This fix requires Armory Enterprise 2.26.0 later.
* 0.0.19 - Adds forced authentication feature and fixes NPE bug
* 0.0.17 - Initial plugin release
