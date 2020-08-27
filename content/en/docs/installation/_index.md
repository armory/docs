---
title: "Installation"
linkTitle: "Installation"
weight: 2
description: |
  Installing Spinnaker
aliases:
  - /install_guide/install/
  - /install-guide/getting_started/
  - /docs/spinnaker/install/
---

Armory supports several methods to install Spinnaker:

| Method                             | Environment           | Description                                                          | Benefits                                                            |
|------------------------------------|-----------------------|----------------------------------------------------------------------|-----------------------------------------------------------------|
| [Spinnaker Operator]({{< ref "operator" >}})   | Kubernetes            | Kubernetes operator that turns Spinnaker's configuration declarative | GitOps friendly and ready for production use                                 |
| [Armory Halyard]({{< ref "armory-halyard" >}}) | Kubernetes            | Versatile command line interface to configure and deploy Spinnaker   | Quick Setup                                                     |
| [Minnaker]({{< ref "minnaker" >}})             | MacOS, Linux, Windows | Spin up a whole environment on top of Rancher K3s to deploy Spinnaker    | This is ideal if you do not have a Kubernetes cluster available and want to try out Spinnaker |


All the methods above share similar configurations, and you can migrate between them if your needs change.


## Guides

Based on your environment, use one of the following guides to help you install Spinnaker:

| Guide                                                                 | Environment                    | Description                               |
|-----------------------------------------------------------------------|--------------------------------|-------------------------------------------|
| [Air Gapped]({{< ref "air-gapped" >}})                                | Air-gapped environments that use Halyard or Operator | Learn how to host your own Bill of Materials to install Spinnaker in air-gapped environments.                     |
| [AWS Marketplace]({{< ref "aws-container-marketplace" >}})            | AWS                            | One-click install on the AWS marketplace.      |
| [Install on Kubernetes]({{< ref "install-on-k8s" >}})                 | Halyard, Operator              | General workflow for installing Spinnaker on Kubernetes                    |
| [Install on AWS]({{< ref "install-on-aws" >}})                        | AWS, Halyard                   | Installation steps for AWS, including IAM configuration |
| [Install on AKS]({{< ref "install-on-aks" >}})                        | AKS, Halyard                   | Installation steps for Azure Kubernetes Service                   |
| [Install on GKE]({{< ref "install-on-gke" >}})                        | GKE, Halyard                   | Installation steps for GoogLe Kubernetes Engine                    |
| [Install on GKE with Operator]({{< ref "install-on-gke-operator" >}}) | GKE, Operator                  | Installation steps for Google Kubernetes Engine using Operator                    |
| [Configuring Halyard]({{< ref "configure-halyard" >}})                | Halyard                        | Description of Armory-extended Halyard configurations              |