---
title: "Install the Armory Agent Plugin Using kubectl"
linkTitle: "Install Plugin - kubectl"
description: >
  Install the Armory Agent Clouddriver plugin using kubectl in your Kubernetes and Spinnaker or Armory CD environments.
weight: 30
---

## {{% heading "prereq" %}}

* Make sure you have read the Installation [overview]({{< ref "scale-agent" >}}).

## Create the plugin manifest

Create a new `armory-agent` directory in your Kustomize patches directory. Add the following `agent-config.yaml` manifest to your new `armory-agent` directory.

* Change the value for `name` if your Armory CD service is called something other than "spinnaker".
* Update the `agent-kube-spinplug` value to the Armory Agent Plugin Version that is compatible with your Armory CD version. See the [compatibility matrix]({{< ref "scale-agent/install#compatibility-matrix" >}}).

{{< tabs name="DeploymentPlugin" >}}
{{% tabbody name="Quickstart with remote plugin repo" %}}

```yaml
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
            repositories:
              armory-agent-k8s-spinplug-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-io/agent-k8s-spinplug-releases/master/repositories.json
            plugins:
              Armory.Kubesvc:
                enabled: true
                version: {{<param kubesvc-plugin.agent_plug_latest>}} # check compatibility matrix for your Armory CD version
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

{{% /tabbody %}}
{{% tabbody name="Cacheable using a init container" %}}

```yaml
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
          cluster: kubernetes
          cluster-kubernetes:
            kubeconfigFile: <path-to-file> # (Optional, default: null). If configured, the plugin uses this file to discover Endpoints. If not configured, it uses the service account mounted to the pod.
            verifySsl: <true|false> # Optional, default: true). Whether to verify the Kubernetes API cert or not.
            namespace: <string> # (Optional, default: null). If configured, the plugin watches Endpoints in this namespace. If null, it watches endpoints in the namespace indicated in the file "/var/run/secrets/kubernetes.io/serviceaccount/namespace".
            httpPortName: <string> # (Optional, default: http). Name of the port configured in the Clouddriver Service that forwards traffic to the Clouddriver HTTP port for REST requests.
            clouddriverServiceNamePrefix: <string> # (Optional, default: spin-clouddriver). Name prefix of the Kubernetes Service pointing to the Clouddriver standard HTTP port.
  kustomize:
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: armory-agent-plugin
                    image: docker.io/armory/kubesvc-plugin:{{<param kubesvc-plugin.agent_plug_latest>}} # must be compatible with your Armory CD version
                    volumeMounts:
                      - mountPath: /opt/plugin/target
                        name: armory-agent-plugin-vol
                  containers:
                  - name: clouddriver
                    volumeMounts:
                      - mountPath: /opt/clouddriver/lib/plugins
                        name: armory-agent-plugin-vol
                  volumes:
                  - name: armory-agent-plugin-vol
                    emptyDir: {}
```

{{% /tabbody %}}
{{< /tabs >}}


Then include the file under the `patchesStrategicMerge` section of your `kustomization` file.

{{< prism lang="yaml" line="4" >}}
bases:
  - agent-service
patchesStrategicMerge:
  - armory-agent/agent-config.yaml
{{< /prism >}}

## Expose Clouddriver as a LoadBalancer

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

## Apply the manifests

After you have configured both manifests, apply the updates.

## Get the LoadBalancer IP address

Use `kubectl get svc spin-agent-cloud-driver -n spinnaker` to make note of the LoadBalancer IP external address. You need this address when you configure the Armory Agent.

## Confirm Clouddriver is listening

Use `netcat` to confirm Clouddriver is listening on port 9091 by executing `nc -zv [LB address] 9091`. Perform this check from a node in your
Armory CD cluster and one in your target cluster.


## {{% heading "nextSteps" %}}

Install the Armory Agent service [using a Helm chart]({{< ref "install-agent-service-helm" >}}) or [using `kubectl`]({{< ref "install-agent-service-kubectl" >}}).
</br>
</br>
