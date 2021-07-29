---
title: Get Started with Armory Deployments for Spinnaker 
description: Use this self-service guide to prepare your environment and then install the Armory Deployments Plugin, which allows you to deploy apps incrementally based on criteria you set.
exclude_search: true
toc_hide: true
---

{{< include "early-access-feature.html" >}}

## Overview

The Armory Deployments Plugin provides a single stage solution (called Kubernetes Progressive in the UI)for deploying an app using a Canary Deployment Strategy to your Kubernetes clusters. For example, you can configure a new deployment to serve 10% of the traffic initially and then increment from there. The deployment can only progress if the criteria you set are met, either a wait time or manually approval. These criteria give you a chance to evaluate the state of the deployment to make sure things are working as intended.

This guide walks you through the following:

- Registering your Armory Enterprise environment
- Installing the Armory Agent, which is required for Armory Deployments
- Connecting to Armory Cloud services
- Installing the Armory Deployments plugin
- Deploying a "hello world" manifest

## Requirements

Verify that you meet or can meet these requirements before getting started.

### Armory Enterprise (Spinnaker)

Your Armory Enterprise (or OSS Spinnaker) instance must meet the following requirements:

- Version 2.24 or later (or OSS 1.24 or later)
- The Armory Agent Plugin installed in your instance. The Agent has requirements of its own, which have been included on this page as well as instructions for a proof-of-concept installation of the Agent. For more information about the Agent, see [Armory Agent for Kubernetes Quickstart Installation]({{< ref "armory-agent" >}}).
- A supported Operator or Halyard version. For information about what version of Halyard or Operator is supported, see the [release notes]({{< ref "rn-armory-spinnaker" >}}) for your Armory Enterprise version.

### Networking

Ensure that your Armory Enterprise (or Spinnaker) instance and Armory Agents have the following networking access:

| Protocol                    | DNS                                                                    | Port | Used By           | Notes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|-----------------------------|------------------------------------------------------------------------|------|-------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTPS                       | api.cloud.armory.io                      | 443  | Spinnaker         | **Armory Cloud REST API**<br><br>Used fetch information from the Kubernetes cache                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| TLS enabled gRPC over HTTP2 | agents.cloud.armory.io                | 443  | Spinnaker, Agents | **Armory Cloud Agent-Hub**<br><br>Used to connect agents to the Agent Hub through encrypted long-lived gRPC HTTP2 connections. The connections are used for bi-directional communication between Armory Enterprise or Armory Cloud Services and any target Kubernetes clusters.<br><br>This is needed so that Armory Cloud Services can interact with a your private Kubernetes APIs, orchestrate deployments, and cache data for Armory Enterprise without direct network access to your Kubernetes APIs.<br><br>Agents send data about deployments, replica-sets, and related data to Armory Cloud's Agent Cache to power infrastructure management experiences, such as the Armory Deployments Plugin. |
| HTTPS                       | auth.cloud.armory.io                    | 443  | Spinnaker, Agents | **Armory’s OIDC authorization server**<br><br>Used to exchange the client ID and secret for a Java Web Token () to verify identity.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| TLS enabled gRPC over HTTP2 | grpc.deploy.cloud.armory.io | 443  | Spinnaker         | **Armory Cloud Deploy Engine gRPC Service**<br><br>Used to orchestrate deployments in target Kubernetes clusters through agents using gRPC.<br><br>Armory Enterprise calls this during the Armory Kubernetes Progressive Delivery Stage.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| HTTPS                       | github.com                                        | 443  | Spinnaker         | **Github**<br><br>Used to download official Armory plugins at startup time.


### Database 

You must be using either MySQL or PostgreSQL for your Clouddriver service as well as Redis because the Armory Agent requires both. For information about MySQL, see [Configure Clouddriver to use a SQL Database]({{< ref "clouddriver-sql-configure.md" >}}).

### Deployment target

You must have at least one Kubernetes cluster to use as the deployment target for your app. The target cluster must also have the following installed:

- Armory Agent service
- Argo Rollout 1.x or later. For information about how to install Argo Rollout, see [Controller Installation](https://argoproj.github.io/argo-rollouts/installation/#controller-installation) in the Argo documentation.


## Register your Armory Enterprise environment

Register your Armory Enterprise environment so that it can communicate with Armory services. Each environment needs to get registered if you, for example, have production and development environments.

1. Get your registration link from Armory
2. Complete the [deployment registration]({{< ref "deployment-reg" >}}) for your Armory Enterprise environment.

## Create client credentials for your Agents

1. Log in to the Armory Cloud Console: https://console.cloud.armory.io/.
2. If you have more than one registered environment, ensure the proper env is selected in the user context menu:

{{< figure src="/images/deploy-engine/cloud-env-context.png" alt="The upper right section of the window shows what environment you are currently in." >}}

3. In the left navigation menu, select **Access Management > Client Credentials** under the  section.
4. In the upper right corner, select **New Credential**.
5. Create a credential for the Armory Agent. Use a descriptive name for the credential, such as `Armory K8s Agent`
6. Set the permission scope to the following:

  - `write:infra:data`
  - `get:infra:op`

  > This is the minimum set of required permissions for the Armory Agent.
7. Note both the `Client ID` and `Client Secret`. You need these values when configuring the Agent.

## Install Armory Agent for Kubernetes Service

The Armory Agent is a lightweight, scalable service that monitors your Kubernetes infrastructure and streams changes back to the Clouddriver service. Install and configure the Agent. As part of the configuration process, you enable communication with Armory Cloud, which is required for the Armory Deployments plugin.

This section describes how to install the Agent Service in the Kubernetes cluster where you want to deploy applications to. The service is one half of the Agent. A subsequent section describes how to install the other half, the [Armory Agent Plugin for Clouddriver](#install-armory-agent-plugin-for-clouddriver).

> These instructions are meant for a proof-of-concept installation of the Armory Agent. For information about using the Agent for production workloads (including features such as mTLS), see the Armory Agent]({{< ref "armory-agent" >}}) documentation.


### Create a namespace

In the target cluster where you want to deploy apps, create a namespace for the agent:

```bash
kubectl create ns spin-agent
```

> The examples on this page assume you are using a namespace called spin-agent for the Agent. Replace the namespace in the examples if you are using a different namespace.

### Configure permissions

Create a `ClusterRole`, `ServiceAccount`, and `ClusterRoleBinding` for the Agent by applying the following manifest to your `spin-agent` namespace:

<details>
  <summary>Show me the manifest</summary>

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

### Configure the Agent

Use a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) to configure the Agent. In the `data` block, define `kubesvc.yml` and add your Kubernetes account configuration for your cluster. This YAML file is where you provide the Client ID and Secret that you received when you [create client credentials for your agents](#create-client-credentials-for-your-agents).

<details><summary>Show me the ConfigMap</summary>

For information about adding accounts, see  the [kubernetes.accounts[] options in the Agent Options documentation]({{< ref "agent-options#options" >}}).

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: kubesvc-config
  namespace: spin-agent
data:
  kubesvc.yaml: |
    hub:
      connection:
        grpc: agents.cloud.armory.io:443
      auth:
        armory:
          clientId: <Armory K8s Agent ClientId>
          secret: <Armory K8s Agent Secret>
          tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
          audience: https://api.cloud.armory.io
          verify: true
    kubernetes:
     accounts: [] 
```

</details>


### Deploy the Agent

Apply the following Agent deployment manifest to the namespace you created on the target cluster for the Agent (`spin-agent` for the examples on this page):

<details><summary>Show me the manifest</summary>

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

</details>


### Verify the Agent deployment

In the target deployment cluster, examine the Agent logs.

You should see messages similar to the following that show your client ID and your account getting registered in the Armory Cloud Hub:

```
time="2021-07-16T17:41:45Z" level=info msg="registering with uuid: f69daec0-0a32-4ded-b3ed-dc84bc0e93d0"
time="2021-07-16T17:41:45Z" level=info msg="registering with 1 servers"
time="2021-07-16T17:48:30Z" level=info msg="handling registration 01FAR6Y7EDJW1B5G8JQ109D53G"
time="2021-07-16T17:48:30Z" level=info msg="starting agentCreator provider:\"kubernetes\" name:\"account-test\""
```

## Enable communication between Armory Enterprise services and Armory Cloud

This step establishes communication between all Armory Enterprise services, plugins, and Armory Cloud.

{{< tabs name="DeploymentStrategy" >}}
{{% tab name="Operator" %}}

> Note that the following instructions assume that you are using Kustomize to manage your Operator config files.

If you completed all the steps described in [Deployment Registration]({{< ref "deployment-reg.md" >}}), you can skip this section.

In your Kustomize patches directory, create a file named **patch-cloud-config.yml**. This manifest includes the Client ID and Secret from when you [registered your environment](#register-your-armory-enterprise-instance).

<details>
<summary>Show me the manifest</summary>

```yaml
#patch-cloud-config.yml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      # Global Settings
      spinnaker:
        armory.cloud:
          enabled: true
          iam:
            tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
            clientId: <clientId>
            clientSecret: <clientSecret>
          api:
            baseUrl: https://api.cloud.armory.io
          hub:
            baseUrl: https://api.cloud.armory.io/agents
            grpc:
              host: agents.cloud.armory.io
              port: 443
              tls:
                insecureSkipVerify: true
          deployEngineGrpc:
            host: grpc.deploy.cloud.armory.io
            port: 443
```

</details>

After you create the manifest, include it under the `patchesStrategicMerge` section of your `kustomization` file:

```yaml
bases:
  - spinnaker.yml
patchesStrategicMerge:
  - patches/patch-cloud-config.yml
```  

{{% /tab %}}
{{% tab name="Halyard" %}}

If `spinnaker-local.yml` does not exist in your `.hal/default/profiles/` directory, create it. Then, add the following configuration to it:

```yaml
#spinnaker-local.yml
armory.cloud:
  enabled: true
  iam:
    tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
    clientId: <clientId>
    clientSecret:<clientSecret>
  api:
    baseUrl: https://api.cloud.armory.io
  hub:
    baseUrl: https://api.cloud.armory.io/agents
    grpc:
      host: agents.cloud.armory.io
      port: 443
  deployEngineGrpc:
    host: grpc.deploy.cloud.armory.io
    port: 443
```
{{% /tab %}}
{{< /tabs >}}

## Install Armory Agent Plugin for Clouddriver

The Agent Plugin for Clouddriver is the other half of the Armory Agent. You install it within your Armory Enterprise cluster and it runs alongside the Clouddriver service, facilitating communication between Armory Enterprise and the Kubernetes cluster that is your deployment target.

{{< tabs name="KubesvcPlugin" >}}
{{% tab name="Operator" %}}

> Note that the following instructions assume that you are using Kustomize to manage your Operator config files.

Create a new `armory-agent` directory in your Kustomize patches directory. Add the following `agent-config.yaml` manifest to the `armory-agent` directory:

- Change the value for `name` if your Armory Enterprise service is called something other than `spinnaker`.
- Update the `kubesvc-plugin` value to the Armory Agent Plugin Version that is compatible with your Armory Enterprise version. For more information, see the [Agent compatibility matrix]({{< ref "armory-agent-quick#compatibility-matrix" >}}).

<details><summary>Show me the Kustomize file</summary>

```yaml
#agent-config.yml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        kubesvc:
          cluster: redis
        spinnaker:
          extensibility:
            pluginsRootPath: /opt/clouddriver/lib/plugins
            plugins:
              Armory.Kubesvc:
                enabled: true
                extensions:
                  armory.kubesvc:
                    enabled: true
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
                    image: docker.io/armory/kubesvc-plugin:<version>
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

</details>

Then, include the file under the `patchesStrategicMerge` section of your `kustomization` file:

```yaml
bases:
  - spinnaker.yml
patchesStrategicMerge:
  - armory-agent/agent-config.yml
```      

{{% /tab %}}
{{% tab name="Halyard" %}}

In the `.hal/default/profiles/` directory, create a file named `clouddriver-local.yml` if one does not already exist. Add the following configuration to it:

```yaml
kubesvc:
  cluster: redis
spinnaker:
  extensibility:
    pluginsRootPath: /opt/clouddriver/lib/plugins
    plugins:
      Armory.Kubesvc:
        enabled: true
        extensions:
          armory.kubesvc:
            enabled: true
redis:
  enabled: true
```

In the `.hal/default/service-settings` directory, create a file named `clouddriver.yml`  if one does not already exist. Add the following configuration to it:

```yaml
#clouddriver
kubernetes:
  volumes:
  - id: kubesvc-plugin-vol
    type: emptyDir
    mountPath: /opt/clouddriver/lib/plugins
```        

Add the next configuration under **deploymentEnvironment**  in your config file.

- Update the `kubesvc-plugin` value to the Armory Agent Plugin Version that is compatible with your Armory Enterprise version. See the [compatibility matrix]({{< ref "armory-agent-quick#compatibility-matrix" >}}).

```yaml
deploymentEnvironment:
  initContainers:
    spin-clouddriver:
    - name: kubesvc-plugin
      image: docker.io/armory/kubesvc-plugin:<version>
      volumeMounts:
        - mountPath: /opt/plugin/target
          name: kubesvc-plugin-vol
```
{{% /tab %}}
{{< /tabs >}}

## Install the Armory Deployment Plugin

{{< tabs name="DeploymentPlugin" >}}
{{% tab name="Operator" %}}

In your Kustomize patches directory, create a file named **patch-plugin-deployment.yml** and add the following manifest to it:

<details><summary>Show me the Kustomize file</summary>

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
                  config:
                    deployEngine:
                      baseUrl: https://deploy-engine.cloud.armory.io
                  version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
      # Global Settings
      spinnaker:
        spinnaker:
          extensibility:
            plugins:
              Armory.Deployments:
                enabled: true
                config:
                  deployEngine:
                    baseUrl: https://deploy-engine.cloud.armory.io
                version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

</details>

Then, include the file under the `patchesStrategicMerge` section of your `kustomization` file:

```yaml
bases:
  - spinnaker.yml
patchesStrategicMerge:
  - patches/patch-plugin-deployment.yml
```      

{{% /tab %}}
{{% tab name="Halyard" %}}

Add a new file named `spinnaker-local.yml` under your **profiles** directory, and add the next configuration, if you already have an `spinnaker-local.yml` just add the config to the existing file.

```yaml
#spinnaker-local.yml
spinnaker:
  extensibility:
    plugins:
      Armory.Deployments:
        enabled: true
        config:
          deployEngine:
            baseUrl: https://deploy-engine.cloud.armory.io
        version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

Add a new file named `gate-local.yml` under your **profiles** directory, and add the next configuration, if you already have an `gate-local.yml` just add the config to the existing file.

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
          config:
            deployEngine:
              baseUrl: https://deploy-engine.cloud.armory.io
          version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

{{% /tab %}}
{{< /tabs >}}

## Apply the changes to Armory Enterprise

Apply the changes to your Armory Enterprise instance after you complete the sections:
- [Enable communication between Armory Enterprise and Armory Cloud](#enable-communication-between-armory-enterprise-services-and-armory-cloud)
- [Install Armory Agent Plugin for Clouddriver](#install-armory-agent-plugin-for-clouddriver)
- [Install the Armory Deployment Plugin](#install-the-armory-deployment-plugin)

Run the following command:

{{< tabs name="ApplyChanges" >}}
{{% tab name="Operator" %}}

```bash
kubectl apply -k <path-to-kustomize-file>.yml
```

{{% /tab %}}
{{% tab name ="Halyard" %}}

```bash
hal deploy apply
```

{{% /tab %}}
{{< /tabs >}}
This applies your changes and redeploys Armory Enterprise.

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

<details><summary>Show me the manifest</summary>

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

</details>

3. In the **How to Deploy** section, configure your canary steps. You can set percentage thresholds for how widely an app should get rolled out before it either waits for a manual approval or a set amount of time.
4. Save the pipeline and trigger a manual execution.

Watch the pipeline execute the canary rollout!

## Troubleshooting

### Kubernetes agent

If you get a `Method not found: ops.Operations/GetOps` error on the Kubernetes agent similar to the following:

```
time="2021-07-21T18:55:54Z" level=error msg="error receiving from ops from server: rpc error: code = Unimplemented desc = Method not found: ops.Operations/GetOps" error="rpc error: code = Unimplemented desc = Method not found: ops.Operations/GetOps"
time="2021-07-21T18:55:54Z" level=info msg="stopping all tasks"
```

Check that you added the env `variable ARMORY_HUB` on the [Kubernetes Agent deployment manifest](#deploy-the-agent) for the target cluster:

```yaml
env:
- name: ARMORY_HUB
  value: "true"
```
