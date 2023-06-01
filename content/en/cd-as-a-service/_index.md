---
title: Armory Continuous Deployment-as-a-Service
linkTitle: Armory CD-as-a-Service
no_list: true
description: >
  Use Armory CD-as-a-Service to continuously deliver your apps to your Kubernetes clusters. CD-as-a-Service (CDaaS) integrates with external automation tools so you can create your own CI/CD pipelines.
---

## What is CD-as-a-Service?

Armory CD-as-a-Service is a single control plane that allows you to deploy to multiple Kubernetes clusters using our secure 
one-way agents. These agents enable multi-cluster orchestration and advanced deployment strategies, such as canary and 
blue/green, for your applications.


## How does it work?

1. Install an agent in your cluster to communicate with Armory CDaaS
2. Install the Armory CLI on your machine
3. Configure your CDaaS deployment yaml with paths to your K8s manifests
4. Issue the CLI deploy command and 🚀🚀🚀


## What can I do with it?

- A merge with main automatically kicks off a deploy to staging, and a webhook automatically triggers integration tests to run. If the tests fail, the deployment is rolled back automatically. If they pass, the app is deployed to prod.
- Deploy a new version of your app to 10% of servers (optionally using service mesh). Use RBAC to require an approval by users with a particular role before the app can be deployed to a greater percentage of servers
- Integrate with metrics providers to only allow the next deployment phase if certain metrics pass


## Core Features

- Multi-cluster support
- Automated rollbacks
- Reliable deployment strategies
  - Blue/green
  - Canary
- Traffic management
  - istio
  - linkerd
- Automated canary analysis with metrics providers integration
    - Prometheus
    - Datadog
    - New Relic
- CI integrations
  - GitHub Actions
  - Jenkins
  - Spinnaker
  - CircleCI
- Security
  - RBAC
  - Two-factor authentication
  - SSO
  - Secure secret storage
  
The [Armory CDaaS](https://www.armory.io/products/continuous-deployment-as-a-service/) product page contains a full list of features and pricing.

## We take security seriously

- SOC2 certified
- Agent explainer
- Secrets handling

## Demo

{{< youtube-enhanced id="r29UCKMXEi4" title="CD-as-a-Service Simplifies Your Deployment Process" widthPercent="60" heightPercent="100" >}}


## Start using Armory CD-as-a-Service

The **Get Started** section contains guides that walk you through the core functionality. 

* {{< linkWithTitle "cd-as-a-service/setup/quickstart.md" >}} guide shows you how to sign up for an account, connect to your Kubernetes cluster, and deploy an example app.
* {{< linkWithTitle "cd-as-a-service/setup/deploy-your-app.md" >}} guide to learn how to create a deployment file for your own app and then deploy using the CLI.
* {{< linkWithTitle "cd-as-a-service/setup/gh-action.md" >}} guide walks you through integrating Armory CD-as-a-Service's GitHub Action into your workflow.

Learn how to configure deployment strategies with these guides:

* {{< linkWithTitle "cd-as-a-service/setup/blue-green.md" >}}
* {{< linkWithTitle "cd-as-a-service/setup/canary.md" >}}    

To integrate CD-as-a-Service into your Spinnaker pipelines, install the [Armory CD plugin]({{< ref "cd-as-a-service/plugin-spinnaker" >}})
</br>
</br>

