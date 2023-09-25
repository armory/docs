---
title: GiHub API Plugin Release Notes
linkTitle: Release Notes
weight: 99
description: >
  Github API Plugin for Spinnaker release notes.
---

## Release notes

### v1.0 

Date: September 2023

Initial release

#### Known issues

* The GitHub API plugin conflicts with the Armory.Header plugin's default version installed in Armory Continuous Deployment 2.30.x. 

  * **Fix**: Update the Armory.Header plugin to v0.2.0+

* The workflow run for the stages **Workflow Dispatch** and **Repository Dispatch** must have a minimum run duration of 30 seconds. If the duration is less than 30 seconds, Spinnaker and Armory CDSH might fail to fetch the workflow details, causing the run to fail with a timeout error.
