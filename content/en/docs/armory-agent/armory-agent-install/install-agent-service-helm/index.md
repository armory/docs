---
title: "Armory Agent Service Installation Using a Helm Chart"
linkTitle: "Install Service - Helm"
description: >
  Use a Helm chart to install the Armory Agent service in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

## Chart overview

- Exposes all settings for installing the Agent service.
- Enables you to easily deploy the Agent service with default configuration using a single command.
- Ability to customize the service settings in a file or via the command line.

Connecting to Armory Cloud services is enabled by default. Armory Cloud services is required for some features to function and affects how you configure the Agent service installation. If you want to connect to Armory Cloud services, you must include your Armory Cloud client ID and secret. You can disable connecting to Armory Cloud services by setting a gPRC URL instead of providing your Armory Cloud services credentials.


## {{% heading "prereq" %}}

1. You have [installed the Clouddriver plugin]({{< ref "install-agent-plugin" >}}).
1. You are familiar with [Helm](https://helm.sh/) and have installed v3.6.3+.
1. You have added or updated the Armory charts repo in your Kubernetes environment.

   To add the Armory chart repo, execute the following command:

   {{< prism lang="bash" >}}
   helm repo add armory-charts http://armory.jfrog.io/artifactory/charts
   {{< /prism >}}

   If you have previously added the chart repo, update it with the following commands:

   {{< prism lang="bash" >}}
   helm repo update
   helm upgrade armory-agent armory-charts/agent-k8s-full
   {{< /prism >}}


## Quickstart

{{< tabs name="agent-quickstart-tabs" >}}
{{< tabbody name="Agent Mode" include="frag-helm-agent-mode" />}}
{{< tabbody name="Infrastructure Mode" include="frag-helm-infra-mode" />}}
{{< /tabs >}}

### Confirm success

Create a pipeline with a **Deploy manifest** stage. You should see your target cluster available in the **Accounts** list. Deploy a static manifest.


## Advanced Configuration

You can override any supported [configuration option]({{< ref "agent-options#configuration-options" >}}) if you need greater flexibility, either by setting values using the command line or by setting values in an `armory-agent.yml` file.

### Set config values using the command line

You can update configuration options via the command line by using `--set config.<option>`. For example, if you want to set `logging.level` to `debug`, use `--set config.logging.level=debug` to do that.


### Set configuration in a file

You can also override default settings in your own `armory-agent.yml` file. If you want to modify the default logging settings, create an `armory-agent.yml` file with the following content:

{{< prism lang="yaml" >}}
logging:
  file: "my-log"
  format: "json"
  level: "debug"
{{< /prism >}}

Set that file in the Helm `install` command:

{{< prism lang="bash" line="4">}}
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=<agent-namespace> \
--set-file agentyml=<path-to>/armory-agent.yml
{{< /prism >}}

It is possible to pass an `armory-agent.yml` file and still override values:

{{< prism lang="bash" line="4-5">}}
helm install armory-agent armory-charts/agent-k8s-full \
--create-namespace \
--namespace=<agent-namespace> \
--set-file agentyml=<path-to>/armory-agent.yml \
--set config.logging.level=debug
{{< /prism >}}



## Proxy settings

The `env` parameters are optional and only need to be used if Armory Enterprise is behind a HTTP(S) proxy. If you need to set more than one of the `env` parameters, you must increment the index value for the parameters. For example: `env[0].name="HTTP_PROXY`, `env[1].name="HTTPS_PROXY"`, and `env[2].name="NO_PROXY"`.

Alternatively, you can create a `values.yaml` file to include the parameters:

{{< prism lang="yaml" >}}
env:
  - name: HTTP_PROXY
    value: <hostname>:<port>
  - name: HTTPS_PROXY
    value: <hostname>:<port>
  - name: NO_PROXY
    value: localhost,127.0.0.1,*.spinnaker
{{< /prism >}}

With the file, you can avoid setting individual `env` parameters in the `helm install` command. Instead include the `--values` parameter as part of the Helm install command:

```bash
--values=<path>/values.yaml
```

## Examples