---
title: Armory Continuous Deployment-as-a-Service
linkTitle: Armory CD-as-a-Service
no_list: true
description: >
  Armory CD-as-a-Service is a single control plane that enables deployment to multiple Kubernetes clusters using CD-as-a-Service's secure, one-way Kubernetes agents. These agents facilitate multi-cluster orchestration and advanced deployment strategies, such as canary and blue/green, for your apps.
---

## Overview of Armory CD-as-a-Service

{{< youtube-enhanced id="r29UCKMXEi4" title="CD-as-a-Service Simplifies Your Deployment Process" widthPercent="75" heightPercent="85" >}}

Armory CD-as-a-Service delivers intelligent deployment-as-a-service that supports advanced deployment strategies so developers can focus on building
great code rather than deploying it. By automating code deployment across all of your Kubernetes environments, Armory CD-as-a-Service removes demands on developers and reduces the risk of service disruptions due to change failures. It does this by seamlessly integrating pre-production verification tasks with advanced production deployment strategies. This mitigates risks by providing deployment flexibility while limiting blast radius, which leads to a better customer experience. Best of all, Armory CD-as-a-Service doesn’t require migrating to a new deployment platform. It easily plugs into any existing SDLC.

{{< figure src="/images/cdaas/cdaas-arch.png" alt="CD-as-a-Service High-Level Architecture" height="75%" width="75%" >}}

See the [Key Components]({{< ref "cd-as-a-service/concepts/architecture/key-components" >}}) section for details.

The [Armory CDaaS](https://www.armory.io/products/continuous-deployment-as-a-service/) product page contains a full list of features and pricing.

## Start using Armory CD-as-a-Service

The **Get Started** section contains guides that walk you through the core functionality. 

* {{< linkWithTitle "cd-as-a-service/setup/quickstart.md" >}} guide shows you how to sign up for an account, connect to your Kubernetes cluster, and deploy an example app.
* {{< linkWithTitle "cd-as-a-service/setup/deploy-your-app.md" >}} guide to learn how to create a deployment file for your own app and then deploy using the CLI.
* {{< linkWithTitle "cd-as-a-service/setup/gh-action.md" >}} guide walks you through integrating Armory CD-as-a-Service's GitHub Action into your workflow.

Learn how to configure deployment strategies with these guides:

* {{< linkWithTitle "cd-as-a-service/setup/blue-green.md" >}}
* {{< linkWithTitle "cd-as-a-service/setup/canary.md" >}}    

[Install the Armory CD (Spinnaker) plugin]({{< ref "cd-as-a-service/plugin-spinnaker" >}}) if you want to integrate Armory CD-as-a-Service into your pipelines.



