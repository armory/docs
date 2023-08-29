---
title: Install Pipelines-as-Code in Spinnaker (Spinnaker Operator)
linkTitle: Spinnaker - Operator
weight: 3
description: >
  Learn how to install Armory Pipelines-as-Code in a Spinnaker instance managed by the Spinnaker Operator.
---

## Overview

In this guide, you use the Kustomize files in the [`spinnaker-kustomize-patches` repo](https://github.com/armory/spinnaker-kustomize-patches) to deploy the service and install the plugin. You do need to update the contents of some files.

### Compatibility

{{< include "plugins/pac/compat-matrix.md" >}}

## {{% heading "prereq" %}}

* You are running open source Spinnaker.
* You manage your instance using the Spinnaker Operator and the `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches). If you are using Halyard, see {{< linkWithTitle "plugins/pipelines-as-code/install/spinnaker-halyard.md" >}}.

## Find the files

You can find the Pipelines-as-Code files in the `spinnaker-kustomize-patches` repo's `plugins/oss/pipelines-as-code` directory.  

* `kustomization.yml`: Kustomize build file
* `deployment.yml`: `spin-dinghy` Deployment manifest
* `dinghy.yml`: service config
* `pac-plugin-config.yml`: plugin config
* `service.yml`: `spin-dinghy` Service manifest
* `spinnaker.yml`: Spinnaker service mapping 
* `versions` directory: contains version-specific values that Kustomize inserts into the manifest during generation

The `spinnaker-kustomize-patches/recipes` directory contains the example `kustomization-oss-pac.yml` recipe. You can use that recipe or copy the entries to your  recipe. This guide uses the `kustomization-oss-pac.yml` recipe for examples.

## Configure the service

### Set your Spinnaker version

Make sure the service version is compatible with your Spinnaker version.

You specify the version in the `patchesStrategicMerge` section of `plugins/oss/pipelines-as-code/kustomization.yml`. You can find supported versions in the `plugins/oss/pipelines-as-code/versions` directory. For example, if you are running Spinnaker 1.27.x, replace `./versions/v-1.28.yml` with `./versions/v-1.27.yml`.

```yaml
patchesStrategicMerge:
  - ./pac-plugin-config.yml
  - ./versions/v-1.28.yml
```

### Configure your repo

{{% alert title="Important" color="primary" %}}
Configure your repo in the `plugins/oss/pipelines-as-code/dinghy.yml` file.
{{% /alert %}}

{{< include "plugins/pac/before-enable-repo.md" >}}

{{< tabpane text=true right=true  >}}
{{% tab header="**Version Control**:" disabled=true /%}}
{{% tab header="GitHub"  %}}
{{< include "plugins/pac/config-github-spinnaker.md" >}}
{{< include "plugins/pac/config-github-common.md" >}}
{{% /tab %}}
{{% tab header="Bitbucket/Stash"  %}}
{{< include "plugins/pac/config-bitbucket-spinnaker.md" >}}
{{< include "plugins/pac/config-bitbucket-common.md" >}}
{{% /tab %}}
{{% tab header="GitLab"  %}}
{{< include "plugins/pac/config-gitlab-spinnaker.md" >}}
{{< include "plugins/pac/config-gitlab-common.md" >}}
{{% /tab %}}
{{< /tabpane >}}


## Configure the plugin

In `pac-plugin-config.yml`, make sure the `version` number is compatible with your Spinnaker instance.

<details><summary><strong>Show the manifest</strong></summary>
{{< github repo="armory/spinnaker-kustomize-patches" file="plugins/oss/pipeline-as-a-code/pac-plugin-config.yml" lang="yaml" options="" >}}
</details><br />

## Deploy

This step deploys the Dinghy service and installs the plugin. If you want to see the generated manifest before you deploy, execute `kubectl kustomize`.

Apply the updates to your Kustomization file.

```bash
kubectl apply -k <kustomization-directory-path>
```

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/install/configure.md" >}}