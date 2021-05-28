---
title: "Armory Agent for Kubernetes Quickstart Installation"
linkTitle: "Quickstart"
description: >
  Learn how to install the Armory Agent in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

## Overview

The Agent consists of a service deployed as a Kubernetes `Deployment` and a plugin to the Clouddriver service. You can review the architecture in the Armory Agent [overview]({{< ref "armory-agent#deployment-topologieshug" >}}).

Deploying the Agent consists of the following:

1. [Install the Clouddriver plugin](#install-the-clouddriver-plugin). You do this in the cluster where you are running Armory Enterprise. You add the plugin and expose it as type `LoadBalancer` on gRPC port `9091`.
1. [Install the Agent](#install-the-agent) in the deployment target cluster. Configure it to communicate with Clouddriver. Configure Agent permissions with a Kubernetes `ServiceAccount`.

>This installation does not include [mTLS configuration]({{< ref "agent-mtls" >}}). The Agent uses insecure config for connecting to Clouddriver.

## {{% heading "prereq" %}}

* You deployed Armory Enterprise using the [Armory Operator and Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions.
* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).
* If you are running multiple Clouddriver instances, you have a running Redis instance. The Agent uses Redis to coordinate between Clouddriver replicas.
* You have an additional cluster to serve as your deployment target cluster.

### Networking requirements

Communication from the Agent to Clouddriver occurs over gRPC port 9091. Communication between the Agent and Clouddriver must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Agent and Clouddriver.  

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## Install the Clouddriver plugin

### Create the plugin manifest

Add the following manifest to your Kustomize patches directory. Then include the file under the `patchesStrategicMerge` section of your `kustomization` file.

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

## Install the Agent

### Create a namespace

In the deployment target cluster, execute `kubectl create ns spin-agent` to create a namespace for the Agent.

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

### Configure Agent for the Clouddriver LoadBalancer

Configure the Agent using a `configmap`. In the following manifest, replace **[LoadBalancer Exposed Address]** with the IP address you obtained in the [Get the LoadBalancer IP address section](#get-the-loadbalancer-ip-address).

{{< prism lang="yaml" line="18" >}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubesvc-config
  namespace: spin-agent
data:
  kubesvc.yaml: |
    kubernetes:
      accounts:
      - name: remote1 # Change this name for each remote cluster
        serviceAccount: true
        serviceAccountName: spin-sa
        metrics: false
        # /kubeconfigfiles/ is the path to the config files
        # as mounted from the `kubeconfigs-secret` Kubernetes secret
        #kubeconfigFile: /kubeconfigfiles/kubecfg-account01.yaml
    clouddriver:
      grpc: [LoadBalancer Exposed Address]:9091 # For Agent or Infrastructure mode, change this to your exposed lb address
      insecure: true #Set this to true if TLS between spinnaker services is not enabled
    server:
      port: 8082
{{< /prism >}}

Apply the manifest to your `spin-agent` namespace.

### Deploy the Agent

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
      - image: armory/kubesvc
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
