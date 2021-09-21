---
title: Get Started with Project Aurora for Spinnaker™ 
description: Use this self-service guide to install Project Aurora, which enables you to perform canary deployments in a single stage.
exclude_search: true
toc_hide: true
hide_summary: true
aliases:
  - /docs/installation/armory-deployments-for-spinnaker/
---

{{< include "early-access-feature.html" >}}

## Overview

Project Aurora is plugin that adds a new stage to your Armory Enterprise (Spinnaker) instance. When you use this stage to deploy an app, you can configure how to deploy the stage incrementally by setting percentage thresholds for the deployment. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This wait gives you time to assess the impact of your changes. From there, either continue the deployment to the next threshold you set or roll back the deployment.

See the [Architecture]({{< ref "borealis/architecture" >}}) page for an overview of Project Aurora and how it fits in with Spinnaker.

This guide walks you through the following:

- Registering your Armory Enterprise environment
- Installing the Remonte Network Agent (RNA) and the Argo Rollouts Controller, which are both required for Project Aurora/Borealis
- Connecting to Armory Cloud services
- Installing the Project Aurora plugin
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
| HTTPS                       | armory.jfrog.io                                        | 443  | Helm         | **Armory's Artifact Repository**<br><br>Used to download official Armory artifacts during installation, such as Helm charts. |
| HTTPS                       | api.cloud.armory.io                      | 443  | Spinnaker         | **Armory Cloud REST API**<br><br>Used fetch information from the Kubernetes cache                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| TLS enabled gRPC over HTTP2 | agents.cloud.armory.io                | 443  | Spinnaker, Agents | **Armory Cloud Agent-Hub**<br><br>Used to connect agents to the Agent Hub through encrypted long-lived gRPC HTTP2 connections. The connections are used for bi-directional communication between Armory Enterprise or Armory Cloud Services and any target Kubernetes clusters.<br><br>This is needed so that Armory Cloud Services can interact with a your private Kubernetes APIs, orchestrate deployments, and cache data for Armory Enterprise without direct network access to your Kubernetes APIs.<br><br>Agents send data about deployments, replica-sets, and related data to Armory Cloud's Agent Cache to power infrastructure management experiences, such as the Project Aurora Plugin. |
| HTTPS                       | auth.cloud.armory.io                    | 443  | Spinnaker, Agents | **Armory’s OIDC authorization server**<br><br>Used to exchange the client ID and secret for a Java Web Token () to verify identity.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| HTTPS                       | github.com                                        | 443  | Spinnaker         | **Github**<br><br>Used to download official Armory plugins at startup time. |

### Target Kubernetes cluster

Project Aurora is a separate product from Armory Enterprise (Spinnaker). It does not use Clouddriver to source its accounts. Instead, it uses Remote Network Agents (RNAs) that are deployed in your target Kubernetes clusters. An RNA is a lightweight, scalable service that enables Project Aurora to interact with your infrastructure. You must install RNAs in every target cluster. 

Additionally, Project Aurora uses the Argo Rollouts Controller to manage progressive deployments to your infrastructure.

The Helm chart described in [Enable Project Aurora in target Kubernetes clusters](#enable-aurora-in-target-kubernetes-clusters) manages the installation of both of these requirements for you.

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
3. Create a credential for the your RNAs. Use a descriptive name for the credential, such as `Armory K8s Agent`
4. Set the permission scope to the following:

- `write:infra:data`
- `get:infra:op`

> This is the minimum set of required permissions for a RNA.

5. Note both the `Client ID` and `Client Secret`. You need these values when configuring the Agent.

## Enable Aurora in target Kubernetes clusters

This section walks you through installing the Remote Network Agent (RNA) and the Argo Rollouts Controller, which are both required for Project Aurora. The Helm chart that Armory provides installs both the Armory Cloud Agent and Argo Rollouts. If your target deployment cluster already has Argo Rollouts installed, you can disable that part of the installation.

> Note: You can use encrypted secrets instead of providing plaintext values. For more information, see the [Secrets Guide]({{< ref "secrets" >}}).

```bash
# Add the Armory helm repo. This only needs to be done once.
helm repo add armory https://armory.jfrog.io/artifactory/charts

# Refresh your repo cache.
helm repo update

# The `accountName` opt is what this cluster will render as in the
# Spinnaker Stage and Armory Cloud APIs.
helm install aurora \
    --set agent-k8s.accountName=my-k8s-cluster \
    --set agent-k8s.clientId=${CLIENT_ID_FOR_AGENT_FROM_ABOVE} \
    --set agent-k8s.clientSecret=${CLIENT_SECRET_FOR_AGENT_FROM_ABOVE} \
    --namespace armory \
    # Omit --create-namespace if installing into existing namespace.
    --create-namespace \
    armory/aurora
```

If you already have Argo Rollouts configured in your environment you may disable
that part of the Helm chart by setting the `enabled` key to false as in the following example:

```shell
helm install aurora \
    # ... other config options
    --set argo-rollouts.enabled=false
    # ... other config options
```

If your Armory Enterprise (Spinnaker) environment is behind an HTTPS proxy, you need to configure HTTPS proxy settings. 

<details><summary>Learn more</summary>

To set an HTTPS proxy, use the following config:

```yaml
env[0].name=”HTTPS_PROXY”,env[0].value="<hostname>:<port>"
``` 

You can include the following snippet in your `helm install` command:

```yaml
--set env[0].name=”HTTPS_PROXY”,env[0].value="<hostname>:<port>" 
```

Alternatively, you can create a `values.yaml` file to include the parameters:

```yaml
env:
  - name: HTTPS_PROXY
    value: <hostname>:<port>
```
With the file, you can configure multiple configs in addition to the `env` config in your `helm install` command. Instead of using `--set`, include the `--values` parameter as part of the Helm install command:

```
--values=<path>/values.yaml
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
