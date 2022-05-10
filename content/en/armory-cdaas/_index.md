---
title: "Armory Continuous Deployment-as-a-Service"
linkTitle: Armory CD-as-a-Service
exclude_search: true
no_list: true
description: >
  Use Armory Continuous Deployment-as-a-Service to continuously deliver your apps to your Kubernetes clusters. Armory Continuous Deployment-as-a-Service integrates with external automation so you can create your own CI/CD pipelines.
---

Project Borealis uses Armory's hosted cloud services to deploy Kubernetes applications to your clusters. When you use the Borealis CLI to deploy your application, the CLI sends the deployment request to Armory's hosted cloud services. In turn, the cloud services communicate with your Kubernetes cluster using Armory's Remote Network Agent (RNA) to initiate the deployment. For a more in-depth look at Borealis, see [Architecture]({{< ref "armory-cdaas/concepts/architecture" >}}).

Borealis supports performing canary deployments. The canary deployment strategy deploys an app progressively to your cluster based on a set of steps that you configure. You set weights (percentage thresholds) for how the deployment should progress and a pause after each weight is met. Borealis works through these steps until your app is fully deployed. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This pause gives you time to assess the impact of your changes. From there, either continue the deployment to the next weight you set or roll back the deployment if you notice an issue.

## Terminology

To help you understand how Borealis works, familiarize yourself with the following terms:

- **Environment**: environments are used in two ways for Borealis, depending on the context.
  - **Cloud Console**: the Borealis backend and UI use environments to isolate users and secrets. Users and secrets for one environment do not have access to other environments. That means a user in environment A cannot access secrets or deployments in environment B.
  - **Deployments**: for deployments, an environment is the collection of configs that you configure to tailor the deployment. It consists of characteristics that define how you deploy your app, including the  target Kubernetes cluster, namespace, deployment strategy, and constraints (dependencies). For example, if you create a `prod` environment for your deployment, you can make it dependent on a `dev` environment and add a deployment strategy that protects `prod` untested changes.
- **Deployment/deploy file**: the deployment file is a YAML file that you use to define where you want to deploy to (the environments), what  you want to deploy (the manifests), and how you want to deploy (the strategy). You can generate a template for the file using the Borealis CLI. For more information, see the [Deployment File Reference]({{< ref "ref-deployment-file" >}}).

## Using Borealis

To start, review the [Requirements]({{< ref "requirements" >}}) and (optionally), the [Architecture]({{< ref "armory-cdaas/concepts/architecture" >}}).

Once you're ready, using Borealis involves two parts:

1. Preparing your deployment target as described in [Get Started with Project Borealis]({{< ref "get-started" >}}). This only needs to be done once per deployment target.
2. Using the Borealis CLI to deploy your app, either manually or programmatically. To learn more, see [Get Started with the CLI to Deploy Apps]({{< ref "armory-cdaas/setup/cli" >}}).

You can do the whole deployment process using the Borealis CLI directly while you are working on defining how you want to deploy apps. When you're ready to scale, integrate Borealis with your existing tools (such as GitHub or Jenkins) to deploy programmatically.

