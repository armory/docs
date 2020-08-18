---
title: Installing Spinnaker in Lightweight Kubernetes (K3s) using Spinnaker Operator
linkTitle: Install in AWS EC2 with Operator
weight: 50
description: >
  For POCs: Use Operator to install Spinnaker in a K3s instance running on an AWS EC2 VM
---

## Overview

This guide walks you through using the [Spinnaker Operator]({{< ref "operator" >}}) to install Armory Spinnaker in a [Lightweight Kubernetes (K3s)](https://k3s.io/) instance running on an AWS EC2 instance. The environment is for POCs and development only. It is **not** meant for production environments.

See the [Install on Kubernetes]({{< ref "install-on-k8s" >}}) guide for how to install Spinnaker using the Spinnaker Operator in a regular Kubernetes installation.

## Prerequisites

* Know how to create a VM in AWS EC2
* Be familiar with AWS IAM roles and S3 buckets

## Create an AWS EC2 instance

* Configuration:

  * Ubuntu Server 18.04 LTS (HVM), SSD Volume Type; 64-bit (x86)
  * Minimum 2 vCPUs
  * Minimum 8 GB of memory
  * Minimum of 50 GB of storage
  * Public IP

## Install K3s

SSH into your VM and run the following command to install the latest version of K3s:

```bash
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
```

Terminal output is similar to:

```bash
[INFO]  Finding release for channel stable
[INFO]  Using v1.18.6+k3s1 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/sha256sum-amd64.txt
[INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v1.18.6+k3s1/k3s
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Creating /usr/local/bin/kubectl symlink to k3s
[INFO]  Creating /usr/local/bin/crictl symlink to k3s
[INFO]  Creating /usr/local/bin/ctr symlink to k3s
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  systemd: Starting k3
```

## Create an S3 bucket

Spinnaker's Front50 service needs access to an S3 bucket, so create an S3 bucket with a globally unique name. See the [Creating a bucket](https://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html) page in the _Amazon Simple Storage Service_ docs for how to create a bucket and naming constraints.

On the *Configure options* screen, select *Versioning* and *Default encryption*.

![ Create bucket - configure options](/images/installation/guide/create-bucket-config-options.jpg)

On the *Set permissions* screen, select *Block all public access*.

Create your bucket.

## Create an IAM Role

Create an IAM Role that you will attach to your EC2 instance. Calls to s3 will use this role to get credentials for the requests. You can read more about IAM Roles in AWS' [AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_terms-and-concepts.html) guide.

From the *Services* menu, select *IAM*, which is in the *Security, Identity, & Compliance* section.

![ Select IAM](/images/installation/guide/selectIAM.png)

Select the *Roles* section.

![ Select Roles section](/images/installation/guide/selectRolesSection.png)

Press the *Create role* button.

![ Press Create role](/images/installation/guide/createRoleButton.png)

*AWS Service* is highlighted. Select *EC2*. Then press the *Next: Permissions* button.

![ Select EC2](/images/installation/guide/createIAMRoleForEc2-01.png)


In the *Filter policies* field, type "s3" and press enter. This action displays polices for S3. Select *AmazonS3FullAccess*. Then press the *Next: Tags* button.

![ Select AmazonS3FullAccess](/images/installation/guide/roleSelectS3Policy-02.png)

You can optionally add tags to your Role. Press the *Next: Review* button to move to the *Review* screen. Type in a name for your role in the *Role name* field and then press the *Create role* button.

![ Role review](/images/installation/guide/roleReview-03.png)

## Attach your IAM Role to your EC2 instance

Navigate to the EC2 services screen and then access your running instance. Select your instance. From the *Actions* menu, select *Instance Settings* and then *Attach/Replace IAM Role*.

![ Attach Replace IAM Role](/images/installation/guide/assignRoleToVM01.jpg)

Select the *IAM role* you created in the previous section. The press *Apply*.

![ Select IAM Role](/images/installation/guide/assignRoleToVM02.jpg)

