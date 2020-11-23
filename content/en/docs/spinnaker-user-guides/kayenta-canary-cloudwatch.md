---
title: Using Canary Analysis with Cloudwatch
aliases:
  - /spinnaker_user_guides/kayenta_cloudwatch/
  - /docs/spinnaker-user-guides/kayenta_cloudwatch
---

Before you can start using Canary deployments, you need to enable Kayenta, the Spinnaker service for canary deployments. For more information, see [Configuring Kayenta]({{< ref "kayenta-configure" >}}).

## Cloudwatch configuration

To enable Cloudwatch, add the following `cloudwatch` entry and add the supported type `METRICS_STORE` to your aws configuration entry to `kayenta-local.yml`, on this example we are going to configure S3 as Object Storage and Cloudwatch as Metric Store:

```yaml
kayenta:
  aws:
    enabled: true
    accounts:
      - name: monitoring
        bucket: <Your S3 bucket>
        region: us-west-1
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

In your canary stage, set up the canary config you just created. Then use the application values from Cloudwatch to fill in the **Baseline + Canary Pair** and **MetricScope** fields.

![image](/images/user-guides/canary/cloudwatch/canary_stage_cloudwatch.png)
