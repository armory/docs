---
title: "Armory Agent Plugin Installation Using Halyard"
linkTitle: "Install Plugin - Halyard"
description: >
  Install the Armory Agent Clouddriver plugin using Halyard in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

## {{% heading "prereq" %}}

- You have read the Installation [overview]({{< ref "armory-agent-install" >}}).
- You have a running Redis instance.

## Configure Clouddriver to use a SQL database

Follow the [Configure Clouddriver to use a SQL Database guide]({{< ref "clouddriver-sql-configure" >}}), but skip the step that removes Redis. You need to make sure Redis is enabled:

{{< prism lang="yaml" line="2" >}}
redis:
 enabled: true
{{< /prism >}}

## Create a `mountPath` for the plugin

Create an empty directory inside the Clouddriver pod for the plugin. You can do this using a Halyard [custom service setting](https://spinnaker.io/docs/reference/halyard/custom/). Add the following content to `<HALYARD>/<DEPLOYMENT>/service-settings/clouddriver.yml`:

{{< prism lang="yaml" >}}
kubernetes:
  volumes:
  - id: kubesvc-plugin-vol
    type: emptyDir
    mountPath: /opt/clouddriver/lib/plugins
{{< /prism >}}

## Declare the plugin image

Add an `initContainer` inside the Clouddriver deployment in your `<HALYARD>/config` file:

{{< prism lang="yaml" >}}
deploymentConfigurations:
  - name: <deployment-name>
    deploymentEnvironment:
      initContainers:
        spin-clouddriver:
          - name: kubesvc-plugin
            image: docker.io/armory/kubesvc-plugin:<version>
            volumeMounts:
            - mountPath: /opt/plugin/target
              name: kubesvc-plugin-vol
{{< /prism >}}

- Replace `<deployment-name>` with the your deployment's name or `default`.
- Replace `<version>` with the plugin version compatible with your Armory Enterprise version. See the [Compatibility Matrix]({{< ref "armory-agent-install#compatibility-matrix" >}}) for details.

## Install the plugin

Configure the plugin in `<HALYARD>/<DEPLOYMENT>/profiles/clouddriver-local.yml`:

{{< prism lang="yaml" >}}
spinnaker:
  extensibility:
    plugins:
      Armory.Kubesvc:
        enabled: true
        extensions:
         armory.kubesvc:
           enabled: true
    pluginsRootPath: /opt/clouddriver/lib/plugins
 {{< /prism >}}

Restart your Armory Enterprise instance to apply the changes.

## Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your
Armory Enterprise cluster and one in your target cluster.


## {{% heading "nextSteps" %}}

Install the Agent service [using a Helm chart]({{< ref "install-agent-service-helm" >}}) or [using `kubectl`]({{< ref "install-agent-service-kubectl" >}}).
</br>
</br>