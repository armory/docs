---
title: "Install Armory Continuous Deployment for Spinnaker"
linkTitle: "Installation"
weight: 5
description: |
  Guides for deploying Armory Continuous Deployment for Spinnaker, a continuous integration and software delivery platform built on top of Spinnaker<sup>TM</sup>, in your air-gapped, local, or cloud environment (AWS, GCP, Azure, or Kubernetes). Use the Armory Operator for Kubernetes to install  Armory Continuous Deployment, or use the open source Operator to install open source Spinnaker in Kubernetes.
no_list: true
---

{{< include "armory-license.md" >}}

## Installation tools

| Method                             | Environment           | Description                                                          | Benefits                                                            |
|------------------------------------|-----------------------|----------------------------------------------------------------------|-----------------------------------------------------------------|
| [Armory Operator]({{< ref "armory-operator" >}})   |  Kubernetes Operator that enables you to configure and manage Armory Continuous Deployment declaratively | GitOps friendly and ready for production use                                 |
| [Spinnaker Operator]({{< ref "armory-operator" >}}) | Kubernetes            | An open source Kubernetes Operator that installs open source Spinnaker | GitOps friendly and ready for production use                                 |


The preceding tools share similar configurations.

> Armory Continuous Deployment does not generate default usernames and passwords for user accounts for any service. Manage these by configuring authentication and authorization for Armory Continuous Deployment.

## Armory CD install guides

Based on your environment, use one of the following guides to help you install Armory Continuous Deployment:

| Guide                                                     | Environment                                          | Description                                                                                                                            |
|-----------------------------------------------------------|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| {{< linkWithLinkTitle "continuous-deployment/installation/armory-operator/install-armorycd.md" >}}  | Kubernetes, Armory Operator                          | Install the Armory Operator, create a Kubernetes manifest for Armory Continuous Deployment, and then deploy and manage using the Armory Operator. |
| {{< linkWithLinkTitle "continuous-deployment/installation/guide/air-gapped/_index.md" >}}                  | Air-gapped environments that use the Armory Operator | Learn how to host your own Bill of Materials for deploying Armory Continuous Deployment in an air-gapped environment.                             |
| {{< linkWithLinkTitle "continuous-deployment/installation/guide/aws-container-marketplace.md" >}} | AWS, Armory Operator | Use the Armory Operator from the AWS Container Marketplace to deploy Armory Continuous Deployment in your Amazon Kubernetes (EKS) cluster. |
| [Armory Continuous Deployment on AWS workshop](https://armory.awsworkshop.io/) | AWS |  Use AWS CloudFormation to create infrastructure and deploy Armory Continuous Deployment from the AWS Marketplace. |
| {{< linkWithLinkTitle "continuous-deployment/installation/guide/install-on-aws.md" >}} | AWS EKS | Use the Armory Operator to deploy Armory Continuous Deployment in an AWS EKS cluster. |
| [Install on AWS EC2 with Operator]({{< ref "operator-k3s" >}})        | AWS EC2, Armory Operator              | Installation steps for using Armory Operator to install Armory CD in a Lightweight Kubernetes (K3s) instance for a Proof of Concept.

## Spinnaker install guides

| Guide                                                     | Environment                                          | Description                                                                                                                            |
|-----------------------------------------------------------|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| {{< linkWithLinkTitle "continuous-deployment/installation/armory-operator/install-spinnaker.md" >}} | Kubernetes, Spinnaker Operator, Kustomize     | Install the Spinnaker Operator and use it with the `spinnaker-kustomize-patches` repo to deploy Spinnaker to your Kubernetes cluster. |

