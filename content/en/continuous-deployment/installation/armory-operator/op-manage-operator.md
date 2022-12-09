---
title: Manage Operator
linkTitle: Manage Operator
weight: 50
description: >
  Manage, upgrade, or uninstall the Armory Operator.
---

{{< include "armory-operator/os-operator-blurb.md" >}}
## Upgrade the Operator

>Do not manually change Docker image tags in your existing manifest files. Operator computes the compatible Halyard version, so manually updating image tags is an **unsupported** upgrade method and may cause issues.

Use the `kubectl replace` command to replace your Operator deployment. See the `kubectl replace` [docs](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#replace) for an explanation of this command.

1. Download the Operator version you want to upgrade to:

   In the following command, replace `<version>` with the specific version or "latest" for the most recent version.

   ```bash
   bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/download/<version>/manifests.tgz | tar -xz'
   ```

1. Update CRDs across the cluster:

   ```bash
   kubectl replace -f deploy/crds/
   ```

1. Update the Operator:

   ```bash
   kubectl -n spinnaker-operator replace -f deploy/operator/cluster
   ```

## Uninstall the Operator

Uninstalling the Operator involves deleting its deployment and `SpinnakerService` CRD. When you delete the Operator CRD, Kubernetes deletes any installation created by Operator. This occurs because the CRD is set as the owner of the resources, so they get garbage collected.

You can remove this ownership relationship so that Armory Enterprise is not
deleted when deleting the Operator by [removing Operator ownership of
resources](#remove-operator-ownership-of-spinnaker-resources).

### Remove Operator ownership of Armory Enterprise resources

Run the following script to remove ownership of Armory resources, where `NAMESPACE` is the namespace where Armory Enterprise is installed:

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
