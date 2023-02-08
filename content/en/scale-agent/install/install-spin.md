---
title: Install the Scale Agent - Spinnaker
linkTitle: Spinnaker
description: >
  This guide shows you how to get started using the Scale Agent with an existing Spinnaker instance. Configure the plugin in your `cloudriver-local.yml` file and use the provided manifests to deploy the service to your Kubernetes cluster.
aliases:
  - /scale-agent/install/service-kubectl
---


## How to get started using the Scale Agent with open source Spinnaker

1. Ensure you meet the prerequisites outlined in the {{% heading "prereq" %}} section.
1. Decide how you are going to deploy the Scale Agent service. For evaluation, Armory recommends you deploy the service in the cluster where Spinnaker is running ("Spinnaker mode").
1. Decide how you are going to migrate Clouddriver accounts to the Scale Agent.
1. [Configure the Clouddriver plugin in your `clouddriver-local.yml` file and deploy using Halyard](#install-the-plugin). 
1. [Configure and deploy the Scale Agent service](#deploy-the-armory-scale-agent-service). You have two options:

   1. Use the provided manifests and `kubectl`.
   1. Use the Helm chart.
   

>This installation guide is designed for installing the Armory Scale Agent in a test environment. It does not include [mTLS configuration]({{< ref "configure-mtls" >}}), so the Armory Agent service and plugin do not communicate securely.

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

* Verify that there is a Kubernetes Service with prefix name `spin-clouddriver` (configurable) routing HTTP traffic to Clouddriver pods, having a port with name `http` (configurable). This service is created automatically when installing Armory CD using the Armory Operator.
* You have at least one Kubernetes cluster to serve as your deployment target cluster.

Be sure to choose the Scale Agent version that is compatible with your Spinnaker version.

{{< include "scale-agent/agent-compat-matrix.md" >}}

## Install the plugin

{{% alert title="Warning" color="warning" %}}
The Scale Agent plugin extends Clouddriver. When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to each service. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid each service restarting and downloading the plugin, configure the plugin in Clouddriver’s local profile.
{{% /alert %}}

>This guide show how to install the plugin using a plugin repository. You can also install the plugin from Docker. If you want to cache the plugin and run security scans on it before installation, choose the Docker option.

If you don't have a Clouddriver local profile, create one in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

{{< tabs name="DeploymentPlugin" >}}
{{< tabbody name="Plugin Repo" >}}
<br>
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
  # cluster-kubernetes:
    # kubeconfigFile: <path-to-file> # (Optional, default: null). If configured, the plugin uses this file to discover Endpoints. If not configured, it uses the service account mounted to the pod.
    # verifySsl: <true|false> # Optional, default: true). Whether to verify the Kubernetes API cert or not.
    # namespace: <string> # (Optional, default: null). If configured, the plugin watches Endpoints in this namespace. If null, it watches endpoints in the namespace indicated in the file "/var/run/secrets/kubernetes.io/serviceaccount/namespace".
    # httpPortName: <string> # (Optional, default: http). Name of the port configured in the Clouddriver Service that forwards traffic to the Clouddriver HTTP port for REST requests.
    # clouddriverServiceNamePrefix: <string> # (Optional, default: spin-clouddriver). Name prefix of the Kubernetes Service pointing to the Clouddriver standard HTTP port.
```
{{< /tabbody >}}
{{< tabbody name="Docker" >}}
<br>

```yaml
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            pluginsRootPath: /opt/clouddriver/lib/plugins
            plugins:
              Armory.Kubesvc:
                enabled: true
        kubernetes:
          enabled: true # This is not needed if spinnaker already has kubernetes V2 accounts enabled by other files
        sql:
          enabled: true # kubesvc depends on clouddriver using SQL. See patch-sql-clouddriver for full configuration
          scheduler:
            enabled: true
        redis:
          enabled: false # kubesvc deprecate the use of redis
          scheduler:
            enabled: false
        kubesvc:
          cluster: kubernetes # Communication between clouddrivers is through direct HTTP requests instead of using the redis pubusb, requires redis.
          # cluster-kubernetes:
            # kubeconfigFile: <path-to-file> # (Optional, default: null). If configured, the plugin uses this file to discover Endpoints. If not configured, it uses the service account mounted to the pod.
            # verifySsl: <true|false> # Optional, default: true). Whether to verify the Kubernetes API cert or not.
            # namespace: <string> # (Optional, default: null). If configured, the plugin watches Endpoints in this namespace. If null, it watches endpoints in the namespace indicated in the file "/var/run/secrets/kubernetes.io/serviceaccount/namespace".
            # httpPortName: <string> # (Optional, default: http). Name of the port configured in the Clouddriver Service that forwards traffic to the Clouddriver HTTP port for REST requests.
            # clouddriverServiceNamePrefix: <string> # (Optional, default: spin-clouddriver). Name prefix of the Kubernetes Service pointing to the Clouddriver standard HTTP port.
  kustomize:
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: armory-agent-plugin
                    image: docker.io/armory/kubesvc-plugin:0.11.31 # must be compatible with your Spinnaker version
                    volumeMounts:
                      - mountPath: /opt/plugin/target
                        name: armory-agent-plugin-vol
                  containers:
                  - name: clouddriver
                    volumeMounts:
                      - mountPath: /opt/clouddriver/lib/plugins
                        name: armory-agent-plugin-vol
                  volumes:
                  - name: armory-agent-plugin-vol
                    emptyDir: {}
```

{{< /tabbody >}}
{{< /tabs >}}

Save your file and apply your changes by running `hal deploy apply`.

### Expose Clouddriver as a LoadBalancer

To expose Clouddriver as a Kubernetes-type LoadBalancer, `kubectl` apply the following manifest:

{{< github repo="armory/spinnaker-kustomize-patches" file="targets/kubernetes/scale-agent/scale-agent-service.yml" lang="yaml" options="" >}}

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.


### Get the LoadBalancer IP address

Use `kubectl get svc spin-clouddriver-grpc -n spinnaker` to make note of the LoadBalancer IP external address. You need this address when you configure the Scale Agent.

### Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your
Spinnaker cluster and one in your target cluster.

## Deploy the service using manifests and `kubectl`

This section includes manifests for deploying the Scale Agent service using `kubectl`. If you want to use Helm, see {{< linkWithTitle "scale-agent/install/spin-install/service-helm/index.md" >}}.

### Create a namespace

In the deployment target cluster, execute `kubectl create ns spin-agent` to create a namespace for the Armory Scale Agent service.

### Configure permissions

The Agent _can_ run with most features on the [default ServiceAccount](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/). However, if you want the Scale Agent to load balance connections or assign a precise Zone ID, the Scale Agent needs permissions to get Pods, Deployments, ReplicaSets, and Namespaces in your cluster. Rather than modifying the default ServiceAccount permissions, Armory recommends creating a new ServiceAccount, ClusterRole, and ClusterRoleBinding for the Scale Agent.

Apply the following manifest in your `spin-agent` namespace:

<details><summary>Show me the manifest</summary>

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: spin-cluster-role
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
  namespace: spin-agent
  name: spin-sa
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: spin-cluster-role-binding
subjects:
  - kind: ServiceAccount
    name: spin-sa
    namespace: spin-agent
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: spin-cluster-role
```

</details>

### Configure the service

Configure the Armory Scale Agent service using a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/). Define `armory-agent.yml` in the `data` section:


```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: armory-agent-config
  namespace: spin-agent
data:
  armory-agent.yml: |  
  server:
    port: 8082
```

**Clouddriver plugin LoadBalancer**

Replace **[LoadBalancer Exposed Address]** with the IP address you obtained in the [Get the LoadBalancer IP address section](#get-the-loadbalancer-ip-address).


```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: armory-agent-config
  namespace: spin-agent
data:
  armory-agent.yaml: |
    clouddriver:
      grpc: [LoadBalancer Exposed Address]:9091
      insecure: true
```


**Kubernetes account**

Add your Kubernetes account configuration for your cluster:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubesvc-config
  namespace: spin-agent
data:
  armory-agent.yaml: |
    clouddriver:
      grpc: <LoadBalancer Exposed Address>:9091
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

Apply the manifest to your `spin-agent` namespace.

### Deploy the Armory Scale Agent service

Apply the following Agent deployment manifest in your `spin-agent` namespace:

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
      serviceAccount: spin-sa
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

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/troubleshooting/_index.md" >}} page if you run into issues.
* Learn how to {{< linkWithTitle "scale-agent/tasks/service-monitor.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Armory Scale Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "scale-agent/tasks/configure-mtls.md" >}}
* Read about {{< linkWithTitle "scale-agent/concepts/service-permissions.md" >}}