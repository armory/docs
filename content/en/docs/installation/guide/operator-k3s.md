---
title: Installing Spinnaker in Lightweight Kubernetes (K3s) using Spinnaker Operator
linkTitle: Operator and K3s
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

## Create an S3 bucket and IAM credentials

Create an S3 bucket with a globally unique name. See the [Creating a bucket](https://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html) page in the _Amazon Simple Storage Service_ docs for how to create a bucket and naming constraints.

On the *Configure options* screen, select *Versioning* and *Default encryption*.

![ Create bucket - configure options](/images/installation/guide/create-bucket-config-options.jpg)

On the *Set permissions* screen, select *Block all public access*.

Create your bucket.

### Create an IAM user

Spinnaker's Front50 service will need access to your bucket, so you need to create an IAM user and then add an inline policy for that user to your bucket. See AWS' [Creating IAM Users (Console)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console) guide for details on creating IAM users.

For this guide, your IAM user needs only programmatic access:

![ Create IAM user](/images/installation/guide/iam-user-01.jpg)

Do not add your IAM user to a group on the *Set permissions* screen. Go to the next screen.

![ IAM user second screen](/images/installation/guide/iam-user-02.jpg)

You do not need to add any tags, so go to the next screen to review your IAM user.

![ IAM user review screen](/images/installation/guide/iam-user-03.jpg)

You can ignore the *This user has no permissions* warning because you will use an inline policy to add the IAM user to your s3 bucket.