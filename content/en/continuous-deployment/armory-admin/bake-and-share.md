---
title: Bake and Share Amazon Machine Images Across Accounts
linkTitle: Bake and Share AMIs Across Accounts
aliases:
  - /docs/spinnaker/bake-and-share/
description: >
  Configure Spinnaker to share an Amazon Machine Image (AMI) when Spinnaker and the deployment target share the same AWS account.

---

## Overview of sharing AMIs across accounts

In many environments, Spinnaker<sup>TM</sup> runs under a different AWS account than the target deployment account. This guide shows you how to configure Spinnaker to share an AMI created where Spinnaker lives with the AWS account where your applications live. This guide is assuming that AWS roles are already properly setup for talking to the target account.

## Spinnaker configuration for sharing baked AMIs

You can add the following snippet to your `SpinnakerService` manifest and apply it after replacing the example values with ones that correspond to your environment. The example adds an AWS account and configures the baking service (Rosco) with default values:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      aws:
        enabled: true
        accounts:
        - name: my-aws-account
          requiredGroupMembership: []
          providerVersion: V1
          permissions: {}
          accountId: 'aws-account-id'               # Use your AWS account id
          regions:                                  # Specify all target regions for deploying applications
            - name: us-west-2
          assumeRole: role/SpinnakerManagedProfile  # Role name that worker nodes of Spinnaker cluster caassume in the target account to make deployments and scan infrastructure
        primaryAccount: my-aws-account
        bakeryDefaults:
          baseImages: []
        defaultKeyPairTemplate: '{{"{{"}}name{{"}}"}}-keypair'
        defaultRegions:
        - name: us-west-2
        defaults:
          iamRole: BaseIAMRole
          ... # Config omitted for brevity
    service-settings:
      rosco:
        env:
          SPINNAKER_AWS_DEFAULT_REGION: "us-west-2"               # Replace by default bake region
          SPINNAKER_AWS_DEFAULT_ACCOUNT: "target-aws-account-id"  # Target AWS account id
          ... # Config omitted for brevity
```

## Spinnaker pipeline Bake stage configuration

![Bake Stage](/images/bake-and-share-1.png)

Make sure to check the `Show Advanced Options` checkbox. Then where it says `Template File Name` use [aws-multi-ebs.json](https://github.com/spinnaker/rosco/blob/ccb004e511b14642218aaf229923fefa0a9c250c/rosco-web/config/packer/aws-multi-ebs.json) as the value.

Then add an `Extended Attribute`. Have the key be `share_with_1` and the value being the target AWS account ID that was used for `SPINNAKER_AWS_DEFAULT_ACCOUNT`. `share_with_1` is for [ami_users](https://www.packer.io/docs/builders/amazon-ebs.html#ami_users) inside Packer.

You can also copy the resulting AMI to different regions by overriding the [copy_to_1](https://github.com/spinnaker/rosco/blob/ccb004e511b14642218aaf229923fefa0a9c250c/rosco-web/config/packer/aws-multi-ebs.json#L33) values. These match up to [ami_regions](https://www.packer.io/docs/builders/amazon-instance.html#ami_regions) inside Packer.
