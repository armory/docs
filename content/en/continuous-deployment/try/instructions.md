---
title: Instructions for Trying Armory Continuous Deployment Self-Hosted
linkTitle: Try Armory CD
description: >
  Install a lightweight Docker image of Armory Continuous Deployment (CD) for evaluation and proofs of concept.
exclude_search: true
toc_hide: true
aliases:
  - /armory-enterprise/try/
  - /armory-enterprise/quick-spin-instructions/
  - /continuous-deployment/try/
  - /continuous-deployment/quick-spin-instructions/
---

![Proprietary](/images/proprietary.svg)

Thank you for signing up to try Armory CD. Use these instructions to obtain and quickly install a containerized Armory CD instance for evaluating the self-hosted solution. [Contact Armory](https://www.armory.io/contact-us/) if you have questions about using the product! Your feedback helps shape future development.

Use this containerized version of Armory to run a minimal instance for evaluating the Armory CD Self-Hosted product. The easy install container comes configured with a sample application and three pipelines for you to start your Armory CD journey.

> If you have not already done so, please sign up for access to try out [Armory CD Self Hosted](https://www.armory.io/quick-spin/).

> Do not use this evaluation product as a production environment.
## {{% heading "prereq" %}}
* Ensure you have installed [Docker](https://docs.docker.com/get-docker/) on your host machine.
* Your host machine must be able to run a container with the following minimum resource requirements:
  * 4 vCPU
  * 8 GB RAM
  * 20 GB disk space
  * Make sure Docker is running on your host machine.
  * Your non-local Kubernetes cluster configured for the Armory CD Self-Hosted easy install container.
## Configure the cluster
Before you can use the evaluation product, you must configure your Kubernetes cluster to provide access to the easy install container. This is done by creating a namespace in your cluster, creating a service account within that namespace, associating a cluster role binding with that service account, and then generating a kubeconfig using that service account.  This is handled by an executable we provide you through the following command.

   ```bash
   bash <(curl -sL https://go.armory.io/generate-quick-spin-kubeconfig)
   ```


## Install the Armory CD Self-Hosted easy install container
Run the container using Docker Compose by executing:

   ```bash
   curl -sSL https://go.armory.io/quick-spin-compose | docker compose -f - up
   ```
   When the installation is complete the ready banner appears:

   ```bash
   Waiting for Quick-Spin to become ready . . .
   +---------------------------------+
   |                                 |
   | Quick-Spin is ready to go       |
   |                                 |
   | Go to: http://localhost:9000    |
   |                                 |
   | To stop Quick-Spin press ctrl+c |
   |                                 |
   +---------------------------------+
   ```
{{< alert color="success" >}}
The easy install container includes some preconfigured pipelines which will interact with the cluster you provided access to earlier.  These pipelines will create and deploy to the `quick-spin-dev` and `quick-spin-prod` namespaces by default.  

Beyond the default pipelines, you are free to create your own applications and pipelines.
{{< /alert >}}
## Use Armory CD Self-Hosted
Access Armory CD in your browser on [localhost:9000](http://localhost:9000). The main page displays the Armory CD UI.
## Running the sample pipelines
1. Click **Applications** on the top menu bar.
1. On the **Applications** screen, click **my-first-application**.
1. Click **Pipelines** in the left navigation menu.

### Prepare your environment
1. Click **Start Manual Execution** for the **prepare-quick-spin-environment** pipeline.
1. In the **Select Execution Parameters** window, click **Run** to execute the pipeline that prepares the deployment environment.

{{< alert color="success" >}}Your pipeline is executing. When it completes you can try out the `basic-deployment` pipeline.
{{< /alert >}}

### Test the basic-deployment pipeline
1. Select **Pipelines** from the left navigation menu to go back to the **Pipelines** screen.
1. Click **Start Manual Execution** for the **basic-deployment** pipeline.
1. In the **Select Execution Parameters** window, click **Run** to execute the pipeline that prepares the deployment environment.

### Test the promote-to-prod-with-red-black pipeline
1. Select **Pipelines** from the left navigation menu to go back to the **Pipelines** screen.
1. Click **Start Manual Execution** for the **promote-to-prod-with-red-black** pipeline.
1. In the **Select Execution Parameters** window, click **Run** to execute the pipeline that prepares the deployment environment.
1. This pipeline is configured for you to provide a manual judgement. Before the pipeline executes the `Deploy to PROD` stage, a prompt appears which must be approved. Click on the pipeline progress bar for the manual judgement stage and select **Continue** to approve the pipeline and complete the deployment.

> Executing this pipeline multiple times will result in deploying new replica sets into the `quick-spin-prod` namespace. Once the newest replica set is fully available, the previous replica set has traffic to it disabled -- this behavior relies on the `blue/green` deployment strategy

{{< alert color="success" >}}Your pipeline is executing. Run it again to see what happens when you do not approve the deploy task to continue. Use the `teardown-quick-spin environment` pipeline to remove the deployment.
{{< /alert >}}

## Armory CD easy install container limitations and troubleshooting

The Armory CD instance is configured for easy installation, evaluation, testing, and proof of concept use. It has the following usage limitations:

- Support for Blue/Green (formerly red/black in Spinnaker lingo) and Highlander deployment strategies (Canary not currently supported)
- Default providers are limited to Kubernetes using the Kubernetes account you provide access to
- This release does not support local cluster deployments
- Port `9000` must be open to deploy the easy install container