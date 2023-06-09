---
title: Enable Pipelines-as-Code in Armory Continuous Deployment
linkTitle: Armory CD
weight: 1
description: >
  Learn how to enable Armory CD's Pipelines-as-Code feature.
aliases:
   - /continuous-deployment/armory-admin/dinghy-enable/
---

## {{% heading "prereq" %}}

* You are running Armory Continuous Deployment.
* You manage your instance using the Armory Operator. 

Pipelines-as-Code is a built-in feature of Armory CD. You only need to configure your repo, enable the Dinghy service, and apply your changes to use Pipelines-as-Code.

If you are running open source Spinnaker, see the [Pipelines-as-Code landing page]({{< ref "plugins/pipelines-as-code/#installation" >}}) for installation paths based on whether you are using Halyard or the Spinnaker Operator.

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
  ```

## Enable Pipelines-as-Code

{{< tabpane text=true right=true  >}}
{{% tab header="spinnaker-kustomize-patches"  %}}
The Dinghy service is already enabled in the `armory/features/pipelines-as-code/features.yml` file, so you only need to modify your Kustomization recipe. Add an entry for Pipelines-as-Code in the `components` section of your `kustomization.yml` file:

```yaml
components:
  - core/base
  - core/persistence/in-cluster
  - targets/kubernetes/default
  - armory/features/pipelines-as-code/
```

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

{{% /tab %}}
{{< /tabpane >}}

## Configure your repo

{{< include "plugins/pac/before-enable-repo.md" >}}

{{< tabpane text=true right=true  >}}
{{% tab header="**Version Control**:" disabled=true /%}}
{{% tab header="GitHub"  %}}
{{< include "plugins/pac/config-github-armory.md" >}}
{{< include "plugins/pac/config-github-common.md" >}}
{{% /tab %}}
{{% tab header="Bitbucket/Stash"  %}}
{{< include "plugins/pac/config-bitbucket-armory.md" >}}
{{< include "plugins/pac/config-bitbucket-common.md" >}}
{{% /tab %}}
{{% tab header="GitLab"  %}}
{{< include "plugins/pac/config-gitlab-armory.md" >}}
{{< include "plugins/pac/config-gitlab-common.md" >}}
{{% /tab %}}
{{< /tabpane >}}

## Deploy

Apply your updates.

{{< tabpane text=true right=true  >}}
{{% tab header="spinnaker-kustomize-patches"  %}}
```bash
kubectl apply -k <kustomization-directory-path>
```
{{% /tab %}}
{{% tab header="spinnakerservice.yml"  %}}
```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```
{{% /tab %}}
{{< /tabpane >}}


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/install/configure.md" >}}