---
title: Enable Policy Engine Plugin in Armory Enterprise
linkTitle: Enable Policy Engine Plugin
description: "Enable the Policy Engine Plugin and connect it to your OPA server. When enabled, you can write policies that the Policy Engine enforces during save time, runtime validation, or when a user interacts with Armory Enterprise.."
---

## Before you start

Make sure the following requirements are met:

* If you are [migrating from the Policy Engine Extension]({{< ref "policy-engine-enable#migrating-to-the-policy-engine-plugin" >}}), make sure you have turned off the extension. 
* You have an OPA server available. For more information, see [Deploy an OPA server]({{< ref "policy-engine-enable#deploy-an-opa-server" >}}). 
* Access to the internet to download the plugin.

## Setup

The Policy Engine Plugin can be enabled using one of the following methods:

1. Docker image as an init container on each affected service

1. Using a remote plugin repository

### Docker image as init container

{{< tabs name="enable-plugin" >}}
{{% tab name="Operator" %}}

You can use the sample configuration to install the plugin, but keep the following in mind:

- The `patchesStrategicMerge` section for each service is unique. Do not reuse the snippet from one service for the other services.

- Make sure to replace `<PLUGIN_VERSION>` with the version of the plugin you want to use without the `v` prefix. For a list of versions, see [Release notes](#release-notes).

- This configuration must go into `spinnakerservice.yml`. It cannot be patched in through Kustomize.


<details><summary>Show the manifest</summary>

```yaml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      # Configs in the spinnaker profile get applied to all services
      spinnaker:
        armory:
          policyEngine:
            opa:
              # Replace with the actual URL to your Open Policy Agent deployment
              baseUrl: https://opa.url:8181/v1/data
              # Optional. The number of seconds that the Policy Engine will wait for a response from the OPA server. Default is 10 seconds if omitted.
              # timeoutSeconds: <integer> 
        spinnaker:
          extensibility:
            repositories:
              policyEngine:
                enabled: true
                # The init container will install plugins.json to this path.
                url: file:///opt/spinnaker/lib/local-plugins/policy-engine/plugins.json
      gate:
        spinnaker:
          extensibility:
            plugins:
              Armory.PolicyEngine:
                enabled: true
            deck-proxy:
              enabled: true
              plugins:
                Armory.PolicyEngine:
                  enabled: true
                  version: <PLUGIN_VERSION>

      orca:
        spinnaker:
          extensibility:
            plugins:
              Armory.PolicyEngine:
                enabled: true

      front50:
        spinnaker:
          extensibility:
            plugins:
              Armory.PolicyEngine:
                enabled: true

      clouddriver:
        spinnaker:
          extensibility:
            plugins:
              Armory.PolicyEngine:
                enabled: true
  kustomize:
    front50:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                    - name: policy-engine-install
                      image: armory/policy-engine-plugin:<PLUGIN_VERSION>
                      imagePullPolicy: Always
                      args:
                        - -install-path
                        - /opt/policy-engine-plugin/target
                      volumeMounts:
                        - mountPath: /opt/policy-engine-plugin/target
                          name: policy-engine-plugin-vol
                  containers:
                    - name: front50
                      volumeMounts:
                        - mountPath: /opt/spinnaker/lib/local-plugins
                          name: policy-engine-plugin-vol
                  volumes:
                    - name: policy-engine-plugin-vol
                      emptyDir: {}
    orca:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                    - name: policy-engine-install
                      image: armory/policy-engine-plugin:<PLUGIN_VERSION>
                      imagePullPolicy: Always
                      args:
                        - -install-path
                        - /opt/policy-engine-plugin/target
                      volumeMounts:
                        - mountPath: /opt/policy-engine-plugin/target
                          name: policy-engine-plugin-vol
                  containers:
                    - name: orca
                      volumeMounts:
                        - mountPath: /opt/spinnaker/lib/local-plugins
                          name: policy-engine-plugin-vol
                  volumes:
                    - name: policy-engine-plugin-vol
                      emptyDir: {}
    gate:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                    - name: policy-engine-install
                      image: armory/policy-engine-plugin:<PLUGIN_VERSION>
                      imagePullPolicy: Always
                      args:
                        - -install-path
                        - /opt/policy-engine-plugin/target
                      volumeMounts:
                        - mountPath: /opt/policy-engine-plugin/target
                          name: policy-engine-plugin-vol
                  containers:
                    - name: gate
                      volumeMounts:
                        - mountPath: /opt/spinnaker/lib/local-plugins
                          name: policy-engine-plugin-vol
                  volumes:
                    - name: policy-engine-plugin-vol
                      emptyDir: {}
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                    - name: policy-engine-install
                      image: armory/policy-engine-plugin:<PLUGIN_VERSION>
                      imagePullPolicy: Always
                      args:
                        - -install-path
                        - /opt/policy-engine-plugin/target
                      volumeMounts:
                        - mountPath: /opt/policy-engine-plugin/target
                          name: policy-engine-plugin-vol
                  containers:
                    - name: clouddriver
                      volumeMounts:
                        - mountPath: /opt/spinnaker/lib/local-plugins
                          name: policy-engine-plugin-vol
                  volumes:
                    - name: policy-engine-plugin-vol
                      emptyDir: {}
```

### Optional settings
#### Timeout settings

You can configure the amount of time that the Policy Engine waits for a response from your OPA server. If you have network or latency issues, increasing the timeout can make Policy Engine more resilient. Use the following config to set the timeout in seconds:  `spec.spinnakerConfig.profiles.spinnaker.armory.policyEngine.opa.timeoutSeconds`. The default timeout is 10 seconds if you omit the config.

</details>

{{% /tab %}}

{{% tab name="Halyard" %}}

1. Add the following to `profiles/spinnaker-local.yml`:

   ```yaml
   armory:
     policyEngine:
       opa:
         # Replace with the  URL to your OPA deployment   
         baseUrl: http://opa.server:8181/v1/data
   spinnaker:
     extensibility:
       repositories:
         policyEngine:
           enabled: true
           url: file:///opt/spinnaker/lib/local-plugins/policy-engine/plugins.json
   ```

1. For each service you want to enable the plugin for, add the following snippet to its local profile. For example, add it to the file `profiles/gate-local.yml` for Gate.

   ```yaml
   spinnaker:
     extensibility:
       plugins:
           Armory.PolicyEngine:
               enabled: true
   ```

1. Add the following to `service-settings/gate.yml`, `service-settings/orca.yml`, `service-settings/clouddriver.yml` and `service-settings/front50.yml`:

   ```yaml
   kubernetes:
     volumes:
     - id: policy-engine-install
       type: emptyDir
       mountPath: /opt/spinnaker/lib/local-plugins
   ```

1. Configure Halyard by updating your `.hal/config` file. Use the following snippet and replace `<PLUGIN VERSION>` with the [plugin version](#release-notes) you want to use without the `v` prefix: 

   ```yaml
   deploymentConfigurations:
     - name: default
       deploymentEnvironment:
         initContainers:
           front50:
             - name: policy-engine-install
               image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
               args:
                 - -install-path
                 - /opt/policy-engine-plugin/target
               volumeMounts:
                 - mountPath: /opt/policy-engine-plugin/target
                   name: policy-engine-install
           clouddriver:
             - name: policy-engine-install
               image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
               args:
                 - -install-path
                 - /opt/policy-engine-plugin/target
               volumeMounts:
                 - mountPath: /opt/policy-engine-plugin/target
                   name: policy-engine-install
           gate:
             - name: policy-engine-install
               image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
               args:
                 - -install-path
                 - /opt/policy-engine-plugin/target
               volumeMounts:
                 - mountPath: /opt/policy-engine-plugin/target
                   name: policy-engine-install
           orca:
             - name: policy-engine-install
               image: docker.io/armory/policy-engine-plugin:<PLUGIN VERSION>
               args:
                 - -install-path
                 - /opt/policy-engine-plugin/target
               volumeMounts:
                 - mountPath: /opt/policy-engine-plugin/target
                   name: policy-engine-install
   ```

{{% /tab %}}
{{< /tabs >}}

### Remote plugin repository

The configuration is mostly identical to the Docker image method but omits all volumes and init container configurations. Additionally, replace all occurrences of the following:

```yaml
url: file:///opt/spinnaker/lib/local-plugins/policy-engine/plugins.json
```

with:

```yaml
url: https://raw.githubusercontent.com/armory-plugins/policy-engine-releases/master/repositories.json
```

If you do not omit the `volume` and `initContainers` configurations for the `patchesStrategicMerge` section, the pods for Armory may not start.

### Finish the setup

Once Policy Engine is enabled, you must authorize API calls in order to use the Armory (or OSS Spinnaker) UI. To do this, you need to load a policy into the Policy Engine that is similar to the following:  

```rego
package spinnaker.http.authz
default allow = true
allow {
    input.user.isAdmin == true
}
```

This basic policy allows all API calls. For information about constructing a more restrictive policy, see [API authorization](#api-authorization).

For information about loading a policy, see [Using the Policy Engine]({{< ref "policy-engine-use#step-2-add-policies-to-opa" >}}).
