---
title: AWS Resources
linkTitle: AWS
description: >
  Services used by Armory Enterprise when it is deployed on Amazon Web Services - VPC, EKS, IAM, S3, Secrets Manager, Redis, Aurora.
---

## Armory and AWS services

You use several AWS services when you deploy the Armory platform on AWS: [Virtual Private Cloud](#networking), [Elastic Kubernetes Service (EKS)](#eks), [IAM](#iam), [Simple Storage Service (S3)](#s3), [Secrets Manager](#secrets-manager), [Redis](#elasticache-for-redis), and [Aurora](#aurora-database).

{{< figure src="/images/cloud-resources/aws/armory-detail.png"
alt="Diagram of Armory and AWS services"
height="75%" width="75%" >}}

## Deployment on AWS

### Without disaster recovery

{{< figure src="/images/cloud-resources/aws/armory-active-none.png"
alt="Diagram of Armory deployment on AWS without disaster recovery"
height="75%" width="75%" >}}

### With disaster recovery

Spinnaker does not function in multi-master mode, which means that active-active is not supported at this time. Instead, you can achieve an active-passive Spinnaker setup that results in two instances of Spinnaker deployed into two regions that can fail independently. See [Configuring Spinnaker on AWS for Disaster Recovery]({{< ref "aws-dr" >}}) for instructions.


{{< figure src="/images/cloud-resources/aws/armory-active-passive.png"
alt="Diagram of Armory deployment on AWS with disaster recovery"
height="75%" width="75%" >}}

## AWS Services

### Aurora database

- [User Guide](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/CHAP_AuroraOverview.html)
- [Engine selection and size](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Concepts.DBInstanceClass.html)
- [Database encryption](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Encryption.html) for storing sensitive data
- [Backup and restore Aurora clusters](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.Managing.Backups.html)
- [Replicate Amazon Aurora MySQL DB Clusters Across AWS Regions](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.Replication.CrossRegion.html)
- [Failover for Aurora Global Databases](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/aurora-global-database.html#aurora-global-database-failover)

### CloudWatch

- [User Guide](https://aws.amazon.com/cloudwatch/)

### EKS

- [User Guide](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [Resilience in Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/disaster-recovery-resiliency.html)

### ElastiCache for Redis

- [Amazon ElastiCache for Redis](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/index.html)
- [Amazon ElastiCache for Redis - Exporting Backup to S3](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/backups-exporting.html)

### IAM

- [User Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)
- IAM [roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html)
- IAM [policies and permissions](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html)

### Networking

- VPC [User Guide](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
- [VPCs and subnets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Subnets.html)

### S3

- [User Guide](https://docs.aws.amazon.com/AmazonS3/latest/gsg/GetStartedWithS3.html)
- Bucket [restrictions](https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html)
- Security [best practices](https://docs.aws.amazon.com/AmazonS3/latest/dev/security-best-practices.html)
- S3 buckets should be set up with cross-region [replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/replication.html) turned on.

### Secrets Manager

- [User Guide](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html)

### Service quotas

- [User Guide](https://docs.aws.amazon.com/servicequotas/latest/userguide/getting-started.html)
- Service quotas [dashboard](https://docs.aws.amazon.com/servicequotas/latest/userguide/gs-request-quota.html)
- [EC2 service quotas](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html)


## Pricing

See the AWS Pricing [guide](https://aws.amazon.com/pricing) for explanations of AWS pricing tiers.

You can calculate AWS costs by using the [AWS Pricing Calculator](https://calculator.aws) or by consulting individual pricing pages.

- [Aurora](https://aws.amazon.com/rds/aurora/pricing)
- [EKS](https://aws.amazon.com/eks/pricing/)
- [ElastiCache for Redis](https://aws.amazon.com/elasticache/pricing)
- [Secrets Manager](https://aws.amazon.com/secrets-manager/pricing)
- [S3](https://aws.amazon.com/s3/pricing/?nc=sn&loc=4)
- [VPC](https://aws.amazon.com/vpc/pricing/)

If you plan to use EC2 with your Armory installation, you can find related costs on the following pages:

- [EC2](https://aws.amazon.com/ec2/pricing/)
- [Elastic Block Store (EBS)](https://aws.amazon.com/ebs/pricing/)
- [Elastic Load Balancing (ELB)](https://aws.amazon.com/elasticloadbalancing/pricing) for Application Load Balancer (ALB), Network Load Balancer (NLB), or Classic Load Balancer (CLB)


### Basic cost estimate

The example below is based on a basic Armory production environment running in a single region without disaster recovery. Your infrastructure needs and costs may vary.

Prices are based on "On Demand" rates. "Reserved" rates may be more cost effective. AWS pricing can change without notice, so be sure to determine your costs using the [AWS Pricing Calculator](https://calculator.aws). You can also [contact Armory](mailto:info@armory.io?subject=Armory%20on%20AWS%20Cost%20Help) for help in calculating costs.

{{< gsuite src="https://docs.google.com/spreadsheets/d/e/2PACX-1vSlG-eNaziGxpi-d4NbiQfd6RREHZ-EdShx89nTl1gZGeZ5NECAm85BfOXp5-jWVOaPC9d6pzo6vfww/pubhtml?gid=0&amp;single=true&amp;widget=true&amp;headers=false"  width="100%" height="500" >}}

