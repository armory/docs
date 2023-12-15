---
title: AWS CloudWatch Metrics Plugin Overview
linkTitle: Overview
weight: 1
description: >
  Learn what the plugin does. View installation paths and release notes.
---


## What the AWS CloudWatch Metrics plugin does

The AWS CloudWatch Metrics Plugin allows you to use AWS CloudWatch as a metrics provider for your canary deployments.


## Installation paths

{{% cardpane %}}

{{% card header="Spinnaker" %}}

1. Make sure you have enabled canary deployments (the Kayenta service) in your Spinnaker instance.
1. [Enable AWS CloudWatch](#enable-aws-cloudwatch) as a metrics provider.
1. [Install the plugin](#install-the-plugin-in-spinnaker) in Spinnaker using the Spinnaker Operator or Halyard.
1. [Use AWS CloudWatch](#use-aws-cloudwatch) in your pipeline.

{{% /card %}}

{{% card header="Armory CD" %}}

Armory CD includes the AWS Cloudwatch Metrics Plugin. You do not have to install it. 

1. Make sure you have enabled canary deployments (the Kayenta service) in your Armory CD instance.
1. [Enable AWS CloudWatch](#enable-aws-cloudwatch) as a metrics provider.
1. [Use AWS CloudWatch](#use-aws-cloudwatch) in your pipeline.

{{% /card %}}

{{% /cardpane %}}


## Spinnaker compatibility matrix

| Spinnaker Version | AWS CloudWatch Metrics Plugin Version |
|-------------------|-----------------------------------|
| 1.33.x            | 0.1.0                             |


## Release notes

- 0.1.0: Initial release

