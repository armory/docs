---
title: Enable Dynamic Accounts 
linkTitle: Enable Dynamic Accounts
description: >
  Learn how to enable and configure the Dynamic Accounts feature in Armory Scale Agent for Spinnaker and Kubernetes.
---

## {{% heading "prereq" %}}

* You are familiar with [installing the Scale Agent]({{< ref "scale-agent/install" >}}) and the [Dynamic Accounts feature]({{< ref "scale-agent/concepts/dynamic-accounts" >}})
* The Dynamic Accounts automatic migration feature uses Clouddriver Account Management, which is not enabled by default in Spinnaker or Armory Continuous Deployment. See Spinnaker's [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/) page for how to enable the feature in Spinnaker.

## Scale Agent plugin

You need to enable Dynamic Accounts in your plugin config. Add `kubesvc.dynamicAccounts` to the config section of your plugin declaration. For example:

{{< prism lang="yaml" line="27-28" >}}
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
             enabled: <true|false>
             interceptor: # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
               enabled: <true|false>
             scanBatchSize: <int> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
             scanFrequencySeconds: <int> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
             namePatterns: ['^account1.*','^.*account2.*'] # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
{{< /prism >}}

`dynamicAccounts`:

* **enabled**: (Optional) default: false; set to `true` to enable the Dynamic Accounts feature

The remaining optional attributes in the `dynamicAccounts` section are for configuring automatic migration of Clouddriver accounts to the Scale Agent. These options are discussed in detail in {{< linkWithTitle "scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}.

If you want to use the [interceptor]({{< ref "scale-agent/tasks/dynamic-accounts/migrate-accounts#intercept-clouddriver-account-creation-request" >}}) feature to intercept account creation requests sent to Clouddriver's `/credentials` endpoint, add:

{{< prism lang="yaml" line="3-4" >}}
dynamicAccounts:
   enabled: true
   interceptor:
      enabled: true
{{< /prism >}}

Alternately, you can enable the [autoscan for new Clouddriver accounts]({{< ref "scale-agent/tasks/dynamic-accounts/migrate-accounts#scan-for-new-accounts" >}}) feature by configuring the following:

* `scanBatchSize`: <int> 
* `scanFrequencySeconds`: <int> 
* `namePatterns`: ['^account1.*','^.*account2.*'] 

For example:

{{< prism lang="yaml" line="3-5" >}}
dynamicAccounts:
   enabled: true
   scanBatchSize: 15
   scanFrequencySeconds: 120
   namePatterns: ['^account1.*','^.*account2.*'] 
{{< /prism >}}

### Access the API

{{< include "scale-agent/api-overview" >}}

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