---
title: "Armory Agent for Kubernetes Installation"
linkTitle: "Installation"
description: >
  Learn how to install the Armory Agent in your Kubernetes and Armory Enterprise environments.
weight: 30
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

>This installation guide is designed for installing the Agent in a test environment. It does not include [mTLS configuration]({{< ref "agent-mtls" >}}), so the Agent service and plugin do not communicate securely.

## {{% heading "prereq" %}}

* You deployed Armory Enterprise using the [Armory Operator and Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have configured Clouddriver to use MySQL or PostgreSQL. See the {{< linkWithTitle "clouddriver-sql-configure.md" >}} guide for instructions. The Agent plugin uses the SQL database to store cache data.
* You have a running Redis instance. The Agent plugin uses Redis to coordinate between Clouddriver replicas. Note: you need Redis even if you only have one Clouddriver instance.
* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).
* If you are running multiple Clouddriver instances, you have a running Redis instance. The Agent uses Redis to coordinate between Clouddriver replicas.
* You have an additional Kubernetes cluster to serve as your deployment target cluster.

### Networking requirements

Communication from the Agent service to the Clouddriver plugin occurs over gRPC port 9091. Communication between the service and the plugin must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between the Agent service and Clouddriver plugin.  

### Compatibility matrix

{{< include "agent/agent-compat-matrix.md" >}}

## Installation overview

In this guide, you deploy the Agent service to your target cluster.

Installation steps:

1. [Install the Clouddriver plugin](#install-the-clouddriver-plugin). You do this in the cluster where you are running Armory Enterprise.

   1. [Create the plugin manifest as a Kustomize patch](#create-the-plugin-manifest).
   1. [Create a LoadBalancer service Kustomize patch](#expose-clouddriver-as-a-loadbalancer) to expose the plugin on gRPC port `9091`.
   1. [Apply the manifests](#apply-the-manifests).

1. [Install the Agent service](#install-the-agent-service) in the deployment target cluster.

## Install the Clouddriver plugin

### Create the plugin manifest

Create a new `armory-agent` directory in your Kustomize patches directory. Add the following `agent-config.yaml` manifest to your new `armory-agent` directory.

* Change the value for `name` if your Armory Enterprise service is called something other than "spinnaker".
* Update the `kubesvc-plugin` value to the Armory Agent Plugin Version that is compatible with your Armory Enterprise version. See the [compatibility matrix](#compatibility-matrix).

{{< prism lang="yaml" line="4, 39" >}}
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version">}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            pluginsRootPath: /opt/clouddriver/lib/plugins
            plugins:
              Armory.Kubesvc:
                enabled: true
        # Plugin config
        kubesvc:
          cluster: redis
#          eventsCleanupFrequencySeconds: 7200
#          localShortCircuit: false
#          runtime:
#            defaults:
#              onlySpinnakerManaged: true
#            accounts:
#              account1:
#                customResources:
#                  - kubernetesKind: MyKind.mygroup.acme
#                    versioned: true
#                    deployPriority: "400"
  kustomize:
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: kubesvc-plugin
                    image: docker.io/armory/kubesvc-plugin:<version> # must be compatible with your Armory Enterprise version
                    volumeMounts:
                      - mountPath: /opt/plugin/target
                        name: kubesvc-plugin-vol
                  containers:
                  - name: clouddriver
                    volumeMounts:
                      - mountPath: /opt/clouddriver/lib/plugins
                        name: kubesvc-plugin-vol
                  volumes:
                  - name: kubesvc-plugin-vol
                    emptyDir: {}
{{< /prism >}}

Then include the file under the `patchesStrategicMerge` section of your `kustomization` file.

{{< prism lang="yaml" line="4" >}}
bases:
  - agent-service
patchesStrategicMerge:
  - armory-agent/agent-config.yaml
{{< /prism >}}

### Expose Clouddriver as a LoadBalancer

To expose Clouddriver as a Kubernetes-type LoadBalancer, add the following manifest to your Kustomize directory. Then include the file in the `resources` section of your `kustomization` file.

>Various cloud providers may require additional annotations for LoadBalancer. Consult your cloud provider's documentation.

{{< prism lang="yaml" >}}
# This LoadBalancer service exposes the gRPC port on Clouddriver for the remote Agents to connect to
# Look for the LoadBalancer service IP address that is exposed on 9091
apiVersion: v1
kind: Service
metadata:
  labels:
  name: spin-agent-clouddriver
spec:
  ports:
    - name: grpc
      port: 9091
      protocol: TCP
      targetPort: 9091
  selector:
    app: spin
    cluster: spin-clouddriver
  type: LoadBalancer
{{< /prism >}}

### Apply the manifests

After you have configured both manifests, apply the updates.

### Get the LoadBalancer IP address

Use `kubectl get svc spin-agent-cloud-driver -n spinnaker` to make note of the LoadBalancer IP external address. You need this address when you configure the Agent.

### Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your
Armory Enterprise cluster and one in your target cluster.

## Install the Agent service

On the Kubernetes cluster where you want to install the Agent Service, perform the following steps:

1. Add the Armory charts repo:

   ```bash
   helm repo add armory-charts http://armory.jfrog.io/artifactory/charts
   ```
2. Create a namespace in the Kubernetes cluster where you are installing the Agent Service. This is the same cluster as the deployment target for your app for Agent mode.
   
   ```bash
   kubectl create namespace <agent-namespace>
   ```

   > If you plan to run the Agent in something other than Agent mode, such as Infrastructure mode, you need to create a kubeconfig file that grants access to the deployment target cluster. For example, run the following command if you use Amazon EKS: `aws eks update-kubeconfig --name <target-cluster> `.

3. Run one of the following Helm commands:

   **Install with default configs in Agent mode:**

   ```bash
   helm install armory-agent  \
   --set mode=agent \
   --set cloudEnabled=false \ # Required if you do not have a clientID and secret and do not want to use Armory Cloud services. Omit this if you are providing a clientId and secret.   
   --set grpcUrl=localhost:9090 \ # Required if you do not have a clientID and secret and do not want to use Armory Cloud services. Omit this if you are providing a clientId and secret.
   # --set clientId=<your-clientId> # Required if you want to use Armory Cloud services. Client ID provided by Armory. 
   # --set secret=<your-Armory-Cloud-secret> # Required if you want to use Armory Cloud services. Secret to access Armory Cloud services. 
   # --set kubernetes=<kubernetes-options> # Optional 
   --namespace=<agent-namespace> # Namespace where you want to install the Agent.
   ```

   For information about the Kubernetes options, see the [Agent config options for the kubernetes parameter]({{< ref "agent-options#configuration-options" >}}).

   **Install with default configs in Infrastructure mode:**

   ```bash
   helm install armory-agent \
   --set cloudEnabled=false \ # Required if you do not have a clientID and secret and do not want to use Armory Cloud services. Omit this if you are providing a clientId and secret.   
   --set grpcUrl=localhost:9090 \ # Required if you do not have a clientID and secret and do not want to use Armory Cloud services. Omit this if you are providing a clientId and secret.
   # --set clientId=<your-clientId> # Required if you want to use Armory Cloud services. Client ID provided by Armory. 
   # --set secret=<your-Armory-Cloud-secret> # Required if you want to use Armory Cloud services. Secret to access Armory Cloud services. 
   --namespace=<agent-namespace> # Namespace where you want to install the Agent.
   ```

   For information about the Kubernetes options, see the [Agent config options for the kubernetes parameter]({{< ref "agent-options#configuration-options" >}}).


   **Install with custom settings:**

   1. Use `helm template` to generate a manifest. 
      ```bash
      helm template armory-agent armory-charts/kubesvc-beta \
      --set-file kubeconfig=<path-to-your-kubeconfig>,armoryagentyml=<path-to-agent-options>.yml \ 
      --namespace=<agent-namespace> # Namespace where you want to install the Agent.
      ```
   
      For `armoryagentyml`, create the file and customize it to meet your needs. For information about the options, see the [Agent config options]({{< ref "agent-options#configuration-options" >}}).
    1. Install the helm chart using your template:
   
       ```bash
       helm install armory-agent <local-helm-chart-name>
       ```

## Confirm success

Create a pipeline with a `Deploy manifest` stage. You should see your target cluster available in the `Accounts` list. Deploy a static manifest.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "agent-troubleshooting.md" >}} page if you run into issues.
* Learn how to {{< linkWithTitle "agent-monitoring.md" >}}. Agent CPU usage is low, but the amount of memory depends on the size of the cluster the Agent is monitoring. The gRPC buffer consumes about 4MB of memory.
* {{< linkWithTitle "agent-mtls.md" >}}
* Read about {{< linkWithTitle "agent-permissions.md" >}}
