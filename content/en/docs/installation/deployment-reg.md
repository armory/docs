---
title: Deployment Registration
description: Register your Armory Enterprise deployment so that it can communicate with Armory services. 
exclude_search: true
toc_hide: true
---
<!--Several shortlinks point to this page from Deck:
- go.armory.io/UIdocs-deploy-reg points to the top of this page
- go.armory.io/UIdocs-deploy-reg-troubleshooting points to Troubleshooting
- go.armory.io/UIdocs-deploy-reg-manual-id points to the Operator fails to generate an instance ID section
-->

## Overview

As part of the configuration process, you need to register your instance with Armory.

## Register your environment

1. Navigate to the URL provided by Armory and follow the instructions to create an account.
2. Make note of the following information:
  - Instance ID
  - Client ID
  - Secret
   > This is the only time you are shown the secret value. Store it somewhere safe.

## Apply the registration information

In your Operator manifest (such as `spinnakerService.yml`) or `spinnaker-local` file (Halyard), configure the following parameters:
  - `spec.spinnakerConfig.profiles.spinnaker.”armory.cloud”.iam.tokenIssueUrl`: set this value to `https://auth.cloud.armory.io/oauth/token`.
  - `spec.spinnakerConfig.profiles.spinnaker.”armory.cloud”.iam.clientID`: set this value to **Client ID** that you received from [Get your registration information](#get-your-registration-information)
  - `spec.spinnakerConfig.profiles.spinnaker.”armory.cloud”.iam.clientSecret`: set this value to the **Secret** that you received from [Get your registration information](#get-your-registration-information).

Once you apply the registration information to your environment, communication between your Armory Enterprise environment and Armory Cloud is enabled. The communication allows certain Armory Enterprise features, such as the K8s Progressive Deployments plugin, to function.

{{< tabs name="Configure Armory Enterprise" >}}
{{% tab name="Operator" %}}

```yaml
spec:
  spinnakerConfig:
    profiles:
      # Global Settings
      spinnaker:
        armory.cloud:
          enabled: true
          iam:
            tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
            clientId: <clientId>
            clientSecret: <clientSecret>
          api:
            baseUrl: https://api.cloud.armory.io
          hub:
            baseUrl: https://api.cloud.armory.io/agents
            grpc:
              host: agents.cloud.armory.io
              port: 443
              tls:
                insecureSkipVerify: true
          deployEngineGrpc:
            host: grpc.deploy.cloud.armory.io
            port: 443
```

Save the file and apply the manifest. Applying the config changes redeploys Armory Enterprise.

{{% /tab %}}

{{% tab name="Halyard" %}}

```yaml

#spinnaker-local
armory.cloud:
  enabled: true
  iam:
    tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
    clientId: <clientId>
    clientSecret:<clientSecret>
  api:
    baseUrl: https://api.cloud.armory.io
  hub:
    baseUrl: https://api.cloud.armory.io/agents
    grpc:
      host: agents.cloud.armory.io
      port: 443
      tls:
        insecureSkipVerify: true
  deployEngineGrpc:
    host: grpc.deploy.cloud.armory.io
    port: 443
```

Save the file and apply the changes with the following command: `hal deploy apply`. Applying the config changes redeploys Armory Enterprise.
{{% /tab %}}
{{< /tabs >}}