---
title: Instructions for Trying Armory Continuous Deployment Self-Hosted
linkTitle: Try Armory CD
description: >
  Use Armory Quick Spin to quickly install a lightweight Docker image of Armory CD for evaluation and proofs of concept.
exclude_search: true
toc_hide: true
aliases:
  - /armory-enterprise/try/
  - /armory-enterprise/quick-spin-instructions/
---

![Proprietary](/images/proprietary.svg)

{{% alert title="Early Access" color="warning" %}}
The information below is written for an Early Access product. [Contact us](https://www.armory.io/contact-us/) if you are interested in using this product! Your feedback helps shape future development.
<br><br>
<b>Do not use this Early Access product as a production environment.
</b>
{{% /alert %}}

## What is Quick Spin?

Quick Spin is a containerized version of Armory CD that you install and run using Docker. You can use this minimal instance to evaluate the Armory CD Self-Hosted product in functional areas such as creating pipelines to deploy an application. Quick Spin comes configured with a sample application and three pipelines to start you on your continuous deployment journey.

## {{% heading "prereq" %}}

1. Ensure you have installed [Docker](https://docs.docker.com/get-docker/) on your host machine.
1. Your host machine must be able to run a container with the following resource needs:

   * 4 vCPU
   * 8 GB RAM
   * 2 GB disk space           

## Pull and run the Quick Spin image

1. Ensure Docker is running on your host machine.
1. Pull the `armory/quick-spin` [image](https://hub.docker.com/r/armory/quick-spin) by executing:

   ```bash
   docker pull armory/quick-spin
   ```

1. Run the image:

   ```bash
   docker run --name quick-spin --rm -p 9000:80 -t armory/quick-spin:latest
   ```

   You should see output similar to this:

   ```bash
   Waiting for Quick-Spin to become ready . . .
   +---------------------------------+
   |                                 |
   | Quick-Spin is ready to go!      |
   |                                 |
   | Go to: http://localhost:9000    |
   |                                 |
   | To stop Quick-Spin press ctrl+c |
   |                                 |
   +---------------------------------+
   ```



## Run pipelines

 Use the following steps to get a deployment running:

1. Launch the Armory CD application in your browser (http://localhost:9000).
1. Click **Applications** on the top menu bar.
1. On the **Applications** screen, click **my  first application**.
1. Click **PIPELINES** in the left navigation menu.
1. Select **Configure** for the **prepare-quick-spin-environment** pipeline.
1. In the **Parameters** section, update the **Name** and **Label** values to create a unique deployment.
1. In the **Notifications** section, click **Add Notification Preference**.
1. In the **Edit Notification** window, select **Email** from the **Notify via** drop-down, enter your email address in the **Email Address** field, and select all the options in the **Notify when** list. Click **Update**.
1. Click **Save Changes**.
1. Select **Pipelines** from the left navigation menu to go back to the **Pipelines** screen.
1. Click **Start Manual Execution** for the **prepare-quick-spin-environment** pipeline.
1. In the **Select Execution Parameters** window, click **Run** to execute the pipeline that prepares the deployment environment.

@TODO Add additional steps

{{< alert color="success" >}}Your pipeline is deployed. When it completes you can try out the `basic-deployment` pipeline. Use the `teardown-qick-spin environment` pipeline to remove the a deployment.{{< /alert >}}

## Armory CD trial version limitations

The Armory CD instance is configured for easy installation, evaluation, testing, and proof of concept use. It has the following usage limitations:

- Only supports Blue/Green and Highlander deployment strategies