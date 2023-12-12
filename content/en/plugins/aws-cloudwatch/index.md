---
title: AWS CloudWatch Metrics Plugin
linkTitle: AWS CloudWatch Metrics
description: >
  The AWS CloudWatch Metrics Plugin for Spinnaker allows you to use AWS CloudWatch as a metrics provider for your canary deployments.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## What the AWS CloudWatch Metrics plugin does

The AWS CloudWatch Metrics Plugin allows you to use AWS CloudWatch as a metrics provider for your canary deployments.

## {{% heading "prereq" %}}

{{< tabpane text=true right=true >}}
{{% tab header="**Platform**:" disabled=true /%}}
{{% tab header="Spinnaker" %}}

You should enable canary analysis support and be familiar with canary analysis in Spinnaker. See the following Spinnaker Docs guides:

* [Set up Canary Analysis Support](https://spinnaker.io/docs/setup/other_config/canary/) (Halyard)
* [Canary Overview](https://spinnaker.io/docs/guides/user/canary/canary-overview/) 
* [Configure a canary](https://spinnaker.io/docs/guides/user/canary/config/canary-config/)
* [Add a canary stage to a pipeline](https://spinnaker.io/docs/guides/user/canary/stage/)

{{% /tab %}}
{{% tab header="Armory CD" %}}

Before you can start using canary deployments, you need to enable Kayenta, the Spinnaker<sup>TM</sup> service for canary deployments. For more information, see the {{< linkWithTitle "continuous-deployment/armory-admin/kayenta-configure.md" >}} guide.

{{% /tab %}}
{{< /tabpane >}}

## Installation paths

{{% cardpane %}}
{{% card header="Armory CD" %}}

Armory CD includes the AWS Cloudwatch Metrics Plugin. You do not have to install it. 

1. [Enable AWS CloudWatch](#enable-aws-cloudwatch) as a metrics provider.
1. [Use AWS CloudWatch](#use-aws-cloudwatch) in your pipeline.

{{% /card %}}

{{% card header="Spinnaker" %}}

1. [Install the plugin](#install-the-plugin-in-spinnaker) in Spinnaker using the Spinnaker Operator or Halyard.
1. [Enable AWS CloudWatch](#enable-aws-cloudwatch) as a metrics provider.
1. [Use AWS CloudWatch](#use-aws-cloudwatch) in your pipeline.

{{% /card %}}

{{% /cardpane %}}


## Spinnaker compatibility matrix

| Spinnaker Version | AWS CloudWatch Metrics Plugin Version |
|-------------------|-----------------------------------|
| 1.33.x            | 0.1.0                             |


## Install the plugin in Spinnaker


{{< tabpane text=true right=true >}}
{{% tab header="**Install Method**:" disabled=true /%}}
{{% tab header="Spinnaker Operator" %}}

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
{{% /tab %}}

{{% tab header="Spinnaker Halyard"%}}

>When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. 


The AWS CloudWatch Metrics Plugin extends Kayenta. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

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

{{% /tab %}}
{{< /tabpane >}}

## Enable AWS CloudWatch

To enable [AWS CloudWatch](https://aws.amazon.com/cloudwatch/), update the AWS configuration entry in your `kayenta-local.yml` file. Make sure `METRICS_STORE` is listed under `supportedTypes`. Add the `cloudwatch` entry with `enabled: true`.

This example uses S3 as the object store and CloudWatch as the metrics store.

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

## Use AWS CloudWatch

### Create a canary config

In the UI, you need to create a new canary config for the metrics you are interested in.

{{< figure src="canary_config_cloudwatch.png"  height="80%" width="80%" >}}

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

{{< figure src="canary_config_cloudwatch_query.png" height="80%" width="80%" >}}

### Update pipeline configs

In your canary stage, set up the canary config you just created. Then use the app values from AWS CloudWatch to fill in the **Baseline + Canary Pair** and **MetricScope** fields.

{{< figure src="canary_stage_cloudwatch.png" >}}

## Release notes

- 0.1.0: Initial release

