---
title: "Install the Scale Agent Plugin"
linkTitle: "Install Plugin"
description: >
  Install the Armory Scale Agent Clouddriver plugin in your Spinnaker or Armory CD environments.
weight: 30
---

## {{% heading "prereq" %}}

* Make sure you have read the Installation [overview]({{< ref "scale-agent" >}}) and have met the prerequisites.
* You are familiar with how plugins work in Spinnaker. See open source Spinnaker's [Plugin User Guide](https://spinnaker.io/docs/guides/user/plugins-users/).

You can install the plugin from a plugins repository or from Docker. If you want to cache the plugin and run security scans on it before installation, choose the Docker option.

The tool you use to install the plugin depends on the tool you use to manage your Armory CD or Spinnaker installation.

1. [Armory Operator or Spinnaker Operator](#armory-operator-or-spinnaker-operator) with Kustomize
1. [Halyard](#halyard) (Spinnaker only)

Be sure to choose the Scale Agent version that is compatible with your Armory CD or Spinnaker version.

{{< include "scale-agent/agent-compat-matrix.md" >}}

## Armory Operator or Spinnaker Operator

You can install the Scale Agent plugin using the Armory Operator or the Spinnaker Operator and the sample manifest, which uses Kustomize and is in the `spinnaker-kustomize-patches` [repository](https://github.com/armory/spinnaker-kustomize-patches/tree/master/targets/kubernetes/scale-agent).

* The sample manifest is for the Armory Operator using Kustomize. If you are using the Spinnaker Operator, you must replace the `apiVersion` value "spinnaker.armory.io/" with "spinnaker.io/". For example:

  * Armory Operator: `apiVersion: spinnaker.armory.io/v1alpha2`
  * Spinnaker Operator: `apiVersion: spinnaker.io/v1alpha2`

* Change the value for `metadata.name` if your Armory CD service is called something other than "spinnaker".

{{< tabs name="DeploymentPlugin" >}}
{{< tabbody name="Plugin Repo" >}}
<br>
Update <code>plugins.Armory.Kubesvc.version</code> to a version that is compatible with your Armory CD installation.

{{< github repo="armory/spinnaker-kustomize-patches" file="targets/kubernetes/scale-agent/plugin-config.yml" lang="yaml" options="" >}}

Then include the file under the <code>patchesStrategicMerge</code> section of your <code>kustomization</code> file.

{{< prism lang="yaml" line="4" >}}
bases:
  - plugins/scale-agent
patchesStrategicMerge:
  - scale-agent/plugin-config.yml
{{< /prism >}}

{{< /tabbody >}}
{{< tabbody name="Docker" >}}
<br>
Update <code>plugins.Armory.Kubesvc.version</code> to a version that is compatible with your Armory CD installation.

{{< github repo="armory/spinnaker-kustomize-patches" file="targets/kubernetes/scale-agent/plugin-container-patch.yml" lang="yaml" options="" >}}

Then include the file under the <code>patchesStrategicMerge</code> section of your <code>kustomization</code> file.

{{< prism lang="yaml" line="4" >}}
bases:
  - agent-service
patchesStrategicMerge:
  - scale-agent/plugin-container-patch.yml
{{< /prism >}}

{{< /tabbody >}}
{{< /tabs >}}



Apply your manifest.

## Halyard

{{% alert title="Warning" color="warning" %}}
The Scale Agent plugin extends Clouddriver. When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to each service. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid each service restarting and downloading the plugin, configure the plugin in Clouddriver’s local profile.
{{% /alert %}}

If you don't have a Clouddriver local profile, create one in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Add the following to `clouddriver.yml`:

```yaml
spinnaker:
  extensibility:
    repositories:
      armory-agent-k8s-spinplug-releases:
        enabled: true
        url: https://raw.githubusercontent.com/armory-io/agent-k8s-spinplug-releases/master/repositories.json
    plugins:
      Armory.Kubesvc:
        enabled: true
        version: {{< param kubesvc-plugin.agent_plug_latest >}} # check compatibility matrix for your Armory CD version
        extensions:
          armory.kubesvc:
            enabled: true
# Plugin config
kubesvc:
  cluster: kubernetes
  cluster-kubernetes:
    kubeconfigFile: <path-to-file> # (Optional, default: null). If configured, the plugin uses this file to discover Endpoints. If not configured, it uses the service account mounted to the pod.
    verifySsl: <true|false> # Optional, default: true). Whether to verify the Kubernetes API cert or not.
    namespace: <string> # (Optional, default: null). If configured, the plugin watches Endpoints in this namespace. If null, it watches endpoints in the namespace indicated in the file "/var/run/secrets/kubernetes.io/serviceaccount/namespace".
    httpPortName: <string> # (Optional, default: http). Name of the port configured in the Clouddriver Service that forwards traffic to the Clouddriver HTTP port for REST requests.
    clouddriverServiceNamePrefix: <string> # (Optional, default: spin-clouddriver). Name prefix of the Kubernetes Service pointing to the Clouddriver standard HTTP port.
```

Save your file and apply your changes by running `hal deploy apply`.


## Expose Clouddriver as a LoadBalancer

To expose Clouddriver as a Kubernetes-type LoadBalancer, apply the following manifest:

{{< github repo="armory/spinnaker-kustomize-patches" file="/targets/kubernetes/scale-agent/scale-agent-service.yml" lang="yaml" options="" >}}

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.

If you are using the `spinnaker-kustomize-patches` repo, the manifest file is already included in the `resources` section of the `/targets/kubernetes/scale-agent/kustomization.yaml` file. Alternately, you can apply the manifest using `kubectl`.

## Get the LoadBalancer IP address

Use `kubectl get svc spin-clouddriver-grpc -n spinnaker` to make note of the LoadBalancer IP external address. You need this address when you configure the Scale Agent.

## Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your
Armory CD or Spinnaker cluster and one in your target cluster.


## {{% heading "nextSteps" %}}

* Install the Armory Scale Agent service using one of the following guides:

   - {{< linkWithTitle "scale-agent/install/install-agent-service-helm/index.md" >}}
   - {{< linkWithTitle "scale-agent/install/install-agent-service-kubectl.md" >}}


* {{< linkWithTitle "scale-agent/reference/config/agent-plugin-options.md" >}}
* {{< linkWithTitle "scale-agent/troubleshooting/_index.md" >}}

