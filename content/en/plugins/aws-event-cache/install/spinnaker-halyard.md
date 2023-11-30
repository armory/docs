---
title: Install the AWS Event Cache Plugin in Spinnaker (Halyard)
linkTitle: Spinnaker - Halyard
weight: 3
description: >
  Learn how to install the AWS Event Cache Plugin in a Spinnaker instance managed by Halyard.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## Installation overview

Enabling the AWS Event Cache plugin consists of the following steps:

1. [Configure the plugin](#configure-the-plugin)
1. [Install the plugin](#install-the-plugin)
1. [Create an AWS SNS topic and subscription](#create-an-aws-sns-topic-and-subscription)


## {{% heading "prereq" %}}

* You have read the AWS Event Cache [overview]({{< ref "plugins/aws-event-cache/overview/index" >}}).
* You are running open source Spinnaker.
* You manage your instance using Halyard. If you are using the Spinnaker Operator, see {{< linkWithTitle "plugins/aws-event-cache/install/spinnaker-operator.md" >}}.


{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. Clouddriver can take an hour or more to restart if you have many accounts configured.

The AWS Event Cache plugin extends Clouddriver and Gate. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. Instead, follow the local config installation method, in which you configure the plugin in each extended service’s local profile.

{{% /alert %}}

## Compatibility

{{< include "plugins/aws-event-cache/compat-matrix.md" >}}

## Configure the plugin



## Install the plugin


## Create an AWS SNS topic and subscription

{{< include "plugins/aws-event-cache/create-aws-sns-subscription.md" >}}