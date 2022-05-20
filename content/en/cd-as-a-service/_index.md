---
title: Armory Continuous Deployment-as-a-Service
linkTitle: Armory CD-as-a-Service
exclude_search: true
no_list: true
description: >
  Use Armory Continuous Deployment-as-a-Service to continuously deliver your apps to your Kubernetes clusters. Armory CD-as-a-Service integrates with external automation tools so you can create your own CI/CD pipelines.
---

## Overview of Armory CD-as-a-Service

Armory CD-as-a-Service delivers intelligent deployment-as-a-service that supports advanced deployment strategies so developers can focus on building
great code rather than deploying it. By automating code deployment across all of your Kubernetes environments, Armory CD-as-a-Service removes demands on developers and reduces the risk of service disruptions due to change failures. It does this by seamlessly integrating pre-production verification tasks with advanced production deployment strategies. This mitigates risks by providing deployment flexibility while limiting blast radius, which leads to a better customer experience. Best of all, Armory CD-as-a-Service doesn’t require migrating to a new deployment platform. It easily plugs into any existing SDLC.

{{< include "cdaas/mermaid/how-it-works.md" >}}

See the [Architecture]({{< ref "cd-as-a-service/concepts/architecture" >}}) and [System Requirements]({{< ref "cd-as-a-service/release-notes/requirements">}}) pages for details.

For a full list of features and pricing, see the [Armory Continuous Deployment-as-a-Service product page](https://www.armory.io/products/continuous-deployment-as-a-service/).

## Start using Armory CD-as-a-Service

The **Get Started** section contains guides that walk you through the core functionality. The {{< linkWithTitle "cd-as-a-service/setup/get-started.md" >}} guide shows you how to complete registration, create machine credentials, and install the Remote Network Agent in your Kubernetes cluster. You can complete the process in under 10 minutes.

When you have an app ready to deploy to Kubernetes, read the {{< linkWithTitle "cd-as-a-service/setup/cli.md" >}} guide to learn how to install the CLI, create a deployment file, and deploy your app.

After you've completed those guides, you can follow the {{< linkWithTitle "cd-as-a-service/tutorials/deploy-demo-app.md" >}}, in which you fork a demo app repo and deploy that app to your Kubernetes cluster.

In addition to deployment using the CLI, you can start a deployment from your GitHub workflow. Read the {{< linkWithTitle "cd-as-a-service/setup/gh-action.md" >}} guide to integrate Armory CD-as-a-Service's GitHub Action into your workflow.

Learn how to configure deployment strategies with these guides:

* {{< linkWithTitle "cd-as-a-service/setup/blue-green.md" >}}
* {{< linkWithTitle "cd-as-a-service/setup/canary.md" >}}    

[Install the Armory CD (Spinnaker) plugin]({{< ref "cd-as-a-service/plugin-spinnaker" >}}) if you want to integrate Armory CD-as-a-Service into your pipelines.

