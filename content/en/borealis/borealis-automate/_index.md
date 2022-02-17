---
title: Integrate Borealis & Automate Deployments
linktitle: Integrate & Automate
description: >
  Project Borealis and the CLI can be integrated with any of your tools and scripts that support invoking a CLI as part of its workflow. This gives you the ability to automatically deploy apps using Borealis as part of existing workflows.

aliases:
  - /borealis/quick-start/borealis-integrate/
weight: 40
---



## {{% heading "prereq" %}}

Before you get started, ensure that the requirements listed on [Requirements]({{< ref "borealis-requirements" >}}) are met and that you can log in to the [Armory Cloud Console](https://console.cloud.armory.io/).

## Create service account credentials

Service account credentials are machine-to-machine client credentials that the Borealis CLI uses to authenticate with Armory's hosted cloud services when you use the CLI as part of an automated workflow. These credentials are passed through the `clientID` and `clientSecret` parameters.

To create service account credentials, perform the following steps:

{{< include "aurora-borealis/borealis-client-creds.md" >}}

Armory recommends that you store these credentials in a secret engine that is supported by the tool you want to integrate Borealis with.

## GitHub Actions

Armory has a GitHub action available on the marketplace for integrating Project Borealis with your GitHub repo. For more information, see the [repo](https://github.com/armory/cli-deploy-action) or the [Borealis Deployment GitHub Action page]({{< ref "borealis-gh-action" >}}).

## Jenkins

Jenkins supports invoking a CLI as a step in a pipeline. 

## Tekton

Tekton supports invoking a CLI as a step in a pipeline.