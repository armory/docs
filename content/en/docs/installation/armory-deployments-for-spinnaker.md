---
title: Armory Deployments Getting Started Guide for Spinnaker Users
description: A detailed self-service process for using Armory’s EAP deployment engine via our new Spinnaker plugin.
exclude_search: true
toc_hide: true
---

## Minimum supported Spinnaker versions
Armory Deployment for Spinnaker requires one of the following:

- Armory Enterprise’s Supported Spinnaker: 2.24.+
- OSS Spinnaker 1.24.+

## Networking requirements

Ensure that your Spinnaker instance and Armory Kubernetes agents will have the following networking access:

| Protocol                    | DNS                                                                    | Port | Used By           | Notes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| --------------------------- | ---------------------------------------------------------------------- | ---- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| HTTPS                       | [api.cloud.armory.io](http://api.cloud.armory.io)                      | 443  | Spinnaker         | **Armory Cloud REST API**<br><br>Used fetch information from the Kubernetes Cache                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| TLS enabled gRPC over HTTP2 | [agents.cloud.armory.io](http://agents.cloud.armory.io)                | 443  | Spinnaker, Agents | **Armory Cloud Agent-Hub**<br><br>Used to connect agents to the agent-hub via a encrypted long lived gRPC HTTP2 connections to broker bi-directional communication between Spinnaker or Armory Cloud Services and Target Kubernetes clusters.<br><br>This allows the Armory Cloud Services to interact with a customers private kubernetes APIs and orchestrate deployments and cache data for Spinnaker with out needing direct network access to a customer Kubernetes API from Armory's Networks.<br><br>Customer installed agents send data about deployment, replica-sets, etc to Armory Clouds Agent Cache to power its infrastructure management user experiences such as the Armory Deployments Spinnaker plugin. |
| HTTPS                       | [auth.cloud.armory.io](http://auth.cloud.armory.io)                    | 443  | Spinnaker, Agents | **Armory’s OIDC authorization server**<br><br>Used to exchange client id and secret for JWT to prove customer identity                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| TLS enabled gRPC over HTTP2 | [grpc.deploy.cloud.armory.io](http://grpc.deploy.cloud.armory.io:443/) | 443  | Spinnaker         | **Armory Cloud Deploy Engine gRPC Service**<br><br>Used to orchestrate deployments in target Kubernetes Clusters through the agents via gRPC.<br><br>Spinnaker calls this during the Armory Kubernetes Progressive Delivery Stage.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| HTTPS                       | [github.com](http://github.com)                                        | 443  | Spinnaker         | **Github**<br><br>Used to download official Armory plugins at Spinnaker startup time.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |


## Before you get started confirm the following
1. You have confirmed that you meet the [minimum Spinnaker version](#minimum-supported-spinnaker-versions)
2. You use [Halyard](https://docs.armory.io/docs/installation/armory-halyard/) or [Operator](https://docs.armory.io/docs/installation/armory-operator/#what-are-kubernetes-operators-for-spinnaker) to manage your Spinnaker Installation
3. You’ve confirmed you will have the network access as defined in the [networking requirements section](#networking-requirements)
4. You have configured Clouddriver to use MySQL or PostgreSQL. See the [Configure Clouddriver to use a SQL Database](https://docs.armory.io/docs/armory-admin/clouddriver-sql-configure/) guide for instructions.
5. You have read the Armory Deployments for Spinnaker overview [Coming Soon]
6. If you are running multiple Clouddriver instances, you have a running Redis instance. The Agent uses Redis to coordinate between Clouddriver replicas.
7. You have an additional cluster to serve as your deployment target cluster.

## Register your Spinnaker instance
Register your Armory Enterprise deployment so that it can communicate with Armory services.

1. Get your registration link from Armory
2. [Follow the registration guide here](https://docs.armory.io/docs/installation/deployment-reg)

## Create Client Credentials for your Agents
1. Log into the cloud console: https://console.cloud.armory.io/
2. If you have more than one registered environment ensure the proper env is selected in the user context menu
   
![](https://paper-attachments.dropbox.com/s_E08DEB2438E1FE549FA4A46A4E24D61421AFC189C01FBDC3C6FAE177EE0DA240_1626889902900_image.png)

3. In the left navigation menu select ***Client Credentials*** under the ***Access Management*** section.
4. Click the ***New Credential*** in the upper right corner
5. For Name use `Armory K8s Agent` or anything you’d like here
6. Select the following scopes:
  - `write:infra:data`
  - `get:infra:op`
7. Take note of the `Client ID` and `Client Secret` as you will need these later when configuring the agent.

## Install Armory Agent for Kubernetes

Here we will install the agent for Kubernetes accounts and enable communication with Armory Cloud.

The [Armory Agent](https://deploy-preview-750--armory-docs.netlify.app/docs/armory-agent/) is a lightweight, scalable service that monitors your Kubernetes infrastructure and streams changes back to Spinnaker’s Clouddriver service.

### Create a namespace

In the deployment target cluster, execute `kubectl create ns spin-agent` to create a namespace for the Agent.

### Configure permissions

Create a `ClusterRole`, `ServiceAccount`, and `ClusterRoleBinding` for the Agent by applying the following manifest in your `spin-agent` namespace:

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

### Configure the agent

Configure the Agent using a [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/). Define `kubesvc.yml` in the `data` section and add your Kubernetes account configuration for your cluster:

Here you will make use of `Armory K8s Agent` creds that was created on the Create client credentials for your agents step

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
        tls:
          insecureSkipVerify: true
      auth:
        armory:
          clientId: <Armory K8s Agent ClientId>
          secret: <Armory K8s Agent Secret>
          tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
          audience: https://api.cloud.armory.io
          verify: true
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

### Deploy the agent

Apply the following Agent deployment manifest in your `spin-agent` namespace:

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

### Confirm success

Check the agent logs you should be able to see the id registration and your accounts getting register by Armory Cloud Hub

```
time="2021-07-16T17:41:45Z" level=info msg="registering with uuid: f69daec0-0a32-4ded-b3ed-dc84bc0e93d0"
time="2021-07-16T17:41:45Z" level=info msg="registering with 1 servers"
time="2021-07-16T17:48:30Z" level=info msg="handling registration 01FAR6Y7EDJW1B5G8JQ109D53G"
time="2021-07-16T17:48:30Z" level=info msg="starting agentCreator provider:\"kubernetes\" name:\"account-test\""
```

## Enable communication between Spinnaker services and Armory Cloud

On this step we will establish communication from all spinnaker services and plugins with Armory Cloud.

Create a new file in your Kustomize patches directory. Add the following **patch-cloud-config.yml** manifest.

Here you will make use of Spinnaker creds that was created on the Register your Spinnaker Instance step

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

Then include the file under the `patchesStrategicMerge` section of your `kustomization` file.

```yaml
bases:
  - spinnaker.yml
patchesStrategicMerge:
  - patches/patch-cloud-config.yml
```  


### Halyard version

Add a new file named `spinnaker-local.yml` under your **profiles** directory, and add the next configuration, if you already have an `spinnaker-local.yml` just add the config to the existing file

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
      tls:
        insecureSkipVerify: true
  deployEngineGrpc:
    host: grpc.deploy.cloud.armory.io
    port: 443
```

## Install Kubesvc Plugin into Clouddriver

Create a new `armory-agent` directory in your Kustomize patches directory. Add the following `agent-config.yaml` manifest to your new `armory-agent` directory.

- Change the value for `name` if your Armory Enterprise service is called something other than “spinnaker”.
- Update the `kubesvc-plugin` value to the Armory Agent Plugin Version that is compatible with your Armory Enterprise version. See the [compatibility matrix](https://docs.armory.io/docs/armory-agent/armory-agent-quick/#compatibility-matrix).

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

Then include the file under the `patchesStrategicMerge` section of your `kustomization` file.

```yaml
bases:
  - spinnaker.yml
patchesStrategicMerge:
  - armory-agent/agent-config.yml
```      

### Halyard version

Add a new file named `clouddriver-local.yml` under your **profiles** directory, and add the next configuration, if you already have an `clouddriver-local.yml` just add the config to the existing file.

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
```            

Add a new file named `clouddriver.yml` under your **service-settings** directory, and add the next configuration, if you already have an `clouddriver.yml` just add the config to the existing file.

```yaml
#clouddriver
kubernetes:
  volumes:
  - id: kubesvc-plugin-vol
    type: emptyDir
    mountPath: /opt/clouddriver/lib/plugins
```        

Add a the next configuration under **deploymentEnvironment**  on your config file.

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

## Install Armory Deployment plugin

Create a new file  in your Kustomize patches directory. Add the following **patch-plugin-deployment.yml** manifest

here you can check the latest version: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/

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
                  version: <latest-version>
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
                version: <latest-version>
            repositories:
              armory-deployment-plugin-releases:
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```                    

Then include the file under the `patchesStrategicMerge` section of your `kustomization` file.

```yaml
bases:
  - spinnaker.yml
patchesStrategicMerge:
  - patches/patch-plugin-deployment.yml
```      

### Halyard version

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
        version: 0.15.3
    repositories:
      armory-deployment-plugin-releases:
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```        

### Apply the manifests

After you have configured all the manifests, apply the updates.

## Test that everything works

First check that all the services are up and running.

Then check that you can see the new stage, create new pipeline → create new stage → on type field select Kubernetes Progressive

![](https://paper-attachments.dropbox.com/s_F545B87D4B405D60F3CA7E44FA79199B7C3D654B6D445EBE400240663409EB75_1626460093709_image.png)


Also verify that you can see the accounts from kubesvc on the account dropdown

![](https://paper-attachments.dropbox.com/s_F545B87D4B405D60F3CA7E44FA79199B7C3D654B6D445EBE400240663409EB75_1626460242910_image.png)

## Wrapping up
Deploy Something!

## Troubleshooting
### Kubernetes agent

if you’re getting this error `Method not found: ops.Operations/GetOps` on the Kubernetes agent.

```
time="2021-07-21T18:55:54Z" level=error msg="error receiving from ops from server: rpc error: code = Unimplemented desc = Method not found: ops.Operations/GetOps" error="rpc error: code = Unimplemented desc = Method not found: ops.Operations/GetOps"
time="2021-07-21T18:55:54Z" level=info msg="stopping all tasks"
```

check that you added the env variable ARMORY_HUB on the Kubernetes Agent deployment manifest.

```yaml
env:
- name: ARMORY_HUB
  value: "true"
```
