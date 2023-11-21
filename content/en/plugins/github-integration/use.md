---
title: Use the GitHub Integration Plugin
linkTitle: How to Use
weight: 5
description: >
  Learn how to use the GitHub Integration plugin to trigger Spinnaker pipelines from GitHub and also to trigger GitHub workflows from Spinnaker pipelines.
---

## {{% heading "prereq" %}}

You should be familiar with [GitHub workflows](https://docs.github.com/en/actions/using-workflows/about-workflows).

## Trigger GitHub workflows from Spinnaker pipelines

Use the **Github Integration Workflow Trigger Stage** to trigger your GitHub workflow from your Spinnaker pipeline.

### `workflow_dispatch` event

Configure the **Github Integration Workflow Trigger Stage** as in the following screenshot: 

{{< figure src="/images/plugins/github/workflowDispatch.png" >}}

* **Github Account**: (Required) Select the GitHub Account; this is one of the accounts you configured when you installed the plugin
* **Organization or User**: (Required) The organization or username that should trigger the workflow
* **Project**: (Required) Spinnaker project name
* **Workflow Name**: (Required) The filename of your workflow
* **Git reference (branch or tag name)**: (Required) The branch or tag name that receives the `workflow_dispatch` event
* **Workflow Inputs**: (Optional) Key/value pairs to pass to your GitHub workflow

### `repository_dispatch` event

Configure the **Github Integration Workflow Trigger Stage** as in the following screenshot: 

{{< figure src="/images/plugins/github/repoDispatch.png" >}}

* **Github Account**: (Required) Select the GitHub Account; this is one of the accounts you configured when you installed the plugin
* **Organization or User**: (Required) The organization or username that should trigger the workflow
* **Project**: (Required) Spinnaker project name
* **Event Type**: (Required) The event type that should trigger the workflow
* **Client Payload Inputs**: (Optional) Key/value pairs to pass to your GitHub workflow

## Trigger Spinnaker pipelines from GitHub workflows

### Workflow success trigger

To trigger a Spinnaker pipeline when a GitHub workflow finishes successfully, configure an automated trigger in your pipeline.

{{< figure src="/images/plugins/github/workflowFinish.png" >}}

* **Type**: (Required) Select **GitHub Workflow Trigger**
* **Github Account**: (Required) Select the GitHub Account; this is one of the accounts you configured when you installed the plugin
* **Organization**: (Required) Select the organization associated with the **Github Account**
* **Repository**: (Required) Select the repository that contains the workflow
* **Workflow**: (Required) Select the name of the workflow that Spinnaker should monitor
* **Branch**: (Optional) If specified, only pushes to the branches that match this Java Regular Expression are triggered. Leave empty to trigger builds for every branch.

###  New deployment trigger

To trigger a Spinnaker pipeline when GitHub creates a new deployment, first [create a deployment event webhook in GitHub](https://docs.github.com/en/webhooks/using-webhooks/creating-webhooks). Armory strongly recommends you create a secret for the webhook.

{{< figure src="/images/plugins/github/deploymentCreated.png" >}}

Next, configure an automated trigger to process the deployment event from GitHub.

{{< figure src="/images/plugins/github/deploymentCreated2.png" >}}

* **Type**: (Required) Select **GitHub Event Trigger**
* **GitHub Account**: (Required) Select the GitHub Account; this is one of the accounts you configured when you installed the plugin
* **Organization**: (Required) Select the organization associated with the **Github Account**
* **Repository**: (Required) Select the repository that contains the workflow
* **Secret**: (Optional) Provide the name of the GitHub secret associated with the deployment workflow event webhook; the GitHub Integration Plugin does not process the request when the secrets do not match
* **Environment**: (Optional) If specified, only deployment to the environment that matches this Java Regular Expression is triggered. Leave empty to trigger builds for every environment.

When the pipeline triggered by a deployment event finishes, Spinnaker automatically update the status of the GitHub deployment based on the pipeline's outcome. 

## Fetch release information

You can use the **GitHub Integration Releases Get Details** stage to fetch the latest release information.

{{< figure src="/images/plugins/github/getDetails.png" >}}

* **Github Account**: (Required) Select the GitHub Account; this is one of the accounts you configured when you installed the plugin
* **Retrieve**: (Required) Select **Get Latest Release**
* **Organization or User**: (Required) The organization or username that should trigger the workflow
* **Project**: (Required) Spinnaker project name

## Fetch prerelease information

You can use the **GitHub Integration Releases Get Details** stage to fetch the latest prerelease information.

{{< figure src="/images/plugins/github/preRelease.png" >}}


* **Github Account**: (Required) Select the GitHub Account; this is one of the accounts you configured when you installed the plugin
* **Retrieve**: (Required) Select **Get Latest PreRelease**
* **Organization or User**: (Required) The organization or username that should trigger the workflow
* **Project**: (Required) Spinnaker project name

## Create GitHub Commit Status

The GitHub Commit Status pipeline stage allows you to create a GitHub Commit Status in a repository using the GitHub App
accounts configured in the plugin without the need to configure a notification block in your pipelines and viewing the execution
status of the stage in your pipeline's execution details.

Configure the **Github Integration Commit Status Stage** as in the following screenshot:

{{< figure src="/images/plugins/github/commitStatus.png" >}}

* **GitHub Repo**: (Required) The full repository name including the GitHub Org. For example myorg/mygithubrepo.
* **Commit Ref**: (Required) The commit reference. Can be a commit SHA, branch name (heads/BRANCH_NAME), or tag name (tags/TAG_NAME).
* **Status**: (Required) The state of the status. Can be one of: error, failure, pending, success.
* **Context**: (Required) A string label to differentiate this status from the status of other systems. This field is case-insensitive.
* **Description**: (Optional) A short description of the status.


