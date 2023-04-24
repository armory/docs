---
title: Install Pipelines-as-Code in Spinnaker
linkTitle: Spinnaker - Operator
weight: 5
description: >
  Learn how to install Armory Pipelines and Code in a Spinnaker instance managed by the Spinnaker Operator.
---

## {{% heading "prereq" %}}

* You should familiarize yourself with Pipelines-as-Code [architecture]({{< ref "plugins/pipelines-as-code/architecture" >}}).
* You have created a personal access token in your repo.
* You have installed kubectl and are familiar with [Kustomize](https://kustomize.io/), which is bundled with recent versions of kubectl (1.14+).
* You have permissions to create ServiceAccount, ClusterRole, and ClusterRoleBinding objects in your cluster.


## Install the service

Armory maintains a repo of Kustomize files that you can use to generate the Kubernetes manifests you need to install the service. You do need to update the contents of some of the files before you run `kubectl kustomize`.

1. Clone the spinnaker-kustomize-patches repo
1. change the symlink
1. Update files

### Clone the repo

Clone the [`spinnaker-kustomize-patches`](https://github.com/armory/spinnaker-kustomize-patches) repo to your local machine. The Pipelines-as-Code recipe is in `recipes/kustomization-oss-pac.yml`, so you need to update the `kustomization.yml` symlink to point to that file. From the root directory, run:

```bash
rm kustomization.yml
ln -s ./recipes/kustomization-oss-pac.yml kustomization.yml
```

### Configure the service

You can find the relevant config and install files in `plugins/oss/pipelines-as-code`.

* `kustomization.yml`: Kustomize build file
* `deployment.yml`: `spin-dinghy` Deployment manifest
* `dinghy.yml`: service config file
* `service.yml`: `spin-dinghy` Service manifest
* `spinnaker.yml`: Spinnaker service mapping (provides values to `dinghy.yml` during the Kustomize build)
* `versions` directory: contains version-specific values that Kustomize inserts into the manifest during generation

**kustomization.yml**

1. In the `patchesStrategicMerge` section, 

You can find the files to install the Pipelines-as-Code plugin in the [spinnaker-kustomize-patches repository](https://github.com/armory/spinnaker-kustomize-patches/blob/master/plugins/oss/pipeline-as-a-code/pac-plugin-config.yml).

1. In `pac-plugin-config.yml`, make sure the `version` number is compatible with your Spinnaker instance.

   <details><summary><strong>Show the manifest</strong></summary>
   {{< github repo="armory/spinnaker-kustomize-patches" file="plugins/oss/pipeline-as-a-code/pac-plugin-config.yml" lang="yaml" options="" >}}
   </details><br />

1. Add the plugin directory in the `components` section of your kustomization file. For example:

   ```yaml
   apiVersion: kustomize.config.k8s.io/v1beta1
   kind: Kustomization

   namespace: spinnaker

   components:
	   - core/base
	   - core/persistence/in-cluster
	   - targets/kubernetes/default
     - plugins/oss/pipelines-as-code

   patchesStrategicMerge:
     - core/patches/oss-version.yml

   patches:
     - target:
         kind: SpinnakerService
       path: utilities/switch-to-oss.yml
   ```

1. Apply the manifest using `kubectl`.
