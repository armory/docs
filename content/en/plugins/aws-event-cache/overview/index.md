---
title: Overview
linkTitle: Overview
weight: 1
description: >
  Learn about the AWS Event Cache plugin's features, how the plugin works, Spinnaker version compatibility, and plugin installation paths.
---


## AWS Event Cache features

The AWS Event Cache Plugin provides the following features:

- **Manual cache refresh within Spinnaker**
  * Enables fetching the latest data from AWS providers
  * Useful in scenarios where you've reached rate limits and need real-time data
- **Dynamic polling interval adjustment for data retrieval from AWS providers**
  * Provides flexibility in managing the frequency of API calls, helping to mitigate rate limit issues
- **Seamless integration with AWS SNS** for event-driven communication
  * The plugin receives notifications from SNS whenever a change is made, ensuring timely responses to rate limit issues.
- **An event scheduler** 
  * Coordinates with the notification handling service
  * Designed to be invoked by AWS SNS, ensuring efficient processing of events related to rate limit changes
- **Different configurations for non-production environments**
  * You can set a longer polling interval in non-production environments to reduce the frequency of API calls without compromising overall functionality.

The plugin uses [AWS Config](https://docs.aws.amazon.com/config/latest/developerguide/notifications-for-AWS-Config.html) to send events to Spinnaker through a new endpoint in the Gate service.

## How the plugin works

**AWS SNS Integration**

The plugin seamlessly integrates with AWS SNS to establish a reliable communication channel. AWS SNS is configured to send notifications whenever a change is detected in the AWS environment, such as rate limit adjustments or IAM role modifications.

**Event Scheduler Initialization**

Upon receiving a notification from AWS SNS, the plugin's event scheduler is initialized. This scheduler acts as the orchestrator, coordinating the subsequent actions to manage rate limit issues.
Event Handling Workflow:

The Event Scheduler triggers an event handling workflow that consists of the following steps:

  1. Event Validation: The plugin validates the incoming event, ensuring it is legitimate and corresponds to a relevant change in the AWS environment.
  1. Decision Logic: The plugin determines the appropriate action to take based on the type of event, such as rate limit increase or IAM role modification. 

{{< figure src="architecture.png" >}}

## Compatibility matrix

{{< include "plugins/aws-event-cache/compat-matrix.md" >}}

## Installation paths

{{% cardpane %}}
{{% card header="Armory CD<br>Armory Operator" %}}
Use a Kustomize patch to install the plugin.

1. Install the plugin.
1. Create your AWS Simple Notification Service topic and subscription.

[Instructions]({{< ref "plugins/aws-event-cache/install/armory-cd" >}})
{{% /card %}}

{{% card header="Spinnaker<br>Spinnaker Operator" %}}
Use a Kustomize patch to install the plugin.

1. Install the plugin.
1. Create your AWS Simple Notification Service topic and subscription.

[Instructions]({{< ref "plugins/aws-event-cache/install/spinnaker-operator" >}})
{{% /card %}}

{{% card header="Spinnaker<br>Halyard" %}}
Use Spinnaker local config files to install the plugin.

1. Install the plugin.
1. Create your AWS Simple Notification Service topic and subscription.

[Instructions]({{< ref "plugins/aws-event-cache/install/spinnaker-halyard" >}})
{{% /card %}}
{{% /cardpane %}}