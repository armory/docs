---
title: Using Canary Analysis with Dynatrace
aliases:
  - /spinnaker_user_guides/kayenta_dynatrace/
  - /docs/spinnaker-user-guides/kayenta_dynatrace
---


Before you can start using Canary deployments, ensure that Kayenta, the Spinnaker for canary deployments, is enabled. For more information, see [Configuring Kayenta]({{< ref "kayenta-configure" >}}).


## Dynatrace configuration
To enable dynatrace currently you need to do this on kayenta-local.yml

```
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

You need to create a new canary-config for the metrics you are interested.

![image](/images/canary_config_dynatrace.png)


Add your dynatrace query into the inline configuration.

![image](/images/canary_config_dynatrace_query.png)


## Pipeline configs

On your canary stage setup the same canary-config you just created. Then setup your namespace and scope corresponding to your application values in dynatrace.

![image](/images/canary_stage_dynatrace.png)