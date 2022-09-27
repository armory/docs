---
title: Quick Spin
linkTitle: "quick-spin-instructions"
no_list: true
weight: 3
description: >
  Get an evaluation or testing instance of Spinnaker up and running.
exclude_search: true
toc_hide: true
---
{{< include "experimental-feature.html" >}}

## What is Quick Spin?
Quick Spin is a containerized Armory CD instance that you install with a single shell command. You can use this minimal instance to evaluate the Armory CD Self-Hosted product.

Once you have Quick Spin running, you can use it to evaluate Armory CD Self Hosted and to learn how to use Spinnaker. You can also use Quick Spin to test out Spinnaker features and to learn how to configure Spinnaker. 

Included with the Quick Spin container is a sample application and three sample pipelines that you can use to test out Spinnaker. After installing Quick Spin, you can use the sample application and pipelines to test out Spinnaker features.


> The Quick Spin container is not intended for production use.

## Installing Quick Spin

- To install Quick Spin use the steps provided in {{< linkWithTitle "install-quick-spin" >}}. 
- See the {{< linkWithTitle "quickstart-quick-spin" >}} to get started using Quick Spin.

The provided application deploys a basic NGINX instance and sets up a minimal deployment configuration. To learn more about each pipeline, see the [Quick Spin Pipelines](/armory-enterprise/quickspin/pipelines/) page.

## Using Quick Spin

 Use the following steps to get a deployment running:

1. After opening Quick Spin in your browser (localhost:9000), select Applications >  *my  first application*.
1. Select *Pipelines* for the left navigation menu.
1. Select *Configure* for the `prepare-quick-spin-environment`.
1. Update the *Default Name* and *Default Label* parameters to create a unique deployment.
1. Update the notification options to receive notifications about pipeline activity, select the events you want to receive notifications for, and click *Update*.
1. Click *Save Changes*.
1. Select *Pipleines* for the left navigation menu and click *Start Manual Execution* for the `prepare-quick-spin-environment` pipeline.

{{< alert color="success" >}}Your pipeline is deployed. When it completes you can try out the `basic-deployment` pipeline. Use the `teardown-qick-spin environment` pipeline to remove the a deployment.{{< /alert >}}

### Quick Spin limitations
The Quick Spin Spinnaker instance is configured for easy install and evaluation, testing, or POC use. It has the following usage limitations:
- This container is provided with limited features and supports only Blue Green and Highlander deployment strategy evaluations.