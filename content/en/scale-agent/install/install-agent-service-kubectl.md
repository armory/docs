---
title: "Install the Armory Agent Service Using Kubectl"
linkTitle: "Install Service - Kubectl"
description: >
  Use 'kubectl' to install the Armory Scale Agent for Spinnaker and Kubernetes service in your Kubernetes and Spinnaker or Armory CD environments.
weight: 30
---

## {{% heading "prereq" %}}

Make sure you have [installed the Clouddriver plugin]({{< ref "install-agent-plugin" >}}).


## Create a namespace

In the deployment target cluster, execute `kubectl create ns spin-agent` to create a namespace for the Armory Agent service.

## Configure permissions

Agent could make use of the default `ServiceAccount` created by k8s under every namespace, but since agent needs access to list and get the pods and endpoints kinds under the cluster to assign a precise zoneId if its not provided under config file and load balance connections if balanceConnection property is true.

If the default `ServiceAccount` doesn't have those access, agent will still be able to run but not able to load balance connections or compute a precise zoneId but this is not essential, also if you are planing 
to have accounts that use such default `ServiceAccount` (serviceAccount: true) be wary of the permissions when you are deploying or caching.

For all those cases we could always create a `ClusterRole`, `ServiceAccount`, and `ClusterRoleBinding` for the Armory Agent by applying the following manifest in your `spin-agent` namespace:

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

## Configure the Armory Agent service

Configure the Armory Agent service using a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/). Define `armory-agent.yml` in the `data` section:


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

See the [Agent options]({{< ref "agent-options#configuration-options">}}) for field explanations.

Apply the manifest to your `spin-agent` namespace.

## Deploy the Armory Agent service

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

## Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/troubleshooting/_index.md" >}} page if you run into issues.
* Learn how to {{< linkWithTitle "scale-agent/tasks/agent-monitoring.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Armory Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "scale-agent/tasks/agent-mtls.md" >}}
* Read about {{< linkWithTitle "scale-agent/concepts/agent-permissions.md" >}}
</br>
</br>