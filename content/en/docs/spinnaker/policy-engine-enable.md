---
title: Enabling Policy Engine
weight: 143
aliases:
  - /spinnaker/policy_engine/
  - /spinnaker/policy-engine/
summary: "Enable the Policy Engine and configure an OPA server. When enabled, the Policy Engine can perform save time or runtime validation on your Spinnaker pipelines." 
---

## Overview

The Armory Policy Engine is designed to allow enterprises more complete control of their software delivery process by providing them with the hooks necessary to perform more extensive verification of their pipelines and processes in Spinnaker. This policy engine is backed by [Open Policy Agent](https://www.openpolicyagent.org/)(OPA) and uses input style documents to perform validation of pipelines during save time and runtime:

* **Save time validation** - Validate pipelines as they're created/modified. This validation operates on all pipelines using a fail closed model. This means that if you have the Policy Engine enabled but no policies configured, the Policy Engine prevents you from creating or updating any pipeline.
* **Runtime validation** - Validate deployments as a pipeline is executing. This validation only operates on tasks that you have explicitly created policies for. Tasks with no policies are not validated.

For information about how to use the Policy Engine, see [Using the Policy Engine]({{< ref "policy-engine-use" >}}).

## Requirements

Make sure you can meet the following version requirements for the Policy Engine:

* OPA versions 0.12.x or 0.13.x
* Halyard 1.7.2 or later if you are using Halyard to manage Spinnaker
* Armory 2.16.0 or later for Pipeline save time validation
* Armory 2.19.0 or later for Pipeline runtime validation

## Before You Start

The Policy Engine requires an OPA server. You can either [deploy an OPA server](https://www.openpolicyagent.org/docs/latest/#running-opa) or use the example on this page to deploy a server in the same Kubernetes cluster as Spinnaker.


## Deploy an OPA server

The Policy Engine supports the following OPA server deployments:

* An OPA server deployed in the same Kubernetes cluster as an Armory Spinnaker deployment. The [Using ConfigMaps for OPA policies](#using-configmaps-for-opa-policies) section contains a ConfigMap you can use.
* An OPA cluster that is **not** in the same Kubernetes cluster as an Armory Spinnaker deployment . See the [OPA documentation](https://www.openpolicyagent.org/docs/latest/) for more information about installing an OPA cluster.

## Using ConfigMaps for OPA Policies

If you want to use ConfigMaps for OPA policies, you can use the below manifest as a starting point. This example manifest deploys an OPA server and applies the configuration for things like rolebinding and a static DNS.

When using the below example, keep the following guidelines in mind:
* The manifest does not configure any authorization requirements for the OPA server it deploys. This means that anyone can add a policy.
* The manifest deploys the OPA server to a namespace called `opa`.
* The OPA server uses the following config: `"--require-policy-label=true"`. This configures the OPA server to look for a specific label so that it does not check all configmaps for new policies. For information about how to apply the relevant label to your policy configmaps, see [Creating a policy]({{< ref "policy-engine-use#step-2-add-policies-to-opa" >}}).

<details><summary>Show the manifest</summary>
<code><pre>
---
apiVersion: v1
kind: Namespace
metadata:
  name: opa # Change this to install OPA in a different namespace
---
# Grant service accounts in the 'opa' namespace read-only access to resources.
# This lets OPA/kube-mgmt replicate resources into OPA so they can be used in policies.
# The subject name should be `system:serviceaccounts:<namespace>` where `<namespace>` is the namespace where OPA will be installed
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: opa-viewer-spinnaker
roleRef:
  kind: ClusterRole
  name: view
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: Group
  name: system:serviceaccounts:opa # Change this to the namespace OPA is installed in
  apiGroup: rbac.authorization.k8s.io
---
# Define role in the `opa` namespace for OPA/kube-mgmt to update configmaps with policy status.
# The namespace for this should be the namespace where policy configmaps will be created
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: opa # Change this to the namespace where policies will live
  name: configmap-modifier
rules:
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["update", "patch"]
---
# Bind the above role to all service accounts in the `opa` namespace
# The namespace for this should be the namespace where policy configmaps will be created
# The subject name should be `system:serviceaccounts:<namespace>` where `<namespace>` is the namespace where OPA will be installed
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: opa # Change this to the namespace where policies will live
  name: opa-configmap-modifier
roleRef:
  kind: Role
  name: configmap-modifier
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: Group
  name: system:serviceaccounts:opa # Change this to the namespace OPA is installed in
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: opa-deployment
  namespace: opa # Change this to the namespace OPA is installed in
  labels:
    app: opa
spec:
  replicas: 1
  selector:
    matchLabels:
      app: opa
  template:
    metadata:
      labels:
        app: opa
    spec:
      containers:
      # WARNING: OPA is NOT running with an authorization policy configured. This
      # means that clients can read and write policies in OPA. If you are
      # deploying OPA in an insecure environment, be sure to configure
      # authentication and authorization on the daemon. See the Security page for
      # details: https://www.openpolicyagent.org/docs/security.html.
        - name: opa
          image: openpolicyagent/opa:0.17.2
          args:
            - "run"
            - "--server"
            - "--addr=http://0.0.0.0:8181"
          readinessProbe:
            httpGet:
              path: /health
              scheme: HTTP
              port: 8181
            initialDelaySeconds: 3
            periodSeconds: 5
          livenessProbe:
            httpGet:
              path: /health
              scheme: HTTP
              port: 8181
            initialDelaySeconds: 3
            periodSeconds: 5
        - name: kube-mgmt
          image: openpolicyagent/kube-mgmt:0.9
          args:
          # Change this to the namespace where you want OPA to look for policies
            - "--policies=opa"
          # Configure the OPA server to only check ConfigMaps with the relevant label
            - "--require-policy-label=true"
---
# Create a static DNS endpoint for Spinnaker to reach OPA
apiVersion: v1
kind: Service
metadata:
  name: opa
  namespace: opa # Change this to the namespace OPA is installed in
spec:
  selector:
    app: opa
  ports:
  - protocol: TCP
    port: 8181
    targetPort: 8181
</pre></code>
</details>


## Enabling the Policy Engine

The steps to enable the Policy Engine vary based on whether you use the [Operator](#enabling-policy-engine-using-operator) or [Halyard](#enabling-policy-engine-using-halyard).

### Enabling Policy Engine using Operator

Add the following section to `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      front50: #Enables Save time validation of policies
        armory:
          opa:
            enabled: true
            url: <OPA Server URL>:<port>/v1
      clouddriver: #Enables Runtime validation of policies
        armory:
          opa:
            enabled: true
            url: <OPA Server URL>:<port>/v1
```

*Note: There must be a trailing /v1 on the URL. This extension is only compatible with OPA's v1 API.*

If you are using an in-cluster OPA instance (such as one set up with the instructions below), Spinnaker can access OPA via the Kubernetes service DNS name. The following example configures Spinnaker to connect with an OPA server at `http://opa.opa:8181`:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      front50: #Enables Save time validation of policies
        armory:
          opa:
            enabled: true
            url: http://opa.opa:8181/v1
      clouddriver: #Enables Runtime validation of policies
        armory:
          opa:
            enabled: true
            url: http://opa.opa:8181/v1
```

Deploy the changes (assuming that Spinnaker lives in the: `spinnaker` namespace and the manifest file is named `spinnakerservice.yml`:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

### Enabling Policy Engine using Halyard

Add the following configuration to `.hal/default/profiles/spinnaker-local.yml`:

```yaml
armory:
  opa:
    enabled: true
    url: <OPA Server URL>:<port>/v1
```

*Note: There must be a trailing `/v1` on the URL. The Policy Engine is only compatible with OPA's v1 API.*

If you only want to perform a certain type of validation, you can add the corresponding configuration to the following files instead:

| Feature                 | File                                          |
|-------------------------|-----------------------------------------------|
| Save time Validation     | `.hal/default/profiles/front50-local.yml`     |
| Runtime Validation      | `.hal/default/profiles/clouddriver-local.yml` |

You must also connect Spinnaker to an OPA server. This can be in a separate Kubernetes cluster or an in-cluster OPA server (such as one set up with the instructions below). For in-cluster OPA servers, Spinnaker can access OPA via the Kubernetes service DNS name. For example, add the following configuration to `spinnaker-local.yml` to allow Spinnaker to connect to an OPA server at `http://opa.opa:8181`:

```yaml
armory:
  opa:
    enabled: true
    url: http://opa.opa:8181/v1
```

After you enable the Policy Engine, deploy your changes:

```bash
hal deploy apply
```

Once Spinnaker finishes redeploying, Policy Engine can evaluate pipelines based on your policies.

## Troubleshooting

**Debugging runtime validation**

You can make debugging issues with runtime validation for your pipelines easier by adjusting the logging level to `DEBUG`. Add the following snippet to `hal/default/profiles/spinnaker-local.yml`:

```
logging:
  level:
    com.netflix.spinnaker.clouddriver.kubernetes.OpaDeployDescriptionValidator: DEBUG
    io.armory.spinnaker.front50.validator.validator.OpenPolicyAgentValidator: INFO
```

Once the logging level is set to `DEBUG`, you can start seeing information similar to the following in the logs:

```
2020-03-03 21:42:05.131 DEBUG 1 --- [.0-7002-exec-10] c.n.s.c.k.OpaDeployDescriptionValidator  : Passing {"input":{"deploy":{"credentials":"EKS-WEST","manifest":null,"manifests":[{"metadata":{"labels":{"app":"nginx"},"name":"policyapp","namespace":"dev"},"apiVersion":"apps/v1","kind":"Deployment","spec":{"replicas":1,"selector":{"matchLabels":{"app":"nginx"}},"template":{"metadata":{"labels":{"app":"nginx"}},"spec":{"containers":[{"image":"away168/nginx:latest","name":"nginx","ports":[{"containerPort":80}]}]}}}},{"metadata":{"name":"policyapp-service","namespace":"dev"},"apiVersion":"v1","kind":"Service","spec":{"ports":[{"port":80,"protocol":"TCP","targetPort":80}],"selector":{"app":"nginx"},"type":"LoadBalancer"}}],"moniker":{"app":"policyapp","cluster":null,"detail":null,"stack":null,"sequence":null},"requiredArtifacts":[],"optionalArtifacts":[],"versioned":null,"source":"text","manifestArtifact":null,"namespaceOverride":null,"enableTraffic":true,"services":null,"strategy":null,"events":[],"account":"EKS-WEST"}}} to OPA
```

From this information, you can extract the exact JSON being enforced. You can use it to help you understand how to build policies.

Note: The following ConfigMap is missing some annotations that Spinnaker adds later.

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  annotations:
    artifact.spinnaker.io/location: dev
    artifact.spinnaker.io/name: policyapp
    artifact.spinnaker.io/type: kubernetes/deployment
    deployment.kubernetes.io/revision: '4'
    kubectl.kubernetes.io/last-applied-configuration: >
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{"artifact.spinnaker.io/location":"dev","artifact.spinnaker.io/name":"policyapp","artifact.spinnaker.io/type":"kubernetes/deployment","moniker.spinnaker.io/application":"policyapp","moniker.spinnaker.io/cluster":"deployment
      policyapp"},"labels":{"app":"nginx","app.kubernetes.io/managed-by":"spinnaker","app.kubernetes.io/name":"policyapp"},"name":"policyapp","namespace":"dev"},"spec":{"replicas":1,"selector":{"matchLabels":{"app":"nginx"}},"template":{"metadata":{"annotations":{"artifact.spinnaker.io/location":"dev","artifact.spinnaker.io/name":"policyapp","artifact.spinnaker.io/type":"kubernetes/deployment","moniker.spinnaker.io/application":"policyapp","moniker.spinnaker.io/cluster":"deployment
      policyapp"},"labels":{"app":"nginx","app.kubernetes.io/managed-by":"spinnaker","app.kubernetes.io/name":"policyapp"}},"spec":{"containers":[{"image":"away168/nginx:latest","name":"nginx","ports":[{"containerPort":80}]}]}}}}
    moniker.spinnaker.io/application: policyapp
    moniker.spinnaker.io/cluster: deployment policyapp
  creationTimestamp: '2020-03-03T18:40:23Z'
  generation: 4
  labels:
    app: nginx
    app.kubernetes.io/managed-by: spinnaker
    app.kubernetes.io/name: policyapp
  name: policyapp
  namespace: dev
  resourceVersion: '947262'
  selfLink: /apis/extensions/v1beta1/namespaces/dev/deployments/policyapp
  uid: 711a1e92-5d7e-11ea-9dde-067e9dc02856
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      annotations:
        artifact.spinnaker.io/location: dev
        artifact.spinnaker.io/name: policyapp
        artifact.spinnaker.io/type: kubernetes/deployment
        moniker.spinnaker.io/application: policyapp
        moniker.spinnaker.io/cluster: deployment policyapp
      labels:
        app: nginx
        app.kubernetes.io/managed-by: spinnaker
        app.kubernetes.io/name: policyapp
    spec:
      containers:
        - image: 'away168/nginx:latest'
          imagePullPolicy: Always
          name: nginx
          ports:
            - containerPort: 80
              protocol: TCP
          resources: {}
          terminationMessagePath: /dev/termination-log
          terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
    - lastTransitionTime: '2020-03-03T20:46:21Z'
      lastUpdateTime: '2020-03-03T20:46:21Z'
      message: Deployment has minimum availability.
      reason: MinimumReplicasAvailable
      status: 'True'
      type: Available
    - lastTransitionTime: '2020-03-03T20:42:46Z'
      lastUpdateTime: '2020-03-03T21:26:43Z'
      message: ReplicaSet "policyapp-597c756868" has successfully progressed.
      reason: NewReplicaSetAvailable
      status: 'True'
      type: Progressing
  observedGeneration: 4
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1
  ```