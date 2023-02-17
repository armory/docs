---
title: Install the Armory Scale Agent in Armory CD Quick Start
linkTitle: Armory CD Quick Start
weight: 10
description: >
  This guide shows you how to get started using the Scale Agent with an existing Armory Continuous Deployment test instance. Configure the plugin and service in your Kustomize files and use the Armory Operator to deploy the Scale Agent components.
---

<!-- 
**@TODO IDEALLY THIS PAGE USES A KUSTOMIZE RECIPE THAT INSTALLS BOTH THE PLUGIN AND THE SERVICE (BUT NOT CDSH). SHOULD BE ABLE TO CREATE A RECIPE BASED ON THE KUSTOMIZE SPINNAKER/SCALE AGENT RECIPE OR USE FILES FROM THAT AND TELL USERS HOW TO MODIFY THEIR EXISTING CDSH RECIPE.**
-->

## How to get started using the Scale Agent with Armory Continuous Deployment

This guide assumes you want to evaluate the Scale Agent with an existing Armory CD test instance. With that in mind:

1. Your Armory CD test instance is running in the `spinnaker` namespace.
1. You have Kubernetes accounts configured in Clouddriver so you can evaluate account migration.
1. You are going to deploy the Scale Agent service in the same cluster and namespace as your Armory CD test instance. 

The following features require Armory CD 2.28+ and [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/):

* [Automated scanning]({{< ref "scale-agent/concepts/dynamic-accounts#automatic-account-migration" >}}) for newly created accounts in Clouddriver and migrating those accounts to Scale Agent management
* [Intercepting and processing requests]({{< ref "scale-agent/concepts/dynamic-accounts#clouddriver-account-management-api-request-interception" >}}) sent to Clouddriver's `<GATE-URL>/credentials` endpoint

### Objectives

1. Meet the prerequisites outlined in the {{% heading "prereq" %}} section.
1. [Configure and install the Clouddriver plugin](#install-the-plugin). This step optionally includes configuring Clouddriver Account Management.
1. [Learn the options for migrating Clouddriver accounts to the Scale Agent](#options-for-migrating-accounts).
1. [Configure and deploy the Scale Agent service](#deploy-the-armory-scale-agent-service) in the cluster and namespace where Spinnaker is running ([Spinnaker Service mode]({{< ref "scale-agent/install/advanced/modes#spinnaker-service-mode" >}})). 

>Since this guide is for installing the Armory Scale Agent in a test environment, it does not include [mTLS configuration]({{< ref "configure-mtls" >}}). The Armory Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}

* You are familiar with how plugins work in Spinnaker. See open source Spinnaker's [Plugin User Guide](https://spinnaker.io/docs/guides/user/plugins-users/).
* You have read the Scale Agent [overview]({{< ref "scale-agent" >}}).
* You have at least one Kubernetes cluster to serve as your deployment target cluster.
* Choose the Scale Agent version that is compatible with your Spinnaker version.

   {{< include "scale-agent/agent-compat-matrix.md" >}}

## Install the plugin

{{% alert title="Warning" color="warning" %}}
The default behavior when Spinnaker installs a plugin is to add the plugin repository information to each service. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. 

When you use the Armory Operator to install a plugin, the Operator creates the configuration in the relevant service's local configuration. This means only the Armory CD service that the plugin is installed into downloads the plugin.
{{% /alert %}}
<!-- need to add kustomize repo instructions -->
Add the following to your `spinnakerservice` manifest:

```yaml
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            repositories:
              armory-agent-k8s-spinplug-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-io/agent-k8s-spinplug-releases/master/repositories.json
            plugins:
              Armory.Kubesvc:
                enabled: true
                version: {{< param kubesvc-plugin.agent_plug_latest >}} # check compatibility matrix for your Armory CD version
                extensions:
                  armory.kubesvc:
                    enabled: true
        account:
          storage:
            enabled: true # This enables Clouddriver Account Management; requires Armory CD 2.28+
        kubernetes:
          enabled: true # This is not needed if Armory CD already has kubernetes V2 accounts enabled by other files
        sql:
          enabled: true # kubesvc depends on clouddriver using SQL. See patch-sql-clouddriver for full configuration
          scheduler:
            enabled: true
        redis:
          enabled: false # kubesvc deprecate the use of redis
          scheduler:
            enabled: false
        kubesvc:
          cluster: kubernetes # Communication between clouddrivers is through direct HTTP requests instead of using the redis pubusb, requires redis.enabled: false
```

Update <code>plugins.Armory.Kubesvc.version</code> to a version that is compatible with your Armory CD installation.

`account.storage.enable: true` enables Clouddriver Account Management. Set this to `false` if your Armory CD version is earlier than 1.28.

Apply the manifest using `kubectl`. 


## Expose Clouddriver as a LoadBalancer
<!-- need to add kustomize repo instructions -->

To expose Clouddriver as a Kubernetes-type LoadBalancer, `kubectl` apply the following manifest:

{{< readfile file="/includes/scale-agent/install/ns-spin/loadbalancer.yaml" code="true" lang="yaml" >}}

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.
Apply the manifest using `kubectl`.

## Get the LoadBalancer IP address

Use `kubectl get svc spin-clouddriver-grpc -n spinnaker` to make note of the LoadBalancer IP external address. You need this address when you configure the Scale Agent.

## Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your
Armory CD or Spinnaker cluster and one in your target cluster.


## Options for migrating accounts

In Spinnaker, you can configure Kubernetes accounts in multiple places:

* Clouddriver configuration files: `clouddriver.yml`, `clouddriver-local.yml`, `spinnaker.yml`, `spinnaker-local.yml`
* Clouddriver database: `clouddriver.accounts` table
* Spring Cloud Config Server reading accounts from Git, Vault, or another supported backend
* Plugins

You have the following options for migrating accounts:

1. You can configure the Scale Agent service to manage specific accounts by adding those accounts to a ConfigMap. This approach means you should remove the accounts from the Clouddriver credential source before you deploy the service.  
1. You can [dynamically migrate accounts]({{< ref "scale-agent/concepts/dynamic-accounts" >}}) after the service has been deployed. This requires `kubectl` access to the cluster so you can port-forward the endpoint to your local machine.

This guide shows you how to statically add an account to the Scale Agent service configuration before deployment.


## Deploy the service using manifests

<!--
**@DOES THIS STILL WORK? WHEN WAS THE LAST TIME SOMEBODY TESTED THIS?**

**IDEALLY THIS SECTION IS REPLACED WITH A KUSTOMIZE RECIPE THAT INSTALLS BOTH THE PLUGIN AND THE SERVICE (BUT NOT CDSH). THIS WOULD BE THE SAME AS THE QUICKSTART OPTION EXCEPT THE RECIPE WOULD NOT INSTALL CDSH**
-->

The Scale Agent service _can_ run with most features on the [default ServiceAccount](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/). However, if you want the Scale Agent service to load balance connections or assign a precise Zone ID, the Scale Agent service needs permissions to get Pods, Deployments, ReplicaSets, and Namespaces in your cluster. Rather than modifying the default ServiceAccount permissions, Armory recommends creating a new ServiceAccount, ClusterRole, and ClusterRoleBinding for the Scale Agent.

### Configure permissions

The following manifest creates a ServiceAccount, ClusterRole, and ClusterRoleBinding. Apply the manifest in your `spinnaker` namespace.

{{< readfile file="/includes/scale-agent/install/ns-spin/sa-cr-crb.yaml" code="true" lang="yaml" >}}

### Configure the service

Configure the Armory Scale Agent service using a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/). Define `armory-agent.yml` in the `data` section:


```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: armory-agent-config
  namespace: spinnaker
data:
  armory-agent.yml: |  
```

**Clouddriver plugin LoadBalancer**

Replace **<LoadBalancer-exposed-address>** with the IP address you obtained in the [Get the LoadBalancer IP address section](#get-the-loadbalancer-ip-address).


```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: armory-agent-config
  namespace: spinnaker
data:
  armory-agent.yaml: |
    clouddriver:
      grpc: <LoadBalancer-exposed-address>:9091
      insecure: true
```

**Kubernetes account**

Add your Kubernetes account configuration:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: armory-agent-config
  namespace: spinnaker
data:
  armory-agent.yaml: |
    clouddriver:
      grpc: <LoadBalancer-exposed-address>:9091
      insecure: true
    kubernetes:
     accounts:
     - name:
       kubeconfigFile:
       insecure:
       context:
       oAuthScopes:
       serviceAccount: true
       serviceAccountName: spin-sa
       namespaces: []
       omitNamespaces: []
       onlyNamespacedResources:
       kinds: []
       omitKinds: []
       customResourceDefinitions: [{kind:}]
       metrics:
       permissions: []
       maxResumableResourceAgeMs:
       onlySpinnakerManaged:
       noProxy:
```

See the [Agent options]({{< ref "scale-agent/reference/config/service-options#configuration-options">}}) for field explanations.

Apply the manifest in your `spinnaker` namespace.

### Deploy the Armory Scale Agent service

Apply the following manifest in your `spinnaker` namespace:

{{< readfile file="/includes/scale-agent/install/ns-spin/agent-service.yaml" code="true" lang="yaml" >}}

### Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## Uninstall the plugin

Remove the Scale Agent plugin config from `spinnakerservice` and apply the changes.
<!-- need to add kustomize instructions -->

## Uninstall the service
<!-- need to add kustomize instructions Remove `targets/kubernetes/scale-agent` from your Kustomization recipe.-->

You can use `kubectl` to delete all Scale Agent service's `Deployment` objects and their accompanying `ConfigMap` and `Secret`.



## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/concepts/dynamic-accounts.md" >}}
* {{< linkWithTitle "scale-agent/tasks/service-monitor.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Armory Scale Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "scale-agent/tasks/configure-mtls.md" >}}
* {{< linkWithTitle "scale-agent/concepts/service-permissions.md" >}}
* {{< linkWithTitle "scale-agent/troubleshooting/_index.md" >}} page if you run into issues.
