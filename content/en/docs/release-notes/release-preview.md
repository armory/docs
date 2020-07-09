---
title: Release Preview
description: "Learn about some of the upcoming changes to Spinnaker and their impact."
---

## Overview

Learn about some of the upcoming major changes to Spinnaker by the open source community and Armory. Included in this page are the implications of upcoming changes. Armory will incorporate this information into the release notes when appropriate, but this page is meant to be a preview and advance notice.

This page is divided between a preview of Open Source Spinnaker and Armory's extensions of it.

## Open Source

### Changes to Spinnaker services

#### Gate

**Change**: Lore te gatesum

* **Impact**: Make sure you hit 88 MPH before Biff shows up.
* **Version**: x.y.z

**Change**: Lore te gatesum
* **Impact**: Make sure you hit 88 MPH before Biff shows up.
* **Version**: x.y.z

**Change**: Lore te gatesum
* **Impact**: Make sure you hit 88 MPH before Biff shows up.
* **Version**: 

#### Fiat

**Change**: Lore te fiatsum
* **Impact**: Don't let Gizmo get wet.
* **Version**: 

#### Igor

**Change**: Lore te igor
* **Impact**: Don't cross the streams.
* **Version**:

### Breaking Change for Kubernetes Run Job stage

#### Change

Spinnaker no longer automatically appends a unique suffix to the name of jobs created by the Kubernetes Run Job stage. Prior to this release, if you specified `metadata.name: my-job`, Spinnaker would update the name to `my-job-[random-string]` before deploying the job to Kubernetes. As of 1.22, the job’s name will be passed through to Kubernetes exactly as supplied.

To continue having a random suffix added to the job name, set the `metadata.generateName` field instead of `metadata.name`, which causes the Kubernetes API to append a random suffix to the name.

This change is particularly important for users who are using the preconfigured job stage for Kubernetes, or who are otherwise sharing job stages among different pipelines. In these cases, jobs are often running concurrently, and it is important that each job have a unique name. In order to retain the previous behavior, these users will need to manually update their Kubernetes job manifests to use the generateName field.

#### Impact

Users of Spinnaker >= 1.20.3 can opt in to this new behavior by setting `kubernetes.jobs.append-suffix: false` in their `clouddriver-local.yml`.

As of Spinnaker 1.22, this new behavior is the default. Users can still opt out of the new behavior by setting `kubernetes.jobs.append-suffix: true` in their `clouddriver-local.yml`. This will cause Spinnaker to continue to append a suffix to the name of jobs as in prior releases.

The ability to opt out of the new behavior will be removed in OSS Spinnaker 1.23. The above setting will have no effect, and Spinnaker will no longer append a suffix to job names. It is thus strongly recommended that 1.22 users who opt out update any necessary jobs and remove the setting before upgrading to Spinnaker 1.23.

#### Version
Open Source Spinnaker 1.22 (Armory Spinnaker 2.22)

## Armory 

### Spinnaker Operator

#### Change

Currently, Halyard manages Spinnaker's configs and lifecycle. Spinnaker users are accustomed to running `hal deploy apply` after making a change. If you have looked at Armory's documentation recently, you might have noticed that alongside the Halyard commands you are used to, Operator sections containing equivalent `yaml` configs for the Spinnaker Operator have started showing up.   

#### Impact

Nothing if you are happy with Halyard and want to continue to use it. 

If you want to make your Spinnaker deployment more Kubernetes native though, Operator provides that pathway. The service `yaml` files that you edited manually or through `hal` commands are traded out for manifests that you can store in source control, facilitating collaboration. 

#### Version
Armory's extended Spinnaker Operator is available now. In addition, Armory's extended Halyard continues to be available.