---
title: "Install Armory Enterprise for Spinnaker"
linkTitle: "Installation"
weight: 5
description: |
  Guides for deploying Armory Enterprise for Spinnaker, a continuous integration and software delivery platform built on top of Spinnaker<sup>TM</sup>, in your air-gapped, local, or cloud environment (AWS, GCP, Azure, Kubernetes, OpenShift). Use the Armory Operator for Kubernetes to install  Armory Enterprise, or use the open source Operator to install open source Spinnaker in Kubernetes.
aliases:
  - /install_guide/install/
  - /install-guide/getting_started/
  - /docs/spinnaker/install/
---

{{< include "armory-license.md" >}}

## Methods for installing Armory Enterprise

There are several methods to install Armory Enterprise or open source Spinnaker:

| Method                             | Environment           | Description                                                          | Benefits                                                            |
|------------------------------------|-----------------------|----------------------------------------------------------------------|-----------------------------------------------------------------|
| [Armory Operator]({{< ref "armory-operator" >}})   |  Kubernetes Operator that enables you to configure Armory Enterprise declaratively | GitOps friendly and ready for production use                                 |
| [Armory Halyard]({{< ref "armory-halyard" >}}) | Kubernetes            | Versatile command line interface to configure and deploy Armory Enterprise   | Quick Setup                                                     |
| [Minnaker]({{< ref "minnaker" >}})             | MacOS, Linux, Windows | Spin up a whole environment on top of Rancher K3s to deploy Armory  Enterprise or Spinnaker    | This is ideal if you do not have a Kubernetes cluster available and want to try out Armory Enterprise or Spinnaker |
| [Operator]({{< ref "armory-operator" >}}) | Kubernetes            | An open source Kubernetes Operator that installs open source Spinnaker | GitOps friendly and ready for production use                                 |


All the preceding methods share similar configurations, and you can migrate between them if your needs change.

> Armory Enterprise does not generate default usernames and passwords for user accounts for any service. Manage these by configuring authentication and authorization for Armory Enterprise.

## Guides

Based on your environment, use one of the following guides to help you install Armory Enterprise:

| Guide                                                                 | Environment                    | Description                               |
|-----------------------------------------------------------------------|--------------------------------|-------------------------------------------|
| [Air Gapped]({{< ref "air-gapped" >}})                                | Air-gapped environments that use Halyard or Operator | Learn how to host your own Bill of Materials to install Armory Enterprise in air-gapped environments.                     |
| [AWS Marketplace]({{< ref "aws-container-marketplace" >}})            | AWS                            | One-click install from the AWS marketplace.      |
| [Install on Kubernetes]({{< ref "install-on-k8s" >}})                 | Halyard, Operator              | General workflow for installing Armory Enterprise on Kubernetes                    |
| [Install on AWS]({{< ref "install-on-aws" >}})                        | AWS, Halyard                   | Installation steps for AWS, including IAM configuration |
| [Install on AWS EC2 with Operator]({{< ref "operator-k3s" >}})        | AWS EC2, Operator              | Installation steps for using Armory Operator to install Armory  Enterprise in a Lightweight Kubernetes (K3s) instance for POCs
| [Install on AKS]({{< ref "install-on-aks" >}})                        | AKS, Halyard                   | Installation steps for Azure Kubernetes Service                   |
| [Install on GKE]({{< ref "install-on-gke" >}})                        | GKE, Halyard                   | Installation steps for Google Kubernetes Engine                    |
| [Install on GKE with Operator]({{< ref "install-on-gke-operator" >}}) | GKE, Operator                  | Installation steps for Google Kubernetes Engine using Operator                    |
| [Configuring Halyard]({{< ref "configure-halyard" >}})                | Halyard                        | Description of Armory-extended Halyard configurations              |
