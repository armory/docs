---
title: Install Armory Enterprise for Spinnaker in Air-Gapped Environments
linkTitle: Air-Gapped Environments
weight: 1
no_list: true
description: >
  Options for deploying Armory Enterprise in an environment that is isolated from the internet.
categories: ["install"]
tags: ["air-gapped"]
---

{{< include "armory-license.md" >}}

## Overview of air-gapped environments

An air-gapped deployment environment is one where any combination of the following conditions is true:

- Your deployment environment, such as a Kubernetes cluster, doesn't have internet access AWS S3 bucket and `docker.io`.
- No ability for engineers to deploy with Halyard from their machines.

If your deployment environment is air-gapped, you need to host the Armory Enterprise Bill of Materials (BOM) and Docker images in a location that your deployment environment can access. To set this up, you need public internet access so you can get the BOM and images, authority to create or access internal storage and image hosting, and permissions to move the Armory Enterprise materials to your internal systems.  

The process for deploying Armory Enterprise in an air-gapped environment is different depending on whether you are using Halyard or the Armory Operator. The first step in both cases, though, is to familiarize yourself with the Armory Enterprise Bill of Materials.

## {{% heading "prereq" %}}

* You have access to public AWS S3 buckets and docker.io.
* You have installed the [AWS CLI](https://aws.amazon.com/cli/).


## Inspect the Armory Enterprise Bill of Materials

Armory Enterprise's Bill of Materials (BOM) is stored in the public S3 bucket `halconfig`. You can see the contents of this bucket using the AWS CLI:

```bash
aws s3 ls s3://halconfig
```

There are `bom` and `profiles` directories as well as four files: `versions-edge.yml`, `versions-ossedge.yml`, `version-rc.yml`, and `versions.yml`.

You can view the content of `s3://halconfig/versions.yml` by executing:

```bash
aws s3 cp s3://halconfig/versions.yml -
```

Output is similar to:

```yaml
latestHalyard: 1.10.1
latestSpinnaker: 2.25.0
versions:
    - version: 2.25.0
      alias: OSS Release 1.25.3
      changelog: https://docs.armory.io/docs/release-notes/rn-armory-spinnaker/armoryspinnaker_v2-25-0/
      minimumHalyardVersion: 1.10.1
      lastUpdate: "1616710502000"
```

The `bom` folder contains files for each release. To see the BOM for a specific release, you can run:

```bash
 aws s3 ls s3://halconfig/bom/<release-number>.yml
```

Then you can inspect the file's contents. For example, to see the BOM for release 2.25.0:

```bash
aws s3 cp s3://halconfig/bom/2.25.0.yml -
```

Output is similar to:

```yaml
version: 2.25.0
timestamp: "2021-03-25 09:28:32"
services:
    clouddriver:
        commit: de3aa3f0
        version: 2.25.3
    deck:
        commit: 516bcf0a
        version: 2.25.3
    dinghy:
        commit: 522e67e5
        version: 2.25.1
    echo:
        commit: 3a098acc
        version: 2.25.2
    fiat:
        commit: ca75f0d0
        version: 2.25.3
    front50:
        commit: 502b753e
        version: 2.25.2
    gate:
        commit: "47352833"
        version: 2.25.5
    igor:
        commit: 252dbd5c
        version: 2.25.2
    kayenta:
        commit: "72616529"
        version: 2.25.2
    monitoring-daemon:
        version: 2.25.0
    monitoring-third-party:
        version: 2.25.0
    orca:
        commit: 53f48823
        version: 2.25.2
    rosco:
        commit: 272f4f82
        version: 2.25.2
    terraformer:
        commit: 5dcae243
        version: 2.25.0
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
```

## {{% heading "nextSteps" %}}

Follow the instructions for your deployment method: {{< linkWithTitle "ag-operator.md" >}} or {{< linkWithTitle "ag-halyard.md" >}}.
