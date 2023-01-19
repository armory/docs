---
title: Enable the Dynamic Accounts API
linkTitle: Enable Dynamic Accounts
description: >
  Learn how to enable and disable the Dynamic Accounts API in Armory Scale Agent for Spinnaker and Kubernetes.
---

## {{% heading "prereq" %}}

* You are familiar with [installing the Scale Agent]({{< ref "scale-agent/install" >}}) and the [Dynamic Accounts API]({{< ref "scale-agent/concepts/dynamic-accounts" >}})
* Make sure you have [exposed Clouddriver]({{< ref "scale-agent/install/install-agent-plugin#expose-clouddriver-as-a-loadbalancer>}}). The Dynamic Accounts API endpoints are not directly accessible, so you call the endpoints using the Clouddriver API.

## Scale Agent plugin

The Dynamic Accounts API can be enabled or disabled using the `kubesvc.dynamicAccounts.enable` variable in the plugin config. For example:

{{< prism lang="yaml" line="31-32" line-numbers="true" >}}
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
            repositories:
              armory-agent-k8s-spinplug-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-io/agent-k8s-spinplug-releases/master/repositories.json
            plugins:
              Armory.Kubesvc:
                enabled: true
                version: 0.11.26  # Replace with a version compatible with your Armory CD version
                extensions:
                  armory.kubesvc:
                    enabled: true
        # Plugin config
        kubesvc:  
          cluster: kubernetes
          cluster-kubernetes:
            kubeconfigFile: <path-to-file> # (Optional; default: null) 
            verifySsl: <true|false> # Optional; default: true) 
            namespace: <string> # (Optional; default: null) 
            httpPortName: <string> # (Optional; default: http)
            clouddriverServiceNamePrefix: <string> # (Optional; default: spin-clouddriver)
         	dynamicAccounts:
             enabled: true # (Optional; default: false)
{{< /prism >}}

## Scale Agent service

The Dynamic Accounts API is enabled by default in the Scale Agent Service. If you want to disable it, add the `dynamicAccountsEnabled` variable to your `armory-agent` config. For example:

{{< prism lang="yaml" line=10" line-numbers="true" >}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: armory-agent-config
  namespace: spin-agent
data:
  armory-agent.yml: |  
  server:
    port: 8082
  dynamicAccountsEnabled: false # (Optional; default: true)
{{< /prism >}}

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}
* {{< linkWithTitle "scale-agent/reference/dynamic-accounts/_index.md" >}}