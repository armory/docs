---
title: Configuring AWS Lambda for Spinnaker
linkTitle: Configuring AWS Lambda
description: >
  Enable Spinnaker to deploy to AWS Lambda
---
## Background
In Dec 2018, AWS had provided clouddriver support for AWS Lambda.
Then in Feb 2020, AWS added UI support for Lambda (see [AWS Blog](https://aws.amazon.com/blogs/opensource/how-to-integrate-aws-lambda-with-spinnaker/)).
Finally, in Dec 2020, AWS created a plugin to add Lambda stages to Spinnaker pipelines. (see [GitHub - AWS-Lambda-Deployment-Plugin-Spinnaker](https://github.com/spinnaker-plugins/aws-lambda-deployment-plugin-spinnaker))

This document seeks to consolidate the blog and the instructions in GitHub, to give you a singular guide on enabling AWS Lambda in your Spinnaker instance.  This requires configuration changes to clouddriver, orca and gate profiles.

## Prerequisites and assumptions:

- Spinnaker 1.23+ or Armory 2.23+

## Configuration

NOTE: If you are using the [Armory Operator](https://docs.armory.io/docs/installation/operator/) check out the [Spinnaker Kustomize Patches repo](https://github.com/armory/spinnaker-kustomize-patches/pull/70) for an example of how to easily add the configuration to enable AWS Lambda

This guide will show how to add the clouddriver profile settings to [enable AWS Lambda](#enabling-aws-lambda), and [add the plugin](#adding-aws-lambda-plugin) to Spinnaker to enable the associated Lambda provided stages (Delete, Deploy, Invoke and Route)

### Enabling AWS Lambda

Halyard:
```
#.hal/default/profiles/clouddriver-local.yml
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
```
#.hal/default/profiles/settings-local.js
window.spinnakerSettings.feature.functions = true
```

Operator:
```
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

### Adding AWS Lambda Plugin
