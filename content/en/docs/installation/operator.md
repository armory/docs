---
title: Armory Operator
weight: 1
description: >
  The Armory Operator is a Kubernetes Operator that makes it easy to install, deploy, and upgrade any version of Armory.
aliases:
  - /docs/spinnaker/operator/
---

Using the Armory Operator, you can:

- Manage Armory with `kubectl` like other applications.
- Expose Armory via `LoadBalancer` or `Ingress` (optional)
- Keep secrets separate from your config. Store your config in `git` and have an easy Gitops workflow.
- Validate your configuration before applying it (with webhook validation).
- Store Spinnaker secrets in [Kubernetes secrets](https://github.com/armory/spinnaker-operator/blob/master/doc/managing-spinnaker.md#secrets-in-kubernetes-secrets).
- Gain total control over Armory manifests with [`kustomize` style patching](https://github.com/armory/spinnaker-operator/blob/master/doc/options.md#speckustomize)
- Define Kubernetes accounts in `SpinnakerAccount` objects and store kubeconfig inline, in Kubernetes secrets, in s3, or GCS **(Experimental)**.
- Deploy Armory in an Istio controlled cluster **(Experimental)**

> We refer here to the Armory Operator, which installs Armory. The open source operator installs open source Spinnaker<sup>TM</sup> and is found [here](https://github.com/armory/spinnaker-operator).

## Requirements

Before you start, ensure you meet the following requirements:

- Your Kubernetes cluster runs version 1.13 or later.
- You have admission controllers enabled in Kubernetes (`-enable-admission-plugins`).
- You have `ValidatingAdmissionWebhook` enabled in the kube-apiserver. Alternatively, you can pass the `--disable-admission-controller` parameter to the to the `deployment.yaml` file that deploys the operator.
- You have admin rights to install the Custom Resource Definition (CRD) for Operator.

## Install Armory Operator

The Armory Operator has two distinct modes:
- **Basic**: Installs Armory into a single namespace. This mode does not perform pre-flight checks before applying a manifest.
- **Cluster**: Installs Armory across namespaces with pre-flight checks to prevent common misconfigurations. This mode requires a `ClusterRole`.

Pick a release from [https://github.com/armory-io/spinnaker-operator/releases](https://github.com/armory-io/spinnaker-operator/releases):

```bash
mkdir -p spinnaker-operator && cd spinnaker-operator
bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/latest/download/manifests.tgz | tar -xz'

# Install or update CRDs cluster wide
kubectl apply -f deploy/crds/

# We'll install in the spinnaker-operator namespace
kubectl create ns spinnaker-operator
```

Next, install Operator in either `cluster` or `basic` mode:

```bash
# Install Operator cluster mode
kubectl -n spinnaker-operator apply -f deploy/operator/cluster
```

```bash
# OR install Operator in basic mode
# kubectl -n spinnaker-operator apply -f deploy/operator/basic
```

After installation, you can verify that the Operator is running with the following command:

```bash
kubectl -n spinnaker-operator get pods
```

The command returns output similar to the following if the pod for the Operator is running:

```
NAMESPACE                             READY         STATUS       RESTARTS      AGE
spinnaker-operator-7cd659654b-4vktl   2/2           Running      0             6s
```

> If you want to use a namespace other than `spinnaker-operator` in cluster mode, you'll also need to edit the namespace in `deploy/operator/cluster/role_binding.yaml`.


## Install Armory

Update the values such as `version` and `persistentStorage` in `deploy/spinnaker/<operator-installation-mode>/SpinnakerService.yml` before you install Spinnaker.

If you installed Operator in `basic` mode, you must use the `spinnaker-operator` namespace. The permissions in `basic` mode are scoped to a single namespace so it doesn't see anything in other namespaces. Run the following command:

```bash
kubectl -n spinnaker-operator apply -f deploy/spinnaker/basic/SpinnakerService.yml
```

If you installed Operator in `cluster` mode, run this command:

```bash
kubectl -n spinnaker-operator apply -f deploy/spinnaker/kustomize/SpinnakerService.yml
```

Watch the install progress and check out the pods being created:

```bash
kubectl -n spinnaker get spinsvc spinnaker -w
```

### How it works
Armory's configuration is found in a `spinnakerservices.spinnaker.armory.io` Custom Resource Definition (CRD) that you can store in version control. After you install the Armory Operator, you can use `kubectl` to manage the lifecycle of your deployment.

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: 2.21.0
```

See [the full format]({{< ref "operator-reference" >}}).


### Upgrade Armory

To upgrade an existing Armory deployment, perform the following steps:

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



### Manage Armory Instances

The Armory Operator allows you to use `kubectl` to manager you Armory deployment.

**List Armory instances**

```bash
kubectl get spinnakerservice --all-namespaces
```

The short name `spinsvc` is also available.

**Describe Armory instances**

```bash
kubectl -n <namespace> describe spinnakerservice spinnaker
```


**Delete Armory instances**

```bash
kubectl -n <namespace> delete spinnakerservice spinnaker
```


## Manage configuration

### Kustomize

Because Armory's configuration is now a Kubernetes manifest, you can manage `SpinnakerService` and related manifests in a consistent and repeatable way with [Kustomize](https://kustomize.io/).

See the example [here](https://github.com/armory-io/spinnaker-operator/tree/master/deploy/spinnaker/kustomize).

```bash
kubectl create ns spinnaker
kustomize build deploy/spinnaker/kustomize | kubectl -n spinnaker apply -f -
```

There are many more possibilities:
- managing manifests of MySQL instances
- ensuring the same configuration is used between Staging and Production Spinnaker
- splitting accounts in their own kustomization for an easy to maintain configuration

See this [repo](https://github.com/armory/spinnaker-kustomize-patches) for examples of common setups that you can adapt to your needs.

### Secret Management

You can store secrets in one of the [supported secret engine]({{< ref "secrets#supported-secret-engines" >}}).

#### Kubernetes Secret
With the Operator, you can also reference secrets stored in existing Kubernetes secrets in the same namespace as Spinnaker.

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

Armory can deploy manifests or kustomize packages. You can configure Armory to redeploy itself (or use a separate Armory) with a trigger on the git repository containing its configuration.

A change to Armory's configuration follows:

> Pull Request --> Approval --> Configuration Merged --> Pipeline Trigger in Spinnaker --> Deploy Updated SpinnakerService

This process is auditable and reversible.

## Accounts CRD (Experimental)

Operator has a CRD for Armory accounts. `SpinnakerAccount` is defined in an object - separate from the main Spinnaker config - so its creation and maintenance can be automated.

To read more about this CRD, see [SpinnakerAccount](https://github.com/armory/spinnaker-operator/blob/master/doc/spinnaker-accounts.md).


## Migrate from Halyard to the Armory Operator

If you have a current Armory instance installed with Halyard, use this guide
to migrate existing configuration to Operator.

The migration process from Halyard to Operator can be completed in 7 steps:

1. To get started, install Armory Operator.
2. Export Armory configuration.

    Copy the desired profile's content from the `config` file

   For example, if you want to migrate the `default` hal profile, use the following `SpinnakerService` manifest structure:

   ```yaml
   currentDeployment: default
   deploymentConfigurations:
   - name: default
     <CONTENT>
   ```

   Add `<CONTENT>` in the `spec.spinnakerConfig.config` section in the `SpinnakerService` manifest as follows:

   ```yaml
   spec:
     spinnakerConfig:
       config:
         <<CONTENT>>
   ```

   Note: `config` is under `~/.hal`

   More details on [SpinnakerService options]({{< ref "operator-config#specspinnakerconfig" >}}) on `.spec.spinnakerConfig.config` section

3. Export Armory profiles.

   If you have configured Armory profiles, you will need to migrate these profiles to the `SpinnakerService` manifest.

   First, identify the current profiles under  `~/.hal/default/profiles`

   For each file, create an entry under `spec.spinnakerConfig.profiles`

   For example, you have the following profile:

   ```bash
   $ ls -a ~/.hal/default/profiles | sort
   echo-local.yml
   ```

   Create a new entry with the name of the file without `-local.yaml` as follows:

   ```yaml
   spec:
     spinnakerConfig:
       profiles:
         echo:
           <CONTENT>
   ```

   More details on [SpinnakerService Options]({{< ref "operator-config#specspinnakerconfigprofiles" >}}) in the `.spec.spinnakerConfig.profiles` section

4. Export Armory settings.

   If you configured Armory settings, you need to migrate these settings to the `SpinnakerService` manifest also.

   First, identify the current settings under  `~/.hal/default/service-settings`

   For each file, create an entry under `spec.spinnakerConfig.service-settings`

   For example, you have the following settings:

   ```bash
   $ ls -a ~/.hal/default/service-settings | sort
   echo.yml
   ```

   Create a new entry with the name of the file without `.yaml` as follows:

   ```yaml
   spec:
     spinnakerConfig:
       service-settings:
         echo:
           <CONTENT>
   ```
   More details on [SpinnakerService Options]({{< ref "operator-config#specspinnakerconfigservice-settings" >}}) on `.spec.spinnakerConfig.service-settings` section

5. Export local file references.

   If you have references to local files in any part of the config, like `kubeconfigFile`, service account json files or others, you need to migrate these files to the `SpinnakerService` manifest.

   For each file, create an entry under `spec.spinnakerConfig.files`

   For example, you have a Kubernetes account configured like this:

   ```yaml
   kubernetes:
     enabled: true
     accounts:
     - name: prod
       requiredGroupMembership: []
       providerVersion: V2
       permissions: {}
       dockerRegistries: []
       configureImagePullSecrets: true
       cacheThreads: 1
       namespaces: []
       omitNamespaces: []
       kinds: []
       omitKinds: []
       customResources: []
       cachingPolicies: []
       oAuthScopes: []
       onlySpinnakerManaged: false
       kubeconfigFile: /home/spinnaker/.hal/secrets/kubeconfig-prod
     primaryAccount: prod
   ```

   The `kubeconfigFile` field is a reference to a physical file on the machine running Halyard. You need to create a new entry in `files` section like this:

   ```yaml
   spec:
     spinnakerConfig:
       files:
         kubeconfig-prod: |
           <CONTENT>
   ```

   Then replace the file path in the config to match the key in the `files` section:

   ```yaml
   kubernetes:
     enabled: true
     accounts:
     - name: prod
       requiredGroupMembership: []
       providerVersion: V2
       permissions: {}
       dockerRegistries: []
       configureImagePullSecrets: true
       cacheThreads: 1
       namespaces: []
       omitNamespaces: []
       kinds: []
       omitKinds: []
       customResources: []
       cachingPolicies: []
       oAuthScopes: []
       onlySpinnakerManaged: false
       kubeconfigFile: kubeconfig-prod  # File name must match "files" key
     primaryAccount: prod
   ```

   More details on [SpinnakerService Options]({{< ref "operator-config#specspinnakerconfigfiles" >}}) on `.spec.spinnakerConfig.files` section

6. Export Packer template files (if used).

   If you are using custom Packer templates for baking images, you need to migrate these files to the `SpinnakerService` manifest.

   First, identify the current templates under  `~/.hal/default/profiles/rosco/packer`

   For each file, create an entry under `spec.spinnakerConfig.files`

   For example, you have the following `example-packer-config` file:

   ```bash
   $ tree -v ~/.hal/default/profiles
   ├── echo-local.yml
   └── rosco
       └── packer
           └── example-packer-config.json

   2 directories, 2 files
   ```

   You need to create a new entry with the name of the file following these instructions:

   - For each file, list the folder name starting with `profiles`, followed by double underscores (`__`) and at the very end the name of the file.

   ```yaml
   spec:
     spinnakerConfig:
       files:
         profiles__rosco__packer__example-packer-config.json: |
           <CONTENT>
   ```

   More details on [SpinnakerService Options]({{< ref "operator-config#specspinnakerconfigfiles" >}}) on `.spec.spinnakerConfig.files` section

6. Validate your Armory configuration if you plan to run the Operator in cluster mode.

   ```bash
   kubectl -n <namespace> apply -f <spinnaker service manifest> --dry-run=server
   ```

   The validation service throws an error when something is wrong with your manifest.

7. Apply your SpinnakerService:

   ```bash
   kubectl -n <namespace> apply -f <spinnaker service>
   ```


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
