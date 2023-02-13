---
title: Install the Scale Agent Plugin Using a Docker Image
linkTitle: Install Plugin - Docker
weight: 20
description: >
  Learn how to install the Armory Scale Agent plugin using a Docker image. 
---


## Halyard

{{% alert title="Warning" color="warning" %}}
The Scale Agent plugin extends Clouddriver. When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to each service. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. To avoid each service restarting and downloading the plugin, configure the plugin in Clouddriver’s local profile.
{{% /alert %}}

If you don't have a Clouddriver local profile, create one in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

Add the following to `clouddriver.yml`:

@TODO - IS THIS CORRECT??????

```yaml
spinnaker:
  extensibility:
    pluginsRootPath: /opt/clouddriver/lib/plugins
    plugins:
      Armory.Kubesvc:
        enabled: true
    kubernetes:
      enabled: true # This is not needed if spinnaker already has kubernetes V2 accounts enabled by other files
    sql:
      enabled: true # kubesvc depends on clouddriver using SQL. See patch-sql-clouddriver for full configuration
      scheduler:
        enabled: true
    redis:
      enabled: false # kubesvc deprecate the use of redis
      scheduler:
        enabled: false
    kubesvc:
      cluster: kubernetes # Communication between clouddrivers is through direct HTTP requests instead of using the redis pubusb, requires redis.enabled: false
      #cluster-kubernetes:
      #kubeconfigFile: <path-to-file> # (Optional, default: null). If configured, the plugin uses this file to discover Endpoints. If not configured, it uses the service account mounted to the pod.
      #verifySsl: <true|false> # Optional, default: true). Whether to verify the Kubernetes API cert or not.
      #namespace: <string> # (Optional, default: null). If configured, the plugin watches Endpoints in this namespace. If null, it watches endpoints in the namespace indicated in the file "/var/run/secrets/kubernetes.io/serviceaccount/namespace".
      #httpPortName: <string> # (Optional, default: http). Name of the port configured in the Clouddriver Service that forwards traffic to the Clouddriver HTTP port for REST requests.
      #clouddriverServiceNamePrefix: <string> # (Optional, default: spin-clouddriver). Name prefix of the Kubernetes Service pointing to the Clouddriver standard HTTP port.
clouddriver:
  deployment:
    spec:
      template:
        spec:
          initContainers:
            - name: armory-agent-plugin
              image: docker.io/armory/kubesvc-plugin:0.11.31 # must be compatible with your Armory CD version, see https://docs.armory.io/docs/armory-agent/armory-agent-quick/#compatibility-matrix for available versions
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

Save your file and apply your changes by running `hal deploy apply`.


## Armory Operator

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
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
        kubernetes:
          enabled: true # This is not needed if spinnaker already has kubernetes V2 accounts enabled by other files
        sql:
          enabled: true # kubesvc depends on clouddriver using SQL. See patch-sql-clouddriver for full configuration
          scheduler:
            enabled: true
        redis:
          enabled: false # kubesvc deprecate the use of redis
          scheduler:
            enabled: false
        kubesvc:
          cluster: kubernetes # Communication between clouddrivers is through direct HTTP requests instead of using the redis pubusb, requires redis.enabled: false
          #cluster-kubernetes:
            #kubeconfigFile: <path-to-file> # (Optional, default: null). If configured, the plugin uses this file to discover Endpoints. If not configured, it uses the service account mounted to the pod.
            #verifySsl: <true|false> # Optional, default: true). Whether to verify the Kubernetes API cert or not.
            #namespace: <string> # (Optional, default: null). If configured, the plugin watches Endpoints in this namespace. If null, it watches endpoints in the namespace indicated in the file "/var/run/secrets/kubernetes.io/serviceaccount/namespace".
            #httpPortName: <string> # (Optional, default: http). Name of the port configured in the Clouddriver Service that forwards traffic to the Clouddriver HTTP port for REST requests.
            #clouddriverServiceNamePrefix: <string> # (Optional, default: spin-clouddriver). Name prefix of the Kubernetes Service pointing to the Clouddriver standard HTTP port.
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
                    image: docker.io/armory/kubesvc-plugin:<version> # must be compatible with your Armory CD version
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
