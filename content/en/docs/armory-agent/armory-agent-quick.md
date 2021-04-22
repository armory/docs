---
title: "Armory Agent for Kubernetes Quick Start Installation"
linkTitle: "Quick Start"
description: >
  Leearn how to install the Armory Agent in your Kubernetes and Spinnaker environments.
weight: 2
---
![Proprietary](/images/proprietary.svg)
> This guide is for experienced Kubernetes and Spinnaker<sup>TM</sup> users.

## Compatibility matrix

> [MySQL storage for Clouddriver]({{< ref "clouddriver-sql-configure" >}}) is required for the Agent.

{{< include "agent/agent-compat-matrix.md" >}}

The Agent consists of a service deployed as a Kubernetes `Deployment` and a plugin to Spinnaker's Clouddriver service. Be sure to check out the [architecture]({{< ref "armory-agent" >}}).

## Networking requirements

Communication between Clouddriver and the Agent must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between Clouddriver and the Agent.  

## Step 1: Agent plugin installation

You modify the current Clouddriver deployment as well as add a new Kubernetes `Service`.

The easiest installation path is to modify an existing [`spinnakerservice.yaml`]({{< ref "op-config-manifest" >}}) with [Kustomize](https://kustomize.io/). To start, download additional manifests into the directory with your `SpinnakerService`:

```bash
# AGENT_PLUGIN_VERSION is found in the compatibility matrix above
curl https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/agent-plugin-$AGENT_PLUGIN_VERSION.tar.gz | tar -xJvf -
```


Then include the manifests in your current kustomization:

```yaml
# Existing kustomization.yaml
namespace: spinnaker  #   could be different
resources:
  # Pre-existing SpinnakerService resource (may have a different name)
  - spinnakerservice.yaml

bases:
  # Add the agent service
  - agent-service

patchesStrategicMerge:
  # Include plugin configuration
  - agent-plugin/config.yaml
  # Change plugin version as well the name of your SpinnakerService in this manifest
  - agent-plugin/clouddriver-plugin.yaml
  # Alternatively you can include this remote manifest
#  - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/clouddriver-plugin-<AGENT_PLUGIN_VERSION>.yaml

```

You can then set the [plugin options]({{< ref "agent-plugin-options" >}}) in `agent-plugin/config.yaml`.

* For topologies like [Infrastructure mode]({{< ref "armory-agent#infrastructure-mode" >}}) and [Agent mode]({{< ref "armory-agent#agent-mode" >}}), in which the Agent is installed in a different cluster from Spinnaker, you should configure TLS through a load balancer.
* For Spinnaker installations with one Clouddriver instance and no Redis, you can use `kubesvc.cluster`. However, a Spinnaker installation with Redis is recommended.
* When running Spinnaker in [HA](https://spinnaker.io/reference/halyard/high-availability/), make sure to modify the following files:

  * `agent-service/kustomization.yaml` according to its comments
  * `agent-plugin/clouddriver-plugin.yaml` and `agent-plugin/config.yaml` references to Clouddriver should be to HA versions (i.e: -rw, -ro, etc)

When you're ready, deploy with:

```bash
kustomize build . | kubectl apply -f -
```

Note:

- If you gave `SpinnakerService` a name other than `spinnaker`, you will need to change it in files under `agent-plugin`.
- If you are using the Agent on an OSS installation, use the following download URL `https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/agent-oss-plugin-${AGENT_PLUGIN_VERSION}-tar.gz` or replace the `apiVersion` with `spinnaker.io/v1alpha2`.

### Alternate methods

If you are not using Kustomize, you can still use the same manifests.

- Deploy `agent-service/clouddriver-grpc-service.yaml` or `agent-service/clouddriver-ha-grpc-service.yaml` if using Clouddriver "HA" (caching, rw, ro).
- Merge `agent-plugin/config.yaml` and `agent-plugin/clouddriver-plugin.yaml` into your existing `SpinnakerService`.


## Step 2: Agent installation

### Kustomize

Create the directory structure described below with `kustomization.yaml`, `kubesvc.yaml`, and `kubecfg/` containing the [kubeconfig files]({{< ref "manual-service-account" >}}) required to access target deployment clusters:

```
.
├── kustomization.yaml
├── kubesvc.yaml
├── kubecfgs/
│   ├── kubecfg-01.yaml
│   ├── kubecfg-02.yaml
│   ├── ...
│   └── kubecfg-nn.yaml
```

```yaml
# ./kustomization.yaml

# Namespace where you want to deploy the agent
namespace: spinnaker
bases:
  - https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-{{<param kubesvc-version>}}-kustomize.tar.gz

configMapGenerator:
  - name: kubesvc-config
    behavior: merge
    files:
      - kubesvc.yaml

secretGenerator:
  - name: kubeconfigs-secret
    files:
    # a list of all needed kubeconfigs
    - kubecfgs/kubecfg-account01.yaml
    - ...
    - kubecfgs/kubecfg-account1000.yaml
```

`kubesvc.yaml`  contains the [Agent options]({{< ref "agent-options" >}}):
```yaml
# ./kubesvc.yaml

kubernetes:
  accounts:
  - name: account01
    # /kubeconfigfiles/ is the path to the config files
    # as mounted from the `kubeconfigs-secret` Kubernetes secret
    kubeconfigFile: /kubeconfigfiles/kubecfg-account01.yaml
    ...
  - ...
...
```

* For installations without gRPC TLS connections, you should include `clouddriver.insecure: true` in the Agent options.
* For HA, make sure to set `clouddriver.grpc: clouddriver-ha-grpc-service.yaml:9091`

With the directory structure in place, deploy the Agent service:

```bash
kustomize build </path/to/directory> | kubectl apply -f -
```

### Managing kustomization locally

If you prefer to manage manifests directly, download all the manifests:

```bash
AGENT_VERSION={{<param kubesvc-version>}} && curl -s https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-$AGENT_VERSION-kustomize.tar.gz | tar -xJvf -
```

- Change the version of the Agent in `kustomization.yaml`
- Modify [Agent options]({{< ref "agent-options" >}}) in `kubesvc.yaml`

## Troubleshooting

Check out the [troubleshooting]({{< ref "agent-troubleshooting" >}}) page if you run into issues.

## Monitoring

Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Agent is monitoring. The gRPC buffer consumes about 4MB of memory. See the [Monitoring]({{< ref "agent-monitoring" >}}) page for how to monitor agents running on an Armory platform.
