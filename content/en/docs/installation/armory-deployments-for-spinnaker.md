---
title: Get Started with Armory Deployments for Spinnaker 
description: Use this self-service guide to install the Armory Deployments for Spinnaker Plugin, which enables new Spinnaker stages that unlock the features of Armory cloud services.
exclude_search: true
---

{{< include "early-access-feature.html" >}}

## Overview

The Armory Deployments plugin for Spinnaker enables new Spinnaker stages that unlock the features of Armory Deployments cloud services.

See [Armory Deployments Architecture]({{< ref "armory-deployments/architecture" >}}) for an overview of Armory Deployments and how it fits in with Spinnaker.

This guide walks you through the following:

- Registering your Armory Enterprise environment
- Installing the Armory Agent and the Argo Rollouts Controller, which are required for Armory Deployments
- Connecting to Armory Cloud services
- Installing the Armory Deployments plugin
- Deploying a "hello world" manifest

## Requirements

Verify that you meet or can meet these requirements before getting started.

### Armory Enterprise (Spinnaker)

Your Armory Enterprise (or OSS Spinnaker) instance must meet the following requirements:

- Version 2.24 or later (or OSS 1.24 or later)
- A supported Operator or Halyard version. For information about what version of Halyard or Operator is supported, see the [release notes]({{< ref "rn-armory-spinnaker" >}}) for your Armory Enterprise version.

### Networking

Ensure that your Armory Enterprise (or Spinnaker) instance and Armory Agents have the following networking access:

| Protocol                    | DNS                                                                    | Port | Used By           | Notes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-----------------------------|------------------------------------------------------------------------|------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTPS                       | api.cloud.armory.io                      | 443  | Spinnaker         | **Armory Cloud REST API**<br><br>Used fetch information from the Kubernetes cache                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| TLS enabled gRPC over HTTP2 | agents.cloud.armory.io                | 443  | Spinnaker, Agents | **Armory Cloud Agent-Hub**<br><br>Used to connect agents to the Agent Hub through encrypted long-lived gRPC HTTP2 connections. The connections are used for bi-directional communication between Armory Enterprise or Armory Cloud Services and any target Kubernetes clusters.<br><br>This is needed so that Armory Cloud Services can interact with a your private Kubernetes APIs, orchestrate deployments, and cache data for Armory Enterprise without direct network access to your Kubernetes APIs.<br><br>Agents send data about deployments, replica-sets, and related data to Armory Cloud's Agent Cache to power infrastructure management experiences, such as the Armory Deployments Plugin. |
| HTTPS                       | auth.cloud.armory.io                    | 443  | Spinnaker, Agents | **Armory’s OIDC authorization server**<br><br>Used to exchange the client ID and secret for a Java Web Token () to verify identity.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| HTTPS                       | github.com                                        | 443  | Spinnaker         | **Github**<br><br>Used to download official Armory plugins at startup time.

### Target Kubernetes cluster

Armory Deployments is a separate product from Armory Enterprise (Spinnaker). It does not use Clouddriver to source its accounts. Instead, it uses the Armory Agents that are deployed in your target Kubernetes clusters. The Armory Agent is a lightweight, scalable service that enables Armory Deployments to interact with your infrastructure. You must install the Armory Agent for Kubernetes in every target cluster. 

Additionally, Armory Deployments uses the Argo Rollouts Controller to manage progressive deployments to your infrastructure.

Installing both of these requirements is discussed in [Enable Armory Deployments in target Kubernetes clusters](#enable-armory-deployments-in-target-kubernetes-clusters).

## Register your Armory Enterprise environment

Register your Armory Enterprise environment so that it can communicate with Armory services. Each environment needs to get registered if you, for example, have production and development environments.

1. Get your registration link from Armory.
2. Complete the [deployment registration]({{< ref "deployment-reg" >}}) for your Armory Enterprise environment.

## Create client credentials for your Agents

1. Log in to the Armory Cloud Console: https://console.cloud.armory.io/.
2. If you have more than one registered environment, ensure the proper env is selected in the user context menu:

   {{< figure src="/images/deploy-engine/cloud-env-context.png" alt="The upper right section of the window shows what environment you are currently in." >}}

1. In the left navigation menu, select **Access Management > Client Credentials**.
2. In the upper right corner, select **New Credential**.
3. Create a credential for the Armory Agent. Use a descriptive name for the credential, such as `Armory K8s Agent`
4. Set the permission scope to the following:

- `write:infra:data`
- `get:infra:op`

> This is the minimum set of required permissions for the Armory Agent.

5. Note both the `Client ID` and `Client Secret`. You need these values when configuring the Agent.

## Enable Armory Deployments in target Kubernetes clusters

This section walks you through installing the Armory Agent for Kubernetes and the Argo Rollouts Controller, which are both required for Armory Deployments.

### Install the Argo Rollout Controller

Armory Deployments requires that you install the Argo Rollouts controller 1.x or later, in each target Kubernetes cluster along with the Armory Agent.

For information about how to install Argo Rollout, see [Controller Installation](https://argoproj.github.io/argo-rollouts/installation/#controller-installation) in the Argo documentation.

### Install the Agent

A quick note on secrets you can configure secrets as outlined in the [Secrets Guide]({{< ref "secrets" >}})

Set the client_secret value to be a secret token, instead of the plain text value.

{{< tabs name="AgentInstall" >}}
{{% tab name="Helm (recommended)" %}}

Installing the Armory Kubernetes agent with helm is simple.

```bash
# Add the armory helm repo
helm repo add armory-charts https://armory.jfrog.io/artifactory/charts
# Refresh your repo cache
helm repo update
# Install the agent, omit --create-namespace if installing into existing namespace
# the accountName opt, is what this cluster will show up as in the Spinnaker Stage and Armory Cloud APIs
helm install armory-agent \
    --set accountName=my-k8s-cluster \
    --set clientId=${CLIENT_ID_FOR_AGENT_FROM_ABOVE} \
    --set clientSecret=${CLIENT_SECRET_FOR_AGENT_FROM_ABOVE} \
    --namespace armory-agent \
    --create-namespace \
    armory-charts/agent-k8s
```

{{% /tab %}}
{{% tab name="Manual" %}}

#### Create a namespace

In the target cluster where you want to deploy apps, create a namespace for the Agent:

```bash
kubectl create ns armory-agent
```

> The examples on this page assume you are using a namespace called armory-agent for the Agent. Replace the namespace in the examples if you are using a different namespace.

#### Configure permissions

Create a `ClusterRole`, `ServiceAccount`, and `ClusterRoleBinding` for the Agent by applying the following manifest to your `armory-agent` namespace:

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
  namespace: armory-agent
  name: spin-sa
---
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: spin-cluster-role-binding
subjects:
  - kind: ServiceAccount
    name: spin-sa
    namespace: armory-agent
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: spin-cluster-role
```

#### Configure the Agent

Use a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) to configure the Agent. In the `data` block, define `kubesvc.yml` and add your Kubernetes account configuration for your cluster. This YAML file is where you provide the Client ID and Secret that you received when you [create client credentials for your agents](#create-client-credentials-for-your-agents).

For information about adding accounts, see  the [kubernetes.accounts[] options in the Agent Options documentation]({{< ref "agent-options#options" >}}).

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubesvc-config
  namespace: armory-agent
data:
  kubesvc.yaml: |
    hub:
      connection:
        grpc: agents.cloud.armory.io:443
      auth:
        armory:
          clientId: <Armory K8s Agent ClientId for Agent from earlier>
          secret: <Armory K8s Agent Secret for Agent from earlier>
          tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
          audience: https://api.cloud.armory.io
          verify: true
    kubernetes:
     accounts: [] 
```

#### Deploy the Agent

Apply the following Agent deployment manifest to the namespace you created on the target cluster for the Agent (`armory-agent` for the examples on this page):

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
      - image: armory/agent-kubernetes:0.1.3
        imagePullPolicy: IfNotPresent
        name: kubesvc
        env:
        - name: ARMORY_HUB
          value: "true"
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

{{% /tab %}}
{{< /tabs >}}

### Verify the Agent deployment

In the target deployment cluster, examine the Agent logs.

You should see messages similar to the following that show your client ID and your account getting registered in the Armory Cloud Hub:

```
time="2021-07-16T17:41:45Z" level=info msg="registering with uuid: f69daec0-0a32-4ded-b3ed-dc84bc0e93d0"
time="2021-07-16T17:41:45Z" level=info msg="registering with 1 servers"
time="2021-07-16T17:48:30Z" level=info msg="handling registration 01FAR6Y7EDJW1B5G8JQ109D53G"
time="2021-07-16T17:48:30Z" level=info msg="starting agentCreator provider:\"kubernetes\" name:\"account-test\""
```

## Install the Armory Deployment Plugin

A quick note on secrets you can configure secrets as outlined in the [Secrets Guide]({{< ref "secrets" >}})

Set the client_secret value to be a secret token, instead of the plain text value.

{{< tabs name="DeploymentPlugin" >}}
{{% tab name="Operator" %}}

In your Kustomize patches directory, create a file named **patch-plugin-deployment.yml** and add the following manifest to it:

```yaml
#patch-plugin-deployment.yml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
  namespace: <namespace>
spec:
  spinnakerConfig:
    profiles:
      gate:
        spinnaker:
          extensibility:
            # This snippet is necessary so that Gate can serve your plugin code to Deck
            deck-proxy:
              enabled: true
              plugins:
                Armory.Deployments:
                  enabled: true
                  version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
      # Global Settings
      spinnaker:
        armory.cloud:
          enabled: true
          iam:
            clientId: <clientId for Spinnaker from earlier>
            clientSecret: <clientSecret for Spinnaker from earlier>
          api:
            baseUrl: https://api.cloud.armory.io
        spinnaker:
          extensibility:
            plugins:
              Armory.Deployments:
                enabled: true
                version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```


Then, include the file under the `patchesStrategicMerge` section of your `kustomization` file:

```yaml
bases:
  - spinnaker.yml
patchesStrategicMerge:
  - patches/patch-plugin-deployment.yml
```      

Apply the changes to your Armory Enterprise instance.

```bash
kubectl apply -k <path-to-kustomize-file>.yml
```

{{% /tab %}}
{{% tab name="Halyard" %}}

In the `/.hal/default/profiles` directory, add the following configuration to `spinnaker-local.yml`. If the file does not exist, create it and add the configuration.

```yaml
#spinnaker-local.yml
armory.cloud:
  enabled: true
  iam:
    clientId: <clientId for Spinnaker from earlier>
    clientSecret: <clientSecret for Spinnaker from earlier>
  api:
    baseUrl: https://api.cloud.armory.io
spinnaker:
  extensibility:
    plugins:
      Armory.Deployments:
        enabled: true
        version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

In the `/.hal/default/profiles` directory, add the following configuration to `gate-local.yml`. If the file does not exist, create it and add the configuration.

```yaml
#gate-local.yml
spinnaker:
  extensibility:
    # This snippet is necessary so that Gate can serve your plugin code to Deck
    deck-proxy:
      enabled: true
      plugins:
        Armory.Deployments:
          enabled: true
          version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

Apply the changes to your Armory Enterprise instance.

```bash
hal deploy apply
```

{{% /tab %}}
{{< /tabs >}}

## Verify that the plugin is configured

1. Check that all the services are up and running:

   ```bash
   kubectl -n <Armory-Enterprise-namespace> get pods
   ```

2. Navigate to the UI.
3. In a new or existing application, create a new pipeline.
4. In this pipeline, select **Add stage** and search for "Kubernetes Progressive." The stage should appear if the plugin is properly configured.

   {{< figure src="/images/deploy-engine/deploy-engine-stage-UI.jpg" alt="The Kubernetes Progressive stage appears in the Type dropdown when you search for it." >}}

1. In the **Basic Settings** section, verify that you can see the target deployment account in the **Account** dropdown.

   {{< figure src="/images/deploy-engine/deploy-engine-accounts.png" alt="If the plugin is configured properly, you should see the target deployment account in the Account dropdown." >}}

## Deploy the hello-world manifest

You can try out the **Kubernetes Progressive** stage using the `hello-world` sample manifest.

1. Create a new pipeline with a single **Kubernetes Progressive** stage.
2. In the **What to Deploy** section, paste the following in the manifest text block:


   ```yaml
   # A simple nginx deployment with an init container that causes deployment to take longer than usual
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: demo-app
   spec:
     replicas: 10
     selector:
       matchLabels:
         app: demo-app
     template:
       metadata:
         labels:
           app: demo-app
       spec:
         containers:
           - env:
               - name: TEST_ID
                 value: __TEST_ID_VALUE__
             image: 'nginx:1.14.1'
             name: demo-app
             ports:
               - containerPort: 80
                 name: http
                 protocol: TCP
         initContainers:
           - command:
               - sh
               - '-c'
               - sleep 10
             image: 'busybox:stable'
             name: sleep
   ```


1. In the **How to Deploy** section, configure your canary steps. You can set percentage thresholds for how widely an app should get rolled out before it either waits for a manual approval or a set amount of time.
2. Save the pipeline and trigger a manual execution.

Watch the pipeline execute the canary rollout!
