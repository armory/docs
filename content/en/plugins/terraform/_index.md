---
title: Terraform Integration Plugin
linkTitle: Terraform
description: >
  The Terraform Integration plugin enables provisioning infrastructure using Terraform as part of your Spinnaker and Armory Continuous Deployment pipelines.   
no_list: true
---

![Proprietary](/images/proprietary.svg) [![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}})

## Overview of Terraform Integration

Armory's Terraform Integration feature integrates your infrastructure-as-code Terraform workflow into your SDLC. The integration interacts with a source repository you specify to deploy your infrastructure as part of a Spinnaker pipeline.

## Supported Terraform versions

{{< include "plugins/terraform/terraform-versions.md" >}}

Armory ships several versions of Terraform as part of the Terraform Integration feature. The Terraform binaries are verified by checksum and with Hashicorp's GPG key before being installed.

When creating a Terraform Integration stage, pipeline creators select a specific available version from a list of available versions:

![Terraform version to use](/images/plugins/terraform/terraform_version.png)

>All Terraform stages within a pipeline that affects state must use the same Terraform version.

## Supported Terraform features

{{< include "plugins/terraform/features.md" >}}

## Installation

Terraform Integration is a feature in Armory CD, so you only need to enable the service. For Spinnaker, however, you need to install both the Terraform Integration service and the Spinnaker plugin.

{{< cardpane >}}
{{< card header="Armory CD<br>Armory Operator" >}}
Use Kustomize patches to enable the service.

1. Enable Terraform Integration.
1. Configure

[Instructions]({{< ref "plugins/terraform/install/armory-cd" >}})
{{< /card >}}

{{< card header="Spinnaker<br>Spinnaker Operator" >}}
Use Kustomize patches to deploy the service and install the plugin.

1. Configure the Dinghy service.
1. Configure the plugin.
1. Install both at the same time.

[Instructions]({{< ref "plugins/terraform/install/spinnaker-operator" >}})
{{< /card >}}

{{< card header="Spinnaker<br>Halyard and kubectl" >}}
Use Kubernetes manifests to deploy the service and Spinnaker local config files to install the plugin.

1. Create ServiceAccount, ClusterRole, and ClusterRoleBinding.
1. Configure the Terraform Integration service in a ConfigMap.
1. Deploy the Terraform Integration service using `kubectl`.
1. Install the plugin using `hal deploy apply`.

[Instructions]({{< ref "plugins/terraform/install/spinnaker-halyard" >}})
{{< /card >}}
{{< /cardpane >}}
