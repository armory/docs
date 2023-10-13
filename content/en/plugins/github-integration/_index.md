---
title: GitHub Integration Plugin for Spinnaker
linkTitle: GitHub Integration
no_list: true
description: >
  Armory's GitHub Integration plugin for Spinnaker streamlines integration with GitHub Actions, filling the native support gap. The plugin enables easy triggering of GitHub Actions workflows, dynamic control of Spinnaker pipelines based on workflow outcomes, and seamless synchronization of GitHub Deployment statuses with Spinnaker pipeline conclusions.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## GitHub Integration Plugin features

The GitHub Integration Plugin provides the following GitHub integration features:

- Trigger a GitHub Actions workflow from a Spinnaker pipeline using **workflow_dispatch** or **repo_dispatch** events
- Trigger a Spinnaker pipeline automatically when a GitHub workflow finishes successfully
- Trigger a Spinnaker pipeline when GitHub creates a new GitHub Deployment
- Monitor a GitHub workflow and finish pipeline execution based on the GitHub workflow result
- Update GitHub deployment status based on Spinnaker pipeline outcome
- View Github Action Logs in Spinnaker -- there is no need to navigate to GitHub to view the logs

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
