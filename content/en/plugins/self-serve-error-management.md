---
title: Self Serve Error Management Plugin
linkTitle: Self Serve Error Management 
description: >
The Self Serve Error Management Plugin for Spinnaker enables overriding and customizing errors from CloudDriver or Scale Agent.
---

![Proprietary](/images/proprietary.svg)

## What the Self Serve Error Management plugin does

The Self Serve Error Management plugin extends CloudDriver and has the following features:

1. **Replacing** the Kubernetes error into a totally new message 
2. **Enhancing** the Kubernetes error, so it has more context for the end user
3. **Providing** a correlationId between the overridden exception and the log of the original one
4. **Highlighting** the Kubernetes account

At the moment, this is available for both [Kubernetes provider](https://spinnaker.io/docs/reference/providers/kubernetes-v2/) or [Scale Agent](https://docs.armory.io/plugins/scale-agent/install/).

Installing the plugin consists of the following:

1. [Decide what you want to customize](#decide-what-you-want-to-customize)
1. Install in your Spinnaker instance:
  * [Spinnaker managed by the Spinnaker Operator](#install---spinnaker-operator)
  * [Spinnaker managed by Halyard](#install---halyard)

## Compatiblity matrix

| Spinnaker Version | Self Serve Error Management Plugin Version |
|-------------------|-----------------------------|
| 1.28.x            | 0.1.0                       |

## {{% heading "prereq" %}}

For this plugin to be available, the Kubernetes provider or Scale Agent must be enabled.

## Config Constraints

For each rule, you can either define `appendWith` or `replaceWith`. Defining both will cause an exception to be thrown
when that specific rule is triggered.

## Example 

To configure this example `override-error` needs to be defined. This property uses the following:
- `rules` - a list defined by the user
- `errorContains` - the error that will be overridden
- `appendWith` - the message that will be appended to the initial error
- `replaceWith` - the message which will replace the initial error

### Replace Exception

This case, allows you to replace the entire exception into a new one. 

For example, if you want to replace `no matches for kind` exception, you need to define the config as it follows:

```yaml
override-error:
  rules:
    - errorContains: "no matches for kind"
      replaceWith: "This is a custom error message appended to the end of the error message"
```

{{< figure src="/images/plugins/selfServeErrorManagement/replaceWith.png" >}}

### Append Exception

This case, allows you to enhance the exception with a new message, providing more details to the end-user.

In this example, if you want to append a new message to the  `no matches for kind` exception, you need to define the config as it follows:

```yaml
override-error:
  rules:
    - errorContains: "no matches for kind"
      appendWith: "This is a custom error message appended to the end of the error message"
```

{{< figure src="/images/plugins/selfServeErrorManagement/appendWith.png" >}}

## Decide what you want to customize

Before you install the plugin, you should decide what exceptions you want to replace or append to. You configure these rules as part of the installation process.

## Install - Spinnaker Operator

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
              Armory.SelfServeErrorManagement :
                enabled: true
                version: <version>
        override-error:
          rules:
            - <your-rules>

```

1. Replace `<version>` with the plugin version that's compatible with your Spinnaker version.
1. Add your list of rules.
1. Add the patch to the `patchesStrategicMerge` section of your kustomization file.
1. Apply your update.

<details><summary>Show an example with filters</summary>

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
              Armory.SelfServeErrorManagement :
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

## Install - Halyard

{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard.
{{% /alert %}}

The Self Serve Error Management Plugin extends CloudDriver. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Add the following to your `clouddriver-local.yml` file:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.SelfServeErrorManagement :
        enabled: true
        version: <version>
    repositories:
      SelfServeErrorManagement :
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
override-error:
  rules:
    - <your-rules>
```

1. Replace `<version>` with the plugin version that's compatible with your Spinnaker version.
1. Add your list of filters.
1. `hal deploy apply` your update.

<details><summary>Show an example with filters</summary>

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.SelfServeErrorManagement :
        enabled: true
        version: 0.1.0
    repositories:
      SelfServeErrorManagement :
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
override-error:
  rules:
    - errorContains: "no matches for kind"
      appendWith: "This is a custom error message appended to the end of the error message"
    - errorContains: "credentials not found"
      replaceWith: "Credentials not found. This is a custom error message."
```

</details></br>

## Release notes

- 0.1.0: Initial release

