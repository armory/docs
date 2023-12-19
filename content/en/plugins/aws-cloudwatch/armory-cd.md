---
title: Enable and Use the AWS CloudWatch Integration Plugin in Armory CD
linkTitle: Armory CD Enable
description: >
  Enable and use the AWS CloudWatch Integration Plugin in your Armory Continuous Deployment instance.
---


## {{% heading "prereq" %}}

Before you can start using canary deployments, you need to enable Kayenta, the Spinnaker<sup>TM</sup> service for canary deployments. For more information, see the {{< linkWithTitle "continuous-deployment/armory-admin/kayenta-configure.md" >}} guide.

## Enable AWS CloudWatch as a metrics store

{{< readfile "/plugins/aws-cloudwatch/files/enable-cloudwatch-as-metrics.md" >}}

## Use AWS CloudWatch

{{< readfile "/plugins/aws-cloudwatch/files/use-aws-cloudwatch.md" >}}