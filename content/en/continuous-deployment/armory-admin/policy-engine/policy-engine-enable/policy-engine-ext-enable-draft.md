---
title: Deprecated - Enable Policy Engine Extension in Armory Enterprise
linkTitle: Deprecated - Enable Policy Engine Extension
description: "This feature is deprecated. Use the Policy Engine Plugin instead."
weight: 10
draft: true
---
![Proprietary](/images/proprietary.svg)

{{< include "deprecations/pe-ext.html" >}}


If you are enabling the Policy Engine for the first time, Armory recommends using the [Policy Engine Plugin]({{< ref "policy-engine-plug-enable.md" >}}) instead. The plugin has additional features not available in the extension. For information about migrating to the plugin, see [Migrating to the Policy Engine Plugin]({{< ref "policy-engine-enable#migrating-to-the-policy-engine-plugin" >}}).

## Enabling the Policy Engine

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

## Troubleshooting

**Debugging runtime validation**

You can make debugging issues with runtime validation for your pipelines easier by adjusting the logging level to `DEBUG`. Add the following snippet to `hal/default/profiles/spinnaker-local.yml`:

```yaml
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

```yaml
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
