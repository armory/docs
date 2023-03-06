---
title: Manage Armory Continuous Deployment using the Operator
linkTitle: Manage Armory CD
weight: 15
description: >
  Manage, upgrade, or uninstall Armory Continuous Deployment or Spinnaker using the Operator.
---

{{< include "armory-operator/os-operator-blurb.md">}}

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

## Deploy Armory Continuous Deployment

{{< tabs name="deploy" >}}
{{% tabbody name="Manifest" %}}

```bash
kubectl -n <namespace> apply -f <path-to-manifest-file>
```

{{% /tabbody %}}
{{% tabbody name="Kustomize" %}}

```bash
kubctl -n <namespace> apply -k <path-to-kustomize-directory>
```

{{% /tabbody %}}
{{< /tabs >}}

You can watch the installation progress by executing:

```bash
kubectl -n <namespace> get spinsvc spinnaker -w
```

You can verify pod status by executing:

```bash
 kubectl -n <namespace> get pods
 ```

## Upgrade Armory Continuous Deployment

{{< tabs name="upgrade" >}}
{{% tabbody name="Manifest" %}}

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

{{% /tabbody %}}
{{% tabbody name="Kustomize" %}}

Change the `version` field in your Kustomize patch to the target version for the upgrade.

Apply the update:

```bash
kubctl -n <namespace> apply -k <path-to-kustomize-directory>
```

{{% /tabbody %}}
{{< /tabs >}}

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

## Rollback Armory Continuous Deployment

{{< tabs name="rollback" >}}
{{% tabbody name="Manifest" %}}

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

{{% /tabbody %}}
{{% tabbody name="Kustomize" %}}

Change the `version` field in your Kustomize patch to the target version for the rollback.

Apply the update:

```bash
kubctl -n <namespace> apply -k <path-to-kustomize-directory>
```

{{% /tabbody %}}
{{< /tabs >}}

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


## Delete Armory Continuous Deployment

```bash
kubectl -n <namespace> delete spinnakerservice spinnaker
```

## Help resources

{{% include "armory-operator/help-resources.md" %}}

## {{% heading "nextSteps" %}}

* See the {{< linkWithTitle "op-troubleshooting.md" >}} guide if you encounter issues.
