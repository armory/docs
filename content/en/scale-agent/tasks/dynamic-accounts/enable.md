---
title: Enable Dynamic Accounts 
linkTitle: Enable Dynamic Accounts
description: >
  Learn how to enable and configure the Dynamic Accounts feature in Armory Scale Agent for Spinnaker and Kubernetes.
---

## {{% heading "prereq" %}}

* You are familiar with [installing the Scale Agent]({{< ref "scale-agent/install" >}}) and the [Dynamic Accounts feature]({{< ref "scale-agent/concepts/dynamic-accounts" >}})
* Make sure you have [exposed Clouddriver]({{< ref "scale-agent/install/install-agent-plugin#expose-clouddriver-as-a-loadbalancer" >}}). The Dynamic Accounts API endpoints are not directly accessible, so you call the endpoints using the Clouddriver API.
* The Dynamic Accounts automatic migration feature uses Clouddriver Account Management, which is not enabled by default in Spinnaker or Armory Continuous Deployment. See Spinnaker's [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/) page for how to enable the feature in Spinnaker.

## Scale Agent plugin

You need to enable Dynamic Accounts in your plugin config. Add `kubesvc.dynamicAccounts` to the config section of your plugin declaration. For example:

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
             interceptor: # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
               enabled: <true|false>
             scan: <true|false> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
             scanBatchSize: <int> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
             scanFrequencySeconds: <int> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
             namePatterns: ['^account1.*','^.*account2.*'] # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
{{< /prism >}}

`dynamicAccounts`:

* enabled: true # (Optional; default: false)
* interceptor: # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
  enabled: <true|false>
* scan: <true|false> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
* scanBatchSize: <int> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
* scanFrequencySeconds: <int> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
* namePatterns: ['^account1.*','^.*account2.*'] # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment

## Scale Agent service

The Dynamic Accounts API is enabled by default in the Scale Agent Service:

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
  dynamicAccountsEnabled: true # (Optional; default: true)
{{< /prism >}}

You can disable dynamic accounts features by setting `dynamicAccountsEnabled` to `false`.

## {{% heading "nextSteps" %}}

1. {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}
1. {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/manage-accounts.md" >}}