---
title: Pipelines-as-Code
linkTitle: Pipelines-as-Code
description: >
   Armory Pipelines-as-Code for Spinnaker and Armory Continuous Deployment enables pipeline version control using GitHub or BitBucket.
no_list: true
aliases:
   - /continuous-deployment/armory-admin/dinghy-enable/
   - /continuous-deployment/spinnaker-user-guides/dinghy-arm-cli/
   - /continuous-deployment/spinnaker-user-guides/using-dinghy/
---

![Proprietary](/images/proprietary.svg)



## Advantages to using Pipelines-as-Code

Armory's _Pipelines-as-Code_ feature provides a way to specify pipeline definitions in source code repos such as GitHub and BitBucket.

The Pipelines-as-Code installation includes a service called _Dinghy_, which keeps the Spinnaker pipeline in sync with what you define in a _dinghyfile_ in your repo. Also, you can make a pipeline by composing other pipelines, stages, or tasks and templating certain values.

> GitHub is in the process of replacing `master` as the name of the default base branch. Newly created repos use `main`. As this transition happens, confirm what branch your repo is using as its base branch and explicitly refer to that branch when configuring Armory features such as Pipelines-as-Code. For more information, see GitHub's [Renaming](https://github.com/github/renaming) information.

## Compatibility

| Armory CD (Spinnaker) Version | Pipelines-as-Code Service Version    |  Pipelines-as-Code Plugin Version    |
|:-------------------------- |:------------------------------ | :------------------------------ |
|2.28 (1.28) | 2.28 | 2.28 |
|2.27 (1.27) | 2.27 | 2.27 |
|2.26 (1.26) | 2.26 | 2.26 |


## Version control systems

| Feature          | Version   | Armory CD Version | Spinnaker Version |Notes                                                                                                               |
| ---------------- | --------- | ------------------------- | --------| ------- |
| BitBucket Cloud  |           | All supported versions    |  1.26+   |                                                                                |
| BitBucket Server | 4.x - 6.x | All supported versions    |  1.26+  | BitBucket Server 7.x is not officially supported due to changes in webhook handling and may not behave as expected. |
| GitHub           |           | All supported versions    |  1.26+  | Hosted or cloud |
| GitLab          |           | All supported versions    |  1.26+  | Hosted or cloud  |

## Features

| Feature       | Armory CD Version | Spinnaker Version | Notes   |
| ------------- | ----------------- | ----------------- | ------- |
| [Fiat service account integration]({{< ref "plugins/pipelines-as-code/install/configure#fiat" >}})                   | All supported versions    | 1.26+ |                 |
| GitHub status notifications                                                            | All supported versions    |   1.26+ |                                              |
| [Local modules for development]({{< ref "plugins/pipelines-as-code/use#local-module-functionality" >}}) | All supported versions    |    1.26+ |                                                  |
| Modules                                                                                | All supported versions   1.26+ |   | Templatize and reuse pipeline snippets across applications and teams |
| [Pull Request Validation]({{< ref "plugins/pipelines-as-code/install/configure#pull-request-validations" >}})        | 2.21 or later             |   1.26+ |                                                         |
| [Slack notifications]({{< ref "plugins/pipelines-as-code/install/configure#slack-notifications" >}})                 | All supported versions    |  1.26+ |                                                            |
| [Webhook secret validation]({{< ref "plugins/pipelines-as-code/use#webhook-secret-validation" >}})      | All supported versions    |    1.26+ |                                                       |

### Templating languages

To create a dinghyfile, you can use one of the following templating languages:

* HashiCorp Configuration Language (HCL)
* JSON
* YAML

### ARM CLI

The ARM CLI is a tool to render dinghyfiles and modules. Use it to help develop and validate your pipelines locally.

You can find the latest version on [Docker Hub](https://hub.docker.com/r/armory/arm-cli).

## Installation

1. Create an access token so that Pipelines-as-Code can access your dinghyfiles.
1. Configure and install Pipelines-as-Code in Kubernetes and your [Armory Continuous Deployment]({{< ref "plugins/pipelines-as-code/install/cdsh" >}}), [Spinnaker (Halyard)]({{< ref "plugins/pipelines-as-code/install/spinnaker-halyard" >}}), or [Spinnaker (Operator)]({{< ref "plugins/pipelines-as-code/install/spinnaker-operator" >}}) instance.
1. [Configure additional features]({{< ref "plugins/pipelines-as-code/install/configure#additional-options" >}}) as needed.
