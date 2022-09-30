---
title: Instructions for Trying Armory Continuous Deployment Self-Hosted
linkTitle: Try Armory CD
description: >
  Install a lightweight Docker image of Armory CD for evaluation and proofs of concept.
exclude_search: true
toc_hide: true
aliases:
  - /armory-enterprise/try/
  - /armory-enterprise/quick-spin-instructions/
---

![Proprietary](/images/proprietary.svg)

Thank you for signing up to try Armory Continuous Deployment. Use these instructions to obtain and quickly install a containerized Armory CD instance for evaluating the self-hosted solution.[Contact Armory](https://www.armory.io/contact-us/) if you have questions about using the product! Your feedback helps shape future development.

{{% alert title="Tip" %}}
If you have not already done so, sign up for access to the Armory Continuous Deployment Try version here: [Try Armory CD](https://armory2020dev.wpengine.com/quick-spin/) page.
{{% /alert %}}

Use this containerized version of Armory to run a minimal instance for evaluating the Armory CD Self-Hosted product. The easy install container comes configured with a sample application and three pipelines for you to start your continuous deployment journey.

{{% alert title="Warning" color="warning" %}}
Do not use this evaluation product as a production environment.
{{% /alert %}}
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
### Running the default pipelines
1. Click **Applications** on the top menu bar.
1. On the **Applications** screen, click **my-first-application**.
1. Click **Pipelines** in the left navigation menu.
1. Select **Configure** for the **prepare-quick-spin-environment** pipeline.
1. In the **Parameters** section, update the **Name** and **Label** values to create a unique deployment.
1. In the **Notifications** section, click **Add Notification Preference**.
1. In the **Edit Notification** window, select **Email** from the **Notify via** drop-down, enter your email address in the **Email Address** field, and select all the options in the **Notify when** list. Click **Update**.
1. Click **Save Changes**.
1.  Select **Pipelines** from the left navigation menu to go back to the **Pipelines** screen.
1. Click **Start Manual Execution** for the **prepare-quick-spin-environment** pipeline.
1. In the **Select Execution Parameters** window, click **Run** to execute the pipeline that prepares the deployment environment.

{{< alert color="success" >}}Your pipeline is deployed. When it completes you can try out the `basic-deployment` pipeline.
{{< /alert >}}

### Deploy the sample application
1.  Select **Pipelines** from the left navigation menu to go back to the **Pipelines** screen.
1. Click **Start Manual Execution** for the **basic-deployment** pipeline.
1. In the **Select Execution Parameters** window, click **Run** to execute the pipeline that prepares the deployment environment.
1. This pipeline is configured for you to provide a judgement. When the application is ready for the deploy task you must manually approve the pipeline to complete the process. Right-click on the pipeline progress bar, at the judgement, and select **Continue** to approve the pipeline and complete the deployment. 

{{< alert color="success" >}}Your pipeline is deployed. Run it again to see what happens when you do not approve the deploy task to continue. Use the `teardown-quick-spin environment` pipeline to remove the a deployment.
{{< /alert >}}

## Armory CD easy install container limitations and troubleshooting

The Armory CD instance is configured for easy installation, evaluation, testing, and proof of concept use. It has the following usage limitations:

- Support for Blue/Green (red/black in Spinnaker lingo) and Highlander        deployment strategies (Canary not supported with this offering)
- Service providers are limited to Kubernetes
- Port `9000` must be open to deploy the service
- This release does not support local cluster deployments