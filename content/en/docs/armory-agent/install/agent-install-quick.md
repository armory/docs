---
title: Quick Start Installation
weight: 3
description: >
  Quick start for experienced K8s and Spinnaker<sup>TM</sup> users
---

## Quick start installation

>These quick start options are for experienced Kubernetes and Spinnaker users.

This guide covers how to quickly install the Armory Agent for Kubernetes and connect to an Armory platform.  You can have hundreds or thousands of Kubernetes agents connected to a single Armory platform, whether self-hosted or SaaS.  This deployment is Kubernetes native via YAML files and can be automated for onboarding of new or existing Kubernetes clusters.

## Terms

- `kubesvc`: Armory Agent service source code is called `kubesvc` in the repository. The name of the running agent in Kubernetes is `kubesvc`.
- `kubesvc-plugin`: Armory Agent for Clouddriver plugin is in a r "kubesvc-plugin" in the repository.

## Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## Install the Agent service

You have three quick options for installing the Agent service: Kubernetes manifest, Kustomize template, or Helm chart.

### Kubernetes manifest

1. From the [artifactory](https://armory.jfrog.io/artifactory/manifests/kubesvc/), download the `kubesvc-<version>-kustomize.tar.gz` archive for the Armory Agent compatible with your Spinnaker version.
2. Edit the `kubesvc-<version>.yaml`'s _config.yml_ section. Add the  Kubernetes Service Account for Agent access to the cluster. Ensure the `grpc` Clouddriver URL is correct so the Agent can connect to the Agent plugin.
3. Install the Agent service by executing:

   ```bash
   kubectl -n <namespace> apply -f <path-to-our-kubesvc-manifest>.yaml
   ```

### Kustomize template

With this option you can leverage a `kustomization.yaml` file to build a Kustomize deployment.

1. From the [artifactory](https://armory.jfrog.io/artifactory/manifests/kubesvc/), download the `kubesvc-<version>-kustomize.tar.gz` archive for the Armory Agent compatible with your Spinnaker version.
2. Edit `config.yaml`. Add the Kubernetes Service Account for Agent access to the cluster.
3. Edit `kustomization.yaml`.

   1. Add the namespace in which to install the service (should be the same as where Spinnaker is installed).
   1. Add a `bases` section.
	1. Add or update the `configMapGenerator` section.
	1. Add a `secretGenerator` section if you are using secrets.

	```yaml
   namespace: spinnaker
   bases:
   - https://armory.jfrog.io/artifactory/manifests/kubesvc/kubesvc-<version>-kustomize.tar.gz

   configMapGenerator:
   - name: kubesvc-config
     behavior: merge
     files:
     - patches/kubesvc.yaml

   secretGenerator:
   - name: kubeconfigs-secret
     files:
     # a list of all needed kubeconfigs
     - kubecfgs/kubecfg-account01.yaml  
     - ...
     - kubeconfgs/kubecfg-account1000.yaml
   ```

### Helm chart

Helm templating is also an option for deploying Armory Agent to Kubernetes. In your `kubescv.yml`:

   ```yaml
   kubernetes:
      accounts:
      - kubeconfigFile: /kubeconfigfiles/<your-kubeconfig>.yml
        permissions: {}
        name: account1
        ... # See options further down
   ```

This next section is to add the Clouddriver plugin to Spinnaker.  This will create the gRPC endpoint for all Armory Agents to connect to.  


## Install the Agent plugin

Armory Agent plugin is installed as a container. There is a file for the plugin itself and another for the plugin's configuration. If you don't need to modify those files, simply add the snippet below to your `kustomization.yaml` file, replacing `<version>` with the plugin version you are using. Installing the plugin creates the gPRC endpoint for communication with the Agent service.

   ```yaml
   namespace: spinnaker

   resources:
   - spinsvc.yaml # Spinnaker's configuration

   patchesStrategicMerge:
      - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/clouddriver-plugin-<version>.yaml
      - https://armory.jfrog.io/artifactory/manifests/kubesvc-plugin/kubesvc-plugin-config-<version>.yaml
   ```

## Validate the Agent service and plugin installation

Below are commands and ways you can validate you have a properly running Armory Agent. This is a good reference for troubleshooting.

Agent Validation Commands:

   ```bash
   kubectl -n <namespace> get pods
   kubectl -n <namespace> describe pod -l app.kubernetes.io/name=kubesvc
   kubectl -n <namespace> logs -l app.kubernetes.io/name=kubesvc -n kubesvc | grep connect
   kubectl -n <namespace> logs -f -l app.kubernetes.io/name=kubesvc -n kubesvc | grep connect
   kubectl -n <namespace> get deployment spin-kubesvc -n kubesvc -o yaml
	```

Clouddriver plugin validation commands

   ```bash
   kubectl -n <namespace> logs -l app.kubernetes.io/name=clouddriver
   kubectl -n <namespace> describe pod -l app.kubernetes.io/name=clouddriver
   kubectl -n <namespace> get svc spin-clouddriver
   NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
   spin-clouddriver   ClusterIP   172.20.216.142   <none>        7002/TCP,9091/TCP   89d
	```

>The gRPC port 9091 is opened for Agent Connections as part of plugin installation.

Additional tools for troubleshooting:

* [gRPCurl](https://github.com/fullstorydev/grpcurl) - Test connection to Clouddriver to ensure proper traffic routing and ports are open.  



