---
title: Deploy a Demo App Tutorial
linktitle: Deploy a Demo App
exclude_search: true
description: >
  Learn how to deploy a demo app to a Kubernetes cluster using Project Borealis.
---

## Objectives

In this tutorial, you configure your Kubernetes environment for the demo app and then deploy using Borealis.

## {{% heading "prereq" %}}

* You have access to a Kubernetes cluster and have installed `kubectl`. Your cluster should have at least 4 nodes available for the demo app.
* You have [set up your Borealis account]({{< ref "borealis-org-get-started" >}}).
* You have [installed the `armory` CLI]({{< ref "borealis-cli-get-started" >}}) and [Helm](https://helm.sh/docs/intro/install/).
* You have access to a GitHub account so you can fork the demo project.

## 1. Fork and clone the repo

Fork and then clone the [demo repo](https://github.com/armory/docs-cdaas-demo) to the machine where you installed `kubectl` and the `armory` CLI.

The demo deploys the following:

- A simple microservice called Potato Facts, which has an API for facts about potatoes; Armory engineers created this app for demo purposes only.
- A Potato Facts load balancer
- Prometheus

In the `configuration` directory is a `setup.sh` script that sets up your Kubernetes infrastructure and connects it to Armory Cloud.

## 2. Create credentials

Create a new set of credentials for the demo Remote Network Agents. Name the credentials "demo-app".

{{< include "aurora-borealis/borealis-client-creds.md" >}}

## 3. Set up the demo environments in Kubernetes

1. Make sure you are connected to the Kubernetes cluster you want to install the demo app on.
1. Log into your Borealis environment using the CLI:

   ```bash
   armory login --envName "<envName>"
   ```

   `--envName <envName` is optional. Replace `<envName` with the name of your Borealis environment if you have access to multiple environments.

1. Navigate to the `docs-cdaas-demo` directory and run the setup script using the "demo app" credentials you created for this tutorial.

   ```bash
   bash configuration/setup.sh <client-ID> <client-secret>
   ```

   After the script completes successfully, you can view the connected Remote Network Agents on the Armory Cloud console's **Networking** > **Agents** screen.

## 4. Add Prometheus integration

In the Armory Cloud console, navigate to **Configuration** > **Canary Analysis** > **Integrations**. Add a new Integration with the following information:

* **Type**: `Prometheus`
* **Name**: `Demo-Prometheus`
* **Base URL**: `http://prometheus-kube-prometheus-prometheus.demo-infra:9090/`
* **Remote Network Agent**: `demo-prod-us-cluster`
* **Authentication Type**: `None`


## 5. Deploy the demo app

The deployment file is called `deploy.yml`. From the `docs-cdaas-demo` directory, run:

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

Deployment to `prod-us` and `prod-eu` requires manual approval, so be sure to approve in the UI.

## Tear down

You can run the `destroy.sh` script to uninstall Prometheus and the Remote Network Agents. This script also deletes the Kubernetes namespaces created by the `setup.sh` script.

## Troubleshooting


@TODO need to add where to look when a deployment fails - logs??


### Deployment times out

Because Borealis deploys to 100% of nodes on initial deployment, you may run out of space. Increasing the number of nodes should solve the issue.

## {{% heading "nextSteps" %}}

* [Introduction to webhook-based approvals]({{< ref "cdaas-webhook-approval" >}}) and [detailed tutorials]({{< ref "cdaas-webhooks" >}}).


<br>