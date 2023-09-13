---
title: Use the GiHub API Plugin
linkTitle: Use
weight: 5
description: >
  TBD
---


## Trigger GitHub Workflow using workflow_dispatch

To trigger a GitHub Workflow from Spinnaker using the ************************************workflow_dispatch************************************ event, we will use the new **************************Github API Workflow Trigger Stage************************** configured like in the screenshot below. We will have to select the GitHub account, the organization, the repository, the workflow name, and the branch where the workflow should be triggered.

{{< figure src="/images/plugins/github/workflowDispatch.png" >}}

## Trigger GitHub Workflow using repo_dispatch

To trigger a GitHub Workflow from Spinnaker using the ************************************repo_dispatch************************************ event, we will use the new **************************Github API Workflow Trigger Stage************************** configured like in the screenshot below. We will have to select the GitHub account, the organization, the repository, and the **********************event_type********************** that should be used to trigger the workflow.

{{< figure src="/images/plugins/github/repoDispatch.png" >}}

## View Workflow logs in Spinnaker

### Trigger Spinnaker pipeline when a GitHub workflow is finished successfully

To trigger a Spinnaker pipeline when a GitHub workflow is finished successfully we can select the new **GitHub Event Trigger** type from the dropdown. We must select the GitHub account, the organization, the repository, and the workflow Spinnaker should monitor.

{{< figure src="/images/plugins/github/workflowFinish.png" >}}

###  Trigger Spinnaker pipeline when a new GitHub deployment was created

To trigger a Spinnaker pipeline when a new GitHub deployment is created, we can select the new **GitHub Event Trigger** type from the dropdown. We must select the GitHub account, the organization, and the repository. Optionally, but strongly recommended to provide a secret when creating the deployment event webhook in Github. 

{{< figure src="/images/plugins/github/deploymentCreated.png" >}}

The same secret we will use to verify the message received is hashed with the same secret. If not, we will not process the request.

{{< figure src="/images/plugins/github/deploymentCreated2.png" >}}

###  Update GitHub deployment when Spinnaker pipeline is finished

When the pipeline triggered by a deployment event is finished, Spinnaker will automatically update the status of the GitHub deployment based on the conclusion of the Spinnaker pipeline. 

## Fetch release and pre-release information

The ******GitHub API Releases Get Details****** stage can be configured like below to fetch the latest release information.

{{< figure src="/images/plugins/github/getDetails.png" >}}

To fetch the latest pre-release the retrieve action should be ********************************************Get Latest Pre-Release********************************************

{{< figure src="/images/plugins/github/preRelease.png" >}}
