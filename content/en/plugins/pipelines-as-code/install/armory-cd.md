---
title: Enable Pipelines-as-Code in Armory Continuous Deployment
linkTitle: Armory CD
weight: 1
description: >
  Learn how to enable Armory CD's Pipelines-as-Code feature.
---

## {{% heading "prereq" %}}

* You are running Armory Continuous Deployment.
* You manage your instance using the Armory Operator. 

Pipelines-as-Code is a built-in feature of Armory CD. You only need to configure your repo, enable the Dinghy service, and apply your changes to use Pipelines-as-Code.

## Where to configure the service

* If you are using the `spinnaker-kustomize-patches` repo, put your config in the `armory/features/pipelines-as-code/features.yml` file.
* If you are using a single `spinnakerservice.yml` manifest, put your config in the `spec.spinnakerConfig.config.armory.dinghy` section. 

  ```yaml
  apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
  kind: SpinnakerService
  metadata:
    name: spinnaker
  spec:
    spinnakerConfig:
      config:
        armory:
          dinghy:
            enabled: true
  ```


## Configure your repo

{{< include "plugins/pac/before-enable-repo.md" >}}

{{< tabpane text=true right=true  >}}
{{% tab header="**Version Control**:" disabled=true /%}}
{{% tab header="GitHub"  %}}
{{< include "plugins/pac/config-github.md" >}}
{{% /tab %}}
{{% tab header="Bitbucket/Stash"  %}}
{{< include "plugins/pac/config-bitbucket.md" >}}
{{% /tab %}}
{{% tab header="GitLab"  %}}
{{< include "plugins/pac/config-gitlab.md" >}}
{{% /tab %}}
{{< /tabpane >}}

## Enable Pipelines-as-Code

{{< tabpane text=true right=true  >}}
{{% tab header="spinnaker-kustomize-patches"  %}}
The Dinghy service is already enabled in the `armory/features/pipelines-as-code/features.yml` file, so you only need to modify your Kustomization recipe. In the `components` section of your `kustomization.yml` file, add an entry for Pipelines-as-Code:

```yaml
components:
  - core/base
  - core/persistence/in-cluster
  - targets/kubernetes/default
  - armory/features/pipelines-as-code/
```

Apply your updates.

{{% /tab %}}
{{% tab header="spinnakerservice.yml"  %}}
Add `enabled: true` to your `dinghy` section.

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true
```

Apply your updates.

{{% /tab %}}
{{< /tabpane >}}


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/install/configure.md" >}}