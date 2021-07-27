---
title: Use Canary Analysis with AWS CloudWatch
description: >
  Learn how to configure and use AWS CloudWatch for canary analysis in Spinnaker.
---
![Proprietary](/images/proprietary.svg)
{{< include "user-guide/canary/config-kayenta-frag.md" >}}

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

![image](/images/user-guides/canary/cloudwatch/canary_config_cloudwatch.png)

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

![image](/images/user-guides/canary/cloudwatch/canary_config_cloudwatch_query.png)

## Pipeline configs

In your canary stage, set up the canary config you just created. Then use the application values from CloudWatch to fill in the **Baseline + Canary Pair** and **MetricScope** fields.

![image](/images/user-guides/canary/cloudwatch/canary_stage_cloudwatch.png)
