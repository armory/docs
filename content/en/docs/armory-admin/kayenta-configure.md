---
title: Configuring Kayenta for Automated Canary Deployments
linkTitle: Configuring Canary Deployments
aliases:
  - /spinnaker/configure_kayenta/
  - /docs/spinnaker/configure-kayenta/
---

## Overview

Kayenta is the Spinnaker service that performs Automated Canary Analysis (ACA). The goal of Kayenta is to provide the end user with confidence that a deployment is safe through automation and intelligence. For information about how to use Canary deployments, see [Using Canary deployments]({{< ref "kayenta-canary-use" >}}).

## Configure Kayenta

The open source Spinnaker documentation has a good overview of how to
configure Kayenta using Halyard at
[Set up canary support](https://www.spinnaker.io/setup/canary/).

For Operator, the following example is an equivalent `SpinnakerService` manifest. The example config uses Datadog as a metrics provider and stores canary configs and analysis in a GCS bucket:

```yaml
apiversion: spinnaker.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      canary:
        enabled: true   # Enable/disable canary analysis
        serviceIntegrations:
          - name: google
            enabled: true   # Enable/disable Google provider
            accounts:
            - name: my-google-account
              project: my-project-id       # The Google Cloud Platform project the Canary service uses to consume GCS and Stackdriver.
              jsonPath: gcp-sa.json        # File name of a JSON service account that Spinnaker uses for credentials. This is only needed if Spinnaker is not deployed on a Google Compute Engine VM or needs permissions not afforded to the VM it is running on. See https://cloud.google.com/compute/docs/access/service-accounts for more information. This field supports using "encryptedFile" secret references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/).
              bucket: my-bucket            # The name of a storage bucket that your specified account has access to. If you specify a globally unique bucket name that doesn't exist, Kayenta creates that bucket.
              bucketLocation: us-central-1 # Required if the bucket you specify doesn't exist. In that case, the bucket gets created in that location. See https://cloud.google.com/storage/docs/managing-buckets#manage-class-location.
              rootFolder: kayenta          # The root folder in the chosen bucket to place all of the Canary service's persistent data in (Default: kayenta).
              supportedTypes:              # Array of: METRICS_STORE, CONFIGURATION_STORE, OBJECT_STORE
              - CONFIGURATION_STORE
              - OBJECT_STORE
            gcsEnabled: true               # Whether or not GCS is enabled as a persistent store (Default: false).
            stackdriverEnabled: false      # Whether or not Stackdriver is enabled Stackdriver as a metrics service (Default: false).
            metadataCachingIntervalMS: 60000 # Number of milliseconds to wait between caching the names of available metric types for use in building canary configs. (Default: 60000)
          - name: prometheus
            enabled: false  # Enable/disable Prometheus provider
            accounts:
            - name: my-prometheus-account
              endpoint:
                baseUrl: http://prometheus     # The base URL to the Prometheus server.
              username: my-username            # Basic auth username.
              password: abc                    # Basic auth password. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/).
              usernamePasswordFile: prom-creds # The path to a file containing "username:password". This field supports "encryptedFile" references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/).
              supportedTypes:                  # Array of: METRICS_STORE, CONFIGURATION_STORE, OBJECT_STORE
              - METRICS_STORE
            metadataCachingIntervalMS: 60000   # Number of milliseconds to wait between caching the names of available metric types for use in building canary configs. (Default: 60000)
          - name: datadog
            enabled: true   # Enable/disable Datadog provider
            accounts:
            - name: my-datadog-account
              endpoint:
                baseUrl: https://app.datadoghq.com # The base URL to the Datadog server.
              apiKey: my-api-key                   # Your org's unique Datadog API key. See https://app.datadoghq.com/account/settings#api. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/).
              applicationKey: my-app-key           # Your Datadog application key. See https://app.datadoghq.com/account/settings#api. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/).
              supportedTypes:                      # Array of: METRICS_STORE, METRICS_STORE, OBJECT_STORE
              - METRICS_STORE
          - name: dynatrace
            enabled: true
            accounts:
            - name: my-dynatrace-account
              endpoint:
                baseUrl: https://<your-dynatrace-url>.live.dynatrace.com #You Dynatrace URL
              apiToken: my-api-key                    # Your org apiToken to query Dynatrace
              supportedTypes:
              - METRICS_STORE
          - name: signalfx
            enabled: false    # Enable/disable SignalFx provider
            accounts:
            - name: my-signalfx-account
              endpoint:
                baseUrl: https://stream.signalfx.com # The base URL to the SignalFx server. Defaults to https://stream.signalfx.com
              accessToken: abc                       # The SignalFx access token. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
              defaultScopeKey: abc                   # Scope key used to distinguish between base and canary deployments. If omitted every request must supply the _scope_key param in extended scope params
              defaultLocationKey: abc                # Location key used to filter by deployment region. If omitted requests must supply the _location_key if it is needed.
              supportedTypes:                        # Array of: METRICS_STORE, METRICS_STORE, OBJECT_STORE
              - METRICS_STORE
          - name: aws
            enabled: false    # Enable/disable aws provider
            accounts:
            - name:  my-aws-account
              bucket: my-bucket       # The name of a storage bucket that your specified account has access to. If you specify a globally unique bucket name that doesn't exist, Kayenta creates that bucket for you.
              region: us-west-2       # The region to use.
              rootFolder: kayenta     # The root folder in the chosen bucket to place all of the Canary service's persistent data in (Default: kayenta).
              profileName: default    # The profile name to use when resolving AWS credentials. Typically found in ~/.aws/credentials (Default: default).
              endpoint: http://minio  # The endpoint used to reach the service implementing the AWS api. Typically used with Minio.
              accessKeyId: abc        # The default access key used to communicate with AWS. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
              secretAccessKey: abc    # The secret key used to communicate with AWS. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
              supportedTypes:         # Array of: METRICS_STORE, METRICS_STORE, OBJECT_STORE
              - CONFIGURATION_STORE
              - OBJECT_STORE
            s3Enabled: false          # Whether or not to enable S3 as a persistent store (Default: false).
          - name: newrelic
            enabled: false   # Enable/disable New Relic provider
            accounts:
            - name: my-newrelic-account
              endpoint:
                baseUrl: https://newrelic  # The base URL to the New Relic Insights server.
              apiKey: abc                  # Your account's unique New Relic Insights API key. See https://docs.newrelic.com/docs/insights/insights-api/get-data/query-insights-event-data-api. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
              applicationKey: abc          # Your New Relic account id. See https://docs.newrelic.com/docs/accounts/install-new-relic/account-setup/account-id. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
              supportedTypes:              # Array of: METRICS_STORE, METRICS_STORE, OBJECT_STORE
              - METRICS_STORE
        reduxLoggerEnabled: true           # Whether or not to enable redux logging in the canary module in deck (Default: true).
        defaultJudge: NetflixACAJudge-v1.0 # Name of canary judge to use by default (Default: NetflixACAJudge-v1.0).
        stagesEnabled: true                # Whether or not to enable canary stages in deck (Default: true).
        templatesEnabled: true             # Whether or not to enable custom filter templates for canary configs in deck (Default: true).
        showAllConfigsEnabled: true        # Whether or not to show all canary configs in deck, or just those scoped to the current application (Default: true).
        ...  # rest of config omitted for brevity
    profiles:
      kayenta:         
        kayenta:
          aws:
            enabled: true            # Enable/disable aws provider
            accounts:
              - name: cloudwatch
                region: us-west-2    # The region to use.
                profileName: default # The profile name to use when resolving AWS credentials. Typically found in ~/.aws/credentials (Default: default).
                explicitCredentials:
                  accessKey: abc     # The default access key used to communicate with AWS. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
                  secretKey: abc     # The secret key used to communicate with AWS. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
                supportedTypes:      # Array of: METRICS_STORE, METRICS_STORE, OBJECT_STORE
                  - METRICS_STORE
          cloudwatch:
            enabled: true            # Whether or not Cloudwatch is enabled, Cloudwatch as a metrics service (Default: false).
    files:
      gcp-sa.json: |
        <JSON CONTENT HERE. WATCH YOUR SPACING>
```
> **Note**: You can delete all disabled provider sections.