---
title: Use Canary Analysis with Dynatrace in Spinnaker
linkTitle: Use Canary Analysis with Dynatrace
aliases:
  - /spinnaker_user_guides/kayenta_dynatrace/
  - /docs/spinnaker-user-guides/kayenta_dynatrace
description: >
  Learn how to configure and use Dynatrace for canary analysis in Spinnaker.
---
![Proprietary](/images/proprietary.svg)

{{< include "user-guide/canary/config-kayenta-frag.md" >}}


## Dynatrace configuration

To enable Dynatrace, add the following `dynatrace` entry to `kayenta-local.yml`:

```yaml
kayenta:
  dynatrace:
    enabled: true
    accounts:
    - name: my-dynatrace-account
      endpoint:
        baseUrl: <Your Dynatrace url> https://xxxxxxxx.live.dynatrace.com
      apiToken: <Your Dynatrace apiToken>
      supportedTypes:
      - METRICS_STORE
```

## Canary configs

In the UI, you need to create a new canary config for the metrics you are interested in.

![image](/images/user-guides/canary/canary_config_dynatrace.png)


Add your Dynatrace query in the **Dynatrace USQL** field.

![image](/images/user-guides/canary/canary_config_dynatrace_query.png)


## Pipeline configs

In your canary stage, set up the canary config you just created. Then use the application values from Dynatrace to fill in the **Baseline + Canary Pair** and **MetricScope** fields.

![image](/images/user-guides/canary/canary_stage_dynatrace.png)