---
title: Manage Spinnaker using the Operator
linkTitle: Manage Spinnaker
weight: 15
description: >
  Manage, upgrade, or uninstall Spinnaker using the Operator.
---

## Upgrade Armory Enterprise

To upgrade an existing Armory Enterprise deployment, perform the following steps:

1. Change the `version` field in `deploy/spinnaker/basic/SpinnakerService.yml`  file to the target version for the upgrade.
2. Apply the updated manifest:

   ```bash
   kubectl -n spinnaker apply -f deploy/spinnaker/basic/SpinnakerService.yml
   ```

   You can view the upgraded services starting up with the following command:

   ```bash
   kubectl -n spinnaker describe spinsvc spinnaker
   ```

3. Verify the upgraded version of Spinnaker:

   ```bash
   kubectl -n spinnaker get spinsvc
   ```

   The command returns information similar to the following:

   ```
   NAME         VERSION
   spinnaker    2.20.2
   ```

   `VERSION` should reflect the target version for your upgrade.



## Manage Armory Enterprise instances

The Armory Operator allows you to use `kubectl` to manager your Armory Enterprise deployment.

**List Armory Enterprise instances**

```bash
kubectl get spinnakerservice --all-namespaces
```

The short name `spinsvc` is also available.

**Describe Armory Enterprise instances**

```bash
kubectl -n <namespace> describe spinnakerservice spinnaker
```


**Delete Armory Enterprise instances**

```bash
kubectl -n <namespace> delete spinnakerservice spinnaker
```


## Manage Armory Enterprise configuration in a Kubernetes manifest

### Kustomize

Because Armory Enterprise's configuration is now a Kubernetes manifest, you can manage `SpinnakerService` and related manifests in a consistent and repeatable way with [Kustomize](https://kustomize.io/).

The `spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches) has many configuration examples.

```bash
kubectl create ns spinnaker
kustomize build deploy/spinnaker/kustomize | kubectl -n spinnaker apply -f -
```

There are many more possibilities:
- managing manifests of MySQL instances
- ensuring the same configuration is used between Staging and Production Spinnaker
- splitting accounts in their own kustomization for an easy to maintain configuration

See this [repo](https://github.com/armory/spinnaker-kustomize-patches) for examples of common setups that you can adapt to your needs.

### Secret management

You can store secrets in one of the [supported secret engine]({{< ref "secrets#supported-secret-engines" >}}).

#### Kubernetes Secret

With the Armory Operator, you can also reference secrets stored in existing Kubernetes secrets in the same namespace as Spinnaker.

The format is:
- `encrypted:k8s!n:<secret name>!k:<secret key>` for string values. These are added as environment variable to the Spinnaker deployment.
- `encryptedFile:k8s!n:<secret name>!k:<secret key>` for file references. Files come from a volume mount in the Spinnaker deployment.


#### Custom Halyard configuration

To override Halyard's configuration, create a `ConfigMap` with the configuration changes you need. For example, if using [secrets management with Vault]({{< ref "secrets-vault" >}}), Halyard and Operator containers need your Vault configuration:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: halyard-custom-config
data:
  halyard-local.yml: |
    secrets:
      vault:
        enabled: true
        url: <URL of vault server>
        path: <cluster path>
        role: <k8s role>
        authMethod: KUBERNETES
```

Then, you can mount it in the Operator deployment and make it available to the Halyard and Operator containers:

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: spinnaker-operator
  ...
spec:
  template:
    spec:
      containers:
      - name: spinnaker-operator
        ...
        volumeMounts:
        - mountPath: /opt/spinnaker/config/halyard.yml
          name: halconfig-volume
          subPath: halyard-local.yml
      - name: halyard
        ...
        volumeMounts:
        - mountPath: /opt/spinnaker/config/halyard-local.yml
          name: halconfig-volume
          subPath: halyard-local.yml
      volumes:
      - configMap:
          defaultMode: 420
          name: halyard-custom-config
        name: halconfig-volume
```


### GitOps

Armory Enterprise can deploy manifests or Kustomize packages. You can configure Armory Enterprise to redeploy itself (or use a separate Armory Enterprise) with a trigger on the git repository containing its configuration.

A change to Armory Enterprise's configuration follows:

> Pull Request --> Approval --> Configuration Merged --> Pipeline Trigger in Spinnaker --> Deploy Updated SpinnakerService

This process is auditable and reversible.

## Accounts CRD (Experimental)

The Operator has a CRD for Armory Enterprise accounts. `SpinnakerAccount` is defined in an object - separate from the main Spinnaker config - so its creation and maintenance can be automated.

To read more about this CRD, see [SpinnakerAccount](https://github.com/armory/spinnaker-operator/blob/master/doc/spinnaker-accounts.md).



## Uninstall the Armory Operator

Uninstalling the Armory Operator involves deleting its deployment and `SpinnakerService` CRD. When you delete the CRD, any Armory installation created by Operator gets deleted. This occurs because the CRD is set as the owner of the Armory resources, so they get garbage collected.

There are two ways in which you can remove this ownership relationship so that Armory is not deleted when deleting the Operator: [replacing Operator with Halyard](#replacing-operator-with-halyard) or [removing Operator ownership of Armory resources](#removing-operator-ownership-from-spinnaker-resources).

### Replace Operator with Halyard

First, export Armory configuration settings to a format that Halyard understands:
1. From the `SpinnakerService` manifest, copy the contents of `spec.spinnakerConfig.config` to its own file named `config`, and save it with the following structure:

   ```yaml
   currentDeployment: default
   deploymentConfigurations:
   - name: default
     <<CONTENT HERE>>
   ```

1. For each entry in `spec.spinnakerConfig.profiles`, copy it to its own file inside a `profiles` folder with a `<entry-name>-local.yml` name.
2. For each entry in `spec.spinnakerConfig.service-settings`, copy it to its own file inside a `service-settings` folder with a `<entry-name>.yml` name.
3. For each entry in `spec.spinnakerConfig.files`, copy it to its own file inside a directory structure following the name of the entry with double underscores (__) replaced by a path separator. For example, an entry named `profiles__rosco__packer__example-packer-config.json` results inthe file `profiles/rosco/packer/example-packer-config.json`.

When finished, you have the following directory tree:

```
config
default/
  profiles/
  service-settings/
```

After that, move these files to your Halyard home directory and deploy Armory with the `hal deploy apply` command.

Finally, delete Operator and their CRDs from the Kubernetes cluster.

```bash
kubectl delete -n <namespace> -f deploy/operator/<installation type>
kubectl delete -f deploy/crds/
```

### Remove Operator ownership from Armory resources

Run the following script to remove ownership of Armory resources, where `NAMESPACE` is the namespace where Armory is installed:

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
After the script completes, delete the Armory Operator and its CRDs from the Kubernetes cluster:

```bash
kubectl delete -n <namespace> -f deploy/operator/<installation type>
kubectl delete -f deploy/crds/
```
