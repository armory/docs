---
title: Install the GitHub Integration Plugin in Spinnaker (Operator)
linkTitle: Spinnaker - Operator
weight: 2
description: >
  Learn how to install Armory's GitHub Integration Plugin in a Spinnaker instance managed by the Spinnaker Operator.  The GitHub Integration plugin enables enhanced Spinnaker-GitHub integration.
---

![Proprietary](/images/proprietary.svg) ![Beta](/images/beta.svg)

## Installation overview

Enabling the GitHub Integration plugin consists of the following steps:

1. [Meet the prerequisites](#before-you-begin)
1. [Create and install a GitHub App](#create-and-install-a-github-app)
1. [Configure the plugin](#configure-the-plugin)
1. [Install the plugin](#install-the-plugin)

## {{% heading "prereq" %}}

{{< include "plugins/github/install-reqs.md" >}}
* You are running open source Spinnaker.
* You manage your instance using the Spinnaker Operator and the `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches). If you are using Halyard, see {{< linkWithTitle "plugins/github-integration/install/spinnaker-halyard.md" >}}.

## Compatibility

{{< include "plugins/github/compat-matrix.md" >}}

## Create and install a GitHub App

{{< include "plugins/github/github-app.md" >}}

## Configure the plugin

Create a `github-integration-plugin.yml` file with the following contents: 

{{< readfile file="/includes/plugins/github/spinnaker-operator.yaml" code="true" lang="yaml" >}}
{{< include "plugins/github/settings-js-config.md" >}}
{{< include "plugins/github/plugin-config.md" >}}

Save the file to your `spinnaker-kustomize-patches/plugins/oss` directory.

### Accounts config example

{{< include "plugins/github/accounts-config-example.md" >}}

## Install the plugin

1. Add the plugin patch to your Kustomize recipe's `patchesStrategicMerge` section. For example:

   {{< highlight yaml "linenos=table,hl_lines=13" >}}
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization
   
   namespace: spinnaker
   
   components:
     - core/base
     - core/persistence/in-cluster
     - targets/kubernetes/default
   
   patchesStrategicMerge:
     - core/patches/oss-version.yml
     - plugins/oss/github-integration-plugin.yml
   
   patches:
     - target:
         kind: SpinnakerService
       path: utilities/switch-to-oss.yml
   {{< /highlight >}}

1. Apply the updates to your Kustomization recipe.

   ```bash
   kubectl apply -k <kustomization-directory-path>
   ```

## {{% heading "nextSteps" %}}

[Learn how to use the GitHub Integration plugin]({{< ref "plugins/github-integration/use" >}}).