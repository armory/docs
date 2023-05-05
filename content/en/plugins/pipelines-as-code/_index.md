---
title: Pipelines-as-Code
linkTitle: Pipelines-as-Code
description: >
   Armory Pipelines-as-Code for Spinnaker and Armory Continuous Deployment enables pipeline version control using GitHub or BitBucket. Pipelines-as-Code is a feature in Armory CD and a service/plugin for open source Spinnaker.
no_list: true
aliases:
   - /continuous-deployment/armory-admin/dinghy-enable/
   - /continuous-deployment/spinnaker-user-guides/dinghy-arm-cli/
   - /continuous-deployment/spinnaker-user-guides/using-dinghy/
---

![Proprietary](/images/proprietary.svg)

## Advantages to using Pipelines-as-Code

Armory's _Pipelines-as-Code_ feature provides a way to specify pipeline definitions in source code repos such as GitHub and BitBucket.

The Pipelines-as-Code has two components: 1) a Spinnaker plugin; and 2) a service called _Dinghy_, which keeps the Spinnaker pipeline in sync with what you define in a _dinghyfile_ in your repo. You can also make a pipeline by composing other pipelines, stages, or tasks and templating certain values.

>GitHub is in the process of replacing `master` as the name of the default base branch. Newly created repos use `main`. As this transition happens, confirm what branch your repo is using as its base branch and explicitly refer to that branch when configuring Armory features such as Pipelines-as-Code. For more information, see GitHub's [Renaming](https://github.com/github/renaming) information.


## Installation

Pipelines-as-Code is a feature in Armory CD, so you only need to enable the service. For Spinnaker, however, you need to install both the Dinghy service and the Spinnaker plugin.

{{< cardpane >}}
{{< card header="Armory CD<br>Armory Operator" >}}
Use Kustomize patches to enable the service.

1. Configure the Dinghy service.
1. Enable the Dinghy service.

[Instructions]({{< ref "plugins/pipelines-as-code/install/armory-cd" >}})
{{< /card >}}

{{< card header="Spinnaker<br>Spinnaker Operator" >}}
Use Kustomize patches to deploy the service and install the plugin.

1. Configure the Dinghy service.
1. Configure the plugin.
1. Install both at the same time.

[Instructions]({{< ref "plugins/pipelines-as-code/install/spinnaker-operator" >}})
{{< /card >}}

{{< card header="Spinnaker<br>Halyard and kubectl" >}}
Use Kubernetes manifests to deploy the service and Spinnaker local config files to install the plugin.

1. Create ServiceAccount, ClusterRole, and ClusterRoleBinding.
1. Configure the Dinghy service in a ConfigMap.
1. Deploy the Dinghy service using `kubectl`.
1. Add plugin to Gate and Echo local config files.
1. Install the plugin using `hal deploy apply`.

[Instructions]({{< ref "plugins/pipelines-as-code/install/spinnaker-halyard" >}})
{{< /card >}}
{{< /cardpane >}}

## Compatibility

{{< include "plugins/pac/compat-matrix.md" >}}


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
| Pull Request Validation      | 2.21 or later             |   1.26+ |                                                         |
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
