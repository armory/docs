---
title: K8s Custom Resource Status Check Plugin
toc_hide: true
exclude_search: true
description: >
  This plugin checks the Status of a Custom Resource Deployment
---
<!-- this is a private plugin. It is also hidden via robots.txt and the netlify sitemap plugin. -->
![Proprietary](/images/proprietary.svg)

## Version Compatibility

| Plugin | Spinnaker Platform | Armory Spinnaker Platform |
|:-------|:-------------------|:--------------------------|
| 1.0.0  | 1.27.x, 1.28.x     | 2.27.x, 2.28.x            |
| 2.0.x  | 1.27.x, 1.28.x     | 2.27.x, 2.28.x            |

## Configuration

Example configuration using the Spinnaker Operator for `clouddriver` service:

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
            plugins:
              Armory.K8sCustomResourceStatus:
                enabled: true
                version: 2.0.1
              repositories:
                pluginRepository:
                  url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
```

## Usage

The plugin checks for the status of a Custom Resource deployment by comparing the values set in the properties and
updating the Deploy (Manifest) stage
pipeline status. The plugin supports two ways to check for a Status in your Custom Resource while deploying using
Spinnaker:

1. Kubernetes Conditions.
2. Any other custom field(s).

The plugin will also check:

* All the replicas associated have been updated to the latest version you've specified, meaning any updates you've
  requested have been completed.
* All the replicas associated with the Deployment are available.
* No old replicas for the Deployment are running.

These replica checks are enabled by default with the plugin and do not require additional configuration.

### Supported Statuses

The plugin supports the following statuses:

* **Stable Deployment**
  1. By default, you do not need to set the expected `Stable` values in your Custom Resource. The plugin will set the
     status as Stable if you do not set the Stable properties. This means that you can only check for negative values.
  2. Manually setting the possible Stable values in the properties. This will let the plugin know that you explicitly
     want
     to check for a status.
* **Failed Deployment**
  * By default, the plugin sets the default status to `Stable`. If you want to check for certain failed statuses, you
    can set them in the properties. When a deployment fails, the Deploy Manifest stage will stop and mark the deployment
    as
    Failed.
* **Paused Deployment**
  * When a deployment is `Paused`, the stage will finish and the message will be yellow colored.
* **Unavailable Deployment**
  * When a deployment is `Unavailable`, the stage continue to query the status and wait for the deployment to become
    stable.

## Properties

All supported properties with some example values:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            my-kind: # The name of your Custom Resource
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
          status:
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

* `markAsUnavailableUntilStable` (optional): Only used under `stable` properties. If it doesn't find any of the fields
  declared under `stable`, it will mark
  the deployment as
  unavailable and wait for the deployment to become stable. It will become stable until it finds any of the fields in
  the properties.
* `failIfNoMatch` (optional): Only used under `stable` properties. In this example, if it doesn't find any of the
  fields, it will mark the deployment as
  failed.

### Considerations

All values below `config` are optional. You have the flexibility to check for multiple combinations of kinds, statuses
and values.

Under `config`, you can split the statuses per Custom Resource kind or set statuses that apply to all Custom Resources
deployed, except the ones you declare by kind.

* If you set any statuses under a specific `kind`, whenever you deploy that `kind`, the plugin will check for those
  statuses in isolation and not any other values from other kinds or the general list under `status`.
* If you set the statuses under the `status` field, the statuses will apply to any Custom Resource you deploy, except
  any declared kinds in the properties.

Each field under `conditions` is optional. But any condition field you set in the properties, has to match your
manifest conditions for the plugin to update the status in your pipeline correctly.

* If you add multiple list items under `conditions`, it will update the status as soon as it finds a match and stop
  checking any other list items. It will not evaluate any further.
* Each list item under `fields` is a map. Every field per map has to match your expected values in the manifest. If the
  first map of fields do not match, it will proceed to check the next list item.

### Custom field syntax

Values under `fields` have a custom syntax to access the value from the Manifest.

Accepted field formats:

* Simple: `field`
* Nested: `field1.field2.field3`
* Indexed: `field[index]`
* Mapped: `field(key)`
* Combined: `field1.field2[index].field3(key)`

For example, if you want to access the field `ready` with the value `True`.

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

The syntax would be:

```yaml
config:
  kind:
    status:
      available:
        fields:
          - status.values.[0].ready: "True"
```

## Examples

### Example 1: Custom Resource following Kubernetes API Guideline with conditions

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

Let's map this custom resource status values to the plugin configuration. The plugin will update the status if the
values from the config match with the values from our custom resource.

#### Example 1.1: Config per kind

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            Foo: # Foo is the name of your Custom Resource kind
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

These properties are only for `Foo` kind. Every time you deploy `Foo`, it will compare the resource status values
against these properties. In this case, it will mark the deployment as unavailable since it matches our custom resource.

#### Example 1.2: Config for all Custom Resources

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

These properties apply to all custom resource kinds you deploy. If you deploy different kinds with different statuses,
you should declare per kind like in `Example 1.1`. In this case, it will mark the deployment as unavailable since it
matches our custom resource.

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

Let's map this custom resource status values to the plugin configuration. The plugin will update the status if the
values from the config match with the values from our custom resource.

#### Example 2.1: Config per kind

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            Foo: # The name of your Custom Resource
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

These properties are only for `Foo` kind. Every time you deploy `Foo`, it will compare the resource status values
against these properties. In this case, it will mark the deployment as ready since it matches our custom resource.

#### Example 2.2: Config for all Custom Resources

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

These properties apply to all custom resource kinds you deploy. If you deploy different kinds with different statuses,
you should declare per kind like in `Example 2.1`. In this case, it will mark the deployment as ready since it
matches our custom resource.

## Release Notes

* v1.0.0 Initial release - 09/09/2022
* v2.0.0 Support multiple statuses - 10/28/2022
* v2.0.1 Bug fixes - 10/14/2022
