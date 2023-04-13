---
title: Pipelines as Code for Spinnaker and Armory Continuous Deployment
linkTitle: Pipelines as Code
description: >
   Pipelines as Code gives you the ability to manage your pipelines and their templates in source control by creating and maintaining `dinghyfiles` that contain text representations of pipelines. These files are then ingested by Spinnaker or Armory Continuous Deployment to generate pipelines that your app devs can use to deploy their apps.
no_list: true
aliases:
   - /continuous-deployment/armory-admin/dinghy-enable/
   - /continuous-deployment/spinnaker-user-guides/dinghy-arm-cli/
   - /continuous-deployment/spinnaker-user-guides/using-dinghy/
---

![Proprietary](/images/proprietary.svg)

## Advantages to using Pipelines as Code

Armory's _Pipelines as Code_ feature provides a way to specify pipeline definitions in source code repos such as GitHub and BitBucket.

The Pipelines as Code installation provides a service called _Dinghy_, which keeps the pipeline in sync with what is defined in the GitHub repo. Also, you can make a pipeline by composing other pipelines, stages, or tasks and templating certain values.

> GitHub is in the process of replacing `master` as the name of the default base branch. Newly created repos use `main`. As this transition happens, confirm what branch your repo is using as its base branch and explicitly refer to that branch when configuring Armory features such as Pipelines as Code. For more information, see GitHub's [Renaming](https://github.com/github/renaming) information.

## Templating languages

To create `dinghyfiles`, you can use one of the following templating languages:

* HashiCorp Configuration Language (HCL) [![Early Access](/images/ea.svg)]({{< ref "release-definitions#early-release">}})
* JSON [![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}})
* YAML [![Early Access](/images/ea.svg)]({{< ref "release-definitions#early-release">}})

## Version control systems

The following table lists the supported version control systems:

| Feature          | Version   | Armory Continuous Deployment Version | Notes                                                                                                               |
| ---------------- | --------- | ------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| BitBucket Cloud  |           | All supported versions    |                                                                                                                     |
| BitBucket Server | 4.x - 6.x | All supported versions    | BitBucket Server 7.x is not officially supported due to changes in webhook handling and may not behave as expected. |
| GitHub           |           | All supported versions    | Hosted or cloud                                                                                                     |

## Features

The following table lists specific features for Pipelines as Code and their supported versions:

| Feature                                                                                | Armory Continuous Deployment Version | Notes                                                                 |
| -------------------------------------------------------------------------------------- | ------------------------- | --------------------------------------------------------------------- |
| [Fiat service account integration]({{< ref "plugins/pipelines-as-code/enable-cdsh#fiat" >}})                   | All supported versions    |                                                                       |
| GitHub status notifications                                                            | All supported versions    |                                                                       |
| [Local modules for development]({{< ref "plugins/pipelines-as-code/use#local-module-functionality" >}}) | All supported versions    |                                                                       |
| Modules                                                                                | All supported versions    | Templatize and reuse pipeline snippets across applications and teams |
| [Pull Request Validation]({{< ref "plugins/pipelines-as-code/enable-cdsh#pull-request-validations" >}})        | 2.21 or later             |                                                                       |
| [Slack notifications]({{< ref "plugins/pipelines-as-code/enable-cdsh#slack-notifications" >}})                 | All supported versions    |                                                                       |
| [Webhook secret validation]({{< ref "plugins/pipelines-as-code/use#webhook-secret-validation" >}})      | All supported versions    |                                                                       |

## ARM CLI

The ARM CLI is a tool to render `dinghyfiles` and modules. Use it to help develop and validate your pipelines locally.

You can find the latest version on [Docker Hub](https://hub.docker.com/r/armory/arm-cli).

