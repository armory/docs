---
title: Enable and Configure Dynamic Accounts in the Armory Scale Agent
linkTitle: Enable Dynamic Accounts
description: >
  Learn how to enable and configure the Dynamic Accounts feature in Armory Scale Agent for Spinnaker and Kubernetes.
---

## {{% heading "prereq" %}}

* You are familiar with {{< linkWithTitle "plugins/scale-agent/concepts/dynamic-accounts" >}}.
* The following Dynamic Accounts features use Clouddriver Account Management:

   * Automatic account migration
   * Clouddriver Account Management API request interception

   Clouddriver Account Management is not enabled by default in Spinnaker or Armory Continuous Deployment. See Spinnaker's [Clouddriver Account Management](https://spinnaker.io/docs/setup/other_config/accounts/) page for how to enable the feature.

## Scale Agent plugin

>Dynamic Accounts is enabled by default starting with plugin versions v0.11.21/0.10.69/0.9.85.

If you are using a prior version of the plugin, you should enable Dynamic Accounts by setting `kubesvc.dynamicAccounts.enabled: true` in your plugin configuration. For example:

{{< highlight bash "linenos=table,hl_lines=27-28">}}
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
             maxRetries: <int>
             retryFrequencySeconds: <int>
             interceptor: # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
               enabled: <true|false>
             scanBatchSize: <int> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
             scanFrequencySeconds: <int> # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
             namePatterns: ['^account1.*','^.*account2.*'] # (Optional) # requires Clouddriver Account Management be enabled in Spinnaker/Armory Continuous Deployment
{{< /highlight >}}

`dynamicAccounts`:

* **enabled**: (Optional) default: false; set to `true` to enable the Dynamic Accounts feature
* **maxRetries**: (Optional) default: 3; the number of times to retry adding an account that fails the first time
* **retryFrequencySeconds**: (Optional) default: 5; the number of seconds to wait between trying to add a FAILED account

The remaining optional attributes in the `dynamicAccounts` section are for configuring automatic migration of Clouddriver accounts to the Scale Agent. These options are discussed in detail in {{< linkWithTitle "plugins/scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}.

If you want to use the [interceptor]({{< ref "plugins/scale-agent/concepts/dynamic-accounts#intercept-clouddriver-account-management-api-requests" >}}) feature to intercept requests sent to Clouddriver's `/credentials` endpoint, add:

```yaml
dynamicAccounts:
   enabled: true
   interceptor:
      enabled: true
```

Alternately, you can enable the [autoscan for new Clouddriver accounts]({{< ref "plugins/scale-agent/concepts/dynamic-accounts#migrate-accounts-using-automatic-scanning" >}}) feature by configuring the following:

* `scanBatchSize`: <int>
* `scanFrequencySeconds`: <int>
* `namePatterns`: ['^account1.*','^.*account2.*']

For example:

{{< highlight bash "linenos=table,hl_lines=3-5">}}
dynamicAccounts:
   enabled: true
   scanBatchSize: 15
   scanFrequencySeconds: 120
   namePatterns: ['^account1.*','^.*account2.*']
{{< /highlight >}}

### Access the API

{{< include "plugins/scale-agent/api-overview" >}}

## Scale Agent service

The Dynamic Accounts API is enabled by default in the Scale Agent Service:

{{< highlight bash "linenos=table,hl_lines=10">}}
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
{{< /highlight >}}

You can disable dynamic accounts features by setting `dynamicAccountsEnabled` to `false`.

## {{% heading "nextSteps" %}}

1. {{< linkWithTitle "plugins/scale-agent/tasks/dynamic-accounts/migrate-accounts.md" >}}
1. {{< linkWithTitle "plugins/scale-agent/tasks/dynamic-accounts/manage-accounts.md" >}}