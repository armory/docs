---
title: Dinghy Events
draft: true
description: >
  Events provide end users access to runtime information about their pipelines-as-code configurations by adding a new tab to the Armory Cloud UI.
---
![Proprietary](/images/proprietary.svg)
{{% alert title="Info" color="warning" %}}{{< include "saas-status.md" >}}{{% /alert %}}

With Dinghy Events, users can troubleshoot and resolve most common
pipelines-as-code issues. You can learn how the feature works in the
[Feature Overview](#feature-overview) section and get a rundown of the user
experience in the [User Guide](#user-guide) section. For a general overview of
Armory's Pipelines as Code feature and the Dinghy service, see
[Using Pipelines as Code]({{< ref "using-dinghy" >}}).

## Feature Overview

Dinghy Events enhance existing pipeline processing by annotating events and
storing them for each pipeline. The Armory Cloud UI retrieves these
events and displays them in a new tab. Here is what a sample interaction with this
feature enabled looks like:

![](/images/dinghy/dinghy-events-user-flow.png)

1. User commits a `dinghyfile` to their repository and a webhook notification
is triggered.
1. Dinghy records and persists events while processing the `dinghyfile`.
1. User navigates to the Dinghy Events tab to view processing status.

## User Guide

### Enabling Dinghy Events

While this feature is in development, Armory must enable the feature for you in
Armory Cloud. If you already have Pipelines as Code and the Dinghy service
enabled, continue to the next section. If not, gather the following information:

- An authentication token that has access to your repositories
- The organization and repository where you will store your Dinghy templates
- If you self-host your source control system, the URL where the SCM API is
exposed

Once you are ready, reach out to Armory.

### Using Dinghy Events

If you have never used Armory's Pipelines as Code feature before, start with
[Using Pipelines as Code]({{< ref "using-dinghy" >}}) to learn how to use the
feature before moving forward.

With Dinghy Events, you author and commit `dinghyfiles` just like you did
previously. In addition, you can now navigate to the Dinghy Events tab in your
Armory Cloud instance to see recent publishing events.

![](/images/dinghy/dinghy-events-mvp-default-view.png)

You can sort by several fields in the table view by clicking on their headings.
When you click anywhere inside an Event row, you can see details related to the
event.

![](/images/dinghy/dinghy-events-mvp-log-view.png)

From this view, you can inspect the webhook payload that triggered a processing
event as well as the Dinghy logs related to that pipeline.
