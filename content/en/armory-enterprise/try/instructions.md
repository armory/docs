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

Thank You for signing up to try Armory Continuous Deployment. Use these instructions to obtain and quickly install a containerized Armory CD instance for evaluating the self-hosted solution.[Contact Armory](https://www.armory.io/contact-us/) if you are interested in using this product! Your feedback helps shape future development.

> Do not use this Early Access product as a production environment.

Use this containerized version of Armory to run a minimal instance for evaluating the Armory CD Self-Hosted product. The easy install container comes configured with a sample application and three pipelines for you to start your continuous deployment journey.

## {{% heading "prereq" %}}

1. Ensure you have installed [Docker](https://docs.docker.com/get-docker/) on your host machine.
1. Your host machine must be able to run a container with the following resource needs:

   * 4 vCPU
   * 8 GB RAM
   * 2 GB disk space
   * Make sure Docker is running on your host machine.
   * Your non-local Kubernetes cluster configured for the Armory CD Self-Hosted easy install container. The docker script expects a ~/.kube/quick-spin-sa.kubeconfig file to be present. This file is created when you run the pre-install script. If you are using a different kubeconfig file, you must copy it to the ~/.kube/quick-spin-sa.kubeconfig file.

## Get the easy install container

1. Pull the `armory/quick-spin` [image](https://hub.docker.com/r/armory/quick-spin) by executing:

   ```bash
   docker pull armory/quick-spin
   ```

2. Run the image:

   ```bash
   docker run --name quick-spin --rm -p 9000:80 -t armory/quick-spin:latest
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
The provided instance deploys a basic NGINX instance and sets up a minimal deployment configuration. Now you can start using Spinnaker to deploy your own applications.
{{< /alert >}}
## Use Armory CD Self-Hosted
1. Launch Armory CD in your browser on `localhost:9000`.
2. Click **Applications** on the top menu bar.
3. On the **Applications** screen, click **my first application**.
4. Click **Pipelines** in the left navigation menu.
5. Select **Configure** for the **prepare-quick-spin-environment** pipeline.
6. In the **Parameters** section, update the **Name** and **Label** values to create a unique deployment.
7. In the **Notifications** section, click **Add Notification Preference**.
8. In the **Edit Notification** window, select **Email** from the **Notify via** drop-down, enter your email address in the **Email Address** field, and select all the options in the **Notify when** list. Click **Update**.
9. Click **Save Changes**.
10. Select **Pipelines** from the left navigation menu to go back to the **Pipelines** screen.
11. Click **Start Manual Execution** for the **prepare-quick-spin-environment** pipeline.
12. In the **Select Execution Parameters** window, click **Run** to execute the pipeline that prepares the deployment environment.

{{< alert color="success" >}}Your pipeline is deployed. When it completes you can try out the `basic-deployment` pipeline. Use the `teardown-quick-spin environment` pipeline to remove the a deployment.{{< /alert >}}

## Armory CD easy install container limitations and troubleshooting

The Armory CD instance is configured for easy installation, evaluation, testing, and proof of concept use. It has the following usage limitations:

- Support for Blue/Green (red/black in Spinnaker lingo) and Highlander deployment strategies (Canary not supported with this offering)
- Service providers are limited to Kubernetes
- Port `9000` must be open to deploy the service
- This release does not support local cluster deployments