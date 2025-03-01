---
title: Kubernetes Custom Resource Status Check Plugin
linkTitle: Kubernetes Custom Resource Status
description: >
  The Kubernetes Custom Resource Status Check Plugin for Armory CD and Spinnaker checks the status of your Custom Resource deployment on Kubernetes.
---

![Proprietary](/images/proprietary.svg)

## Overview of the Kubernetes Custom Resource Status Check Plugin

The Kubernetes Custom Resource Status Check Plugin checks for the status of a Custom Resource deployment by comparing the values set in the properties and
updating the Deploy (Manifest) stage pipeline status. The plugin supports two ways to check for a status in your Custom Resource while deploying using
Armory CD:

1. Kubernetes conditions
2. Any other custom field(s)

The plugin also checks that:

* All the associated replicas have been updated to the latest version you specified, meaning any updates you requested are complete.
* All the replicas associated with the Deployment are available.
* No old replicas for the Deployment are running.

These replica checks are enabled by default and do not require additional configuration.

## Version Compatibility

| Armory CD (Spinnaker) Version | Plugin Version |
|:------------------------------|:---------------|
| 2.36.x (1.36.x)               | 3.1.5          |
| 2.34.x (1.30.x)               | 3.1.4          |
| 2.30 - 2.32 (1.28.x)          | 2.0.5          |

## Breaking change in versions higher than 2.0.4  

**Important**: A config change was introduced to support api groups on Kubernetes kind types to handle duplicate names.  Please update your config to match the documented configuration.  Previous configurations and versions are no longer supported.

## Previous Configuration (before upgrade)

In versions prior to 2.0.5, your configuration for custom resources would look like this:

```yaml
kind:
  Foo:
    stable:
      conditions:
```

## New Configuration (after upgrade)

In version higher than 2.0.4 the configuration for custom resources has changed. You will need to update your configuration as shown below:
```yaml
kind:
  - name: Foo.example.com
    status:
      stable:
        conditions:
```

### Action Required:
To avoid issues with your deployment, you must update your configuration to reflect these changes:

For each custom resource in your configuration, update the kind and status sections according to the new format shown above.
Ensure that the kind corresponds to the correct APIGROUP based on your manifest.

## Configuration

Put the plugin configuration in the `spec.spinnakerConfig.profiles.clouddriver` section of your Operator `spinnakerservice.yml`:

```yaml
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            plugins:
              Armory.K8sCustomResourceStatus:
                enabled: true
                version: <version>
              repositories:
                pluginRepository:
                  url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
```

* `version`: The plugin version that corresponds to your Armory CD version.

## Usage

### Supported Statuses

The plugin uses the following statuses:

* **Stable Deployment**

   By default, you do not need to set the expected `Stable` values in your Custom Resource. The plugin sets the status as **Stable** if you do not set the Stable properties. This means that you can only check for negative values. If you manually set the possible Stable values in the properties, the plugin knows that you explicitly want to check for a status.

* **Failed Deployment**

   By default, the plugin sets the default status to `Stable`. If you want to check for certain failed statuses, you can set them in the properties. When a deployment fails, the Deploy Manifest stage will stop and mark the deployment as Failed.

* **Paused Deployment**

   When a deployment is `Paused`, the stage finishes and the message is rendered in yellow.

* **Unavailable Deployment**

   When a deployment is **Unavailable**, the stage continues to query the status and wait for the deployment to become stable.

### Properties

All supported properties with some example values:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            - name: Foo.example.com # The name of your Custom Resource including API group
              status:
                stable:
                  conditions:
                    - message:
                      reason:
                      status:
                      type:
                    - status:
                      type:
                  fields:
                    - field1: value1
                      field2: value2
                    - item2: valueX
          status:  # Global config
            stable:
              markAsUnavailableUntilStable: false # optional
              failIfNoMatch: false # optional
              conditions:
                - message:
                  reason:
                  status:
                  type:
                - status:
                  type:
              fields:
                - field1: value1
                - field2: value2
            failed:
              conditions:
                - message:
                  reason:
                  status:
                  type:
                - status:
                  type:
              fields:
                - field1: value1
                - field2: value2
            paused:
              conditions:
                - message:
                  reason:
                  status:
                  type:
                - status:
                  type:
              fields:
                - field1: value1
                - field2: value2
            unavailable:
              conditions:
                - message:
                  reason:
                  status:
                  type:
                - status:
                  type:
              fields:
                - field1: value1
                - field2: value2
```

* `markAsUnavailableUntilStable`: (Optional) Only used under `stable` properties. If the plugin doesn't find any of the fields declared under `stable`, it marks the deployment as unavailable and waits for the deployment to become stable. The status changes to stable when the plugin finds any of the fields in the properties.
* `failIfNoMatch`: (Optional) Only used under `stable` properties. In this example, if the plugin doesn't find any of the fields, it marks the deployment as failed.

### Considerations

All values below `config` are optional. You have the flexibility to check for multiple combinations of kinds, statuses, and values.

Under `config`, you can split the statuses per Custom Resource kind or set statuses that apply to all Custom Resources deployed, except the ones you declare by kind.

* If you set any statuses under a specific `kind`, whenever you deploy that `kind`, the plugin checks for those statuses in isolation and not any other values from other kinds or the general list under `status`.
* If you set the statuses under the `status` field, the statuses apply to any Custom Resource you deploy, except any declared kinds in the properties.

Each field under `conditions` is optional. But any condition field you set in the properties must match your manifest conditions in order for the plugin to update the status in your pipeline correctly.

* If you add multiple list items under `conditions`, the plugin updates the status as soon as it finds a match and stops checking any other list items. The plugin does not evaluate any further.
* Each list item under `fields` is a map. Every field per map has to match your expected values in the manifest. If the first map of fields do not match, the plugin proceeds to check the next list item.

### Custom field syntax

Values under `fields` have a custom syntax to access the value from the manifest.

Accepted field formats:

* Simple: `field`
* Nested: `field1.field2.field3`
* Indexed: `field[index]`
* Mapped: `field(key)`
* Combined: `field1.field2[index].field3(key)`

For example, if you want to access the field `ready` with the value `True`:

```yaml
apiVersion: example.com
kind: Foo
metadata:
  generation: 12
  name: bar
spec:
  replicas: 1
status:
  observedGeneration: 12
  values:
    - ready: "True"
```

The syntax is:

```yaml
config:
  kind:
    - name: Foo.example.com
      status:
        available:
          fields:
            - "[status.values.[0].ready]": "True"
```

>`fields` syntax: Make sure you use quotation marks (`"`) and surround the field with brackets `[]` so that the original value is preserved. 

## Examples

### Example 1: Custom Resource following Kubernetes API guidelines with conditions

`kubectl get foo -o yaml`

```yaml
apiVersion: example.com
kind: Foo
metadata:
  generation: 12
  name: bar
spec:
  replicas: 1
status:
  observedGeneration: 12
  conditions:
    - lastTransitionTime: "2020-03-25T21:20:38Z"
      lastUpdateTime: "2020-03-25T21:20:38Z"
      message: Resource is reconciling
      reason: Reconciling
      status: "True"
      type: Reconciling
    - lastTransitionTime: "2020-03-25T21:20:27Z"
      lastUpdateTime: "2020-03-25T21:20:39Z"
      status: "False"
      type: Stalled
```

First map this custom resource's status values to the plugin configuration. The plugin updates the status if the values from the config match the values from your custom resource.

#### Example 1.1: Config per kind

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            - name: Foo.example.com
              status:
                stable:
                  conditions:
                    - message: Resource is Ready
                      reason: ResourceReady
                      status: True
                      type: Ready
                    - status: Pod is stable
                      type: Stable
                failed:
                  conditions:
                    - message: Deployment exceeded its progress deadline
                      reason: ProgressDeadlineExceeded
                      status: "False"
                      type: Progressing
                paused:
                  conditions:
                    - message: Deployment paused
                      reason: DeploymentPaused
                      status: "True"
                      type: Progressing
                unavailable:
                  conditions:
                    - message: Resource is reconciling
                      reason: Reconciling
                      status: "True"
                      type: Reconciling
```

These properties are only for `Foo` kind. Every time you deploy `Foo`, the plugin compares the resource status values against these properties. In this case, the plugin marks the deployment as unavailable since it matches your custom resource.

#### Example 1.2: Global config for all Custom Resources

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          status:
            stable:
              conditions:
                - message: Resource is Ready
                  reason: ResourceReady
                  status: True
                  type: Ready
                - status: Pod is stable
                  type: Stable
            failed:
              conditions:
                - message: Deployment exceeded its progress deadline
                  reason: ProgressDeadlineExceeded
                  status: "False"
                  type: Progressing
            paused:
              conditions:
                - message: Deployment paused
                  reason: DeploymentPaused
                  status: "True"
                  type: Progressing
            unavailable:
              conditions:
                - message: Resource is reconciling
                  reason: Reconciling
                  status: "True"
                  type: Reconciling
```

These properties apply to all custom resource kinds deployed through Spinnaker. If you deploy different kinds with various statuses and haven't configured properties specifically for each kind, the plugin will compare the resource status values against the global properties. In such cases, if the status matches your custom resource, the plugin will mark the deployment accordingly. To ensure specific handling, you should declare properties per kind, as shown in Example 1.1.

### Example 2: Custom Resource with Non-Standard status fields

`kubectl get foo -o yaml`

```yaml
apiVersion: example.com
kind: Foo
metadata:
  generation: 12
  name: bar
spec:
  replicas: 1
status:
  status: Ready
  message: API is ready
  collisionCount: 0
```

First map this custom resource's status value to the plugin configuration. The plugin updates the status if the values from the config match the values from your custom resource.

#### Example 2.1: Config per kind

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            - name: Foo.example.com
              status:
                stable:
                  fields:
                    - status.status: Ready
                      status.message: API is ready
                      status.collisionCount: 0
                failed:
                  fields:
                    - status.ready: False
                      status.collisionCount: 1
                paused:
                  fields:
                    - status.paused: True
                      status.collisionCount: 0
                unavailable:
                  fields:
                    - status.available: False
                      status.collisionCount: 0
```

These properties are only for `Foo` kind. Every time you deploy `Foo`, it compares the resource status values against these properties. In this case, the plugin marks the deployment as ready since that matches your custom resource.

#### Example 2.2: Global config for all Custom Resources

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          status:
            stable:
              fields:
                - status.status: Ready
                  status.message: API is ready
                  status.collisionCount: 0
            failed:
              fields:
                - status.ready: False
                  status.collisionCount: 1
            paused:
              fields:
                - status.paused: True
                  status.collisionCount: 0
            unavailable:
              fields:
                - status.available: False
                  status.collisionCount: 0
```

These properties apply to all custom resource kinds deployed through Spinnaker. If you deploy different kinds with various statuses and haven't configured properties specifically for each kind, the plugin will compare the resource status values against the global properties. In such cases, if the status matches your custom resource, the plugin will mark the deployment accordingly. To ensure specific handling, you should declare properties per kind, as shown in Example 2.1.

## Release Notes

* v1.0.0 Initial release - 09/09/2022
* v2.0.0 Support multiple statuses - 10/28/2022
* v2.0.1 Bug fixes - 10/14/2022
* v2.0.2 Bug fixes - 05/20/2023
* v2.0.3 Adds support with Armory Scale Agent - 06/15/2023
* v2.0.4 Fixing Dockerfile with proper permissions
* v2.0.5 support api groups on Kubernetes kind types
* v2.1.0 Fixes a bug when using partial conditions - 11/07/2023
* v2.2.0 Fixes a bug when the service account has permissions to fetch CRD metadata. Changes configuration format to prevent potential conflicts arising from similar kind names offered by various providers - 10/10/2023
* v3.0.0 Bug fixes: returning stable if fields values match. Compatibility to Spinnaker 1.30.x (Armory 2.30.x) - 08/31/2023
* v3.0.1 Fixes a bug when using partial conditions - 09/07/2023
* v3.1.0 Fixes a bug when the service account has permissions to fetch CRD metadata. Changes configuration format to prevent potential conflicts arising from similar kind names offered by various providers - 10/10/2023
* v3.1.1 fix a bug - default checking condition
* v3.1.3 Fixing Dockerfile with proper permissions
* v3.1.4 Fixing test - add parameter name explicitly 
* v3.1.5 Update plugin to be compatible with Armory Continuous Deployment 2.36.0 and later
