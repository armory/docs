---
title: GitHub Integration Plugin for Spinnaker Overview
linkTitle: Overview
weight: 1
description: >
  Learn about GitHub Integration Plugin features, how the plugin works, different installation paths, and the plugin's compatibility with Armory Continuous Deployment and Spinnaker versions.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)


## GitHub Integration Plugin features

The GitHub Integration Plugin provides the following GitHub integration features:

- [Trigger a GitHub Actions workflow]({{< ref "plugins/github-integration/use#trigger-github-workflows-from-spinnaker-pipelines" >}}) from a Spinnaker pipeline using **workflow_dispatch** or **repository_dispatch** events.
- [Trigger a Spinnaker pipeline automatically when a GitHub workflow finishes successfully]({{< ref "plugins/github-integration/use#workflow-success-trigger" >}}).
- [Trigger a Spinnaker pipeline when GitHub creates a new GitHub Deployment]({{< ref "plugins/github-integration/use#new-deployment-trigger" >}}).
- Monitor a GitHub workflow and finish pipeline execution based on the GitHub workflow result.
- [Update GitHub deployment status based on Spinnaker pipeline outcome]({{< ref "plugins/github-integration/use#create-github-commit-status" >}}).
- View GitHub Action Logs in Spinnaker -- there is no need to navigate to GitHub to view the logs.
- [Validate GitHub access]({{< ref "plugins/github-integration/validate-github-access" >}}) based on configuration assigned to a GitHub App account.
- [Create GitHub commit statuses]({{< ref "plugins/github-integration/commit-status-notifications" >}}) using Echo.
- [Use AuthZ]({{< ref "plugins/github-integration/authz" >}}) for your GitHub Accounts.

The GitHub Integration plugin uses [GitHub Apps](https://docs.github.com/en/apps/overview) to integrate with GitHub. GitHup Apps provide webhooks and narrow, specific permissions. You can install a GitHub App  that gives the GitHub Integration plugin access to all the repos in your GitHub organization, or you can install a Github App that gives the GitHub Integration plugin access to specific repos. You can install as many GitHub Apps as your use case requires.

## How the plugin works with GitHub

```mermaid
graph TD
	Orca -->|Workflow Trigger| Igor
	Gate --> |Trigger based on Deployment event|Echo
	Igor -->|Trigger/Monitor triggered workflows| GitHub
	Echo -->|Pipeline triggers|Orca
	Orca -->|Pipeline notifications|Echo
	GitHub --> |Deployment event| Gate
	Echo --> |Notifications|GitHub
```

For example, the plugin processes a GitHub Deployment event like this:

```mermaid
sequenceDiagram
participant ghActions as "GitHub Workflow job"
participant gh as "GitHub"
participant gate as "Gate"
participant echo as "Echo"
participant orca as "Orca"

ghActions ->> gh: "Create Deployment"
gh ->> ghActions: "Deployment created"
gh ->> gate: "Deployment Event"
gate ->> echo: "Deployment trigger event"
echo ->> orca: "Trigger pipelines matching the Trigger event"
orca ->> gh: "Deployment status update: in_progress, success, failure, or error"
```

## Compatibility matrix

{{< include "plugins/github/compat-matrix.md" >}}

## Installation paths

{{% cardpane %}}
{{% card header="Armory CD<br>Armory Operator" %}}
Use a Kustomize patch to install the plugin.

1. Create a GitHub App and install it in your repo or organization.
1. Configure the plugin with your GitHub repo(s) and/or organization(s).
1. Install the plugin using the Armory Operator.

[Instructions]({{< ref "plugins/github-integration/install/armory-cd" >}})
{{% /card %}}

{{% card header="Spinnaker<br>Spinnaker Operator" %}}
Use a Kustomize patch to install the plugin.

1. Create a GitHub App and install it in your repo.
1. Configure the plugin with your GitHub repo(s) and/or organization(s).
1. Install the plugin using the Spinnaker Operator.

[Instructions]({{< ref "plugins/github-integration/install/spinnaker-operator" >}})
{{% /card %}}

{{% card header="Spinnaker<br>Halyard" %}}
Use Spinnaker local config files to install the plugin.

1. Create a GitHub App and install it in your repo.
1. Configure the plugin with your GitHub repo(s) and/or organization(s).
1. Install the plugin in local config files and apply those changes using Halyard.

[Instructions]({{< ref "plugins/github-integration/install/spinnaker-halyard" >}})
{{% /card %}}
{{% /cardpane %}}
