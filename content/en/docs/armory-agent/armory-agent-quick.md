---
title: "Armory Agent for Kubernetes Quickstart Installation"
linkTitle: "Quickstart"
description: >
  Learn how to install the Armory Agent in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

## Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

The Agent consists of a service deployed as a Kubernetes `Deployment` and a plugin to Spinnaker's Clouddriver service. You can review the architecture in the Armory Agent [overview]({{< ref "armory-agent" >}}).

## {{% heading "prereq" %}}

* You deployed Armory Enterprise using the [Armory Operator and Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions.
* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).
* If you are running multiple Clouddriver instances, you need a Redis instance. The Agent uses Redis to coordinate between Clouddriver replicas.
* You have an additional cluster to serve as your target deployment cluster.

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## Networking requirements

Communication from the Agent to Clouddriver occurs over gRPC port 9091. Communication between the Agent and Clouddriver must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Agent and Clouddriver.  

## Kubernetes permissions needed by the Agent

The Agent can use a `kubeconfig` file loaded as a Kubernetes secret when deploying to a remote cluster or a Kubernetes Service Account when deploying to the cluster it resides in.

The Agent should have `ClusterRole` authorization if you need to deploy pods across your cluster or `Role` authorization if you deploy pods only to a single namespace.

* If Agent is running in [Agent Mode]({{< ref "armory-agent#agent-mode" >}}), then the `ClusterRole` or `Role` is the one attached to the Kubernetes Service Account mounted by the Agent pod.
* If Agent is running in any of the other modes, then the `ClusterRole` or `Role` is the one the `kubeconfigFile` uses to interact with the target cluster. `kubeconfigFile` is configured in `kubesvc.yml` of the Agent pod.

Example configuration for deploying `Pod` manifests:

{{< tabs name="agent-permissions" >}}
{{% tab name="ClusterRole" %}}

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: agent-role
rules:
- apiGroups: ""
  resources:
  - pods
  - pods/log
  - pods/finalizers  
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
```

{{% /tab %}}
{{% tab name="Role" %}}

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: agent-role
rules:
- apiGroups: ""
  resources:
  - pods
  - pods/log
  - pods/finalizers  
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
```

{{% /tab %}}
{{< /tabs >}}

You can see a more detailed example of the kind of `ClusterRole` permissions you may need in the `spinnaker-kustomize-patch` repo's `spin-sa.yml` [file](https://github.com/armory/spinnaker-kustomize-patches/blob/master/accounts/kubernetes/spin-sa.yml#L5).

See the Kubernetes [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) guide for details on configuring `ClusterRole` and `Role` authorization.

## Step 1: Agent Clouddriver plugin installation

This step is performed in the cluster Spinnaker service is running. You will add the Clouddriver plugin and expose it as type `LoadBalancer` on gRPC port `9091`. In step 2, the Agent will be configured to communicate with Clouddriver. _Take note to ensure the plugin version is compatible with the Spinnaker version. See the comments in the manifest_.

Add this manifest to your Kustomize patches directory and include it under the patchesStrategicMerge section of your kustomization file:

```yaml
# The plugin version (see kubesvc-plugin below) must be compatible with the spinnaker version, check here: https://docs.armory.io/docs/armory-agent/armory-agent-quick/#compatibility-matrix
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

To expose Clouddriver as a Kubernetes-type LoadBalancer, add this manifest to your kustomize directory structure and include it in your kustomization resources section:

```yaml
# This loadbalancer service exposes the gRPC port on Clouddriver for the remote agents to connect
# Look for the LB svc IP address that is exposed on 9091
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
```

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.

Once both manifests are configured, apply the update with kustomize. Use ```kubectl get svc spin-agent-cloud-driver -n spinnaker``` to make note of the LB IP external address for use later.

You can also use netcat to confirm Clouddriver is listening on port 9091:  ```nc -zv [LB address] 9091```. Perform this check from a node in your Spinnaker cluster and your target cluster.

## Step 2: Agent installation

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
  - update
  - patch
  - delete
- apiGroups:
  - ""
  -  resources:
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

Create a `configmap` for the Agent config. Replace _[LoadBalancer Exposed Address]_ with the IP address Clouddriver was exposed on earlier. Apply the following manifest to your spin-agent namespace:

```yaml
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

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "agent-mtls.md" >}}
* {{< linkWithTitle "agent-troubleshooting.md" >}} page if you run into issues.
* {{< linkWithTitle "agent-monitoring.md" >}} page for how to monitor agents running on an Armory platform. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
