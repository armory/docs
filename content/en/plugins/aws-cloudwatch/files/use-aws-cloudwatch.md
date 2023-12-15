
### Create a canary config

In the UI, you need to create a new canary config for the metrics you are interested in.

{{< figure src="plugins/aws-cloudwatch/files/canary_config_cloudwatch.png"  height="80%" width="80%" >}}

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

{{< figure src="plugins/aws-cloudwatch/files/canary_config_cloudwatch_query.png" height="80%" width="80%" >}}

### Update pipeline configs

In your canary stage, set up the canary config you just created. Then use the app values from AWS CloudWatch to fill in the **Baseline + Canary Pair** and **MetricScope** fields.

{{< figure src="plugins/aws-cloudwatch/files/canary_stage_cloudwatch.png"  height="80%" width="80%" >}}