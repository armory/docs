---
title: "Installation"
linkTitle: "Installation"
weight: 2
description: |
  Installing Spinnaker
aliases:
  - /install_guide/install/
  - /install-guide/gettings_started/
---

Most installations of Spinnaker are on Kubernetes. Below is a summary of the different installation methods:

| Method  | Environment | Description  | Pros |
|---|---|--|--|
| [Spinnaker Operator](./operator) | Kubernetes | Kubernetes operator that turns Spinnaker's configuration declarative | GitOps friendly, Production use | 
| [Armory Halyard](./armory-halyard)  | Kubernetes | Versatile command line interface to configure and deploy Spinnaker | Quick Setup |
| [Minnaker](./minnaker) | MacOS, Linux, Windows | Spin up a whole environment on top of Rancher to deploy Spinnaker | This is ideal if you do not have a Kubernetes cluster available |


All the methods above share similar configurations and you can change between them.


# Guides

We have prepared a few tutorials to guide you through the install in different environments:

| Guide | Environment | Description |
|--|--|--|
| [Air Gapped](guide/air-gapped) | Air-gapped, Halyard & Operator | Host Bill of Material |
| [AWS Marketplace](guide/aws-container-marketplace/) | AWS | One click install on AWS marketplace |
| [Install on Kubernetes](guide/install-on-k8s/) | Halyard, Operator | General considerations |
| [Install on AWS](guide/install-on-aws/) | AWS, Halyard | Spinnaker Installation, IAM configuration |
| [Install on AKS](guide/install-on-aks/) | AKS, Halyard | Spinnaker Installation | 
| [Install on GKE](guide/install-on-gke/) | GKE, Halyard | Spinnaker Installation | 
| [Install on GKE with Operator](guide/install-on-gke-operator/) | GKE, Operator | Spinnaker Installation | 
| [Configuring Halyard](guide/configure-halyard/) | Halyard | Armory Halyard configuration | 

