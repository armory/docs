---
title: Enable Dynamic Accounts 
linkTitle: Enable Dynamic Accounts
description: >
  Learn how to enable and configure the Dynamic Accounts feature in Armory Scale Agent for Spinnaker and Kubernetes.
---

## {{% heading "prereq" %}}

* You are familiar with [installing the Scale Agent]({{< ref "scale-agent/install" >}}) and the [Dynamic Accounts API]({{< ref "scale-agent/concepts/dynamic-accounts" >}})
* Make sure you have [exposed Clouddriver]({{< ref "scale-agent/install/install-agent-plugin#expose-clouddriver-as-a-loadbalancer" >}}). The Dynamic Accounts API endpoints are not directly accessible, so you call the endpoints using the Clouddriver API.
* The Dynamic Accounts feature uses Clouddriver Account Management, which was introduced in Spinnaker 1.28. Clouddriver Account Management is automatically enabled in Armory Continuous Deployment but not in Spinnaker. See Spinnaker's [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/) page for how to enable the feature in Spinnaker.

## Scale Agent plugin

You need to enable Dynamic Accounts in your plugin config. Add `kubesvc.dynamicAccounts.enabled: true` to the config section of your plugin declaration. For example:

{{< prism lang="yaml" line="27-28" line-numbers="true" >}}
...
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
             interceptor:
               enabled: <true|false>
             scan: <true|false> # (Optional)
             scanBatchSize: <int> # (Optional)
             scanFrequencySeconds: <int> # (Optional)
             namePatterns: ['^account1.*','^.*account2.*'] # (Optional)
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

1. {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}
1. {{< linkWithTitle "scale-agent/reference/dynamic-accounts/_index.md" >}}