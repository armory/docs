---
title: Get Started with Blue/Green Deployment
linktitle: Blue/Green Deployment
description: >
  This guide walks you through using canary analysis on the app you deployed in the Get Started with the CLI to Deploy Apps guide. You perform a retrospective analysi on the app. Then, you use those queries to create canary analysis steps for subsequent deployments.
weight: 10  
exclude_search: true
---

## Blue/Green deployment overview

A blue/green strategy shifts traffic from the running version of your software to a new version of your software. The Borealis blue/green strategy follows these steps:

1. Borealis deploys a new version of your software without exposing it to external traffic.
1. Borealis executes one or more user-defined steps in parallel. These steps are pre-conditions for exposing the new version of your software to traffic. For example, you may want to run automated metric analysis or wait for manual approval.
1. After all pre-conditions complete successfully, Borealis redirects all traffic to the new software version. At this stage of the deployment, the old version of your software is still running but is not receiving external traffic.
1. Next, Borealis executes one or more user-defined steps in parallel. These steps are pre-conditions for tearing down the old version of your software. For example, you may want to pause for an hour or wait for an additional automated metric analysis.
1. After all pre-conditions complete successfully, Borealis tears down the old version of your software.

## {{% heading "prereq" %}}

This quick start assumes that you completed the prior two quick starts that taught you how to register a cluster with Borealis and how to deploy an app with the CLI.

To complete this quick start, you need the following:

- Access to a Kubernetes cluster where you can install the Remote Network Agent (RNA). This cluster acts as the deployment target for the sample app. You can reuse the clusters from the previous quick starts if you want. Or stand up new ones.
- You need to deploy a [Kubernetes Service object](https://kubernetes.io/docs/concepts/services-networking/service/) that sends traffic to your application. This is the `activeService` in YAML configuration and **Current Version** in the Borealis UI.
- You should also create a `previewService` Kubernetes Service object so you can programmatically or manually observe the new version of your software before exposing it to traffic via the `activeService`. This `previewService` equats to **Next Version** in the Borealis UI.


