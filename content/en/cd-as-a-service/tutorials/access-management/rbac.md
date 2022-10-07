---
title: Role-Based Access Control
linktitle: RBAC
description: >
  Learn how to configure and use Role-Based Access Control (RBAC) in Armory Continuous Deployment-as-a-Service.
---

## Objectives

This tutorial is designed to use a single Kubernetes cluster with multiple namespaces to simulate multiple clusters. The sample code is in a GitHub repo that you can fork to your own GitHub account.



## {{% heading "prereq" %}}

* You have installed `kubectl` and have access to a Kubernetes cluster
* You have [set up your Armory CD-as-a-Service account]({{< ref "get-started" >}}).
* You have [installed the `armory` CLI]({{< ref "cd-as-a-service/setup/cli" >}}).
* You have installed [Helm](https://helm.sh/docs/intro/install/).
* You have a GitHub account so you can fork the sample project.

## Fork and clone the repo

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) the  [sample repo](https://github.com/armory/docs-cdaas-sample) to your own GitHub account and then clone it to the machine where you installed `kubectl` and the `armory` CLI.

The `configuration` directory contains a script to set up Kubernetes cluster and connect it to Armory CD-as-a-Service.
