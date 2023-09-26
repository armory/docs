---
title: GiHub API Plugin Release Notes
linkTitle: Release Notes
weight: 99
description: >
  Github API Plugin for Spinnaker release notes.
---

## v0.1.0 2023/09

### Features

Initial release

### Known issues

#### Armory.Header plugin conflict

**Armory Continuous Deployment**: The GitHub API plugin conflicts with the Armory.Header plugin's default version installed in Armory Continuous Deployment 2.30.x. 

**Fix**: Update your GitHub API plugin config to include the Armory.Header plugin v0.2.0

{{< include "plugins/github/armory-header-plugin.md" >}}

#### **Workflow Dispatch** and **Repository Dispatch** run duration

The workflow run for the stages **Workflow Dispatch** and **Repository Dispatch** must have a minimum run duration of 30 seconds. If the duration is less than 30 seconds, both Spinnaker and Armory CDSH might fail to fetch the workflow details, causing the run to fail with a timeout error.
