---
title: Armory CD Quickstart Script
linkTitle: Armory CD Quickstart
weight: 1
description: >
  Use an "all-in-one" script to install a basic Armory Continuous Deployment instance for evaluation.
aliases:
  - /continuous-deployment/installation/armory-operator/op-quickstart.md
---

## Quickstart overview 

This guide shows you how to install Armory CD using an install script that deploys the Armory Operator in cluster mode and then Armory CD. This is useful for a proofs of concept, but you should not use this script for a production environment.

## Objectives

1. Meet the requirements listed in the [{{% heading "prereq" %}}](#before-you-begin) section.
1. [Get the repo](#get-the-repo).
1. [Run the script](#run-the-script).

## {{% heading "prereq" %}}

* Make sure your environment meets or exceeds Armory CD [system requirements]({{< ref "continuous-deployment/installation/system-requirements" >}})
* Make sure your Kubernetes version is compatible with the latest Armory Operator version.

  {{< include "armory-operator/operator-compat-matrix.md" >}}

## Get the repo

{{% include "armory-operator/spin-kust-repo.md" %}}

## Run the script

Navigate to the root of your `spinnaker-kustomize-patches` directory. The `deploy.sh` script does the following:

* Deploys the latest Armory Operator to the `spinnaker-operator` namespace.
* Deploys a basic Armory Continuous Deployment instance with some default integrations to the `spinnaker` namespace.

The install process creates the necessary Kubernetes roles and secrets.

```bash
./deploy.sh
```

The script writes output to `deploy_log.txt`.

If you are installing Armory CD into a cluster running on your laptop, you may have to install the Armory Operator first due to lack of resources. Once the Operator has successfully deployed, you can then run the `deploy` script without installing the Armory Operator:

```bash
./deploy.sh SPIN_OP_DEPLOY=0
```

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-manage-spinnaker.md" >}}
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-manage-operator.md" >}}
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/hal-op-migration.md" >}}