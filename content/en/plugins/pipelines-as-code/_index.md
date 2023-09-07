---
title: Pipelines-as-Code
linkTitle: Pipelines-as-Code
description: >
   Armory Pipelines-as-Code enables pipeline definitions to be managed as code in GitHub, BitBucket, or GitLab.  It operates as a service/plugin for open source Spinnaker and as feature in Armory Continuous Deployment.
no_list: true
---

![Proprietary](/images/proprietary.svg) [![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) 

## Advantages to using Pipelines-as-Code

{{< include "plugins/pac/pac-advantages.md" >}}

## Installation

Pipelines-as-Code is a feature in Armory CD, so you only need to enable the service. For Spinnaker, however, you need to install both the Dinghy service and the Spinnaker plugin.

<!-- https://www.docsy.dev/docs/adding-content/shortcodes/#card-panes -->

{{% cardpane %}}
{{% card header="Armory CD<br>Armory Operator" %}}
Use Kustomize patches to enable the service.

1. Configure the Dinghy service.
1. Enable the Dinghy service.

[Instructions]({{< ref "plugins/pipelines-as-code/install/armory-cd" >}})
{{% /card %}}

{{% card header="Spinnaker<br>Spinnaker Operator" %}}
Use Kustomize patches to deploy the service and install the plugin.

1. Configure the Dinghy service.
1. Configure the plugin.
1. Install both at the same time.

[Instructions]({{< ref "plugins/pipelines-as-code/install/spinnaker-operator" >}})
{{% /card %}}

{{% card header="Spinnaker<br>Halyard and kubectl" %}}
Use Kubernetes manifests to deploy the service and Spinnaker local config files to install the plugin.

1. Create ServiceAccount, ClusterRole, and ClusterRoleBinding.
1. Configure the Dinghy service in a ConfigMap.
1. Deploy the Dinghy service using `kubectl`.
1. Add plugin to Gate and Echo local config files.
1. Install the plugin using `hal deploy apply`.

[Instructions]({{< ref "plugins/pipelines-as-code/install/spinnaker-halyard" >}})
{{% /card %}}
{{% /cardpane %}}

## Compatibility

{{< include "plugins/pac/compat-matrix.md" >}}

## Version control systems

{{< include "plugins/pac/pac-vcs.md" >}}

## Features

{{< include "plugins/pac/pac-features.md" >}}
