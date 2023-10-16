---
title: "Install Armory Continuous Deployment for Spinnaker"
linkTitle: "Installation"
weight: 5
description: |
  Guides for deploying Armory Continuous Deployment for Spinnaker, a continuous integration and software delivery platform built on top of Spinnaker<sup>TM</sup>, in your air-gapped, local, or cloud environment (AWS, GCP, Azure, or Kubernetes). Use the Armory Operator for Kubernetes to install  Armory Continuous Deployment, or use the open source Operator to install open source Spinnaker in Kubernetes.
no_list: true
---

{{< include "armory-license.md" >}}

## Methods for installing Armory Continuous Deployment

There are several methods to install Armory Continuous Deployment or open source Spinnaker:

| Method                             | Environment           | Description                                                          | Benefits                                                            |
|------------------------------------|-----------------------|----------------------------------------------------------------------|-----------------------------------------------------------------|
| [Armory Operator]({{< ref "armory-operator" >}})   |  Kubernetes Operator that enables you to configure and manage Armory Continuous Deployment declaratively | GitOps friendly and ready for production use                                 |
| [Minnaker]({{< ref "minnaker" >}})             | MacOS, Linux, Windows | Spin up a whole environment on top of Rancher K3s to deploy Armory Continuous Deployment or Spinnaker    | This is ideal if you do not have a Kubernetes cluster available and want to try Armory Continuous Deployment |
| [Operator]({{< ref "armory-operator" >}}) | Kubernetes            | An open source Kubernetes Operator that installs open source Spinnaker | GitOps friendly and ready for production use                                 |


All the preceding methods share similar configurations, and you can migrate between them if your needs change.

> Armory Continuous Deployment does not generate default usernames and passwords for user accounts for any service. Manage these by configuring authentication and authorization for Armory Continuous Deployment.

## Guides

Based on your environment, use one of the following guides to help you install Armory Continuous Deployment:

| Guide                                                     | Environment                                          | Description                                                                                                                            |
|-----------------------------------------------------------|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| [Armory Operator Quickstart]({{< ref "op-quickstart" >}}) | Kubernetes, Armory Operator                          | Install the Armory Operator, create a Kubernetes manifest for Armory Continuous Deployment, and then deploy and manage using the Armory Operator. |
| [Air Gapped]({{< ref "air-gapped" >}})                    | Air-gapped environments that use the Armory Operator | Learn how to host your own Bill of Materials for deploying Armory Continuous Deployment in an air-gapped environment.                             |
| [AWS Marketplace]({{< ref "aws-container-marketplace" >}}) | AWS, Armory Operator | Use the Armory Operator from the AWS Container Marketplace to deploy Armory Continuous Deployment in your Amazon Kubernetes (EKS) cluster. |
| [Armory Continuous Deployment on AWS workshop](https://armory.awsworkshop.io/) | AWS |  Use AWS CloudFormation to create infrastructure and deploy Armory Continuous Deployment from the AWS Marketplace. |
| [Install in AWS]({{< ref "install-on-aws" >}}) | AWS EKS | Use Armory Operator to deploy Armory Continuous Deployment in an AWS EKS cluster. |
