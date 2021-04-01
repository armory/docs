---
title: Self Service Demo with Armory Enterprise for Spinnaker
linkTitle: "Armory Demo"
no_list: true
description: "This demo is a fully featured proof of concept (PoC) of Armory Enterprise for Spinnaker™. Walk through installation, configuration, and deployment using sample applications."
aliases:
  - /spinnaker-install-admin-guides/architecture/
---

## Overview

Armory Enteprise for Spinnaker is an superset of Spinnaker, which itself is a collection of microservices working in concert to create a single continuous delivery / deployment service.

Installation and configuration of Armory Enterprise for Spinnaker can seem a daunting task for those not yet familiar with open-source Spinnaker, so we created Minnaker: a demo deployment of Spinnaker designed to run in a single instance (EC2 or other virtual machine).

## Features

What is included in Armory Easy Poc? 

Armory Enterprise 

- Infrastructure as Code (IaC) using gitops and Terraform
- Policy Driven Deployment (PDD) - for security and compliance (Security as Code)
- Declarative Spinnaker Application and Pipelines for (Pipelines as Code)
- Automatic EKS Provisioning through gitops
- Armory Agent for Kubernetes (delegate for kubernetes)
- Enterprise Armory Platform powered by Spinnaker
- Built in Kubernetes deployment namespace for testing (QA, Stage, Prod)
- Extension points through yaml (Jenkins, Git, JIRA, Docker hub)

Minnaker uses [K3s](https://k3s.io/) as the Kubernetes server. If you already have a Kubernetes cluster for testing, you can skip to [Install Minnaker]({{< ref "install-demo#install-minnaker" >}}).

## {{% heading "prereq" %}}

Here are the requirements for completing this demo:

* You need to be able to provision instances in your cloud environment.
* The provisioned instance needs to meet the following minimum requirements
  * Ubuntu 18.04
  * 4 vCPUs
  * 16 GB of memory
  * 50 GB of storage

If deploying to an EC2 instance, we suggest using the t3.xlarge tier.

> You don't need to create this instance ahead of following the guide, only confirm access to the resources required.

## {{% heading "nextSteps" %}}

When you're ready, go to [Deploy and Install]({{< ref "docs/overview/demo/install-demo" >}}) to begin.
