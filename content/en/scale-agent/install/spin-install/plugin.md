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

1. [Armory Operator](#armory-operator-or-spinnaker-operator) with Kustomize
1. [Halyard](#halyard) (Spinnaker only)

Be sure to choose the Scale Agent version that is compatible with your Armory CD or Spinnaker version.

{{< include "scale-agent/agent-compat-matrix.md" >}}

## Armory Operator

You can install the Scale Agent plugin using the Armory Operator and the sample manifest, which uses Kustomize and is in the `spinnaker-kustomize-patches` [repository](https://github.com/armory/spinnaker-kustomize-patches/targets/kubernetes/scale-agent/).

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
  - scale-agent/plugin-config.yaml
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
  - scale-agent/plugin-container-patch.yaml
{{< /prism >}}

{{< /tabbody >}}
{{< /tabs >}}



Apply your manifest.

## Halyard




## Expose Clouddriver as a LoadBalancer

To expose Clouddriver as a Kubernetes-type LoadBalancer, apply the following manifest:

{{< github repo="armory/spinnaker-kustomize-patches" file="targets/kubernetes/scale-agent/scale-agent-service.yml" lang="yaml" options="" >}}

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.

If you are using the `spinnaker-kustomize-patches` repo, the manifest file is already included in the `resources` section of the `/plugins/armory-agent/kustomization.yaml` file. Alternately, you can apply the manifest using `kubectl`.

## Get the LoadBalancer IP address

Use `kubectl get svc spin-clouddriver-grpc -n spinnaker` to make note of the LoadBalancer IP external address. You need this address when you configure the Scale Agent.

## Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your
Armory CD or Spinnaker cluster and one in your target cluster.

