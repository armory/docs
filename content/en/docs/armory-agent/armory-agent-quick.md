---
title: "Armory Agent for Kubernetes Quick Start Installation"
linkTitle: "Quick Start"
description: >
  Install quickly using this guide.
weight: 2
---

> This guide is for experienced Kubernetes and Spinnaker users.

## Compatibility matrix

> [MySQL storage for Clouddriver]({{< ref "clouddriver-sql-configure" >}}) is required for the Agent.

{{< include "agent/agent-compat-matrix.md" >}}

The Agent comes as a service deployed as a Kubernetes `Deployment` as well as a plugin to Spinnaker's Clouddriver service. Be sure to check out the [architecture]({{< ref "armory-agent" >}}).

## Step 1: Agent plugin installation

You modify the current Clouddriver deployment as well as add a new Kubernetes `Service`.

The easiest installation path is to modify an existing [`spinnakerservice.yaml`]({{< ref "operator-config" >}}) with [kustomize](https://kustomize.io/). To start, download additional manifests into the directory with your `SpinnakerService`:

```
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

You can then set the [plugin options]({{< ref "agent-plugin-options" >}}) in `agent-plugin/config.yaml`. When you're ready, deploy with:

```bash
kustomize build . | kubectl apply -f -
```

Note:

- If you gave `SpinnakerService` a name other than `spinnaker`, you will need to change it in files under `agent-plugin`.
- If you are using the Agent on an OSS installation, use the following download URL `https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/agent-oss-plugin-${AGENT_PLUGIN_VERSION}-tar.gz` or replace the `apiVersion` with `spinnaker.io/v1alpha2`.

### Alternate methods

If you are not using kustomize, you can still use the same manifests.

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

With the directory structure in place, deploy the Agent:

```bash
kustomize build </path/to/directory> | kubectl apply -f -
```

### Managing kustomization locally

If you prefer to manage manifests directly, download all the manifests:

```bash
AGENT_VERSION = {{<param kubesvc-version>}} && \
curl -s https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-$AGENT_VERSION-kustomize.tar.gz | tar -xJvf -
```

- Change the version of the Agent in `kustomization.yaml`
- Modify [Agent options]({{< ref "agent-options" >}}) in `kubesvc.yaml`

## Troubleshooting

Check out the [troubleshooting]({{< ref "agent-troubleshooting" >}}) page if you run into issues.

## Monitoring

The Agent should only consume about 4 MB of memory and a small amount of CPU. See the [Monitoring]({{< ref "agent-monitoring" >}}) page for how to monitor agents running on an Armory platform.
