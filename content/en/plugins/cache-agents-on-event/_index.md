---
title: Cache Agents On Event Plugin for Spinnaker
linkTitle: Cache-Agents-On-Event
no_list: true
description: >
  The rate limit handling plugin enhances Spinnaker's functionality by addressing rate limit issues commonly encountered when using AWS providers, particularly in scenarios involving EC2 and ECS. The plugin leverages AWS SNS (Simple Notification Service) to receive events and employs a notification handling service to manage data and gate services effectively.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## Cache Agents On Event features

The Cache Agents On Event Plugin provides the following features:

- Manually triggers a cache refresh within Spinnaker, allowing users to fetch the latest data from AWS providers. This is useful in scenarios where rate limits are reached, and real-time data is needed.
- Dynamically adjusts the polling interval for data retrieval from AWS providers. This feature provides flexibility in managing the frequency of API calls, helping to mitigate rate limit issues.
- Seamless integration with AWS SNS for event-driven communication. The plugin receives notifications from SNS whenever a change is made, ensuring timely responses to rate limit issues.
- Implements an event scheduler that coordinates with the notification handling service. This scheduler is designed to be invoked by AWS SNS, ensuring that events related to rate limit changes are efficiently processed.
- Recognizes the need for different configurations in non-production environments. Users can set a longer polling interval in non-production environments to reduce the frequency of API calls without compromising the overall functionality.

The Cache Agents On Event plugin uses [AWS Config](https://docs.aws.amazon.com/config/latest/developerguide/notifications-for-AWS-Config.html) to send events to Spinnaker through a new endpoint in gate service.

## How the plugin works
AWS SNS Integration:
The plugin seamlessly integrates with AWS SNS to establish a reliable communication channel. AWS SNS is configured to send notifications whenever a change is detected in the AWS environment, such as rate limit adjustments or IAM role modifications.

Event Scheduler Initialization:
Upon receiving a notification from AWS SNS, the plugin's event scheduler is initialized. This scheduler acts as the orchestrator, coordinating the subsequent actions to manage rate limit issues.
Event Handling Workflow:

The event handling workflow is triggered by the event scheduler and consists of the following steps:
Event Validation: The plugin validates the incoming event, ensuring it is legitimate and corresponds to a relevant change in the AWS environment.
Decision Logic: Based on the type of event (e.g., rate limit increase, IAM role modification), the plugin determines the appropriate action to take.

!https://slabstatic.com/prod/uploads/n4300ziu/posts/images/BW42mtckyCvkxpntQLSlGM-k.png

## Compatibility matrix

{{< include "plugins/cats/compat-matrix.md" >}}

## Installation paths

{{% card header="Spinnaker<br>Spinnaker Operator" %}}
Use Kustomize patches to deploy the service and install the plugin.

1. [Meet the prerequisites](#before-you-begin)
1. [Configure the plugin](#configure-the-plugin)
1. [Install the plugin](#install-the-plugin)
1. [Configure the provider infrastructure](#configure-infra)


[Instructions]({{< ref "plugins/pipelines-as-code/install/spinnaker-operator" >}})
{{% /card %}}