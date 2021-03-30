---
title: Configure Spinnaker Using Kustomize
linkTitle: Config Using Kustomize
weight: 10
description: >
  This guide describes how to configure Spinnaker using Kustomize patches.
---

## Why use Kustomize patches for Spinnaker configuration

Even though you can configure Spinnaker or Armory Enterprise in a single manifest file, the advantage of using [Kustomize](https://kustomize.io/) patch files is readability, consistency across environments, and maintenance manageability. You can put each manifest config section in its own file. The `kustomization.yml` file uses the patch files to build a deployment file.

Kustomize is part of `kubectl`, but you can also install Kustomize for standalone use. With Kustomize installed locally, you can run `kustomize build` to print your Spinnaker configuration based on your `kustomization.yml` and patch files.

## Kustomize resources

You should familiarize yourself with Kustomize before you create patch files to configure Spinnaker.

* [Install Kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/)
* [Kustomize introduction](https://kubectl.docs.kubernetes.io/guides/introduction/kustomize/)
* [Kustomization file overview](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/)

## Spinnaker Kustomize patches repo

Armory maintains the [`spinnakaker-kustomize-patches`](https://github.com/armory/spinnaker-kustomize-patches) repository, which contains common configuration options for Spinnaker and Armory Enterprise. This gives you a reliable starting point when adding and removing Armory Enterprise or Spinnaker features.

{{% alert title="Patch Warning" color="warning" %}}
All of the patches in the repo are for configuring Armory Enterprise. To use the patches to configure open source Spinnaker, you must change `spinnaker.armory.io` in the `apiVersion` field to `spinnaker.io`. This is the first line in the patch file.
{{% /alert %}}

To start, create your own copy of the `spinnaker-kustomize-patches` repository
by clicking the `Use this template` button:

![button](/images/kustomize-patches-repo-clone.png)

Once created, clone this repository to your local machine.

If you installed Operator in `basic` mode, you must set the `namespace` field
in your `kustomization.yml` file to the `spinnaker-operator` namespace.  The
permissions in `basic` mode are scoped to a single namespace so it doesn't see
anything in other namespaces.

Once configured, run the following command to install:

```bash
# If you have `kustomize` installed:
kustomize build | kubectl apply -f -


# If you only have `kubectl` installed:

kubectl apply -k .
```

Watch the install progress and check out the pods being created:

```bash
kubectl -n spinnaker get spinsvc spinnaker -w
```

### How configuration works

Armory's configuration is found in a `spinnakerservices.spinnaker.armory.io`
Custom Resource Definition (CRD) that you can store in version control. After
you install the Armory Operator, you can use `kubectl` to manage the lifecycle
of your deployment.

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      # Change the `.x` segment to the latest patch release found on our website:
      # https://docs.armory.io/docs/release-notes/rn-armory-spinnaker/
      version: {{< param armory-version >}}
```

See [the full format]({{< ref "operator-reference" >}}) for more configuration
options.
