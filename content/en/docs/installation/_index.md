---
title: "Install Armory Enterprise for Spinnaker"
linkTitle: "Installation"
weight: 5
description: |
  Guides for deploying Armory Enterprise for Spinnaker, a continuous integration and software delivery platform built on top of Spinnaker<sup>TM</sup>, in your air-gapped, local, or cloud environment (AWS, GCP, Azure, or Kubernetes). Use the Armory Operator for Kubernetes to install  Armory Enterprise, or use the open source Operator to install open source Spinnaker in Kubernetes.
aliases:
  - /install_guide/install/
  - /install-guide/getting_started/
  - /docs/spinnaker/install/
no_list: true
---

{{< include "armory-license.md" >}}

## Methods for installing Armory Enterprise

There are several methods to install Armory Enterprise or open source Spinnaker:

| Method                             | Environment           | Description                                                          | Benefits                                                            |
|------------------------------------|-----------------------|----------------------------------------------------------------------|-----------------------------------------------------------------|
| [Armory Operator]({{< ref "armory-operator" >}})   |  Kubernetes Operator that enables you to configure and manage Armory Enterprise declaratively | GitOps friendly and ready for production use                                 |
| [Armory Halyard]({{< ref "armory-halyard" >}}) ([Deprecated]({{< ref "halyard-deprecation" >}})) | Kubernetes            | Versatile command line interface to configure and deploy Armory Enterprise   | Quick setup                                                     |
| [Minnaker]({{< ref "minnaker" >}})             | MacOS, Linux, Windows | Spin up a whole environment on top of Rancher K3s to deploy Armory Enterprise or Spinnaker    | This is ideal if you do not have a Kubernetes cluster available and want to try Armory Enterprise |
| [Operator]({{< ref "armory-operator" >}}) | Kubernetes            | An open source Kubernetes Operator that installs open source Spinnaker | GitOps friendly and ready for production use                                 |


All the preceding methods share similar configurations, and you can migrate between them if your needs change.

> Armory Enterprise does not generate default usernames and passwords for user accounts for any service. Manage these by configuring authentication and authorization for Armory Enterprise.

## Guides

Based on your environment, use one of the following guides to help you install Armory Enterprise:

| Guide                                                     | Environment                                          | Description                                                                                                                            |
|-----------------------------------------------------------|------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| [Armory Operator Quickstart]({{< ref "op-quickstart" >}}) | Kubernetes, Armory Operator                          | Install the Armory Operator, create a Kubernetes manifest for Armory Enterprise, and then deploy and manage using the Armory Operator. |
| [Air Gapped]({{< ref "air-gapped" >}})                    | Air-gapped environments that use the Armory Operator | Learn how to host your own Bill of Materials for deploying Armory Enterprise in an air-gapped environment.                             |
| [AWS Marketplace]({{< ref "aws-container-marketplace" >}}) | AWS, Armory Operator | Use the Armory Operator from the AWS Container Marketplace to deploy Armory Enterprise in your Amazon Kubernetes (EKS) cluster. |
| [Armory Enterprise on AWS workshop](https://armory.awsworkshop.io/) | AWS |  Use AWS CloudFormation to create infrastructure and deploy Armory Enterprise from the AWS Marketplace. |
| [Install in AWS]({{< ref "install-on-aws" >}}) | AWS EKS, Halyard | Use Armory-extended Halyard to deploy Armory Enterprise in an AWS EKS cluster. |
| [Install on AWS EC2 with Operator]({{< ref "operator-k3s" >}})        | AWS EC2, Armory Operator              | Installation steps for using Armory Operator to install Armory  Enterprise in a Lightweight Kubernetes (K3s) instance for a Proof of Concept.
| [Install on GKE with Operator]({{< ref "install-on-gke-operator" >}}) | GKE, ARmory Operator                  | Installation steps for Google Kubernetes Engine using Operator                    |
| [Configuring Halyard]({{< ref "configure-halyard" >}})                | Halyard                        | Description of Armory-extended Halyard configurations              |
