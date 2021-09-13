---
title: Armory Agent Configuration
linkTitle: Agent Config
weight: 50
description: >
  Learn how to configure the Armory Agent based on installation mode and environment restrictions. This guide contains a detailed list of configuration options.
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

## Where to configure the Agent

On Kubernetes, configure the Agent using a `ConfigMap`. See the Quickstart's [Configure the Agent]({{< ref "armory-agent-quick#configure-the-agent" >}}) section for an example.

## Configure Kubernetes accounts

You can configure Kubernetes accounts in Armory Enterprise in multiple places:

* Clouddriver configuration files: `clouddriver.yml`, c`louddriver-local.yml`, `spinnaker.yml`, `spinnaker-local.yml`
* Spring Cloud Config Server reading accounts from Git, Vault, or another supported backend
* Plugins

Behavior when reading Kubernetes account configuration from multiple sources:

* When you configure different accounts in Agent and Armory Enterprise, Agent merges both sources.
* If you configure an account with the same name in Agent as well as Armory Enterprise (Clouddriver or Spring Cloud Config Server backends), Agent account configuration always overrides the Armory Enterprise configuration.
* If you configure an account with the same name in Agent as well as in the Clouddriver plugin, the account that is used depends on the order of precedence defined in the plugin's `CredentialsDefinitionSource` interface. The Agent has an order precedence of 1000. Check with your plugin provider for the plugin's order of precedence.
  * If the plugin has a higher precedence than the Agent, the plugin's account is used. For example, if the plugin's precedence is 500, the plugin's account is used.
  * If the plugin has no precedence defined or a lower precedence than the Agent, the account defined in the Agent is used.

### Migrate accounts from Clouddriver to Agent

Copy the account definition from its original source, such as Clouddriver, to Agent's configuration. Depending on how you installed Agent, this configuration could be in the `armory-agent.yml` data section of a `ConfigMap` or in the `armory-agent.yml` file in the Agent pod.

Agent may not use all the properties you copy from the original source definition. Unused properties are ignored.

#### Agent mode

In Agent mode, your configuration should look similar to this:

{{< prism lang="yaml" >}}
kubernetes:
  accounts:
    - name: account-01
      serviceAccount: true
      ...
{{< /prism >}}

#### Spinnaker Service and Infrastructure modes

You set up multiple accounts per Agent in these modes. Your configuration should look similar to this:

{{< prism lang="yaml" >}}
kubernetes:
  accounts:
    - name: account-name-01
      kubeconfigFile: /kubeconfigfiles/kubecfg-account01.yaml
    - name: account-name-02
      kubeconfigFile: /kubeconfigfiles/kubecfg-account02.yaml
    - ...  
{{< /prism >}}

### Migrate accounts from Agent to Clouddriver

Follow these steps to migrate accounts from Agent to Clouddriver:

* Delete the account definition from your Agent configuration. Depending on how you installed Agent, this configuration could be in the `armory-agent.yml` data section of a `ConfigMap` or in the `armory-agent.yml` file in the Agent pod.
* Add the account definition to the source that Clouddriver uses.

## Permissions format

Permissions for the Agent use a format that is slightly different than the format that Clouddriver uses for permissions. Define your permissions like this:

```
kubernetes:
  accounts:
    - name: my-k8s-account
      permissions:
        - READ: ['role1', 'role2']
        - WRITE: ['role3', 'role4']
```


## Restricted environments

### Network access

The Agent needs access to its control plane (Spinnaker) as well to the various Kubernetes clusters it is configured to monitor. You can control which traffic should go through an HTTP proxy via the usual `HTTP_PROXY`, `HTTPS_PROXY`, and `NO_PROXY` environment variables.

A common case is to force the connection back to the control plane via a proxy but bypass it for Kubernetes clusters. In that case, define the environment variable `HTTPS_PROXY=https://my.corporate.proxy` and use the `kubernetes.noProxy: true` setting to not have to maintain the list of Kubernetes hosts in `NO_PROXY`.

### Kubernetes authorization

The Agent should be configured to access each Kubernetes cluster it monitors with a service account. You can limit what Spinnaker can do via the role you assign to that service account. For example, if you'd like Spinnaker to see `NetworkPolicies` but not deploy them:

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: agent-role
rules:
- apiGroups: ["networking.k8s.io"]
  resources: ["networkpolicies"]
  verbs: [ "get", "list", "watch"]
...
```

### Namespace restrictions

You can limit the Agent to monitoring specific namespaces by listing them under `namespaces`. If you need to prevent the Agent from accessing cluster-wide (non-namespaced) resources, use the `onlyNamespacedResources` setting.

A side effect of disabling cluster-wide resources is that [CustomResourceDefinitions](https://kubernetes.io/docs/tasks/extend-kubernetes/custom-resources/custom-resource-definitions/) won't be known (and therefore deployable by Spinnaker). `CustomResourceDefinitions` are cluster-wide resources, but the custom resources themselves may be namespaced. To workaround the limitation, you can define `customResourceDefinitions`. Both namespaces and CRDs are sent to Spinnaker as "synthetic" resources. They won't be queried or watched, but Spinnaker knows about their existence.

```yaml
kubernetes:
    accounts:
        - name: production
          ...
          # Restricts the agent to namespaces `ns1` and `ns2`
          namespaces:
            - ns1
            - ns2
          # Prevents the Agent from querying non-namespaced resources
          onlyNamespacedResources: true
          # Whitelist CRDs so Spinnaker
          customResourceDefinitions:
            - kind: ServiceMonitor.monitoring.coreos.com
            - kind: SpinnakerService.spinnaker.armory.io

```

## Configuration options

{{% csv-table "|" "/static/csv/agent/agent-config-options.csv" %}}
