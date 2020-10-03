---
title: "Armory Agent for Kubernetes"
linkTitle: "Armory Agent"
description: >
  Armory Agent is a new, flexible way for Spinnaker to interact with your Kubernetes infrastructure.
weight: 4
---

* Massive scale for Kubernetes
  * Agent only streams changes to Spinnaker in real time over a single TCP connection per cluster.
  * Caching and deployment scales to thousands of Kubernetes clusters for your largest applications.
  * Agent optimizes how infrastructure information is cached resulting in optimal performance for your end users or your pipelines.

* Flexible deployment model
  * Use the agent alongside Spinnaker and benefit from performance improvements.
  * Use the agent in the target cluster and get Kubernetes account automatically registered.
  
* Enhanced security
  * Keep your Kubernetes API servers private from Spinnaker.
  * Control what Spinnaker can do directly in a service account. No need to change Spinnaker.
  * Use a service account or store your `kubeconfig` files in one of the supported [secret engines]({{< ref "secrets#supported-secret-engines" >}}) engines or provision them via the method of your choice as Kubernetes secrets.
  * Only what Spinnaker needs leaves the cluster.


## Compatibility matrix

> [MySQL storage for Clouddriver](../../armory-admin/clouddriver-sql-configure/) is required for the Agent.

{{< include "agent/agent-compat-matrix.md" >}}

The Agent comes as a service deployed as a Kubernetes `Deployment` as well as a plugin to the Clouddriver service of Spinnaker. Be sure to check out the [architecture](../../armory-admin/armory-agent/).

## Step 1: Agent Plugin Installation

The installation consists in modifying the current clouddriver deployment as well as adding a new Kubernetes `Service`.

The easiest installation path is to modify an existing [`spinnakerservice.yaml`](../operator-reference/operator-config/) with [kustomize](https://kustomize.io/). Let's download additional manifests into the directory with your `SpinnakerService`:

```
# AGENT_PLUGIN_VERSION can be found in the compatibility matrix above
curl https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/agent-plugin-$AGENT_PLUGIN_VERSION.tar.gz | tar -xJvf -
```


We'll then include the manifests to our current kustomization:
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

You can then set the [plugin options](../../armory-admin/armory-agent/plugin-options/) in `agent-plugin/config.yaml`. When you're ready, deploy with:
```bash
kustomize build . | kubectl apply -f - 
```

Note: 
- if you gave `SpinnakerService` a name other than `spinnaker`, you will need to change it in files under `agent-plugin`
- if you are using the Agent on an OSS installation, use the following download URL `https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/agent-oss-plugin-${AGENT_PLUGIN_VERSION}-tar.gz` or replace the `apiVersion` to `spinnaker.io/v1alpha2`.

### Alternate methods

If you are not using kustomize, you can still use the same manifests above:

- Deploy `agent-service/clouddriver-grpc-service.yaml` or `agent-service/clouddriver-ha-grpc-service.yaml` if using Clouddriver "HA" (caching, rw, ro).
- Merge `agent-plugin/config.yaml` and `agent-plugin/clouddriver-plugin.yaml` into your existing `SpinnakerService`.


## Step 2: Agent Installation

### Kustomize

Create the following directory structure with `kustomization.yaml` and `kubesvc.yaml` described below and `kubecfg/` containing the [kubeconfig files](../../armory-admin/manual-service-account/) required to access target deployment clusters:

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

`kubesvc.yaml`  contains the [Agent options](../../armory-admin/armory-agent/agent-options/):
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

With the structure above in place deploying the agent is as simple as:

```bash
kustomize build /path/to/directory | kubectl apply -f - 
```

### Managing kustomization locally

If you prefer to manage manifests directly, you can get all the manifests:

```bash
AGENT_VERSION = {{<param kubesvc-version>}} && \
curl -s https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-$AGENT_VERSION-kustomize.tar.gz | tar -xJvf -
```

- Change the version of the Agent in `kustomization.yaml`
- Modify [Agent options](../../armory-admin/armory-agent/agent-options/) in `kubesvc.yaml`

