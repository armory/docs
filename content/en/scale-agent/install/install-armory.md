---
title: Install the Armory Scale Agent in Armory CD
linkTitle: Armory CD
weight: 10
description: >
  This guide shows you how to get started using the Scale Agent with an existing Armory Continuous Deployment instance. Configure the plugin and service in your Kustomize files and use the Armory Operator to deploy the Scale Agent components.
---

## {{% heading "prereq" %}}

This guide assumes you want to evaluate the Scale Agent with an existing Armory CD test instance that you deployed using the Armory Operator and Kustomize patches (`spinnaker-kustomize-patches` [repo](https://github.com/armory/spinnaker-kustomize-patches)). With that in mind:

1. Your Armory CD test instance is running in the `spinnaker` namespace. 
1. Your Clouddriver service uses a SQL backend. The Scale Agent plugin uses the SQL database to store cache data and dynamically created Kubernetes accounts.
1. You have Kubernetes accounts configured in Clouddriver so you can evaluate account migration.
1. You are going to deploy the Scale Agent service in the same cluster and namespace as your Armory CD test instance. 
1. You are not going to configure mTLS, so the Scale Agent service and plugin are not going to communicate securely.
1. Choose the Scale Agent version that is compatible with your Armory CD version.

   {{< include "scale-agent/agent-compat-matrix.md" >}}


{{< alert color="warning" title="Scale Agent Features Limitation" >}}
The following Scale Agent features require Armory CD 2.28+ and [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/):

* [Automated scanning]({{< ref "scale-agent/concepts/dynamic-accounts#automatic-account-migration" >}}) for newly created accounts in Clouddriver and migrating those accounts to Scale Agent management
* [Intercepting and processing requests]({{< ref "scale-agent/concepts/dynamic-accounts#clouddriver-account-management-api-request-interception" >}}) sent to Clouddriver's `<GATE-URL>/credentials` endpoint

If your Armory CD version is earlier than 2.28, see the _Configure the plugin_ [section](#configure-the-plugin) for how to disable Clouddriver Account Management.
{{< /alert >}}

## Objectives

1. Read about [options for migrating Kubernetes accounts](#options-for-migrating-kubernetes-accounts).
1. [Access the latest Scale Agent installation files](#access-the-installation-files).
1. [Update your local `kustomization` recipe](#update-your-kustomization-recipe).
1. [Configure the plugin](#configure-the-plugin).
1. [Configure the service](#configure-the-service)
1. [Install the Scale Agent](#install-the-scale-agent)

## Options for migrating Kubernetes accounts

In Armory CD, you can configure Kubernetes accounts in multiple places:

* Clouddriver configuration files: `clouddriver.yml`, `clouddriver-local.yml`, `spinnaker.yml`, `spinnaker-local.yml`
* Clouddriver database: `clouddriver.accounts` table
* Spring Cloud Config Server reading accounts from Git, Vault, or another supported backend
* Plugins

You have the following options for migrating accounts to the Scale Agent:

1. You can configure the Scale Agent service to manage specific accounts by adding those accounts to a ConfigMap. This approach means you should remove the accounts from the Clouddriver credential source before you deploy the service.  
1. You can [dynamically migrate accounts]({{< ref "scale-agent/concepts/dynamic-accounts" >}}) after the service has been deployed. This requires `kubectl` access to the cluster so you can port-forward the endpoint to your local machine.

This guide shows you how to statically add an accounts to the Scale Agent service configuration before deployment.

## Access the installation files

You can find the files that install the Scale Agent in the `spinnaker-kustomize-patches/targets/kubernetes/scale-agent` [repo](https://github.com/armory/spinnaker-kustomize-patches/tree/master/targets/kubernetes/scale-agent).  Update your local copy from `master` to get the latest updates.

## Update your Kustomization recipe

* `components` section: add `targets/kubernetes/scale-agent`
* `transformers` section: add `utilities/unique-service-account.yml` 

## Configure the plugin

1. Set the plugin version that is compatible with your Armory CD version
   
   In `plugin-config.yml`, check that the version listed is compatible with your Armory CD version. If it isn't, replace with a plugin version that is.
   
   {{< readfile file="/includes/scale-agent/install/cdsh/plugin-version-snippet.yaml" code="true" lang="yaml" >}}


1. (Optional) Disable [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/) if your Armory CD version is earlier than 2.28.

   Set `spec.spinnakerConfig.profiles.clouddriver.account.storage.enabled` to `false`.

   {{< readfile file="/includes/scale-agent/install/cdsh/plugin-cam-snippet.yaml" code="true" lang="yaml" >}}


## Configure the service

You should configure a Kubernetes account or accounts for the Scale Agent service to manage. You do this in `targets/kubernetes/scale-agent/armory-agent.yml`.

Add your Kubernetes accounts to the `kubernetes.accounts` section. For example:

```yaml
kubernetes:
  accounts:
    - kubeconfigFile: /kubeconfigfiles/kubeconfig
      name: agent-demo
```

## Install the Scale Agent

Execute all commands from the root of `spinnaker-kustomize-patches`. The following commands assume your Kustomization recipe is named `kustomization.yml` and is in the root of your `spinnaker-patches-kustomize` directory.

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
   kubectl -n spinnaker get spinsvc && echo "" && kubectl -n spinnaker get pods
   ```

### Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/concepts/dynamic-accounts.md" >}}
* {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}
* {{< linkWithTitle "scale-agent/troubleshooting/_index.md" >}} page if you run into issues.
