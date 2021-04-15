---
title: Self Service Demo with Armory Enterprise for Spinnaker
linkTitle: "Armory Demo"
no_list: true
description: "This demo is a fully featured proof of concept (PoC) of Armory Enterprise for Spinnaker™. Walk through installation, configuration, and deployment using sample applications."
aliases:
  - /spinnaker-install-admin-guides/architecture/
---

## Overview

Armory Enteprise is a superset of Spinnaker, which itself is a collection of microservices working in concert to create a single continuous delivery / deployment service.

Installation and configuration of Armory Enterprise for Spinnaker can seem a daunting task for those not yet familiar with open-source Spinnaker, so we created Minnaker: a demo deployment of Spinnaker designed to run in a single instance (EC2 or other virtual machine).

Minnaker uses [K3s](https://k3s.io/) as the Kubernetes implementation. If you already have a Kubernetes cluster for testing, you can skip to [Install Minnaker]({{< ref "install-demo#install-minnaker" >}}).

## {{% heading "prereq" %}}

Here are the requirements for completing this demo:

* You need to be able to provision instances in your cloud environment.
* The provisioned instance needs to meet the following minimum requirements
  * Ubuntu 18.04
  * 4 vCPUs
  * 16 GB of memory
  * 50 GB of storage

If deploying to an EC2 instance, we suggest using a t3a.xlarge instance.

> You don't need to create this instance ahead of following the guide, only confirm access to the resources required.

### Concepts

The Minnaker demo uses the Armory Operator to manage services, and Kustomize to manage configuration files. If you're unfamiliar with either, check out the following docs before you begin:

 - {{< linkWithTitle "op-config-kustomize#how-kustomize-works" >}}
 - {{< linkWithTitle "armory-operator#how-the-spinnaker-operator-and-the-armory-operator-work" >}}

## {{% heading "nextSteps" %}}

When you're ready, go to [Deploy and Install]({{< ref "docs/overview/demo/install-demo" >}}) to begin.
