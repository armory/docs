---
title: "Armory Agent Service Installation Using a Helm Chart"
linkTitle: "Install Service - Helm"
description: >
  Use a Helm chart to install the Armory Agent service in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

## {{% heading "prereq" %}}

- You have [installed the Clouddriver plugin]({{< ref "install-agent-plugin" >}}).
- You have installed Helm v3.6.3+

## Chart overview

- Enables you to easily deploy the Agent service with default configuration using a single command
- Enables you to customize the service settings by passing in a custom file

## Prepare your Kubernetes cluster

On the Kubernetes cluster where you want to install the Agent Service, perform the following steps:

1. Add the Armory charts repo:

   ```bash
   helm repo add armory-charts http://armory.jfrog.io/artifactory/charts
   ```

   If you have previously added the chart repo, update it with the following commands:

   ```bash
   helm repo update
   helm upgrade armory-agent armory-charts/agent-k8s-full
   ```

1. Create a namespace in the Kubernetes cluster where you are installing the Agent Service. In Agent mode, this is the same cluster as the deployment target for your app.

   ```bash
   kubectl create namespace <agent-namespace>
   ```

## Decide if you want to connect to Armory Cloud services

Armory Cloud services is required for some features to function and affects how you configure the Agent service installation.

Connecting to Armory Cloud services is enabled by default. If you want to connect to Armory Cloud services, you must include the following parameters with the values that Armory provided when you run the `helm` command to install the Agent service:

- `--set hub.auth.armory.clientId=<client ID>`
- `--set hub.auth.armory.secret=<client secret>`

Agent uses these parameters to authenticate to Armory Cloud services.

If you do not want to connect to Armory Cloud services, you must include a gRPC URL when you run the `helm` command to install the Agent service:

- `--set config.clouddriver.grpc=localhost:9090`

This parameter controls whether or not Agent attempts to connect to Armory Cloud services. It is required if you do not have a client ID and client secret and do not want to use Armory Cloud services.

## Install using the Helm chart

<details><summary><strong>Install with default configs in Agent mode</strong></summary>

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=<agent-namespace> # Namespace where you want to install the Agent.
```

Depending on your environment and usage, include one or more of the following parameters:

```bash
# Disable the connection to Armory Cloud
--set config.clouddriver.grpc=localhost:9090

# Authenticate to Armory Cloud
--set hub.auth.armory.clientId=<client ID>
--set hub.auth.armory.secret=<client secret>

# Custom config options for Kubernetes
--set kubernetes=<kubernetes-options>

# If TLS is disabled in your environment
--set insecure=true

# If you are pulling from a private registry
--set image.imagePullSecrets=<secret>    

# Proxy settings
# Set this if your Armory Enterprise instance is behind a HTTP proxy.
--set env[0].name=”HTTP_PROXY”,env[0].value="<hostname>:<port>"

# Set this if your Armory Enterprise instance is behind a HTTPS proxy.
--set env[0].name=”HTTPS_PROXY”,env[0].value="<hostname>:<port>"

# No proxy
--set env[0].name=”NO_PROXY”,env[0].value="localhost,127.0.0.1,*.spinnaker"
```

The `env` parameters are optional and only need to be used if Armory Enterprise is behind a HTTP(S) proxy. If you need to set more than one of the `env` parameters, you must increment the index value for the parameters. For example: `env[0].name="HTTP_PROXY`, `env[1].name="HTTPS_PROXY"`, and `env[2].name="NO_PROXY"`.

Alternatively, you can create a `values.yaml` file to include the parameters:

```yaml
env:
 - name: HTTP_PROXY
   value: <hostname>:<port>
 - name: HTTPS_PROXY
   value: <hostname>:<port>
 - name: NO_PROXY
   value: localhost,127.0.0.1,*.spinnaker
```
With the file, you can avoid setting individual `env` parameters in the `helm install` command. Instead include the `--values` parameter as part of the Helm install command.

For information about additional options, see the [Agent config options]({{< ref "agent-options#configuration-options" >}}).

<details><summary>Show me an example</summary>

The following examples use the `imagePullSecrets` and `insecure` parameters, which may or may not be needed depending on your environment.

This example installs Agent service without a connection to Armory Cloud:

```bash
helm install armory-agent --set imagePullSecrets=regcred,grpcUrl=spin-clouddriver-grpc:9091,insecure=true,cloudEnabled=false --namespace dev armory-charts/agent-k8s-full
```

This example installs Agent service with a connection to Armory Cloud:

```bash
helm install armory-agent --set imagePullSecrets=regcred,grpcUrl=agents.staging.cloud.armory.io:443,audience=https://api.cloud.armory.io,tokenIssuerUrl=https://auth.cloud.armory.io/oauth/token,clientId=************,clientSecret=************ --namespace dev armory-charts/agent-k8s-full
```


</details>

<details><summary><strong>Install with default configs in Infrastructure mode</strong></summary>

You need to create a kubeconfig file that grants access to the deployment target cluster. For example, run the following command if you use Amazon EKS: `aws eks update-kubeconfig --name <target-cluster> `.

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=<agent-namespace> # Namespace where you want to install the Agent.
```

Depending on your environment and usage, set one or more of the following parameters:

```bash
# Disable the connection to Armory Cloud
--set grpcUrl=localhost:9090

# Authenticate to Armory Cloud
--set clientId=<your-clientId>
--set clientSecret=<your-Armory-Cloud-secret>

# Custom config options for Kubernetes
--set kubernetes=<kubernetes-options>

# If TLS is disabled in your environment
--set insecure=true

# If you are pulling from a private registry
--set imagePullSecrets=<secret>

# Proxy settings
# Set this if your Armory Enterprise instance is behind a HTTP proxy.
--set env[0].name=”HTTP_PROXY”,env[0].value="<hostname>:<port>"

# Set this if your Armory Enterprise instance is behind a HTTPS proxy.
--set env[0].name=”HTTPS_PROXY”,env[0].value="<hostname>:<port>"

# No proxy
--set env[0].name=”NO_PROXY”,env[0].value="localhost,127.0.0.1,*.spinnaker"
```

The `env` parameters are optional and only need to be used if Armory Enterprise is behind a HTTP(S) proxy. If you need to set more than one of the `env` parameters, you must increment the index value for the parameters. For example: `env[0].name="HTTP_PROXY`, `env[1].name="HTTPS_PROXY"`, and `env[2].name="NO_PROXY"`.

Alternatively, you can create a `values.yaml` file to include the parameters:

```yaml
env:
 - name: HTTP_PROXY
   value: <hostname>:<port>
 - name: HTTPS_PROXY
   value: <hostname>:<port>
 - name: NO_PROXY
   value: localhost,127.0.0.1,*.spinnaker
```

With the file, you can avoid setting individual `env` parameters in the `helm install` command. Instead include the `--values` parameter as part of the Helm install command.

For information about additional options, see the [Agent config options]({{< ref "agent-options#configuration-options" >}}).

<details><summary>Show me an example</summary>

The following examples use the `imagePullSecrets` and `insecure` parameters, which may or may not be needed depending on your environment.

This example installs Agent service without a connection to Armory Cloud:

```bash
helm install armory-agent --set mode=infrastructure,accountName=demo-account,imagePullSecrets=regcred,grpcUrl=spin-clouddriver-grpc:9091,insecure=true,cloudEnabled=false --set-file kubeconfig=$HOME/.kube/config --namespace dev armory-charts/agent-k8s
```

This example installs Agent service with a connection to Armory Cloud:

```bash
helm install armory-agent --set accountName=hubaccount1,imagePullSecrets=regcred,grpcUrl=agents.staging.cloud.armory.io:443,audience=https://api.cloud.armory.io,tokenIssuerUrl=https://auth.cloud.armory.io/oauth/token,clientId==************,clientSecret=************ --namespace dev armory-charts/agent-k8s
```

</details>
</details>

<details><summary><strong>Install with custom settings</strong></summary>

1. Use `helm template` to generate a manifest.
  ```bash
  helm template armory-agent armory-charts/agent-k8s \
  --set-file kubeconfig=<path-to-your-kubeconfig>,armoryagent.yml=<path-to-agent-options>.yml \
  --namespace=<agent-namespace> # Namespace where you want to install the Agent.
  ```

  For `armoryagentyml`, create the file and customize it to meet your needs. For information about the options, see the [Agent config options]({{< ref "agent-options#configuration-options" >}}).
1. Install the helm chart using your template:

   ```bash
   helm install armory-agent <local-helm-chart-name>
   ```
</details>

### Proxy settings

The `env` parameters are optional and only need to be used if Armory Enterprise is behind a HTTP(S) proxy. If you need to set more than one of the `env` parameters, you must increment the index value for the parameters. For example: `env[0].name="HTTP_PROXY`, `env[1].name="HTTPS_PROXY"`, and `env[2].name="NO_PROXY"`.

Alternatively, you can create a `values.yaml` file to include the parameters:

```yaml
env:
  - name: HTTP_PROXY
    value: <hostname>:<port>
  - name: HTTPS_PROXY
    value: <hostname>:<port>
  - name: NO_PROXY
    value: localhost,127.0.0.1,*.spinnaker
```
With the file, you can avoid setting individual `env` parameters in the `helm install` command. Instead include the `--values` parameter as part of the Helm install command:

```
--values=<path>/values.yaml
```

## Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "agent-troubleshooting.md" >}} page if you run into issues.
* Learn how to {{< linkWithTitle "agent-monitoring.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "agent-mtls.md" >}}
* Read about {{< linkWithTitle "agent-permissions.md" >}}