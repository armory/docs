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
| 2.0.0  | 1.27.x, 1.28.x     | 2.27.x, 2.28.x            |

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
                version: 2.0.0
              repositories:
                pluginRepository:
                  url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
```

## Usage

The plugin checks for any of the statuses the user has set in the properties and will update the Deploy (Manifest) stage
pipeline accordingly. The plugin supports two ways to check for a Status in your Custom Resource while deploying using
Spinnaker:

1. Kubernetes Conditions.
2. Any other custom field(s).

The plugin also checks that:

* All the replicas associated have been updated to the latest version you've specified, meaning any updates you've
  requested have been completed.
* All the replicas associated with the Deployment are available.
* No old replicas for the Deployment are running.

### Properties

The plugin supports checking the following statuses:

* Stable Deployment
* Failed Deployment
* Paused Deployment
* Unavailable Deployment

### Property structure

Under `config`, you can split the statuses per kind or set statuses that apply to any Custom Resource.

* If you set any statuses under a specific `kind`, whenever you deploy that `kind`, the plugin will check for those
  statuses in isolation and not any other values from other kinds or the general list under `status`.
* When setting statuses per `kind`, use the full kind name `kind`+ `.`+`apiVersion` if your Manifest has
  the `apiVersion`
  field.

Example Custom Resource Manifest

```yaml
apiVersion: "stable.example.com/v1"
kind: CronTab
metadata:
  name: my-new-cron-object
spec:
  cronSpec: "* * * * */5"
  image: my-awesome-cron-image
```

Using this Custom Resource, your properties should use the full name since it has the `apiVersion`

```yaml
config:
  kind:
    CronTab.stable.example.com/v1: # The name of your Custom Resource
      failed:
```

If you do not have `apiVersion`, the concatenation is not needed.

```yaml
config:
  kind:
    CronTab: # The name of your Custom Resource
      failed:
```

* If you set the statuses under the `status` field, the statuses will apply to any Custom Resource you deploy, except
  any declared kinds in the properties.
* Each field under `conditions` is optional. But any condition field you set in the properties, has to match your
  manifest conditions.
* If you add multiple list items under `conditions`, it will update the status as soon as it finds a match and stop
  checking any other list items. It will not evaluate any further.
* Each list item under `fields` is a map. Every field per map has to match your expected values in the manifest. If the
  first map of fields do not match, it will proceed to check the next list item.

Full properties:

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

#### Stable Deployment

You can check if your Custom Resource deployment is Stable in the following ways:

1. By default, you do not need to set the expected `Stable` values in your Custom Resource. The plugin will set the
   status as Stable if you do not set the Stable properties.
2. Manually setting the possible Stable values in the properties. This will let the plugin know that you explicitly want
   to check for a status.

##### Example 1: Explicitly check for a Stable status using Kubernetes Conditions:

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
                - message: Resource is stable
                  reason: NewReplicaSetAvailable
                  status: "True"
                  type: Progressing
                - status: "False"
                  type: Stalled
```

In this example, the plugin will check if the Manifest has any of the following conditions from the list, if it matches
with one, it will mark the deployment as `Stable`.

##### Example 2: Explicitly check for a Stable status using Custom Fields:

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
                - status.ready: True
                  status.collisionCount: 0
```

In this example, the plugin will check if the Manifest has any of the following conditions, if it matches with one, it
will mark the deployment as `Stable`.

##### Example 3: Explicitly check for a Stable status using Conditions & Custom Fields per Kind:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            CronTab:
              stable:
                conditions:
                  - message: Resource is stable
                    reason: NewReplicaSetAvailable
                    status: "True"
                    type: Progressing
                  - status: "False"
                    type: Stalled
                fields:
                  - status.ready: True
                    status.collisionCount: 0
```

You can also set statuses per CRD `kind`. In this example, `CronTab` is the CRD kind, and we are specifying and
isolating
the statuses only for CronTab. These statuses will not be checked in when deploying other Custom Resources. When
deploying a `CronTab`, it will only check for the statuses under the `CronTab` properties map.

#### Failed Deployment

By default, the plugin sets the default status to `Stable`. If you want to check for certain failed statuses, you
can set them in the properties. When a deployment fails, the Deploy Manifest stage will stop and mark the deployment as
Failed.

##### Example 1: Check for a Failed status using Kubernetes Conditions:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          status:
            failed:
              conditions:
                - message: Deployment exceeded its progress deadline
                  reason: ProgressDeadlineExceeded
                  status: "False"
                  type: Progressing
```

##### Example 2: Check for a Failed status using Custom Fields:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          status:
            failed:
              fields:
                - status.ready: False
                  status.collisionCount: 1
```

##### Example 3: Check for a Failed status using Conditions & Custom Fields per Kind:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            CronTab:
              failed:
                conditions:
                  - message: Deployment exceeded its progress deadline
                    reason: ProgressDeadlineExceeded
                    status: "False"
                    type: Progressing
                  - status: "True"
                    type: Stalled
                fields:
                  - status.ready: False
                    status.collisionCount: 1
```

You can also set statuses per CRD `kind`. In this example, `CronTab` is the CRD kind, and we are specifying and
isolating
the statuses only for CronTab. These statuses will not be checked in when deploying other Custom Resources. When
deploying a `CronTab`, it will only check for the statuses under the `CronTab` properties map.

#### Paused Deployment

When a deployment is `Paused`, the stage will finish and the message will be yellow colored.

##### Example 1: Check for a Paused status using Kubernetes Conditions:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          status:
            paused:
              conditions:
                - message: Deployment paused
                  reason: DeploymentPaused
                  status: "True"
                  type: Progressing
```

##### Example 2: Check for a Paused status using Custom Fields:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          status:
            paused:
              fields:
                - status.paused: False
                  status.collisionCount: 0
```

##### Example 3: Explicitly check for a Stable status using Conditions & Custom Fields per Kind:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            CronTab:
              failed:
                conditions:
                  - message: Resource unreachable
                    reason: NewReplicaSetAvailable
                    status: "False"
                    type: Progressing
                  - status: "True"
                    type: Stalled
                fields:
                  - status.paused: False
```

#### Unavailable Deployment

When a deployment is `Unavailable`, the stage continue to query the status and wait for the deployment to become stable.

##### Example 1: Check for a Paused status using Kubernetes Conditions:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          status:
            unavailable:
              conditions:
                - message: Deployment unavailable
                  reason: NotAvailable
                  status: "True"
                  type: Progressing
```

##### Example 2: Check for a Paused status using Custom Fields:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          status:
            paused:
              fields:
                - status.available: False
                  status.collisionCount: 0
```

##### Example 3: Explicitly check for a Stable status using Conditions & Custom Fields per Kind:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.K8sCustomResourceStatus:
        enabled: true
        config:
          kind:
            CronTab:
              failed:
                conditions:
                  - message: Deployment unavailable
                    reason: NotAvailable
                    status: "True"
                    type: Progressing
                  - status: "False"
                    type: Stalled
                fields:
                  - status.available: False
```

## Release Notes

* v1.0.0 Initial release - 09/09/2022
* v2.0.0 Support multiple statuses - 28/10/2022
