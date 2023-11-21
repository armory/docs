---
title: GiHub Integration Plugin Release Notes
linkTitle: Release Notes
weight: 99
description: >
  Github Integration Plugin for Spinnaker release notes.
---
## v0.3.1 2023/11/21
### Features
- Added support for GitHub Commit Statuses notifications for pipelines and/or stages using Echo service. See [Configure GitHub Commit Status Echo notifications](/plugins/github-integration/install/configure/#configure-github-commit-status-echo-notifications) for more information.
- Added GitHub Commit Status stage for pipelines. See [Create GitHub Commit Status](/plugins/github-integration/use/#create-github-commit-status) for more information.

## v0.2.4 2023/11/21
### Features
- Added support for AuthZ for GitHub App accounts. See [Authorization (AuthZ)](/plugins/github-integration/install/configure/#authorization-authz) for more information.
- Added support for Validating GitHub App accounts access. See [Validating GitHub App accounts access](/plugins/github-integration/install/configure/#validate-github-access) for more information.

## v0.1.2 2023/11/01

### Features
- Added support for Manual (or Rerun) Execution of pipelines with trigger type *GitHub Workflow Trigger*.
- Modified *GitHub Workflow Trigger* & *GitHub Event Trigger* Types to be enabled independently in Deck configuration.  



## v0.1.1 2023/10/18

### Fixes
- Fixed bug where the Igor fastForward admin endpoint didnt include the `githubBuildMonitor` monitor 

## v0.1.0 2023/10/12

### Features

- Initial release

## Known issues

### Armory.Header plugin conflict

**Armory Continuous Deployment**: The GitHub Integration plugin conflicts with the Armory.Header plugin's default version installed in Armory Continuous Deployment 2.30.x. 

**Fix**: Update your GitHub Integration plugin config to include the Armory.Header plugin v0.2.0

{{< include "plugins/github/armory-header-plugin.md" >}}

### **Workflow Dispatch** and **Repository Dispatch** run duration

The workflow run for the stages **Workflow Dispatch** and **Repository Dispatch** must have a minimum run duration of 30 seconds. If the duration is less than 30 seconds, both Spinnaker and Armory CDSH might fail to fetch the workflow details, causing the run to fail with a timeout error.
