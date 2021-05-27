---
title: "Armory Agent for Kubernetes Quickstart Installation"
linkTitle: "Quickstart"
description: >
  Learn how to install the Armory Agent in your Kubernetes and Armory Enterprise environments.
weight: 2
---
![Proprietary](/images/proprietary.svg) This feature requires an Armory licensed entitlement.

## Overview

The Agent consists of a plugin to Spinnaker's Clouddriver service and a K8s deployment that connects to Clouddriver. You can review the architecture in the Armory Agent [overview]({{< ref "armory-agent" >}}).

## {{% heading "prereq" %}}

* This guide assumes you're using the Armory Operator to install Spinnaker, with the Kustomize method from the [spinnaker-kustomize-patch repo](https://github.com/armory/spinnaker-kustomize-patches).

* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions.
* You have Spinnaker installed in one cluster, and an additional cluster to serve as your target deployment cluster.

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

### Networking requirements

Communication from the Agent to Clouddriver occurs over gRPC port 9091.

### Kubernetes permissions required by the Agent

The Agent can use a kubeconfig file loaded as a K8s secret (This is only appropriate when the agent runs in a separate cluster from the target cluster), or as a service account in the cluster it resides in. Running Agent in the target cluster with a service account is the preferred model. 

## Step 1: Agent Clouddriver Plugin Installation

This step is performed in the cluster Spinnaker service is running. You will add the Clouddriver plugin and expose it as type `LoadBalancer` on gRPC port `9091`. In step 2, the Agent will be configured to communicate with Clouddriver. _Take note to ensure the plugin version is compatible with the Spinnaker version. See the comments in the manifest_.

Add this manifest to your Kustomize patches:

```yaml
# The plugin version (see kubesvc-plugin below) must be comatible with the spinnaker version, check here: https://docs.armory.io/docs/armory-agent/armory-agent-quick/#compatibility-matrix
# Change "spinnaker" name below if your spinsvc is called something else
apiVersion: spinnaker.armory.io/v1alpha2
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
                extensions:
                  armory.kubesvc:
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
                    image: docker.io/armory/kubesvc-plugin:0.8.9 # <-- Version number must be compatible with spinnaker version
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

```

To expose Clouddriver for remote Agents, add this manifest to your Kustomize resources:

```yaml
# This loadbalancer service exposes the gRPC port on cloud-driver for the remote agents to connect
# Look for the LB svc IP address that is exposed on 9091
apiVersion: v1
kind: Service
metadata:
  labels:
  name: spin-agent-cloud-driver
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
```

Once both manifests are configured, apply the update. Use ```kubectl get svc spin-agent-cloud-driver -n spinnaker``` to make note of the LB IP external address for use later.

You can also use netcat to confirm Clouddriver is listening on port 9091:  ```nc -zv [LB address] 9091```. Perform this check from a node in your Spinnaker cluster and your target cluster.

## Step 2: Agent Installation

This step is performed in the deployment target cluster.

This installation is intended as a quickstart and does not include mTLS configuration. Insecure config will be used for connecting to Clouddriver. The Agent will be installed in the deployment target cluster and configured with a K8s service account. 

Create a namespace for the Agent to run in: ```kubectl create ns spin-agent```

Create a service account, clusterrole, and clusterrolebinding for the Agent. Apply the following manifest in your spin-agent namespace:

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
  - watch
  - create
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

Create a configmap for the Agent config. Apply the following manifest to your spin-agent namespace:

```yaml

```

The last task in this step is to apply the Agent deployment manifest in your spin-agent namespace: 

```yaml
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
```

## Confirm Success

Create a pipeline with a ```Deploy manifest``` stage. You should see your target cluster available in the ```Accounts``` list. Deploy a static manifest.
