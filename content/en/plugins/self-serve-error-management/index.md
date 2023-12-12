---
title: Self-Serve Error Management Plugin
linkTitle: Self-Serve Error Management 
description: >
  The Self-Serve Error Management Plugin for Spinnaker enables overriding and customizing error messages from Clouddriver or the Scale Agent.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## What the Self-Serve Error Management plugin does

The Self-Serve Error Management plugin extends Clouddriver and enables you to:

1. **Replace** the Kubernetes error message with new message 
2. **Enhance** the Kubernetes error message, so it has more context for your end users
3. **Provide** a correlation ID between the overridden error message and the log of the original one
4. **Highlight** the Kubernetes account

Error message enhancement is available for both the [Kubernetes provider](https://spinnaker.io/docs/reference/providers/kubernetes-v2/) and the [Scale Agent](https://docs.armory.io/plugins/scale-agent/install/).

Installing the plugin consists of the following:

1. [Decide which error messages you want to customize](#decide-which-error-messages-you-want-to-customize)
1. [Install the plugin](#install-the-plugin)

## Compatiblity matrix

| Spinnaker Version | Self-Serve Error Management Plugin Version |
|-------------------|-----------------------------|
| 1.31.x            | 0.1.0 | 
| 1.30.x            | 0.1.0 | 
| 1.29.x            | 0.1.0                       |
| 1.28.x            | 0.1.0                       |

## {{% heading "prereq" %}}

You must enable the Kubernetes provider or the Scale Agent for this plugin to be available.

## Decide which error messages you want to customize

Before you install the plugin, you should decide which error messages you want to replace or append to. You add your configuration when you install the plugin.

```yaml
override-error:
  rules:
    - errorContains: "<second-error-message-text>"
      appendWith: "<append-to-error-message-text>"
    - errorContains: "<error-message-text>"
      replaceWith: "<custom-error-message>"   
```

Create a rule for each error message you want to modify. For each rule, you configure:

- `errorContains`: unique text from the error message that you want to replace or modify

**and one** of the following:

- `appendWith`: the message that should be appended to the original error message
- `replaceWith`: the message that replaces the original error message

>When you define both `appendWith` and `replaceWith` for the same error message, the plugin logs a warning and uses the original behavior. The plugin continues to apply the other rules.

### `appendWith` example

Use `appendWith` when you want to enhance the enhance the existing error message, such as providing more details to the end user.

In this example, you append text to the `no matches for kind` error message:

```yaml
override-error:
  rules:
    - errorContains: "no matches for kind"
      appendWith: "This is a custom error message appended to the end of the error message"
```

This is how the appended error message appears in the UI:

{{< figure src="appendWith.png" height="80%" weight="80%" >}}

### `replaceWith` example

Use `replaceWith` when you want to replace the entire error message with a different one. 

This example replaces the `no matches for kind` error message:

```yaml
override-error:
  rules:
    - errorContains: "no matches for kind"
      replaceWith: "This is a custom error message for replacing no matches for kind error."
```

This is the new message in the UI:

{{< figure src="replaceWith.png"  height="80%" weight="80%" >}}

## Install the plugin

After you have created your rules, you can install the plugin. Add your rules list to the `override-error` section.


{{< tabpane text=true right=true >}}
{{% tab header="**Install Method**:" disabled=true /%}}
{{% tab header="Spinnaker Operator" %}}

Add a Kustomize patch with the following contents:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            repository:
              enabled: true
              url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
            plugins:
              Armory.SelfServeErrorManagement:
                enabled: true
                version: <version>
        override-error:
          rules:
            - <your-rules>

```

1. Replace `<version>` with the plugin version that's compatible with your Spinnaker version.
1. Replace `<your-rules>` with your rules list.
1. Add the patch to the `patchesStrategicMerge` section of your kustomization file.
1. Apply your update.

This example shows a list of rules:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            repository:
              enabled: true
              url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
            plugins:
              Armory.SelfServeErrorManagement:
                enabled: true
                version: 0.1.0
        override-error:
          rules:
            - errorContains: "no matches for kind"
              appendWith: "This is a custom error message appended to the end of the error message"
            - errorContains: "credentials not found"
              replaceWith: "Credentials not found. This is a custom error message."
```
</details></br>

Alternately, add the plugin configuration in the `spec.spinnakerConfig.profiles.clouddriver` section of your `spinnakerservice.yml` and then apply your update.

{{% /tab %}}
{{% tab header="Halyard" %}}

>When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard.


The Self-Serve Error Management Plugin extends Clouddriver. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Add the following to your `clouddriver-local.yml` file:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.SelfServeErrorManagement:
        enabled: true
        version: <version>
    repositories:
      selfservesrrormanagement:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
override-error:
  rules:
    - <your-rules>
```

1. Replace `<version>` with the plugin version that's compatible with your Spinnaker version.
1. Add your list of filters.
1. `hal deploy apply` your update.

This example shows a list of rules:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.SelfServeErrorManagement :
        enabled: true
        version: 0.1.0
    repositories:
      selfservesrrormanagement:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
override-error:
  rules:
    - errorContains: "no matches for kind"
      appendWith: "This is a custom error message appended to the end of the error message"
    - errorContains: "credentials not found"
      replaceWith: "Credentials not found. This is a custom error message."
```


{{% /tab %}}
{{< /tabpane >}}

## Release notes

- 0.1.0: Initial release

