---
title: Install or Upgrade the Armory Operator or Spinnaker Operator
linkTitle: Install/Upgrade Operator
weight: 10
description: >
  Install, upgrade, or uninstall the Armory Operator or Spinnaker Operator.
---

{{< include "armory-operator/os-operator-blurb.md" >}}

## Compatibility matrix

{{< include "armory-operator/operator-compat-matrix.md" >}}

## Install the Armory Operator

Decide which Armory Operator release you need based on the compatibility matrix and then follow the directions for [cluster mode or basic mode]({{< ref "continuous-deployment/installation/armory-operator#operator-installation-modes" >}}).

{{< tabpane text=true right=true >}}
{{< tab header="**Operator Mode**:" disabled=true />}}
{{% tab header="Cluster" text=true %}}
{{< include "armory-operator/armory-op-install-cluster.md" >}}
{{% /tab %}}
{{% tab header="Basic" text=true %}}
{{< include "armory-operator/armory-op-install-basic.md" >}}
{{% /tab %}}
{{< /tabpane >}}

## Install the Spinnaker Operator

Decide which Spinnaker Operator release you need based on the compatibility matrix and then follow the directions for [cluster mode or basic mode]({{< ref "continuous-deployment/installation/armory-operator#operator-installation-modes" >}}).

{{< tabpane text=true right=true >}}
{{< tab header="**Operator Mode**:" disabled=true />}}
{{% tab header="Cluster" text=true %}}
{{< include "armory-operator/spin-op-install-cluster.md" >}}
{{% /tab %}}
{{% tab header="Basic" text=true %}}
{{< include "armory-operator/spin-op-install-basic.md" >}}
{{% /tab %}}
{{< /tabpane >}}


## Upgrade the Operator

>Do not manually change Docker image tags in your existing manifest files. Operator computes the compatible Halyard version, so manually updating image tags is an **unsupported** upgrade method and may cause issues.

Use the `kubectl replace` command to replace your Operator deployment. See the `kubectl replace` [docs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#replace) for an explanation of this command.

1. Download the Operator version you want to upgrade to:

   **Armory Operator**

   In the following command, replace `<release-version>` with the specific version or "latest" for the most recent version.

   ```bash
   bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/download/<release-version>/manifests.tgz | tar -xz'
   ```

   **Spinnaker Operator**

   In the following command, replace `<release-version>` with the specific version or "latest" for the most recent version.

   ```bash
   bash -c 'curl -L https://github.com/armory/spinnaker-operator/releases/download/<release-version>/manifests.tgz | tar -xz'
   ```

1. Update CRDs across the cluster using `kubectl replace`:

   ```bash
   kubectl replace -f deploy/crds/
   ```

1. Update the Operator using `kubectl replace`:

   ```bash
   kubectl -n spinnaker-operator replace -f deploy/operator/cluster
   ```

## Uninstall the Operator

Uninstalling the Operator involves deleting its deployment and `SpinnakerService` CRD. When you delete the Operator CRD, Kubernetes deletes any installation created by Operator. This occurs because the CRD is set as the owner of the resources, so they get garbage collected.

You can remove this ownership relationship so that Armory Continuous Deployment is not
deleted when deleting the Operator by [removing Operator ownership of
resources](#remove-operator-ownership-of-spinnaker-resources).

### Remove Operator ownership of Armory Continuous Deployment resources

Run the following script to remove ownership of Armory resources, where `NAMESPACE` is the namespace where Armory Continuous Deployment is installed:

```bash
#! /usr/bin/env bash
NAMESPACE=
for rtype in deployment service
do
    for r in $(kubectl -n $NAMESPACE get $rtype --selector=app=spin -o jsonpath='{.items[*].metadata.name}')
    do
        kubectl -n $NAMESPACE patch $rtype $r --type json -p='[{"op": "remove", "path": "/metadata/ownerReferences"}]'
    done
done
```

After the script completes, delete the Operator and its CRDs from the Kubernetes cluster:

```bash
kubectl delete -n <namespace> -f deploy/operator/<installation type>
kubectl delete -f deploy/crds/
```

## Help resources

{{% include "armory-operator/help-resources.md" %}}
