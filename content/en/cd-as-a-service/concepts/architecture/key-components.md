---
title: Armory CD-as-as-Service Key Components
linkTitle: Key Components
description: >
  Learn about the key components that comprise Armory Continuous Deployment-as-a-Service and how they work together to orchestrate deployments. Remote Network Agent (RNA), Kubernetes permissions, networking requirements, CLI, GitHub Action.
weight: 10
aliases:
  - /armory-deployments/architecture/
  - /cd-as-as-service/architecture/
---

<!-- The CDaaS UI links to this page. Do not change the title or headings without checking with engineering. -->

## How Armory CD-as-a-Service works

Armory CD-as-a-Service is a platform of cloud-based services that orchestrate app deployments and monitor their progress. These services have API endpoints with which users and non-cloud services interact via HTTPS or gRPC/HTTP2. The [Networking](#networking) section contains details of the endpoints that need to be whitelisted.

Armory CD-as-a-Service contains components that you manage: the CLI, the Remote Network Agent (RNA), and the GitHub Action (GHA). These components communicate with Armory CD-as-a-Service to deploy your apps to your existing infrastructure.

{{< figure src="/images/cdaas/cdaas-arch.png" alt="CD-as-a-Service High-Level Architecture" height="75%" width="75%" >}}

When you start a deployment from the CLI or the GHA, Armory CD-as-a-Service forwards your deployment request to the designated RNA in your Kubernetes cluster.

You can track the status of a deployment in the Armory CD-as-a-Service UI.

## Key components

### Remote Network Agent (RNA)

The RNA is a Kubernetes Agent that enables Armory CD-as-a-Service to interact with your Kubernetes clusters and orchestrate deployments without direct network access to your clusters. The RNA that you install in your cluster engages in secure communication with Armory CD-as-a-Service over encrypted, long-lived gRPC/HTTP2 connections. The RNA issues calls to your Kubernetes cluster based on requests from Armory CD-as-a-Service.

Once you install the RNA in your cluster, you don't need to update it beyond security updates. Deployment logic is encapsulated in server-side services.

#### Kubernetes permissions for the Remote Network Agent

By default, the RNA is installed with full access to your cluster. At a minimum, the RNA needs permissions to create, edit, and delete all `kind` objects that you plan to deploy with CD-as-a-Service, in all namespaces to which you plan to deploy. The RNA also requires network access to any monitoring solutions or webhook APIs that you plan to forward through it. You can modify permissions, proxy configurations, custom annotations, labels, or environment variables by modifying the Helm chart's configurable values.

### Command Line Interface (CLI)

Users install the CLI locally. The CLI interacts with Armory CD-as-a-Service via REST API. To deploy an app, the user must either log in using the CLI or pass valid authorization credentials to the `deploy` command.

### GitHub Action (GHA)

You can use the `armory/cli-deploy-action` to trigger a deployment from your GitHub workflow. The GitHub Action interacts with Armory CD-as-a-Service via REST API. The GHA requires a valid Client ID and Client Secret be passed to the deploy command.

### Spinnaker plugin

{{< include "cdaas/desc-plugin.md" >}}

## Networking

{{< include "cdaas/req-networking.md" >}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "cd-as-a-service/concepts/architecture/system-requirements.md" >}}
* {{< linkWithTitle "cd-as-a-service/setup/quickstart.md" >}}

<br>
<br>