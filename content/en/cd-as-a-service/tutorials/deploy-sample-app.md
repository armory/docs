---
title: Deploy a Sample App Tutorial
linktitle: Deploy a Sample App
description: >
  Learn how to deploy a sample app to your Kubernetes cluster using Armory Continuous Deployment-as-a-Service. Use Helm to install the Remote Network Agent. Deploy the sample app to multiple targets.  
aliases:
  - /cd-as-a-service/tutorials/deploy-demo-app/
categories: ["Tutorials"]
tags: ["Webhooks", "GitHub"]
---

## Objectives

This tutorial is designed to use a single Kubernetes cluster with multiple namespaces to simulate multiple clusters. The sample code is in a GitHub repo that you can fork to your own GitHub account.

- [Create Client Credentials](#create-client-credentials) to use when installing Remote Network Agents.
- [Connect your cluster](#connect-your-cluster).
- [Deploy the sample app](#deploy-the-sample-app).
- [Tear down](#tear-down) the environment.

## {{% heading "prereq" %}}

* You have completed the Armory CD-as-a-Service [quickstart]({{< ref "cd-as-a-service/setup/quickstart" >}}), in which you create your login credentials, install the CLI, and deploy a sample app.
* You have installed [Helm](https://helm.sh/docs/intro/install/).
* You have a GitHub account so you can fork the sample project.

## Fork and clone the repo

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) the [sample repo](https://github.com/armory/docs-cdaas-sample) to your own GitHub account and then clone it to the machine where you installed `kubectl` and the `armory` CLI.

The `configuration` directory contains a script to set up Kubernetes cluster and connect it to Armory CD-as-a-Service.

## Create Client Credentials

Create a new set of Client Credentials for the Remote Network Agents. Name the credentials "docs-sample-rna".

{{< include "cdaas/client-creds.md" >}}

## Connect your cluster

Configure the sample environments and install the Remote Network Agents in your Kubernetes cluster.

1. Make sure you are connected to the Kubernetes cluster you want to install the sample app on.
1. Log into your Armory CD-as-a-Service environment using the CLI:

   ```bash
   armory login --envName "<tenant-name>"
   ```

   `--envName` is optional. Replace `<<tenant-name>>` with the name of your Armory CD-as-a-Service tenant if you have access to multiple ones.

1. Navigate to the `docs-cdaas-sample/configuration` directory and run the `setup-helm.sh` script using the "docs-sample-rna" Client Credentials you created for this tutorial.

   The script does the following:

      - Creates four namespaces, one for each Remote Network Agent
      - Creates secrets for each RNA namespace using the Client Credentials
      - Uses Helm to install the Remote Network Agents, one in each RNA namespace
      - Creates four namespaces to mimic different deployment target clusters

   ```bash
   bash setup-helm.sh <client-ID> <client-secret>
   ```

   After the script completes successfully, you can view the connected Remote Network Agents on the CD-as-a-Service Console's **Networking** > **Agents** screen.

## Deploy the sample app

The sample [app](https://hub.docker.com/r/demoimages/bluegreen) is a simple webserver and a corresponding `Service`. You can find the Kubernetes manifest is the `manifests` directory. The CD-as-a-Service deployment file is called `deploy.yml` and is at the root level.

You are going to deploy the sample app to four targets: test, staging, prod-us, and prod-eu. Each target defines the following:

* The RNA to connect to
* The namespace to deploy the app to
* The deployment strategy
* Optionally any deployment constraints

CD-as-a-Service deploys the sample app first to the the `test` target. If that succeeds, CD-as-a-Service deploys to `staging`. CD-as-a-Service deploys to the production targets only if deployment to staging is successful and a user manually approves deployment.

To deploy the sample, navigate to your `docs-cdaas-sample` directory and run:

```bash
armory deploy start -f deploy.yml
```

Output is similar to:

```bash
[2022-04-27T16:24:04-05:00] Deployment ID: 4be2228f-5c46-4574-ad9a-e70e601d94c4
[2022-04-27T16:24:04-05:00] See the deployment status UI:
https://console.cloud.armory.io/deployments/pipeline/4be2228f-5c46-4574-ad9a-e70e601d94c4?environmentId=a8906e61-2388-4daa-b38e-4339390b9447
```

You can check deployment status by accessing the URL included in the output.

Deployment to `prod-us` and `prod-eu` requires manual approval, so be sure to approve in the UI. Additionally, `prod-eu` requires manual approval to move all of the traffic to the new pods, so be sure to look two manual approvals

## Tear down

You can run the `configuration/teardown-helm.sh` script to uninstall the Remote Network Agents and delete both the RNA and app namespaces.

## Troubleshooting

### Deployment times out

Because Armory CD-as-a-Service deploys to 100% of nodes on initial deployment, you may run out of space. Increasing the number of nodes should solve the issue.

## {{% heading "nextSteps" %}}

* [Introduction to leveraging external automation]({{< ref "webhook-approval" >}}) and [detailed tutorial]({{< ref "external-automation" >}}).


<br>