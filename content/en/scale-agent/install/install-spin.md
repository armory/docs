---
title: Install the Armory Scale Agent in Spinnaker
linkTitle: Spinnaker
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

>This guide show how to install the plugin using a plugin repository. You can also install the plugin from Docker if you want to cache the plugin and run security scans on it before installation. 

If you don't have a Clouddriver local profile, create one in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Add the following to `clouddriver.yml`:

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
```

Save your file and apply your changes by running `hal deploy apply`.

### Expose Clouddriver as a LoadBalancer
@TODO DO I NEED THIS WHEN I INSTALL THE SERVICE IN THE SAME CLUSTER & NAMESPACE AS SPINNAKER?

To expose Clouddriver as a Kubernetes-type LoadBalancer, `kubectl` apply the following manifest:

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app: spin
    cluster: spin-clouddriver
  name: spin-clouddriver-grpc
spec:
  ports:
    - name: grpc
      port: 9091
      protocol: TCP
      targetPort: 9091
  selector:
    app: spin
    cluster: spin-clouddriver
```

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.

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

**@DOES THIS STILL WORK? WHEN WAS THE LAST TIME SOMEBODY TESTED THIS?**

The Scale Agent service _can_ run with most features on the [default ServiceAccount](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/). However, if you want the Scale Agent service to load balance connections or assign a precise Zone ID, the Scale Agent service needs permissions to get Pods, Deployments, ReplicaSets, and Namespaces in your cluster. Rather than modifying the default ServiceAccount permissions, Armory recommends creating a new ServiceAccount, ClusterRole, and ClusterRoleBinding for the Scale Agent.

### Configure permissions

The following manifest creates a ServiceAccount, ClusterRole, and ClusterRoleBinding. Apply the manifest in your `spinnaker` namespace.

<details><summary>Show me the manifest</summary>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: scale-agent-cluster-role
rules:
- apiGroups:
  - ""
  resources:
  - configmaps
  - endpoints
  - events
  - ingresses
  - ingresses/status
  - jobs
  - jobs/status
  - namespaces
  - namespaces/finalize
  - namespaces/status
  - pods
  - pods/log
  - pods/status
  - secrets
  - services
  - services/status
  - services/finalizers
  verbs:
  - create
  - get
  - list
  - update
  - watch
  - patch
  - delete
- apiGroups:
  - batch
  resources:
  - jobs
  - jobs/status
  verbs:
  - create
  - get
  - list
  - update
  - watch
  - patch
  - delete
- apiGroups:
  - apps
  - extensions
  resources:
  - daemonsets
  - daemonsets/status
  - deployments
  - deployments/finalizers
  - deployments/scale
  - deployments/status
  - replicasets
  - replicasets/finalizers
  - replicasets/scale
  - replicasets/status
  - statefulsets
  - statefulsets/finalizers
  - statefulsets/scale
  - statefulsets/status
  verbs:
  - create
  - get
  - list
  - update
  - watch
  - patch
  - delete
- apiGroups:
  - monitoring.coreos.com
  resources:
  - servicemonitors
  verbs:
  - get
  - create
- apiGroups:
  - spinnaker.armory.io
  resources:
  - '*'
  - spinnakerservices
  verbs:
  - create
  - get
  - list
  - update
  - watch
  - patch
- apiGroups:
  - apiextensions.k8s.io
  resources:
  - customresourcedefinitions
  verbs:
  - '*'
- apiGroups:
  - admissionregistration.k8s.io
  resources:
  - validatingwebhookconfigurations
  verbs:
  - '*'
- apiGroups:
  - argoproj.io
  resources:
  - '*'
  verbs:
  - '*'
---
apiVersion: v1
kind: ServiceAccount
metadata:
  namespace: spinnaker
  name: scale-agent-sa
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: scale-agent-cluster-role-binding
subjects:
  - kind: ServiceAccount
    name: scale-agent-sa
    namespace: spinnaker
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: scale-agent-cluster-role
```

</details>

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

Apply the manifest to your `spinnaker` namespace.

### Deploy the Armory Scale Agent service

Apply the following manifest in your `spinnaker` namespace:

<details><summary>Show me the manifest</summary>

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: spin
    app.kubernetes.io/name: armory-agent
    app.kubernetes.io/part-of: spinnaker
    cluster: spin-armory-agent
  name: spin-armory-agent
spec:
  replicas: 1
  selector:
    matchLabels:
      app: spin
      cluster: spin-armory-agent
  template:
    metadata:
      labels:
        app: spin
        app.kubernetes.io/name: armory-agent
        app.kubernetes.io/part-of: spinnaker
        cluster: spin-armory-agent
    spec:
      serviceAccount: scale-agent-sa
      containers:
      - image: armory/agent-k8s:<version> # must be compatible with your Armory CD version
        imagePullPolicy: IfNotPresent
        name: armory-agent
        ports:
          - name: health
            containerPort: 8082
            protocol: TCP
          - name: metrics
            containerPort: 8008
            protocol: TCP
        readinessProbe:
          httpGet:
            port: health
            path: /health
          failureThreshold: 3
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /opt/armory/config
          name: volume-armory-agent-config
        # - mountPath: /kubeconfigfiles
        #   name: volume-armory-agent-kubeconfigs
      restartPolicy: Always
      volumes:
      - name: volume-armory-agent-config
        configMap:
          name: armory-agent-config
      # - name: volume-armory-agent-kubeconfigs
      #   secret:
      #     defaultMode: 420
      #     secretName: kubeconfigs-secret
```

</details>

### Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## Uninstall the plugin

Remove the Scale Agent plugin config from `clouddriver-local.yml` and `hal deploy apply` the changes.

## Uninstall the service

@TODO (this is more for aimee than potential customers, who should know how to do this)

kubectl delete serviceaccount scale-agent-sa

kubectl delete clusterrole scale-agent-cluster-role

kubectl delete clusterrolebinding scale-agent-cluster-role-binding

kubectl delete ???






## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/concepts/dynamic-accounts.md" >}}
* {{< linkWithTitle "scale-agent/tasks/service-monitor.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Armory Scale Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "scale-agent/tasks/configure-mtls.md" >}}
* {{< linkWithTitle "scale-agent/concepts/service-permissions.md" >}}
* {{< linkWithTitle "scale-agent/troubleshooting/_index.md" >}} page if you run into issues.