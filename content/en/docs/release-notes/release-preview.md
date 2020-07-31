---
title: Release Preview for Armory Spinnaker 2.22 (OSS 1.22)
linkTitle: "Next Release"
description: "Learn about some of the upcoming changes to Spinnaker and their impact."
---

## Overview

Learn about some of the upcoming major changes to Spinnaker by the open source community and Armory. Included in this page are the implications of upcoming changes. Armory will incorporate this information into the release notes when appropriate, but this page is meant to be a preview and advance notice.

This page is updated on a regular basis.

## Changes in 2.22 

The release preview for 2.21 has been moved to the [2.21.0 Release Notes]({{< ref "armoryspinnaker_v2-21-0" >}}). Check back for the 2.22 release preview!

## Upcoming major changes 

This section describes upcoming changes that affect more than one service or a change in recommendations.

### Kubernetes Run Job stage names

Spinnaker no longer automatically appends a unique suffix to the name of jobs created by the Kubernetes Run Job stage. Prior to this release, if you specified `metadata.name: my-job`, Spinnaker would update the name to `my-job-[random-string]` before deploying the job to Kubernetes. As of 2.22, the job’s name will be passed through to Kubernetes exactly as supplied.

To continue having a random suffix added to the job name, set the `metadata.generateName` field instead of `metadata.name`, which causes the Kubernetes API to append a random suffix to the name.

This change is particularly important for users who are using the preconfigured job stage for Kubernetes, or who are otherwise sharing job stages among different pipelines. In these cases, jobs are often running concurrently, and it is important that each job have a unique name. In order to retain the previous behavior, these users will need to manually update their Kubernetes job manifests to use the `generateName` field.

#### Impact

Users of Armory Spinnaker >= 2.20.x can opt in to this new behavior by setting `kubernetes.jobs.append-suffix: false` in their `clouddriver-local.yml`.

As of Spinnaker 1.22, this new behavior is the default. Users can still opt out of the new behavior by setting `kubernetes.jobs.append-suffix: true` in their `clouddriver-local.yml`. This will cause Spinnaker to continue to append a suffix to the name of jobs as in prior releases.

The ability to opt out of the new behavior will be removed in Armory Spinnaker 2.23 (OSS Spinnaker 1.23). The `kubernetes.jobs.append-suffix: true` setting will have no effect, and Spinnaker no longer appends a suffix to job names. Armory recommendeds that 2.22 users who opt out of the new behavior update any necessary jobs and remove the `kubernetes.jobs.append-suffix: true` setting before upgrading to Armory Spinnaker 2.23.

#### Version
Armory Spinnaker 2.22 and 2.23 (Open Source Spinnaker 1.22 and 1.23)

### Spinnaker Operator

#### Change

Currently, Halyard manages Spinnaker's configs and lifecycle. Spinnaker users are accustomed to running `hal deploy apply` after making a change. If you have looked at Armory's documentation recently, you may have noticed that alongside the Halyard configs you are used to, Operator sections containing equivalent configs for the Spinnaker Operator have started showing up.   

#### Impact

Nothing if you are happy with Halyard and want to continue to use it. 

If you want to make your Spinnaker deployment more Kubernetes native though, Operator provides that pathway. The service `yaml` files that you edited manually or through `hal` commands are traded out for manifests that you can store in source control, facilitating collaboration. 

#### Version
Armory's extended Spinnaker Operator is available now. In addition, Armory's extended Halyard continues to be available.
