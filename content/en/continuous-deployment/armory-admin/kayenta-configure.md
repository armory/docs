---
title: Configure Automated Canary Deployments in Spinnaker
linkTitle: Configure Canary Deployments
aliases:
  - /spinnaker/configure_kayenta/
  - /docs/spinnaker/configure-kayenta/
description: >
  Learn how to configure Kayenta using the Armory Operator.
---

## Kayenta Overview

Kayenta is the Spinnaker service that performs automated canary analysis. The goal of Kayenta is to provide you with confidence that a deployment is safe through automation and intelligence. 

## Enable Kayenta

Add the following to your  `SpinnakerService` manifest:

```yaml
spec:
  spinnakerConfig:
    config:
      canary:
        enabled: true   # Enable/disable canary analysis
```

## Configure Kayenta

The following example is a `SpinnakerService` manifest. The example config uses Datadog as the metrics provider and stores canary configs and analysis in a GCS bucket:

```yaml
apiversion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      canary:
        enabled: true   # Enable/disable canary analysis
        serviceIntegrations:
          - name: datadog
            enabled:
            accounts:
            - name: test-account
              endpoint:
                baseUrl: <some-URL> # The base URL to the Datadog server.
              apiKey: <encrypted-secret> # Your org’s unique Datadog API key. See https://app.datadoghq.com/account/settings#api. Supports encrypted value.
              applicationKey: <encrypted-secret> #Your Datadog application key. See https://app.datadoghq.com/account/settings#api. Supports encrypted value.
              supportedTypes:
              - METRICS_STORE
              - CONFIGURATION_STORE
              - OBJECT_STORE
          - name: google
            enabled: true   # Enable/disable Google provider
            accounts:
            - name: my-google-account
              project: my-project-id       # The Google Cloud Platform project the Canary service uses to consume GCS and Stackdriver.
              jsonPath: gcp-sa.json        # File name of a JSON service account that Spinnaker uses for credentials. This is only needed if Spinnaker is not deployed on a Google Compute Engine VM or needs permissions not afforded to the VM it is running on. See https://cloud.google.com/compute/docs/access/service-accounts for more information. This field supports using "encryptedFile" secret references.
              bucket: my-bucket            # The name of a storage bucket that your specified account has access to. If you specify a globally unique bucket name that doesn't exist, Kayenta creates that bucket.
              bucketLocation: us-central-1 # Required if the bucket you specify doesn't exist. In that case, the bucket gets created in that location. See https://cloud.google.com/storage/docs/managing-buckets#manage-class-location.
              rootFolder: kayenta          # The root folder in the chosen bucket to place all of the Canary service's persistent data in (Default: kayenta).
              supportedTypes:              # Array of: METRICS_STORE, CONFIGURATION_STORE, OBJECT_STORE
              - CONFIGURATION_STORE
              - OBJECT_STORE
            gcsEnabled: true               # Whether or not GCS is enabled as a persistent store (Default: false).
            stackdriverEnabled: false      # Whether or not Stackdriver is enabled Stackdriver as a metrics service (Default: false).
            metadataCachingIntervalMS: 60000 # Number of milliseconds to wait between caching the names of available metric types for use in building canary configs. (Default: 60000)
        reduxLoggerEnabled: true           # Whether or not to enable redux logging in the canary module in deck (Default: true).
        defaultJudge: NetflixACAJudge-v1.0 # Name of canary judge to use by default (Default: NetflixACAJudge-v1.0).
        stagesEnabled: true                # Whether or not to enable canary stages in deck (Default: true).
        templatesEnabled: true             # Whether or not to enable custom filter templates for canary configs in deck (Default: true).
        showAllConfigsEnabled: true        # Whether or not to show all canary configs in deck, or just those scoped to the current application (Default: true).
        ...  # rest of config omitted for brevity
    files:
      gcp-sa.json: |
        <JSON CONTENT HERE. WATCH YOUR SPACING>
```

For information about how to configure other providers see [Canary Config]({{< ref "continuous-deployment/installation/armory-operator/op-manifest-reference/canary-op-config" >}}) unless you use Dynatrace or AWS CloudWatch. If you use one of those as the metrics provider, see [Use Canary Analysis with Dynatrace]({{< ref "continuous-deployment/spinnaker-user-guides/canary/kayenta-canary-dynatrace" >}}) or the [AWS CloudWatch Metrics Plugin]({{< ref "plugins/aws-cloudwatch/overview.md" >}}).


## {{% heading "nextSteps" %}}

For information about how to use canary deployments, see {{< linkWithTitle "continuous-deployment/spinnaker-user-guides/canary/kayenta-canary-use" >}}.