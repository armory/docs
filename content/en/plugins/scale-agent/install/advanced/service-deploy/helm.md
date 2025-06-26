---
title: Deploy the Armory Scale Agent Service Using a Helm Chart
linkTitle: Helm
description: >
  Use a Helm chart to deploy the Armory Scale Agent service to your Kubernetes cluster.
weight: 10
aliases:
  - /scale-agent/install/install-agent-service-helm
---

## Chart overview

- Exposes all settings for installing the Armory Scale Agent service.
- Enables you to easily deploy the Armory Scale Agent service with default configuration using a single command.
- Gives you the ability to customize the service settings in a file or via the command line.

>**Connecting to Armory Cloud services is enabled by default.** Armory Cloud services is required for some features to function and affects how you configure the Armory Scale Agent service installation. If you want to connect to Armory Cloud services, you must include your Armory Cloud client ID and secret. You can disable connecting to Armory Cloud services by setting a gPRC URL instead of providing your Armory Cloud services credentials.


## {{% heading "prereq" %}}

Ensure you have completed the following steps before you install the Armory Scale Agent using the Helm chart:

1. You have installed the Clouddriver plugin.
1. You are familiar with [Helm](https://helm.sh/) and have installed v3.6.3+.
1. You have added or updated the Armory charts repo in your Kubernetes environment.

   To add the Armory chart repo, execute the following command:

   ```bash
   helm repo add armory-charts https://armory-charts.s3.amazonaws.com/
   ```

   If you have previously added the chart repo, update it with the following commands:

   ```bash
   helm repo update
   helm upgrade armory-agent armory-charts/agent-k8s-full
   ```

1. You are familiar with the various use cases for deploying Scale Agent services to your Kubernetes clusters.

## Quickstart

{{< tabpane text=true right=true >}}
{{% tab header="**Mode**:" disabled=true /%}}
{{% tab header="Agent" %}}
{{< include "plugins/scale-agent/install/helm/frag-helm-agent-mode.md" >}}
{{% /tab %}}
{{% tab header="Infrastructure"  %}}
{{< include "plugins/scale-agent/install/helm/frag-helm-infra-mode.md" >}}
{{% /tab %}}
{{< /tabpane >}}

### Confirm success

Create a pipeline with a **Deploy manifest** stage. You should see your target cluster available in the **Accounts** list. Deploy a static manifest.

## Set proxy settings

The `env` parameters are optional and only need to be used if Armory CD is behind an HTTP(S) proxy. If you need to set more than one of the `env` parameters, you must increment the index value for the parameters. For example: `env[0].name="HTTP_PROXY`, `env[1].name="HTTPS_PROXY"`, and `env[2].name="NO_PROXY"`.

{{< highlight rego "linenos=table,hl_lines=4-6" >}}
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=<agent-namespace> \
--set env[0].name=”HTTP_PROXY”,env[0].value="<hostname>:<port>" \
,env[1].name=”HTTPS_PROXY”,env[1].value="<hostname>:<port>" \
,env[2].name=”NO_PROXY”,env[2].value="localhost,127.0.0.1,*.spinnaker"
{{< /highlight >}}

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

```bash
--values=<path>/values.yaml
```

## Set a custom Agent image registry

If you need to download the Armory Scale Agent image from a different registry, you can specify that repository using the following settings:

```bash
--set image.repository=<repo-name>,image.imagePullPolicy=IfNotPresent, /
image.imagePullSecrets=<secret>
```

Alternatively, you can create a `values.yaml` file to include the settings:

```yaml
image:
  repository: <repo-name>
  imagePullPolicy: IfNotPresent
  imagePullSecrets: <secret>
```

Include the `--values` parameter as part of the Helm install command:

```bash
--values=<path>/values.yaml
```

## Custom configuration

If you need greater flexibility, you can override any supported [configuration option]({{< ref "plugins/scale-agent/reference/config/service-options#configuration-options" >}}), either by setting values using the command line or by setting values in an `armory-agent.yml` file.

### Set config values using the command line

You can update configuration options via the command line by using `--set config.<option>`. For example, if you want to set `logging.level` to `debug`, use `--set config.logging.level=debug` to do that.


### Set config in a file

You can also override default settings in your own `armory-agent.yml` file. For example, if you want to modify the default logging settings, create an `armory-agent.yml` file with the following content:

```yaml
logging:
  file: "my-log"
  format: "json"
  level: "debug"
```

Note that you do not use "config" in the `armory-agent` file even though you do when setting config using the command line.

Then use the `--set-file` option in the Helm `install` command:

{{< highlight bash "linenos=table,hl_lines=4" >}}
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=<agent-namespace> \
--set-file agentyml=<path-to>/armory-agent.yml
{{< /highlight >}}

You can pass in an `armory-agent.yml` file and also override values on the command line:

{{< highlight bash "linenos=table,hl_lines=4-5">}}
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=<agent-namespace> \
--set-file agentyml=<path-to>/armory-agent.yml \
--set config.logging.level=debug
{{< /highlight >}}

### The difference between `values.yaml` and `armory-agent.yml`

`armory-agent.yml`: any supported configuration option listed in the Armory Scale Agent Options [configuration option]({{< ref "plugins/scale-agent/reference/config/service-options#configuration-options" >}}) section.

`values.yaml`: environmental values such as proxy settings and image repository.

You can use both files. For example:

{{< highlight bash "linenos=table,hl_lines=4-5">}}
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=<agent-namespace> \
--set-file agentyml=<path-to>/armory-agent.yml \
--values=<path-to>/values.yaml
{{< /highlight >}}

## Examples

### Agent mode

<details><summary><string>Armory Cloud, custom config</strong></summary>

This example installs the Armory Scale Agent service into the "dev" namespace with a connection to Armory Cloud services and the following custom configuration:

- `debug` logging level
- Increase the Armory Scale Agent request retry attempts to 5
- Increase the time (in milliseconds) to wait between retry attempts to 5000
- Enables Prometheus.

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=dev \
--set hub.auth.armory.clientId=clientID123,hub.auth.armory.secret=s3cret \
,config.logging.level=debug,config.kubernetes.retries.maxRetries=5 \
,config.kubernetes.retries.backOffMs=5000,config.prometheus.enabled=true
```

The same custom configuration in an `armory-agent.yml` file:

```yaml
logging:
  level: "debug"
kubernetes:
  retries:
    maxRetries: 5
    backOffMs: 5000
prometheus:
  enabled: true
```

Install the Armory Scale Agent with configuration in a file:

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=dev \
--set hub.auth.armory.clientId=clientID123,hub.auth.armory.secret=s3cret
--set-file agentyml=/Users/armory/armory-agent.yml
```

</details>

<details><summary><string>Local gPRC, private image registry, proxy</strong></summary>

This example installs the Armory Scale Agent service into the "dev" namespace with a local gPRC endpoint (no Armory Cloud services connection), pulls the image from a private registry, and configures proxy settings.

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=dev \
--set config.clouddriver.grpc=spin-clouddriver-grpc:9091 \
,image.repository=private-reg/agent-k8s \
,image.imagePullPolicy=IfNotPresent \
,image.imagePullSecrets=regcred \
,env[0].name=”HTTP_PROXY”,env[0].value="corp.proxy.com:8080" \
,env[1].name=”HTTPS_PROXY”,env[1].value="corp.proxy.com:443" \
,env[2].name=”NO_PROXY”,env[2].value="localhost,127.0.0.1,*.spinnaker"

```

The same custom configuration in a `values.yaml` file:

```yaml
image:
  repository: private-reg/agent-k8s
  imagePullPolicy: IfNotPresent
  imagePullSecrets: regcred

env:
  - name: HTTP_PROXY
    value: corp.proxy.com:8080
  - name: HTTPS_PROXY
    value: corp.proxy.com:443
  - name: NO_PROXY
    value: localhost,127.0.0.1,*.spinnaker
```

Install the Armory Scale Agent with configuration in a file:

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=dev \
--values=/Users/armory/values.yaml
--set config.clouddriver.grpc=spin-clouddriver-grpc:9091
```

</details>

<details><summary><string>Agent and environment config in files</strong></summary>

This example installs the Armory Scale Agent service into the "dev" namespace with a connection to Armory Cloud services and the following custom Agent configuration:
- `debug` logging level
- Increase the Armory Scale Agent request retry attempts to 5
- Increase the time (in milliseconds) to wait between retry attempts to 5000
- Enables Prometheus.

Agent configuration in an `armory-agent.yml` file:

```yaml
logging:
  level: "debug"
kubernetes:
  retries:
    maxRetries: 5
    backOffMs: 5000
prometheus:
  enabled: true
```

Additionally, a `values.yaml` file contains custom repository and proxy settings:

```yaml
image:
  repository: private-reg/agent-k8s
  imagePullPolicy: IfNotPresent
  imagePullSecrets: regcred

env:
  - name: HTTP_PROXY
    value: corp.proxy.com:8080
  - name: HTTPS_PROXY
    value: corp.proxy.com:443
  - name: NO_PROXY
    value: localhost,127.0.0.1,*.spinnaker
```


Install command:

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=dev \
--set hub.auth.armory.clientId=clientID123,hub.auth.armory.secret=s3cret
--set-file agentyml=/Users/armory/armory-agent.yml
--vaues=/Users/amory/values.yaml
```

</details>

### Infrastructure mode


<details><summary><string>Armory Cloud, custom config</strong></summary>

This example installs the Armory Scale Agent service into the "dev" namespace with a connection to Armory Cloud services and the following custom configuration:
- `debug` logging level
- Increase the Armory Scale Agent request retry attempts to 5
- Increase the time (in milliseconds) to wait between retry attempts to 5000
- Enables Prometheus.

Create the namespace:

```bash
kubectl create namespace dev
```

Create the secret:

```bash
kubectl create secret generic kubeconfig --from-file=/User/armory/.kube/config -n dev
```

Install the Armory Scale Agent:

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=dev \
--set hub.auth.armory.clientId=clientID123,hub.auth.armory.secret=s3cret \
,kubeconfigs.account1.file=config \
,kubeconfigs.account1.secret=s3cr3t \
,config.logging.level=debug,config.kubernetes.retries.maxRetries=5 \
,config.kubernetes.retries.backOffMs=5000,config.prometheus.enabled=true
```

The same custom configuration in an `armory-agent.yml` file:

```yaml
logging:
  level: "debug"
kubernetes:
  retries:
    maxRetries: 5
    backOffMs: 5000
prometheus:
  enabled: true
```

Install the Armory Scale Agent with configuration in a file:

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=dev \
--set hub.auth.armory.clientId=clientID123,hub.auth.armory.secret=s3cret \
,kubeconfigs.account1.file=config \
,kubeconfigs.account1.secret=s3cr3t \
--set-file agentyml=/Users/armory/armory-agent.yml
```

</details>



<details><summary><string>Local gPRC, private image registry, proxy</strong></summary>

This example installs the Armory Scale Agent service into the "dev" namespace with a local gPRC endpoint (no Armory Cloud services connection), pulls the image from a private registry, and configures proxy settings.

Create the namespace:

```bash
kubectl create namespace dev
```

Create the secret:

```bash
kubectl create secret generic kubeconfig --from-file=/User/armory/.kube/config -n dev
```

Install the Armory Scale Agent:

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=dev \
--set config.clouddriver.grpc=spin-clouddriver-grpc:9091 \
,kubeconfigs.account1.file=config \
,kubeconfigs.account1.secret=s3cr3t \
,image.repository=private-reg/agent-k8s \
,image.imagePullPolicy=IfNotPresent \
,image.imagePullSecrets=regcred \
,env[0].name=”HTTP_PROXY”,env[0].value="corp.proxy.com:8080" \
,env[1].name=”HTTPS_PROXY”,env[1].value="corp.proxy.com:443" \
,env[2].name=”NO_PROXY”,env[2].value="localhost,127.0.0.1,*.spinnaker"
```

The same custom configuration in a `values.yaml` file:

```yaml
image:
  repository: private-reg/agent-k8s
  imagePullPolicy: IfNotPresent
  imagePullSecrets: regcred

env:
  - name: HTTP_PROXY
    value: corp.proxy.com:8080
  - name: HTTPS_PROXY
    value: corp.proxy.com:443
  - name: NO_PROXY
    value: localhost,127.0.0.1,*.spinnaker
```

Install the Armory Scale Agent with configuration in a file:

```bash
helm install armory-agent armory-charts/agent-k8s-full \
--namespace=dev \
--values=/Users/armory/values.yaml
--set config.clouddriver.grpc=spin-clouddriver-grpc:9091 \
,kubeconfigs.account1.file=config \
,kubeconfigs.account1.secret=s3cr3t
```

</details>

## Uninstall

```bash
helm uninstall <release-name> --namespace=<agent-namespace>
```

- `<release-name>`: (Reqired) the Armory Scale Agent service release, such as {{<param kubesvc-version>}}.
- `<agent-namespace>`: (Required) The namespace where you installed the Armory Scale Agent.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/scale-agent/troubleshooting/_index.md" >}} page if you run into issues.
* Learn how to {{< linkWithTitle "plugins/scale-agent/tasks/service-monitor.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Armory Scale Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "plugins/scale-agent/tasks/configure-mtls.md" >}}
* Read about {{< linkWithTitle "plugins/scale-agent/concepts/service-permissions.md" >}}
</br>
</br>
