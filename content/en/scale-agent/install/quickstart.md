---
title: "Quick Start: Spinnaker and the Armory Scale Agent"
linkTitle: Quick Start
description: >
  This guide shows you how to use the Spinnaker Operator and Kustomize to install Spinnaker and the Scale Agent in the same Kubernetes cluster and namespace for testing the Scale Agent's features.
weight: 1
spin-op-ns: spinnaker
---

## Quick start overview

In this guide, you deploy a basic instance of Spinnaker 1.28+ and the corresponding Scale Agent plugin and service. You can evaluate:

* [Dynamic accounts]({{< ref "scale-agent/concepts/dynamic-accounts" >}}) for dynamically adding and managing Kubernetes accounts
* [Automated scanning]({{< ref "scale-agent/concepts/dynamic-accounts#automatic-account-migration" >}}) for newly created accounts in Clouddriver and migrating those accounts to Scale Agent management
* [Intercepting and processing requests]({{< ref "scale-agent/concepts/dynamic-accounts#clouddriver-account-management-api-request-interception" >}}) sent to Clouddriver's `<GATE-URL>/credentials` endpoint

### Objectives

1. Meet the requirements listed in the [{{% heading "prereq" %}}](#before-you-begin) section.
1. [Learn the options for migrating Clouddriver accounts to the Scale Agent](#options-for-migrating-accounts).
1. [Deploy the Spinnaker Operator](#deploy-the-spinnaker-operator).
1. [Get the spinnaker-kustomize-patches repo](#get-the-spinnaker-kustomize-patches-repo).
1. [Configure Spinnaker](#configure-spinnaker).
1. [Deploy Spinnaker and the Scale Agent](#deploy-spinnaker).

>Since this guide is for installing the Armory Scale Agent in a test environment, it does not include [mTLS configuration]({{< ref "configure-mtls" >}}). The Scale Agent service and plugin do not communicate securely.


## {{% heading "prereq" %}}

* You are familiar with [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/), which use custom resources to manage applications and their components.
* You understand the concept of [managing Kubernetes resources using manifests](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/).
* You have read how Armory's operators [deploy Spinnaker or Armory CD]({{< ref "/continuous-deployment/installation/armory-operator#how-the-armory-operator-and-the-spinnaker-operator-work" >}}).
* You have a cluster with at least least 4 cores and 16 GB of RAM available.

## Options for migrating Kubernetes accounts

In Spinnaker, you can configure Kubernetes accounts in multiple places:

* Clouddriver configuration files: `clouddriver.yml`, `clouddriver-local.yml`, `spinnaker.yml`, `spinnaker-local.yml`
* Clouddriver database: `clouddriver.accounts` table
* Spring Cloud Config Server reading accounts from Git, Vault, or another supported backend
* Plugins

You have the following options for migrating accounts to the Scale Agent:

1. You can configure the Scale Agent service to manage specific accounts by adding those accounts to a ConfigMap. This approach means you should remove the accounts from the Clouddriver credential source before you deploy the service.  
1. You can [dynamically migrate accounts]({{< ref "scale-agent/concepts/dynamic-accounts" >}}) after the service has been deployed. This requires `kubectl` access to the cluster so you can port-forward the endpoint to your local machine.

This guide shows you how to statically add an account to the Scale Agent service configuration before deployment.

## Deploy the Spinnaker Operator

Decide which [Spinnaker Operator release](https://github.com/armory/spinnaker-operator/releases) you need based on the Kubernetes version you are using.

{{< readfile file="/includes/armory-operator/spin-operator-compat.md" >}}

1. Fetch the Spinnaker Operator.

   Replace `<release-version>` with a specific version or use `latest` to fetch the latest release.

   ```bash
   mkdir -p spinnaker-operator && cd spinnaker-operator
   bash -c 'curl -L https://github.com/armory/spinnaker-operator/releases/<release-version>/download/manifests.tgz | tar -xz'
   ```

1. From the root of your `spinnaker-operator` directory, install the Spinnaker Operator CRDs cluster-wide.

   ```bash
   kubectl apply -f deploy/crds/
   ```

1. Install the Spinnaker Operator in namespace `{{< param "spin-op-ns" >}}`.

   ```bash
   kubectl create ns {{< param "spin-op-ns" >}}
   kubectl -n {{< param "spin-op-ns" >}} apply -f deploy/operator/cluster
   ```

1. Verify that the Spinnaker Operator is running before you deploy Spinnaker.

   ```bash
   kubectl get pods -n {{< param "spin-op-ns" >}} | grep operator
   ```

   Output is similar to:

   ```bash
   spinnaker-operator-79599cbf55-js5pg   2/2     Running   0          159m
   ```

## Get the spinnaker-kustomize-patches repo

{{% include "armory-operator/spin-kust-repo.md" %}}

## Configure Spinnaker

You can find the recipe for deploying Spinnaker and the Scale Agent in `recipes/kustomization-oss-agent.yml`.

{{< github repo="armory/spinnaker-kustomize-patches" file="/recipes/kustomization-oss-agent.yml" lang="yaml" options="" >}}

* The `resources` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/resource/) contains files that install apps that you want Spinnaker to use, such as MySQL. 
* The `components` [section](https://kubectl.docs.kubernetes.io/guides/config_management/components/) contains paths to directories that define collections of Kubernetes resources. This section contains a link to the `targets/kubernetes/scale-agent` directory, which contains the Scale Agent installation files. 
* The `patchesStrategicMerge` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patchesstrategicmerge/) contains links to files that contain partial resource definitions. Kustomize uses these patch files to overwrite sections of components or resources, such as the `SpinnakerService` definition.
* The `patches` [section](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patches/) is a list of files that Kustomize executes to add or replace fields on resources. The `utilities/switch-to-oss.yml` patch instructs Kustomize to replace `apiVersion: spinnaker.armory.io/v1alpha2` with `apiVersion: spinnaker.io/v1alpha2` in the SpinnakerService manifest.
* The `transformers` section contains links to files that define Kustomize [_transformers_](https://kubectl.docs.kubernetes.io/references/kustomize/glossary/#transformer).

### What this recipe does

* Configures MinIO as the persistent storage provider (instead of Redis or cloud storage)
* Installs MySQL and configures Clouddriver to use MySQL 
* Enables Clouddriver Account Management
* Installs the plugin
* Creates a ServiceAccount, ClusterRole, and ClusterRoleBinding for the Scale Agent service
* Deploys the service

### What this recipe does not do

* Publicly expose Spinnaker services
* Configure mTLS; communication between the plugin and service is not secure

### Spinnaker version

To change the Spinnaker version, update `spec.spinnakerConfig.config.version` in `core/patches/oss-version.yml`.

If you chose a Spinnaker version earlier than 1.28, you should modify the `targets/kubernetes/scale-agent/plugin-config` file to disable Clouddriver Account Management as in the following example:

```yaml
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        account:
          storage:
            enabled: false # This enables Clouddriver Account Management; requires Armory CD 2.28+ or Spinnaker 1.28+
```

### Configure your Kubernetes account

You should configure a Kubernetes account or accounts for the Scale Agent service to manage. You do this in `targets/kubernetes/scale-agent/armory-agent.yml`.

Add your Kubernetes accounts to the `kubernetes.accounts` section. For example:

```yaml
kubernetes:
  accounts:
    - kubeconfigFile: /kubeconfigfiles/kubeconfig
      name: agent-demo
```

## Deploy Spinnaker

Execute all commands from the root of `spinnaker-kustomize-patches`.

1. Set the kustomize recipe.

   The `kustomization.yml` file in the project root is a symlink to `recipes/kustomization-all.yml`.  Update to point to `recipes/kustomization-oss-agent.yml`.

   ```bash
   ln -vfns ./recipes/kustomization-oss-agent.yml kustomization.yml
   ```

1. (Optional) Verify the Kustomize build output.

   ```bash
   kubectl kustomize kustomization.yml
   ```

   This prints out the contents of the manifest file that Kustomize built based on your `kustomization` file.

1. Apply the manifest.

   ```bash
   kubectl apply -k .
   ```

1. Verify the installation.

   ```bash
   kubectl -n {{< param "spin-op-ns" >}} get spinsvc && echo "" && kubectl -n {{< param "spin-op-ns" >}} get pods
   ```

   You can also access the Clouddriver log to verify that the plugin is running and communicating with the service.

   ```bash
   kubectl -n {{< param "spin-op-ns" >}} logs deployment/spin-clouddriver | grep -E "Start plugin|Starting Kubesvc plugin|Registering agent with"
   ```

## Confirm success

If you haven't publicly exposed Spinnaker based on your cloud provider's guides, you should `port-forward` in order to access the Spinnaker UI and API:

```bash
# port-forward for the UI
kubectl port-forward svc/spin-deck 9000:9000 -n spinnaker
# port-forward for the API
kubectl port-forward svc/spin-gate 8084:8084 -n spinnaker
```

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/concepts/dynamic-accounts.md" >}}
* {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}
* {{< linkWithTitle "scale-agent/troubleshooting/_index.md" >}} page if you run into issues.
