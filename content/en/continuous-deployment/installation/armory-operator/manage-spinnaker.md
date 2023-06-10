---
title: Manage Spinnaker using the Spinnaker Operator
linkTitle: Manage Spinnaker
weight: 5
description: >
  Manage, upgrade, or uninstall Spinnaker using the Spinnaker Operator for Kubernetes.
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

Change the `version` value in `spinnaker-kustomize-patches/core/patches/oss-version.yml` to the target version for the upgrade.

From the root of your `spinnaker-kustomize-patches` directory, apply the update:

```bash
kubctl -n <namespace> apply -k .
```

## Rollback

Change the `version` value in `spinnaker-kustomize-patches/core/patches/oss-version.yml` to the target version for the upgrade.

From the root of your `spinnaker-kustomize-patches` directory, apply the update:

```bash
kubctl -n <namespace> apply -k .
```

## Remove

```bash
kubectl -n <namespace> delete spinnakerservice spinnaker
```

## Help resources

* Use the [Spinnaker Slack](https://join.spinnaker.io/) `#kubernetes-operator` or `#armory` channel.
* {{< linkWithTitle "continuous-deployment/installation/armory-operator/op-troubleshooting.md" >}}
