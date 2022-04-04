---
title: Configure AWS Lambda for Spinnaker™
linkTitle: Configure AWS Lambda
description: >
  Enable Spinnaker to deploy apps to AWS Lambda.
---

## Overview

Armory supports using AWS Lambda as a deployment target for your apps and includes a variety of Lambda specific stages. Enabling the full suite of features for Lambda support requires updating the configurations for core Spinnaker services and adding the Lambda Plugin. Depending on how you manage Spinnaker, this requires either Operator or Halyard config updates.

## Requirements

AWS Lambda support requires either Spinnaker 1.23+ or Armory 2.23+.

## Configuration

If you are using the [Armory Operator]({{< ref "armory-operator" >}}), check out the [Spinnaker Kustomize Patches repo](https://github.com/armory/spinnaker-kustomize-patches/pull/70) for an example on how to easily add the configurations required to enable AWS Lambda.

### Enabling AWS Lambda

First, enable Lambda as a deployment target for your apps by updating the settings for Clouddriver and the UI (Deck).

{{< tabs name="enable" >}}
{{% tabbody name="Operator" %}}


In the `spinnakerservice` manifest, update the `spinnakerConfig` section to include the properties for Lambda:

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:  
      deck:                                     # Enables Lambda Functions UI
        settings-local.js: |
          window.spinnakerSettings.feature.functions = true
      clouddriver:                              # Enables Lambda Functions in "Infrastructure"
        aws:
          features:
            lambda:
              enabled: true
          accounts:
          - name: aws-dev                # NOTE: This merge is Index based - so if you do not want to overwrite spinnakerConfig.config.providers.aws.accounts you must create another account in the list
            lambdaEnabled: true
            accountId: "xxxxxxxx"        # (Required)
            assumeRole: role/spinnaker   # (Required)
```

{{% /tabbody %}}

{{% tabbody name="Halyard" %}}

Enabling Lambda support using Halyard requires two configuration changes, one in `clouddriver-local.yml` and one in `settings-local.js`:

`.hal/default/profiles/clouddriver-local.yml`:

```yaml
aws:
  features:
    lambda:
      enabled: true
  accounts:
  - name: aws-dev               # NOTE: This merge is Index based - so if you do not want to overwrite .hal/config you must create another account in the list
    lambdaEnabled: true
    accountId: "xxxxxxxx"       # (Required)
    assumeRole: role/spinnaker  # (Required)
```

`.hal/default/profiles/settings-local.js`:

```
window.spinnakerSettings.feature.functions = true
```

After you make the two changes, run `hal deploy apply` to apply the changes.

{{% /tabbody %}}
{{< /tabs >}}


### Adding AWS Lambda Plugin

Next, add the Lambda Plugin to include the Lambda stages (Delete, Deploy, Invoke, and Route) in the UI.

{{< tabs name="enable-plugin">}}
{{% tabbody name="Operator" %}}

```
#-----------------------------------------------------------------------------------------------------------------
# Example configuration for adding AWS Lambda plugin to spinnaker.
#
# Documentation: https://github.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker
#-----------------------------------------------------------------------------------------------------------------
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      gate:
        spinnaker:
          extensibility:
              deck-proxy:
                enabled: true
                plugins:
                  Aws.LambdaDeploymentPlugin:
                    enabled: true
                    version: 1.0.1
              repositories:
                awsLambdaDeploymentPluginRepo:
                  url: https://raw.githubusercontent.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/master/plugins.json  
      orca:
        spinnaker:
          extensibility:
            plugins:
              Aws.LambdaDeploymentPlugin:
                enabled: true
                version: 1.0.1
                # extensions:
                #   Aws.LambdaDeploymentStage:
                #     enabled: true
            repositories:
              awsLambdaDeploymentPluginRepo:
                id: awsLambdaDeploymentPluginRepo
                url: https://raw.githubusercontent.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/master/plugins.json
```

{{% /tabbody %}}

{{% tabbody name="Halyard" %}}

`.hal/default/profiles/gate-local.yml`:

```yaml
spinnaker:
  extensibility:
    deck-proxy:
      enabled: true
      plugins:
        Aws.LambdaDeploymentPlugin:
          enabled: true
          version: 1.0.1
    repositories:
      awsLambdaDeploymentPluginRepo:
        url: https://raw.githubusercontent.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/master/plugins.json
```

`.hal/default/profiles/orca-local.yml`:

```yaml
spinnaker:
  extensibility:
    plugins:
      Aws.LambdaDeploymentPlugin:
        enabled: true
        version: 1.0.1
        # extensions:
        #   Aws.LambdaDeploymentStage:
        #     enabled: true
    repositories:
      awsLambdaDeploymentPluginRepo:
        id: awsLambdaDeploymentPluginRepo
        url: https://raw.githubusercontent.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker/master/plugins.json
```

{{% /tabbody %}}
{{% /tabs %}}

### Applying config updates

Once you make the required config changes, apply them by running the command for either Operator or Halyard:

{{< tabs name="apply-changes">}}
{{% tabbody name="Operator" %}}

Assuming the Armory instance lives in the `spinnaker` namespace, run the following command to apply the changes:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```
{{% /tabbody %}}

{{% tabbody name="Halyard" %}}

```bash
hal deploy apply
```

{{% /tabbody %}}
{{% /tabs %}}

## Known issues

{{< include "known-issues/ki-lambda-ui-caching.md" >}}



## References

See the following links for more information:

* [GitHub - AWS-Lambda-Deployment-Plugin-Spinnaker](https://github.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker)
* [AWS Blog - How to integrate AWS Lambda with Spinnaker](https://aws.amazon.com/blogs/opensource/how-to-integrate-aws-lambda-with-spinnaker/)
