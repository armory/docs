---
title: Manage Armory Continuous Deployment using the Armory Operator
linkTitle: Manage Armory CD
weight: 1
description: >
  Manage, upgrade, or uninstall Armory Continuous Deployment using the Armory Operator.
aliases:
  - /continuous-deployment/installation/armory-operator/op-manage-spinnaker.md  
---

## Kubernetes tools

You use [`kubectl`](https://kubernetes.io/docs/reference/kubectl/) to manage the Armory Continuous Deployment or Spinnaker lifecycle like you do with other applications deployed to Kubernetes. For example:

**List instances**

```bash
kubectl get spinnakerservice --all-namespaces
```

**Describe instances**

You can use `spinsvc` instead of `spinnakerservice`:

```bash
kubectl -n <namespace> describe spinsvc spinnaker
```

Consult the `kubectl` [docs](https://kubernetes.io/docs/reference/kubectl/) for a list of commands.

## Upgrade 

{{< tabpane text=true right=true >}}
{{< tab header="**Method**:" disabled=true />}}
{{% tab header="Kustomize" text=true %}}

Change the `version` value in `spinnaker-kustomize-patches/core/patches/version.yml` to the target version for the upgrade.

From the root of your `spinnaker-kustomize-patches` directory, apply the update:

```bash
kubctl -n <namespace> apply -k .
```

{{% /tab %}}
{{% tab header="Manifest" text=true %}}

Change the `version` field in your manifest file to the target version for the upgrade:

```bash
kind: SpinnakerService
metadata:
 name: spinnaker
spec:
 spinnakerConfig:
   config:
     version: <version>
```

Apply the updated manifest:

```bash
kubectl -n <namespace> apply -f <path-to-manifest-file>
```

{{% /tab %}}
{{< /tabpane >}}

You can view the upgraded services starting up by executing `describe`:

```bash
kubectl -n <namespace>  describe spinsvc spinnaker
```

Verify the upgraded version of Spinnaker:

```bash
kubectl -n <namespace> get spinsvc
```

The command returns information similar to the following:

```
NAME         VERSION
spinnaker    2.20.2
```

`VERSION` should reflect the target version for your upgrade.

## Rollback
{{< tabpane text=true right=true >}}
{{< tab header="**Method**:" disabled=true />}}
{{% tab header="Kustomize" text=true %}}

Change the `version` value in `spinnaker-kustomize-patches/core/patches/version.yml` to the target version for the upgrade.

From the root of your `spinnaker-kustomize-patches` directory, apply the update:

```bash
kubctl -n <namespace> apply -k .
```

{{% /tab %}}
{{% tab header="Manifest" text=true %}}

Change the `version` field in your manifest file to the target version for the rollback:

```bash
kind: SpinnakerService
metadata:
 name: spinnaker
spec:
 spinnakerConfig:
   config:
     version: <version>
```

Apply the updated manifest:

```bash
kubectl -n <namespace> apply -f <path-to-manifest-file>
```

{{% /tab %}}
{{< /tabpane >}}

You can view the rolled back services starting up by executing `describe`:

```bash
kubectl -n <namespace>  describe spinsvc spinnaker
```

Verify the rolled back version of Spinnaker:

```bash
kubectl -n <namespace> get spinsvc
```

The command returns information similar to the following:

```
NAME         VERSION
spinnaker    2.27.2
```

`VERSION` should reflect the target version for your rollback.


## Remove

```bash
kubectl -n <namespace> delete spinnakerservice spinnaker
```



## Help resources

{{% include "armory-operator/help-resources.md" %}}

## {{% heading "nextSteps" %}}

* See the {{< linkWithTitle "op-troubleshooting.md" >}} guide if you encounter issues.
