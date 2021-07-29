---
title: Enable the Policy Engine for Armory Enterprise
linkTitle: Enable the Policy Engine
description: >
  Enable the Policy Engine to enforce policies on your Armory Enterprise instance. This page includes informatino about how to deploy and configure an OPA server, which the Policy Engine requires.
aliases:
  - /docs/plugin-guide/plugin-policy-engine/
  - /docs/armory-admin/policy-engine-enable/
---

![Proprietary](/images/proprietary.svg)

## Requirements for using the Policy Engine

Make sure you can meet the following version requirements for the Policy Engine:

* OPA versions 0.12.x or later. Specifically, the OPA v1 API must be available.
* A supported version of Armory Enterprise


## Before You Start

The Policy Engine requires an OPA server. You can either use the example on this page to deploy a server in the same Kubernetes cluster as Armory Enterprise or see the OPA documentation for information about how to [deploy an OPA server](https://www.openpolicyagent.org/docs/latest/#running-opa).

### Deploy an OPA server

The Policy Engine supports the following OPA server deployments:

* An OPA server deployed in the same Kubernetes cluster as an Armory Spinnaker deployment. The [Using ConfigMaps for OPA policies](#using-configmaps-for-opa-policies) section contains a ConfigMap you can use.
* An OPA cluster that is **not** in the same Kubernetes cluster as an Armory Spinnaker deployment . See the [OPA documentation](https://www.openpolicyagent.org/docs/latest/) for more information about installing an OPA server in a separate cluster.

#### Using ConfigMaps for OPA Policies

If you want to use ConfigMaps for OPA policies, you can use the below manifest as a starting point. This example manifest deploys an OPA server and applies the configuration for things like rolebinding and a static DNS.
When using the below example, keep the following guidelines in mind:
* The manifest does not configure any authorization requirements for the OPA server it deploys. This means that anyone can add a policy.
* The manifest deploys the OPA server to a namespace called `opa`.
* The OPA server uses the following config: `"--require-policy-label=true"`. This configures the OPA server to look for a specific label so that it does not check all configmaps for new policies. For information about how to apply the relevant label to your policy configmaps, see [Creating a policy]({{< ref "policy-engine-use#step-2-add-the-policy-to-your-opa-server" >}}).

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
          image: openpolicyagent/opa:{{< param opa-server-version >}}
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

Armory recommends using the [plugin]({{< ref "policy-engine-plug-enable.md" >}}). To migrate to the plugin from the extension, see [Migrating to the Policy Engine Plugin](#migrating-to-the-policy-engine-plugin). For information about making configuration changes to a Policy Engine Extension instance that already exists, see the [extension page]({{< ref "policy-engine-ext-enable.md" >}}).

## Migrating to the Policy Engine Plugin

To migrate to the Policy Engine Plugin from the extension, perform the following steps:

1. Turn off the Policy Engine extension. You cannot run both the extension and plugin at the same time. You must disable the extension project and then enable the plugin.
   * **Halyard**: Remove the following snippet from `.hal/default/profiles/spinnaker-local.yml`:
   ```yaml
   armory:
     opa:
       enabled: true
       url: <OPA Server URL>:<port>/v1
   ```
   * **Operator**:  Remove the `opa` blocks from the Front50 and Clouddriver sections of your `SpinnakerService` manifest:
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

   > If you redeploy Armory Enterprise and apply these changes before you enable the Policy Engine Plugin, no policies get enforced.

2. Enable the [Policy Engine Plugin]({{< ref "policy-engine-plug-enable" >}}).  If you have an existing OPA server with policies that you want to use, you can provide that OPA server in the plugin configuration. You do not need to create a new OPA server or migrate your policies. 
