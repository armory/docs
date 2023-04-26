---
title: Install Pipelines-as-Code in Spinnaker
linkTitle: Spinnaker - Operator
weight: 5
description: >
  Learn how to install Armory Pipelines and Code in a Spinnaker instance managed by the Spinnaker Operator.
---

## Overview

In this guide, you use the Kustomize files in the [`spinnaker-kustomize-patches` repo](https://github.com/armory/spinnaker-kustomize-patches) to deploy the service and install the plugin. You do need to update the contents of some of the files.

1. Clone the spinnaker-kustomize-patches repo
1. change the symlink
1. Update files

## {{% heading "prereq" %}}

* You should familiarize yourself with Pipelines-as-Code [architecture]({{< ref "plugins/pipelines-as-code/architecture" >}}).
* You have created a personal access token in your repo.
* You use the Spinnaker Operator to manage your Spinnaker instance.
* You have created a personal access token for your repo and a Kubernetes secret for that token.

## Clone the repo

Clone the [`spinnaker-kustomize-patches`](https://github.com/armory/spinnaker-kustomize-patches) repo to your local machine. The Pipelines-as-Code recipe is in `recipes/kustomization-oss-pac.yml`, so you need to update the `kustomization.yml` symlink to point to that file. From the root directory, run:

```bash
rm kustomization.yml
ln -s ./recipes/kustomization-oss-pac.yml kustomization.yml
```

You can find the relevant config and install files in `plugins/oss/pipelines-as-code`.

* `kustomization.yml`: Kustomize build file
* `deployment.yml`: `spin-dinghy` Deployment manifest
* `dinghy.yml`: service config
* `pac-plugin-config.yml`: plugin config
* `service.yml`: `spin-dinghy` Service manifest
* `spinnaker.yml`: Spinnaker service mapping 
* `versions` directory: contains version-specific values that Kustomize inserts into the manifest during generation

## Configure the service

### Set the version

Make sure the service version is compatible with your Spinnaker version.

You specify the version in the `patchesStrategicMerge` section of `plugins/oss/pipelines-as-code/kustomization.yml`. 

```yaml
patchesStrategicMerge:
  - ./pac-plugin-config.yml
  - ./versions/v-1.28.yml
```

You can find supported versions in the `plugins/oss/pipelines-as-code/versions` directory. For example, if you are running Spinnaker 1.27.x, you would replace `./versions/v-1.28.yml` with `./versions/v-1.27.yml`.

### Configure your repo

{{< readfile file="/includes/plugins/pac/before-enable-repo.md" >}}


{{< tabpane text=true right=true >}}
{{% tab header="**Version Control**:" disabled=true /%}}
{{% tab header="GitHub"  %}}
{{< readfile file="/includes/plugins/pac/config-github.md" >}}
{{% /tab %}}
{{% tab header="Bitbucket/Stash"  %}}
{{< readfile file="/includes/plugins/pac/config-bitbucket.md" >}}
{{% /tab %}}
{{% tab header="GitLab"  %}}
{{< readfile file="/includes/plugins/pac/config-gitlab.md" >}}
{{% /tab %}}
{{< /tabpane >}}


## Configure the plugin

In `pac-plugin-config.yml`, make sure the `version` number is compatible with your Spinnaker instance.

<details><summary><strong>Show the manifest</strong></summary>
{{< github repo="armory/spinnaker-kustomize-patches" file="plugins/oss/pipeline-as-a-code/pac-plugin-config.yml" lang="yaml" options="" >}}
</details><br />

## Deploy

If you want to see the generated manifest before you deploy, execute `kubectl kustomize`.

From the root directory, Apply the manifest using `kubectl`.

```bash
kubectl apply 
```


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/install/configure.md" >}}