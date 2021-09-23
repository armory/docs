---
title: "Armory Agent for Kubernetes Installation"
linkTitle: "Installation"
description: >
  Learn how to install the Armory Agent in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

>This installation guide is designed for installing the Agent in a test environment. It does not include [mTLS configuration]({{< ref "agent-mtls" >}}), so the Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}

* You deployed Armory Enterprise using the [Armory Operator and Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions. The Agent plugin uses the SQL database to store cache data.
* You have a running Redis instance. The Agent plugin uses Redis to coordinate between Clouddriver replicas. Note: you need Redis even if you only have one Clouddriver instance.
* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).
* If you are running multiple Clouddriver instances, you have a running Redis instance. The Agent uses Redis to coordinate between Clouddriver replicas.
* You have an additional Kubernetes cluster to serve as your deployment target cluster.

### Networking requirements

Communication from the Agent service to the Clouddriver plugin occurs over gRPC port 9091. Communication between the service and the plugin must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Agent service and Clouddriver plugin.  

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## Installation overview

In this guide, you deploy the Agent service to your target cluster.

Installation steps:

1. [Install the Clouddriver plugin](#install-the-clouddriver-plugin). You do this in the cluster where you are running Armory Enterprise.

   1. [Create the plugin manifest as a Kustomize patch](#create-the-plugin-manifest).
   1. [Create a LoadBalancer service Kustomize patch](#expose-clouddriver-as-a-loadbalancer) to expose the plugin on gRPC port `9091`.
   1. [Apply the manifests](#apply-the-manifests).

1. [Install the Agent service](#install-the-agent-service) in the deployment target cluster.

## Install the Clouddriver plugin

### Create the plugin manifest

Create a new `armory-agent` directory in your Kustomize patches directory. Add the following `agent-config.yaml` manifest to your new `armory-agent` directory.

* Change the value for `name` if your Armory Enterprise service is called something other than "spinnaker".
* Update the `agent-kube-spinplug` value to the Armory Agent Plugin Version that is compatible with your Armory Enterprise version. See the [compatibility matrix](#compatibility-matrix).

{{< prism lang="yaml" line="4, 39" >}}
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version">}}
kind: SpinnakerService
metadata:
  name: spinnaker
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
        # Plugin config
        kubesvc:
          cluster: redis
#          eventsCleanupFrequencySeconds: 7200
#          localShortCircuit: false
#          runtime:
#            defaults:
#              onlySpinnakerManaged: true
#            accounts:
#              account1:
#                customResources:
#                  - kubernetesKind: MyKind.mygroup.acme
#                    versioned: true
#                    deployPriority: "400"
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
                    image: docker.io/armory/kubesvc-plugin:<version> # must be compatible with your Armory Enterprise version
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
{{< /prism >}}

Then include the file under the `patchesStrategicMerge` section of your `kustomization` file.

{{< prism lang="yaml" line="4" >}}
bases:
  - agent-service
patchesStrategicMerge:
  - armory-agent/agent-config.yaml
{{< /prism >}}

### Expose Clouddriver as a LoadBalancer

To expose Clouddriver as a Kubernetes-type LoadBalancer, add the following manifest to your Kustomize directory. Then include the file in the `resources` section of your `kustomization` file.

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.

{{< prism lang="yaml" >}}
# This LoadBalancer service exposes the gRPC port on Clouddriver for the remote Agents to connect to
# Look for the LoadBalancer service IP address that is exposed on 9091
apiVersion: v1
kind: Service
metadata:
  labels:
  name: spin-agent-clouddriver
spec:
  ports:
    - name: grpc
      port: 9091
      protocol: TCP
      targetPort: 9091
  selector:
    app: spin
    cluster: spin-clouddriver
  type: LoadBalancer
{{< /prism >}}

### Apply the manifests

After you have configured both manifests, apply the updates.

### Get the LoadBalancer IP address

Use `kubectl get svc spin-agent-cloud-driver -n spinnaker` to make note of the LoadBalancer IP external address. You need this address when you configure the Agent.

### Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your
Armory Enterprise cluster and one in your target cluster.

## Install the Agent service

You can either install the Agent service with a Helm chart that Armory provides or manually using `kubectl`. 

{{< tabs name="agent-install" >}}

{{% tab name="Helm" %}}

On the Kubernetes cluster where you want to install the Agent Service, perform the following steps:

1. Add the Armory charts repo:

   ```bash
   helm repo add armory-charts http://armory.jfrog.io/artifactory/charts
   ```

   If you have previously added the chart repo, update it with the following commands:

   ```bash
   helm repo update 
   helm upgrade armory-agent armory-charts/agent-k8s
   ```

2. Create a namespace in the Kubernetes cluster where you are installing the Agent Service. In Agent mode, this is the same cluster as the deployment target for your app.
   
   ```bash
   kubectl create namespace <agent-namespace>
   ```

   > If you plan to run the Agent in something other than Agent mode, such as Infrastructure mode, you need to create a kubeconfig file that grants access to the deployment target cluster. For example, run the following command if you use Amazon EKS: `aws eks update-kubeconfig --name <target-cluster> `.

3. Decide whether or not you want to connect to Armory Cloud services. Armory Cloud services is required for some features to function and affects how you configure the Agent service installation. You must either disable the connection or provide credentials.

   If you do not want to connect to Armory Cloud services, you must include the following parameters when running the `helm` command to install the Agent service:
   - `--set cloudEnabled=false`
   - `--set grpcUrl=localhost:9090`

   These parameters control whether or not Agent attempts to connect to Armory Cloud services. They are required if you do not have a clientID and clientSecret and do not want to use Armory Cloud services. 

   If you want to connect to Armory Cloud services, you must include the following parameters with the values that Armory provided when  running the `helm` command to install the Agent service:

   - `--set clientId`
   - `--set clientSecret`

   These are parameters are used to authenticate you to Armory Cloud services.


4. Run one of the following Helm commands:

   <details><summary><strong>Install with default configs in Agent mode</strong></summary>
   
   ```bash
   helm install armory-agent armory-charts/agent-k8s \
   --set accountName=<my-k8s-cluster> \ # Provide a descriptive name. This name gets used in the UI and Armory Cloud API. 
   --set mode=agent \
   --namespace=<agent-namespace> # Namespace where you want to install the Agent.
   ```

   Depending on your environment and usage, include one or more of the following parameters:

   ```bash
   # Disable the connection to Armory Cloud 
   --set cloudEnabled=false    
   --set grpcUrl=localhost:9090
   
   # Authenticate to Armory Cloud
   --set clientId=<your-clientId>  
   --set clientSecret=<your-Armory-Cloud-secret> 
   
   # Custom config options for Kubernetes
   --set kubernetes=<kubernetes-options>

   # If TLS is disabled in your environment
   --set insecure=true

   # If you are pulling from a private registry
   --set imagePullSecrets=<secret>    

   # Proxy settings
   # Set this if your Armory Enterprise instance is behind a HTTP proxy.
   --set env[0].name=”HTTP_PROXY”,env[0].value="<hostname>:<port>" 
   
   # Set this if your Armory Enterprise instance is behind a HTTPS proxy.
   --set env[0].name=”HTTPS_PROXY”,env[0].value="<hostname>:<port>" 

   # No proxy
   --set env[0].name=”NO_PROXY”,env[0].value="localhost,127.0.0.1,*.spinnaker"
   ```

   The `env` parameters are optional and only need to be used if Armory Enterprise is behind a HTTP(S) proxy. If you need to set more than one of the `env` parameters, you must increment the index value for the parameters. For example: `env[0].name="HTTP_PROXY`, `env[1].name="HTTPS_PROXY"`, and `env[2].name="NO_PROXY"`.

   Alternatively, you can create a `values.yaml` file to include the parameters:
   
   ```yaml
   env:
     - name: HTTP_PROXY
       value: <hostname>:<port>
     - name: HTTPS_PROXY
       value: <hostname>:<port>
     - name: NO_PROXY
       value: localhost,127.0.0.1,*.spinnaker
   ```
   With the file, you can avoid setting individual `env` parameters in the `helm install` command. Instead    include the `--values` parameter as part of the Helm install command.

   For information about additional options, see the [Agent config options]({{< ref "agent-options#configuration-options" >}}).

   <details><summary>Show me an example</summary>
   
   The following examples use the `imagePullSecrets` and `insecure` parameters, which may or may not be needed depending on your environment.

   This example installs Agent service without a connection to Armory Cloud:

   ```bash
   helm install armory-agent --set accountName=demo-account,imagePullSecrets=regcred,grpcUrl=spin-clouddriver-grpc:9091,insecure=true,cloudEnabled=false --namespace dev armory-charts/agent-k8s
   ```

   This example installs Agent service with a connection to Armory Cloud:

   ```bash
   helm install armory-agent --set accountName=hubaccount1,imagePullSecrets=regcred,grpcUrl=agents.staging.cloud.armory.io:443,audience=https://api.cloud.armory.io,tokenIssuerUrl=https://auth.cloud.armory.io/oauth/token,clientId=************,clientSecret=************ --namespace dev armory-charts/agent-k8s
   ```

   </details>
   </details>

   <details><summary><strong>Install with default configs in Infrastructure mode</strong></summary>

   ```bash
   helm install armory-agent armory-charts/agent-k8s \
   --set accountName=<my-k8s-cluster> \ # Provide a descriptive name. This name gets used in the UI and Armory Cloud API. 
   --set mode=infrastructure \
   --namespace=<agent-namespace> # Namespace where you want to install the Agent.
   ```

   Depending on your environment and usage, set one or more of the following parameters:

   ```bash
   # Disable the connection to Armory Cloud 
   --set cloudEnabled=false    
   --set grpcUrl=localhost:9090
   
   # Authenticate to Armory Cloud
   --set clientId=<your-clientId> 
   --set clientSecret=<your-Armory-Cloud-secret> 
   
   # Custom config options for Kubernetes
   --set kubernetes=<kubernetes-options> 

   # If TLS is disabled in your environment
   --set insecure=true

   # If you are pulling from a private registry
   --set imagePullSecrets=<secret>

   # Proxy settings
   # Set this if your Armory Enterprise instance is behind a HTTP proxy.
   --set env[0].name=”HTTP_PROXY”,env[0].value="<hostname>:<port>" 
   
   # Set this if your Armory Enterprise instance is behind a HTTPS proxy.
   --set env[0].name=”HTTPS_PROXY”,env[0].value="<hostname>:<port>" 

   # No proxy
   --set env[0].name=”NO_PROXY”,env[0].value="localhost,127.0.0.1,*.spinnaker"
   ```

   The `env` parameters are optional and only need to be used if Armory Enterprise is behind a HTTP(S) proxy. If you need to set more than one of the `env` parameters, you must increment the index value for the parameters. For example: `env[0].name="HTTP_PROXY`, `env[1].name="HTTPS_PROXY"`, and `env[2].name="NO_PROXY"`.

   Alternatively, you can create a `values.yaml` file to include the parameters:
   
   ```yaml
   env:
     - name: HTTP_PROXY
       value: <hostname>:<port>
     - name: HTTPS_PROXY
       value: <hostname>:<port>
     - name: NO_PROXY
       value: localhost,127.0.0.1,*.spinnaker
   ```

   With the file, you can avoid setting individual `env` parameters in the `helm install` command. Instead    include the `--values` parameter as part of the Helm install command.

   For information about additional options, see the [Agent config options]({{< ref "agent-options#configuration-options" >}}).

   <details><summary>Show me an example</summary>
   
   The following examples use the `imagePullSecrets` and `insecure` parameters, which may or may not be needed depending on your environment.

   This example installs Agent service without a connection to Armory Cloud:

   ```bash
   helm install armory-agent --set mode=infrastructure,accountName=demo-account,imagePullSecrets=regcred,grpcUrl=spin-clouddriver-grpc:9091,insecure=true,cloudEnabled=false --set-file kubeconfig=$HOME/.kube/config --namespace dev armory-charts/agent-k8s
   ```
   
   This example installs Agent service with a connection to Armory Cloud:

   ```bash
   helm install armory-agent --set accountName=hubaccount1,imagePullSecrets=regcred,grpcUrl=agents.staging.cloud.armory.io:443,audience=https://api.cloud.armory.io,tokenIssuerUrl=https://auth.cloud.armory.io/oauth/token,clientId==************,clientSecret=************ --namespace dev armory-charts/agent-k8s
   ```

   </details>
   </details>

   <details><summary><strong>Install with custom settings</strong></summary>

   1. Use `helm template` to generate a manifest. 
      ```bash
      helm template armory-agent armory-charts/agent-k8s \
      --set-file kubeconfig=<path-to-your-kubeconfig>,armoryagent.yml=<path-to-agent-options>.yml \ 
      --namespace=<agent-namespace> # Namespace where you want to install the Agent.
      ```
   
      For `armoryagentyml`, create the file and customize it to meet your needs. For information about the options, see the [Agent config options]({{< ref "agent-options#configuration-options" >}}).
    1. Install the helm chart using your template:
   
       ```bash
       helm install armory-agent <local-helm-chart-name>
       ```
   </details>

#### Proxy settings

The `env` parameters are optional and only need to be used if Armory Enterprise is behind a HTTP(S) proxy. If you need to set more than one of the `env` parameters, you must increment the index value for the parameters. For example: `env[0].name="HTTP_PROXY`, `env[1].name="HTTPS_PROXY"`, and `env[2].name="NO_PROXY"`.

Alternatively, you can create a `values.yaml` file to include the parameters:

```yaml
env:
  - name: HTTP_PROXY
    value: <hostname>:<port>
  - name: HTTPS_PROXY
    value: <hostname>:<port>
  - name: NO_PROXY
    value: localhost,127.0.0.1,*.spinnaker
```
With the file, you can avoid setting individual `env` parameters in the `helm install` command. Instead include the `--values` parameter as part of the Helm install command:

```
--values=<path>/values.yaml
```

{{< /tab >}}


{{% tab name="kubectl" %}}

### Create a namespace

In the deployment target cluster, execute `kubectl create ns spin-agent` to create a namespace for the Agent service.

### Configure permissions

Create a `ClusterRole`, `ServiceAccount`, and `ClusterRoleBinding` for the Agent by applying the following manifest in your `spin-agent` namespace:

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
  - pods
  - pods/log
  - ingresses/status
  - endpoints
  verbs:
  - get
  - list
  - update
  - patch
  - delete
- apiGroups:
  - ""
  resources:
  - services
  - services/finalizers
  - events
  - configmaps
  - secrets
  - namespaces
  - ingresses
  - jobs
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
  verbs:
  - create
  - get
  - list
  - update
  - watch
  - patch
- apiGroups:
  - apps
  - extensions
  resources:
  - deployments
  - deployments/finalizers
  - deployments/scale
  - daemonsets
  - replicasets
  - replicasets/finalizers
  - replicasets/scale
  - statefulsets
  - statefulsets/finalizers
  - statefulsets/scale
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
  - admissionregistration.k8s.io
  resources:
  - validatingwebhookconfigurations
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

### Configure the Agent service

Configure the Agent service using a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/). Define `armory-agent.yml` in the `data` section:


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

See the [Agent options]({{< ref "agent-options#options">}}) for field explanations.

Apply the manifest to your `spin-agent` namespace.

### Deploy the Agent service

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
      - image: armory/agent-k8s:<version> # must be compatible with your Armory Enterprise version
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

{{% /tab %}}

{{< /tabs >}}


## Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "agent-troubleshooting.md" >}} page if you run into issues.
* Learn how to {{< linkWithTitle "agent-monitoring.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "agent-mtls.md" >}}
* Read about {{< linkWithTitle "agent-permissions.md" >}}
