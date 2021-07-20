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
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions.
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

   1. [Create a namespace](#create-a-namespace).
   1. [Create Kubernetes accounts](#configure-permissions).
   1. [Create a ConfigMap](#configure-the-agent) to configure the Agent service.
   1. [Deploy the Agent service](#deploy-the-agent-service).

## Install the Clouddriver plugin

### Create the plugin manifest

Create a new `armory-agent` directory in your Kustomize patches directory. Add the following `agent-config.yaml` manifest to your new `armory-agent` directory.

* Change the value for `name` if your Armory Enterprise service is called something other than "spinnaker".
* Update the `kubesvc-plugin` value to the Armory Agent Plugin Version that is compatible with your Armory Enterprise version. See the [compatibility matrix](#compatibility-matrix).

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
                  - name: kubesvc-plugin
                    image: docker.io/armory/kubesvc-plugin:<version> # must be compatible with your Armory Enterprise version
                    volumeMounts:
                      - mountPath: /opt/plugin/target
                        name: kubesvc-plugin-vol
                  containers:
                  - name: clouddriver
                    volumeMounts:
                      - mountPath: /opt/clouddriver/lib/plugins
                        name: kubesvc-plugin-vol
                  volumes:
                  - name: kubesvc-plugin-vol
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

### Create a namespace

In the deployment target cluster, execute `kubectl create ns spin-agent` to create a namespace for the Agent service.

### Configure permissions

Create a `ClusterRole`, `ServiceAccount`, and `ClusterRoleBinding` for the Agent by applying the following manifest in your `spin-agent` namespace:

{{< prism lang="yaml" line="2, 98, 103" >}}
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
{{< /prism >}}

### Configure the Agent service

Configure the Agent service using a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/). Define `kubesvc.yml` in the `data` section:

{{< prism lang="yaml" line="7" >}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubesvc-config
  namespace: spin-agent
data:
  kubesvc.yml: |  
  server:
    port: 8082
{{< /prism >}}

**Clouddriver plugin LoadBalancer**

Replace **[LoadBalancer Exposed Address]** with the IP address you obtained in the [Get the LoadBalancer IP address section](#get-the-loadbalancer-ip-address).

{{< prism lang="yaml" line="18" >}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubesvc-config
  namespace: spin-agent
data:
  kubesvc.yaml: |
    clouddriver:
      grpc: [LoadBalancer Exposed Address]:9091
      insecure: true
{{< /prism >}}

**Kubernetes account**

Add your Kubernetes account configuration for your cluster:

{{< prism lang="yaml" line="11-30" >}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubesvc-config
  namespace: spin-agent
data:
  kubesvc.yaml: |
    clouddriver:
      grpc: [LoadBalancer Exposed Address]:9091
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
{{< /prism >}}

See the [Agent options]({{< ref "agent-options#options">}}) for field explanations.

Apply the manifest to your `spin-agent` namespace.

### Deploy the Agent service

Apply the following Agent deployment manifest in your `spin-agent` namespace:

{{< prism lang="yaml" >}}
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: spin
    app.kubernetes.io/name: kubesvc
    app.kubernetes.io/part-of: spinnaker
    cluster: spin-kubesvc
  name: spin-kubesvc
spec:
  replicas: 1
  selector:
    matchLabels:
      app: spin
      cluster: spin-kubesvc
  template:
    metadata:
      labels:
        app: spin
        app.kubernetes.io/name: kubesvc
        app.kubernetes.io/part-of: spinnaker
        cluster: spin-kubesvc
    spec:
      serviceAccount: spin-sa
      containers:
      - image: armory/kubesvc:<version> # must be compatible with your Armory Enterprise version
        imagePullPolicy: IfNotPresent
        name: kubesvc
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
        - mountPath: /opt/spinnaker/config
          name: volume-kubesvc-config
        # - mountPath: /kubeconfigfiles
        #   name: volume-kubesvc-kubeconfigs
      restartPolicy: Always
      volumes:
      - name: volume-kubesvc-config
        configMap:
          name: kubesvc-config
      # - name: volume-kubesvc-kubeconfigs
      #   secret:
      #     defaultMode: 420
      #     secretName: kubeconfigs-secret
{{< /prism >}}

## Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "agent-troubleshooting.md" >}} page if you run into issues.
* Learn how to {{< linkWithTitle "agent-monitoring.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "agent-mtls.md" >}}
* Read about {{< linkWithTitle "agent-permissions.md" >}}
