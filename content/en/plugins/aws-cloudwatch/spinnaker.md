---
title: Install and Use the AWS CloudWatch Metrics Plugin in Spinnaker
linkTitle: Spinnaker Install
description: >
  Install and use the AWS CloudWatch Metrics Plugin in your Spinnaker instance.
---


## {{% heading "prereq" %}}

You should enable canary analysis support and be familiar with using canary analysis in Spinnaker. See the following Spinnaker Docs guides:

* [Set up Canary Analysis Support](https://spinnaker.io/docs/setup/other_config/canary/) (Halyard)
* [Canary Overview](https://spinnaker.io/docs/guides/user/canary/canary-overview/) 
* [Configure a canary](https://spinnaker.io/docs/guides/user/canary/config/canary-config/)
* [Add a canary stage to a pipeline](https://spinnaker.io/docs/guides/user/canary/stage/)

## Enable AWS CloudWatch as a metrics store

{{< readfile "/plugins/aws-cloudwatch/files/enable-cloudwatch-as-metrics.md" >}}

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

## Use AWS CloudWatch

{{< readfile "/plugins/aws-cloudwatch/files/use-aws-cloudwatch.md" >}}