---
title: CloudWatch Metrics Plugin
linkTitle: CloudWatch Metrics
description: >
  The CloudWatch Metrics Plugin allows users to use AWS CloudWatch as a metric provider for the canary deployments
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## What the CloudWatch Metrics plugin does

The CloudWatch Metrics Plugin allows users to use AWS CloudWatch as a metric provider for the canary deployments.

Installing the plugin consists of the following:
1. [CloudWatch Configuration](#cloudWatch-configuration)
1. Install in your Spinnaker instance:
   * [Spinnaker managed by the Spinnaker Operator](#install---spinnaker-operator)
   * [Spinnaker managed by Halyard](#install---halyard)

## Compatiblity matrix

| Spinnaker Version | CloudWatch Metrics Plugin Version |
|-------------------|-----------------------------------|
| 1.33.x            | 0.1.0                             |


## CloudWatch configuration

To enable [CloudWatch](https://aws.amazon.com/cloudwatch/), update the AWS configuration entry in your `kayenta-local.yml` file. Make sure `METRICS_STORE` is listed under `supportedTypes`. Add the `cloudwatch` entry with `enabled: true`.

The example below uses S3 as the object store and CloudWatch as the metrics store.

```yaml
kayenta:
  aws:
    enabled: true
    accounts:
      - name: monitoring
        bucket: <your-s3-bucket>
        region: <your-region>
        # Kayenta can assume a role when connecting to Cloudwatch using the iamRole configs
        # iamRoleArn: <your-role-ARN> # For example arn:aws:iam::042225624470:role/theRole
        # iamRoleExternalId: Optional. For example 12345
        # iamRoleArnTarget: <your-role-ARN-target> # For example arn:aws:iam::042225624470:role/targetcloudwatchaccount
        # iamRoleExternalIdTarget: <your-ExternalID> # Optional. For example 84475
        rootFolder: kayenta
        roleName: default
        supportedTypes:
          - OBJECT_STORE
          - CONFIGURATION_STORE
          - METRICS_STORE
  cloudwatch:
    enabled: true
  s3:
    enabled: true
```

## Canary configs

In the UI, you need to create a new canary config for the metrics you are interested in.

{{< figure src="/images/user-guides/canary/cloudwatch/canary_config_cloudwatch.png" >}}

Add your Cloudwatch MetricStat JSON in the **Template** field.

```json
{
    "Metric": {
        "Namespace": "kayenta",
        "MetricName": "integration.test.cpu.value",
        "Dimensions": [
            {
                "Name": "scope",
                "Value": "myapp-prod-canary-2"
            },
            {
                "Name": "namespace",
                "Value": "prod-namespace-2"
            }
        ]
    },
    "Period": 300,
    "Stat": "Average",
    "Unit": "None"
}
```

{{< figure src="/images/user-guides/canary/cloudwatch/canary_config_cloudwatch_query.png" >}}

## Pipeline configs

In your canary stage, set up the canary config you just created. Then use the application values from CloudWatch to fill in the **Baseline + Canary Pair** and **MetricScope** fields.

{{< figure src="/images/user-guides/canary/cloudwatch/canary_stage_cloudwatch.png" >}}

## Install - Spinnaker Operator

Add a Kustomize patch with the following contents:

```yaml
spec:
  spinnakerConfig:
    profiles:
      kayenta:
        spinnaker:
          extensibility:
            plugins:
              Armory.CloudWatch:
                enabled: true
                version: <version>
            repositories:
              cloudwatch:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
        kayenta:
          aws:
            enabled: true
            accounts:
          cloudwatch:
            enabled: true
```

1. Replace `<version>` with the plugin version that's compatible with your Spinnaker version. 
1. Enable AWS CloudWatch as a metric store.
1. Add the patch to the `patchesStrategicMerge` section of your kustomization file. 
1. Apply your update.

<details><summary>Show an example with CloudWatch Configured</summary>

```yaml
spec:
  spinnakerConfig:
    profiles:
      kayenta:
        spinnaker:
          extensibility:
            plugins:
              Armory.CloudWatch:
                enabled: true
                version: 0.1.0
            repositories:
              cloudwatch:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
        kayenta:
          aws:
            enabled: true
            accounts:
              - name: monitoring
                bucket: <your-s3-bucket>
                region: <your-region>
                # Kayenta can assume a role when connecting to Cloudwatch using the iamRole configs
                # iamRoleArn: <your-role-ARN> # For example arn:aws:iam::042225624470:role/theRole
                # iamRoleExternalId: Optional. For example 12345
                # iamRoleArnTarget: <your-role-ARN-target> # For example arn:aws:iam::042225624470:role/targetcloudwatchaccount
                # iamRoleExternalIdTarget: <your-ExternalID> # Optional. For example 84475
                rootFolder: kayenta
                roleName: default
                supportedTypes:
                  - OBJECT_STORE
                  - CONFIGURATION_STORE
                  - METRICS_STORE
          cloudwatch:
            enabled: true
          s3:
            enabled: true
```
</details></br>

Alternately, add the plugin configuration in the `spec.spinnakerConfig.profiles.kayenta` section of your `spinnakerservice.yml` and then apply your update.

## Install - Halyard

{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. 
{{% /alert %}}

The CloudWatch Metrics Plugin extends Kayenta. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Add the following to your `kayenta-local.yml` file:

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.CloudWatch:
        enabled: true
        version: <version>
    repositories:
      cloudwatch:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
kayenta:
  aws:
    enabled: true
    accounts:
  cloudwatch:
    enabled: true
```

1. Replace `<version>` with the plugin version that's compatible with your Spinnaker version.
1. Enable AWS CloudWatch as a metric store.
1. `hal deploy apply` your update.

<details><summary>Show an example with CloudWatch Configured</summary>

```yaml
spinnaker:
  extensibility:
    plugins:
      Armory.CloudWatch:
        enabled: true
        version: 0.1.0
    repositories:
      cloudwatch:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
kayenta:
  aws:
    enabled: true
    accounts:
      - name: monitoring
        bucket: <your-s3-bucket>
        region: <your-region>
        # Kayenta can assume a role when connecting to Cloudwatch using the iamRole configs
        # iamRoleArn: <your-role-ARN> # For example arn:aws:iam::042225624470:role/theRole
        # iamRoleExternalId: Optional. For example 12345
        # iamRoleArnTarget: <your-role-ARN-target> # For example arn:aws:iam::042225624470:role/targetcloudwatchaccount
        # iamRoleExternalIdTarget: <your-ExternalID> # Optional. For example 84475
        rootFolder: kayenta
        roleName: default
        supportedTypes:
          - OBJECT_STORE
          - CONFIGURATION_STORE
          - METRICS_STORE
  cloudwatch:
    enabled: true
  s3:
    enabled: true
```

</details></br>

## Release notes

- 0.1.0: Initial release

