---
title: Get Started with the GitHub Integration Plugin
linkTitle: Get Started
weight: 2
description: >
   In this section, learn how to install the GitHub Integration Plugin for Spinnaker and Armory Continuous Deployment. Use the Armory Operator with Armory CD. Spinnaker users can install the plugin using the Spinnaker Operator or Halyard.
---

{{% cardpane %}}
{{% card header="Armory CD<br>Armory Operator" %}}
Use a Kustomize patch to install the plugin.

1. Create a GitHub App and install it in your repo or organization.
1. Configure the plugin with your GitHub repo(s) and/or organization(s).
1. Install the plugin using the Armory Operator.

[Instructions]({{< ref "plugins/github-integration/install/armory-cd" >}})
{{% /card %}}

{{% card header="Spinnaker<br>Spinnaker Operator" %}}
Use a Kustomize patch to install the plugin.

1. Create a GitHub App and install it in your repo.
1. Configure the plugin with your GitHub repo(s) and/or organization(s).
1. Install the plugin using the Spinnaker Operator.

[Instructions]({{< ref "plugins/github-integration/install/spinnaker-operator" >}})
{{% /card %}}

{{% card header="Spinnaker<br>Halyard" %}}
Use Spinnaker local config files to install the plugin.

1. Create a GitHub App and install it in your repo.
1. Configure the plugin with your GitHub repo(s) and/or organization(s).
1. Install the plugin in local config files and apply those changes using Halyard.

[Instructions]({{< ref "plugins/github-integration/install/spinnaker-halyard" >}})
{{% /card %}}
{{% /cardpane %}}