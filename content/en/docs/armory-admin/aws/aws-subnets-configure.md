---
title: "Configure AWS Networking for Spinnaker"
linkTitle: Configure AWS Networking
aliases:
  - /docs/spinnaker-install-admin-guides/aws-subnets/
  - /docs/armory-admin/aws-subnets-configure/
  - /armory-admin/aws-subnets-configure/
description: >
  Subnets determine where and how you can deploy AWS resources such as EC2 machines, ELBs, and Security Groups.  Learn how to configure your subnets correctly the first time so you won't have to update your pipelines later.
---

## AWS resources

- AWS VPC [guides](https://docs.aws.amazon.com/vpc/index.html)
- AWS [VPCs and subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)

## Configuring subnets

Spinnaker groups subnets into a single subnet name across multiple availability zones.  This makes it simpler for end-users of Spinnaker to choose a group of subnets within a VPC that have a given purpose such as `ec2-subnets`, `elb-subnets` or `public-subnets`.  This allows Spinnaker to place the machines within that group and ensure equal redundancy across zones. Below is a logical representation of how Spinnaker groups multiple subnets together.  If you want to **make a subnet accessible to Spinnaker** you'll have to add a tag and value to the subnet with the following: `immutable_metadata={"purpose":"example-purpose"}`

![subnet tags in AWS console](/images/Image-2017-10-05-at-3.53.35-PM.png)

Conceptually, this is how Spinnaker groups subnets logically.
![subnets groups](/images/Image-2017-04-18-at-4.07.10-PM.png)

## Verifying subnet configuration

Once you configured the purpose of your subnets you can use the Spinnaker API to double check that settings have been noticed. It will take between 30 seconds and 2 minutes for the changes to be picked up. After that time period you can run:

```bash
curl http://<YOUR_GATE_ENDPOINT>/subnets/aws
```

You can expect to receive a response similar to:

```json
[
  {
    "account": "default-aws-account",
    "availabilityZone": "us-west-1b",
    "availableIpAddressCount": 4088,
    "cidrBlock": "172.31.0.0/20",
    "deprecated": false,
    "id": "subnet-7bd69322",
    "purpose": "external",
    "region": "us-west-1",
    "state": "available",
    "target": null,
    "type": "aws",
    "vpcId": "vpc-63327b06"
  }
]
```

If the `purpose` field is non-null then things are configured correctly.

## I don't see my subnets or VPCs
Spinnaker caches as much as possible to keep performance through the UI responsive.  If you don't see the subnets and you believe you configured them correctly, then make sure to refresh the cache.  You can find the cache going to the _config_ section of your application and clicking _refresh all caches_.  You should also make sure to refresh your browswer cache by using your browser's development tools and deleting any browser databases.

![refresh all caches](/images/[75a6d5a8966231fe9cfeba7a14d57864]_Image+2017-04-13+at+1.59.38+PM.png)
