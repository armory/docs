---
title: Manage Operator
linkTitle: Manage Operator
weight: 50
description: >
  Manage, upgrade, or uninstall Spinnaker using the Operator.
---

{{< include "armory-operator/os-operator-blurb.md" >}}

## Uninstall the Operator

Uninstalling the Operator involves deleting its deployment and `SpinnakerService` CRD. When you delete the Operator CRD, Kubernetes deletes any installation created by Operator. This occurs because the CRD is set as the owner of the resources, so they get garbage collected.

There are two ways in which you can remove this ownership relationship so that Spinnaker is not deleted when deleting the Operator: [replace Operator with Halyard](#replace-operator-with-halyard) or [removing Operator ownership of resources](#remove-operator-ownership-of-spinnaker-resources).

### Replace Operator with Halyard

First, export configuration settings to a format that Halyard understands:

1. From the `SpinnakerService` manifest, copy the contents of `spec.spinnakerConfig.config` to its own file named `config`, and save it with the following structure:

   ```yaml
   currentDeployment: default
   deploymentConfigurations:
   - name: default
     <<CONTENT HERE>>
   ```

1. For each entry in `spec.spinnakerConfig.profiles`, copy it to its own file inside a `profiles` folder with a `<entry-name>-local.yml` name.
1. For each entry in `spec.spinnakerConfig.service-settings`, copy it to its own file inside a `service-settings` folder with a `<entry-name>.yml` name.
1. For each entry in `spec.spinnakerConfig.files`, copy it to its own file inside a directory structure following the name of the entry with double underscores (__) replaced by a path separator. For example, an entry named `profiles__rosco__packer__example-packer-config.json` results in the file `profiles/rosco/packer/example-packer-config.json`.

When finished, you have the following directory tree:

```
config
default/
  profiles/
  service-settings/
```

After that, move these files to your Halyard home directory and deploy Spinnaker with the `hal deploy apply` command.

Finally, delete Operator and its CRDs from the Kubernetes cluster.

```bash
kubectl delete -n <namespace> -f deploy/operator/<installation type>
kubectl delete -f deploy/crds/
```

### Remove Operator ownership of Spinnaker resources

Run the following script to remove ownership of Armory resources, where `NAMESPACE` is the namespace where Spinnaker is installed:

```bash
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

* Spinnaker Operator: [Spinnaker Slack](https://join.spinnaker.io/), `#kubernetes-operator` channel
* Armory Operator: contact [Armory Support](https://support.armory.io/)