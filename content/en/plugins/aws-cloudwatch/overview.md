---
title: AWS CloudWatch Integration Plugin Overview
linkTitle: Overview
weight: 1
description: >
  Learn what the plugin does. View installation paths and release notes.
---


## What the AWS CloudWatch Integration plugin does

The AWS CloudWatch Integration Plugin for Spinnaker enables using AWS CloudWatch as a metrics provider for your canary deployments. For example, you can have an analysis stage that compares CPU utilization across two versions of a service using AWS CloudWatch metrics and then a judgment that determines if the deployment proceeds or rolls back based on the metrics.

See [Canary Overview](https://spinnaker.io/docs/guides/user/canary/canary-overview/) for more information on using canary analysis with Spinnaker.

## Installation paths

{{% cardpane %}}

{{% card header="Spinnaker" %}}

1. Make sure you have enabled canary deployments (the Kayenta service) in your Spinnaker instance.
1. Enable AWS CloudWatch as a metrics provider.
1. Install the plugin in Spinnaker using the Spinnaker Operator or Halyard.
1. Use AWS CloudWatch in your pipeline.

[Instructions]({{< ref "plugins/aws-cloudwatch/spinnaker" >}})

{{% /card %}}

{{% card header="Armory CD" %}}

Armory CD includes the AWS Cloudwatch Integration Plugin. You do not have to install it. 

1. Make sure you have enabled canary deployments (the Kayenta service) in your Armory CD instance.
1. Enable AWS CloudWatch as a metrics provider.
1. Use AWS CloudWatch in your pipeline.

[Instructions]({{< ref "plugins/aws-cloudwatch/armory-cd" >}})

{{% /card %}}

{{% /cardpane %}}


## Spinnaker compatibility matrix

| Spinnaker Version | AWS CloudWatch Integration Plugin Version |
|-------------------|-----------------------------------|
| 1.33.x            | 0.1.0                             |


## Release notes

- 0.1.0: Initial release

