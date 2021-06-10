---
title: "Armory Agent for Kubernetes Quickstart Installation"
linkTitle: "Quickstart"
description: >
  Learn how to install the Armory Agent in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

## Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

The Agent consists of a service deployed as a Kubernetes `Deployment` and a plugin to Spinnaker's Clouddriver service. You can review the architecture in the Armory Agent [overview]({{< ref "armory-agent" >}}).

## {{% heading "prereq" %}}

* This guide is for experienced Kubernetes and Armory Enterprise users.
* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).
* You have a Redis instance. The Agent uses Redis to coordinate between Clouddriver replicas.
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions.

## Networking requirements

Communication between Clouddriver and the Agent must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between Clouddriver and the Agent.  

## Kubernetes permissions needed by the Agent

The Agent should have `ClusterRole` authorization if you need to deploy pods across your cluster or `Role` authorization if you deploy pods only to a single namespace.

* If Agent is running in [Agent Mode]({{< ref "armory-agent#agent-mode" >}}), then the `ClusterRole` or `Role` is the one attached to the Kubernetes Service Account mounted by the Agent pod.
* If Agent is running in any of the other modes, then the `ClusterRole` or `Role` is the one the `kubeconfigFile` uses to interact with the target cluster. `kubeconfigFile` is configured in `kubesvc.yml` of the Agent pod.

Example configuration for deploying `Pod` manifests:

{{< tabs name="agent-permissions" >}}
{{% tab name="ClusterRole" %}}

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: agent-role
rules:
- apiGroups: ""
  resources:
  - pods
  - pods/log
  - pods/finalizers  
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
```

{{% /tab %}}
{{% tab name="Role" %}}

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: agent-role
rules:
- apiGroups: ""
  resources:
  - pods
  - pods/log
  - pods/finalizers  
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
```

{{% /tab %}}
{{< /tabs >}}

You can see a more detailed example of the kind of `ClusterRole` permissions you may need in the `spinnaker-kustomize-patch` repo's `spin-sa.yml` [file](https://github.com/armory/spinnaker-kustomize-patches/blob/master/accounts/kubernetes/spin-sa.yml#L5).

See the Kubernetes [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) guide for details on configuring `ClusterRole` and `Role` authorization.

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

- If you gave `SpinnakerService` a name other than `spinnaker`, you need to change it in files under `agent-plugin`.
- If you are using the Agent on an OSS installation, use the following download URL `https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/agent-oss-plugin-${AGENT_PLUGIN_VERSION}-tar.gz` or replace the `apiVersion` with `spinnaker.io/v1alpha2`.

### Alternate methods

If you are not using Kustomize, you can still use the same manifests.

- Deploy `agent-service/clouddriver-grpc-service.yaml` or `agent-service/clouddriver-ha-grpc-service.yaml` if using Clouddriver "HA" (caching, rw, ro).
- Merge `agent-plugin/config.yaml` and `agent-plugin/clouddriver-plugin.yaml` into your existing `SpinnakerService`.


## Step 2: Agent installation

### Kustomize

Create the directory structure described below with `kustomization.yaml`, `kubesvc.yaml`, and `kubecfg/` containing the [kubeconfig files]({{< ref "manual-service-account" >}}) required to access target deployment clusters:

```
./armory-agent
├── kubesvc-agent
├── kustomization.yaml
├── kubesvc.yaml
├── kubecfgs/
│   ├── kubecfg-account01.yaml
│   ├── kubecfg-account02.yaml
│   ├── ...
│   └── kubecfg-accountnn.yaml
```

```yaml

To install the agent, download the additional manifests into the `armory-agent/kubesvc` directory created in the structure shown above:

```bash
# AGENT_PLUGIN_VERSION is found in the compatibility matrix above
curl https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-{{<param kubesvc-version>}}-kustomize.tar.gz | tar -xJvf -
```

Then include the manifests in the current kustomization file:

```yaml

# ./armory-agent/kustomization.yaml

# Namespace where you want to deploy the agent
namespace: spinnaker
bases:
  - kubesvc-agent

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

The `kubesvc.yaml` will need to contain the [Agent options]({{< ref "agent-options" >}}):

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

You could alternatively add the `armory-agent` to the `bases` section of the `kustomization.yaml` file where your `spinnakerservice.yaml` is referenced to deploy the services all together.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "agent-mtls.md" >}}
* {{< linkWithTitle "agent-troubleshooting.md" >}} page if you run into issues.
* {{< linkWithTitle "agent-monitoring.md" >}} page for how to monitor agents running on an Armory platform. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
