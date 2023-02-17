---
title: Install the Armory Scale Agent in Spinnaker Quick Start
linkTitle: Spinnaker Quick Start
weight: 5
description: >
  This guide shows you how to get started using the Scale Agent with an existing Spinnaker instance managed by Halyard. Configure the plugin in your `cloudriver-local.yml` file and use the provided manifests to deploy the service to the same Kubernetes cluster and namespace that Spinnaker is running in.
aliases:
  - /scale-agent/install/service-kubectl
---


## How to get started using the Scale Agent with open source Spinnaker

This guide assumes you want to evaluate the Scale Agent with an existing Spinnaker test instance. With that in mind:

1. Your Spinnaker test instance is running in the `spinnaker` namespace.
1. You have Kubernetes accounts configured in Clouddriver so you can evaluate account migration.
1. You are going to deploy the Scale Agent service in the same cluster and namespace as your Spinnaker test instance. 

The following features require Spinnaker 1.28+ and [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/):

* [Automated scanning]({{< ref "scale-agent/concepts/dynamic-accounts#automatic-account-migration" >}}) for newly created accounts in Clouddriver and migrating those accounts to Scale Agent management
* [Intercepting and processing requests]({{< ref "scale-agent/concepts/dynamic-accounts#clouddriver-account-management-api-request-interception" >}}) sent to Clouddriver's `<GATE-URL>/credentials` endpoint

### Objectives

1. Meet the prerequisites outlined in the {{% heading "prereq" %}} section.
1. [Configure the Clouddriver plugin in your `clouddriver-local.yml` file and deploy using Halyard](#install-the-plugin). 
1. [Learn the options for migrating Clouddriver accounts to the Scale Agent](#options-for-migrating-accounts).
1. [Configure and deploy the Scale Agent service](#deploy-the-armory-scale-agent-service) in the cluster and namespace where Spinnaker is running ([Spinnaker Service mode]({{< ref "scale-agent/install/advanced/modes#spinnaker-service-mode" >}})). 

>Since this guide is for installing the Armory Scale Agent in a test environment, it does not include [mTLS configuration]({{< ref "configure-mtls" >}}). The Armory Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}

* You are familiar with how plugins work in Spinnaker. See open source Spinnaker's [Plugin User Guide](https://spinnaker.io/docs/guides/user/plugins-users/).
* You have read the Scale Agent [overview]({{< ref "scale-agent" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "continuous-deployment/armory-admin/clouddriver-sql-configure.md" >}} guide for instructions. The Scale Agent plugin uses the SQL database to store cache data and dynamically created Kubernetes accounts.
* For Clouddriver pods, you have mounted a service account with permissions to `list` and `watch` the Kubernetes kind `Endpoint` in the namespace where Clouddriver is running.

   ```yaml
   apiVersion: rbac.authorization.k8s.io/v1
   kind: Role
   metadata:
     name: spin-sa
   rules:
     - apiGroups:
         - ""
       resources:
         - endpoints
       verbs:
         - list
         - watch
    ```

* Verify that there is a Kubernetes Service with prefix name `spin-clouddriver` (configurable) routing HTTP traffic to Clouddriver pods, having a port with name `http` (configurable).
* You have at least one Kubernetes cluster to serve as your deployment target cluster.
* Choose the Scale Agent version that is compatible with your Spinnaker version.

   {{< include "scale-agent/agent-compat-matrix.md" >}}


## Install the plugin

{{% alert title="Warning" color="warning" %}}
The Scale Agent plugin extends Clouddriver. When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to each service. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid each service restarting and downloading the plugin, configure the plugin in Clouddriver’s local profile.
{{% /alert %}}

>This guide show how to install the plugin using a plugin repository. You can also [install the plugin from Docker]({{< ref "scale-agent/install/advanced/plugin-docker" >}}) if you want to cache the plugin and run security scans on it before installation. 

If you don't have a Clouddriver local profile, create one in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Add the following to your `clouddriver-local.yml` file:

{{< tabpane text=true right=true >}}
{{% tab header="**Spinnaker Version**:" disabled=true /%}}
{{% tab header="1.28+" %}}
This code snippet includes enabling Clouddriver Account Management configuration so you can evaluate the Scale Agent's interceptor and automatic scanning features.

```yaml
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
    # Plugin config
    kubesvc:
      cluster: kubernetes
spinnaker:
  extensibility:
    repositories:
      armory-agent-k8s-spinplug-releases:
        enabled: true
        url: https://raw.githubusercontent.com/armory-io/agent-k8s-spinplug-releases/master/repositories.json
    plugins:
      Armory.Kubesvc:
        enabled: true
        version: 0.11.32
        extensions:
          armory.kubesvc:
            enabled: true
kubesvc:
  cluster: kubernetes
kubernetes:
  enabled: true
# enable Clouddriver Account Management https://spinnaker.io/docs/setup/other_config/accounts/
account:
  storage:
    enabled: true

```
{{% /tab %}}
{{% tab header="1.27" %}}
This code snippet **does not** enable Clouddriver Account Management, which is not supported in Spinnaker versions 1.27.x and earlier.

```yaml
spinnaker:
  extensibility:
    repositories:
      armory-agent-k8s-spinplug-releases:
        enabled: true
        url: https://raw.githubusercontent.com/armory-io/agent-k8s-spinplug-releases/master/repositories.json
    plugins:
      Armory.Kubesvc:
        enabled: true
        version: {{< param kubesvc-plugin.agent_plug_latest-1 >}} # check compatibility matrix for your Spinnaker version
        extensions:
          armory.kubesvc:
            enabled: true
kubesvc:
  cluster: kubernetes
kubernetes:
  enabled: true
```
{{% /tab %}}
{{< /tabpane >}}



Save your file and apply your changes by running `hal deploy apply`. Kubernetes terminates the existing Clouddriver pod and creates a new one. You can validate plugin installation by executing `kubectl -n spinnaker logs deployments/spin-clouddriver | grep "Plugin"`. Output is similar to:

```bash
org.pf4j.AbstractPluginManager      :  Plugin 'Armory.Kubesvc@0.11.32' resolved
org.pf4j.AbstractPluginManager      :  Start plugin 'Armory.Kubesvc@0.11.32'
io.armory.kubesvc.KubesvcPlugin     :  Starting Kubesvc  plugin...
```

### Expose Clouddriver as a LoadBalancer

To expose Clouddriver as a Kubernetes-type LoadBalancer, `kubectl` apply the following manifest:

{{< readfile file="/includes/scale-agent/install/ns-spin/loadbalancer.yaml" code="true" lang="yaml" >}}

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.

Apply the manifest using `kubectl`.

### Get the LoadBalancer IP address

Use `kubectl get svc spin-clouddriver-grpc -n spinnaker` to make note of the LoadBalancer IP external address. You need this address when you configure the Scale Agent service.

### Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your Spinnaker cluster and one in your target cluster.

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

The Scale Agent service _can_ run with most features on the [default ServiceAccount](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/). However, if you want the Scale Agent service to load balance connections or assign a precise Zone ID, the Scale Agent service needs permissions to get Pods, Deployments, ReplicaSets, and Namespaces in your cluster. Rather than modifying the default ServiceAccount permissions, Armory recommends creating a new ServiceAccount, ClusterRole, and ClusterRoleBinding for the Scale Agent.

### Configure permissions

The following manifest creates a ServiceAccount, ClusterRole, and ClusterRoleBinding. Apply the manifest in your `spinnaker` namespace.

{{< readfile file="/includes/scale-agent/install/ns-spin/sa-cr-crb.yaml" code="true" lang="yaml" >}}

### Configure the service

Configure the Armory Scale Agent service using a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/). In the `data` section, configure the LoadBalancer and and the Kubernetes account you want the Scale Agent to manage.

Define `armory-agent.yml` in the `data` section:


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

Remove the Scale Agent plugin config from `clouddriver-local.yml` and `hal deploy apply` the changes.

## Uninstall the service

You can use `kubectl` to delete all Scale Agent service's `Deployment` objects and their accompanying `ConfigMap` and `Secret`.



## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/concepts/dynamic-accounts.md" >}}
* {{< linkWithTitle "scale-agent/tasks/service-monitor.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Armory Scale Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "scale-agent/tasks/configure-mtls.md" >}}
* {{< linkWithTitle "scale-agent/concepts/service-permissions.md" >}}
* {{< linkWithTitle "scale-agent/troubleshooting/_index.md" >}} page if you run into issues.