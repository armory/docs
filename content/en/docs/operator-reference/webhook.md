---
title: Webhook Config
weight: 2
description: >
  This page describes `spec.spinnakerConfig.config.webhook`.
aliases:
  - /operator_reference/webhook/
---


## Parameters

**spec.spinnakerConfig.config.webhook**

```yaml
webhook:
  trust:
    enabled: false
    trustStore:
    trustStorePassword:
```

- `trust`:
  - `enabled`: false
  - `trustStore`: The path to a key store in JKS format containing certification authorities that should be trusted by webhook stages. File needs to be present on the machine running Spinnaker.
  - `trustStorePassword`: The password for the supplied trustStore.
