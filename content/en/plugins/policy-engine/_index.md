---
title: Armory Policy Engine Plugin for Spinnaker or Armory Continuous Deployment
linkTitle: Policy Engine
description: >
   The Policy Engine enforces save time, runtime, and user interaction policies that you create for Spinnaker or Armory Continuous Deployment. This section includes instructions for configuring and deploying an Open Policy Agent server and the Policy Engine as well as release notes, usage, and example policies.
no_list: true
aliases:
   - /continuous-deployment/armory-admin/policy-engine/
   - /continuous-deployment/armory-admin/policy-engine/policy-engine-enable/
   - /continuous-deployment/armory-admin/policy-engine/policy-engine-enable/policy-engine-plug-enable/
   - /continuous-deployment/armory-admin/policy-engine/policy-engine-enable/policy-engine-ext-enable/
---

![Proprietary](/images/proprietary.svg)

## Overview of the Armory Policy Engine

The [Armory Policy Engine](https://www.armory.io/products/policy-engine/) is a proprietary feature for Armory Continuous Deployment and open source Spinnaker. It is designed to enable more complete control of your software delivery process by providing you with the hooks necessary to make assertions about the structure and behavior of pipelines and processes in your environment. The Policy Engine uses the [Open Policy Agent](https://www.openpolicyagent.org/) (OPA) and input style documents to perform validations on the following:

* **Save time validation** - Validate pipelines as they're created or modified. Tasks with no policies are not validated.
* **Runtime validation** - Validate deployments as a pipeline is executing. Tasks with no policies are not validated.
* **Entitlements using API Authorization** - Enforce restrictions on who can perform certain actions. Note that if you enable policies for API authorization, you must configure who can make API calls or else the API service (Gate) rejects all API calls.

>If no policies are configured for these policy checks, all actions are allowed.

At a high level, adding policies for the Policy Engine to use is a two-step process:

1. Create the policies and save them to a `.rego` file.
2. Add the policies to the OPA server with a ConfigMap or API request.

These policies are evaluated against the packages that Armory Continuous Deployment sends between its services. For a list of packages that you can write policies against, see {{< linkWithTitle "plugins/policy-engine/use/packages/_index.md" >}}. 

Enabling the Policy Engine consists of the following steps:

1. [Deploy an OPA server](#deploy-an-opa-server)
1. [Enable the Policy Engine plugin](#enable-the-policy-engine-plugin)

## {{% heading "prereq" %}}

* The Policy Engine requires an [Open Policy Agent (OPA)](https://www.openpolicyagent.org/) server, version 0.12.x or later. You can use the example on this page to deploy a server in the same Kubernetes cluster as Armory Continuous Deployment. Alternately, see the OPA documentation for information about how to [deploy an OPA server](https://www.openpolicyagent.org/docs/latest/deployments/). Specifically, the OPA v1 API must be available.
* You have identified the Policy Engine plugin that is compatible with your version of Armory Continuous Deployment or Spinnaker. See the [Supported versions](#supported-versions) section.
* If you are using Spinnaker, you are familiar with [installing and using plugins](https://spinnaker.io/docs/guides/user/plugins-users/) in Spinnaker.

### Supported versions

{{< include "policy-engine/plugin-compat-matrix.md" >}}

## Deploy an OPA server

The Policy Engine supports the following OPA server deployments:

* An OPA server deployed in the same Kubernetes cluster as an Armory CD or Spinnaker deployment. The [Use ConfigMaps for Open Policy Agent policies](#use-configmaps-for-open-policy-agent-policies) section contains a ConfigMap you can use.
* An OPA cluster that is **not** in the same Kubernetes cluster as an Armory CD or Spinnaker deployment. See the [OPA documentation](https://www.openpolicyagent.org/docs/latest/) for more information about installing an OPA server in a separate cluster.

### Use ConfigMaps for Open Policy Agent policies

If you want to use ConfigMaps for OPA policies, you can use the following manifest as a starting point. This example manifest deploys an OPA server and applies the configuration for things like RoleBinding and a static DNS. When using the example, keep the following guidelines in mind:

* The manifest does not configure any authorization requirements for the OPA server it deploys. This means that anyone can add a policy.
* The manifest deploys the OPA server to a namespace called `opa`.
* The OPA server uses `"--require-policy-label=true"`. This configures the OPA server to look for a specific label so that it does not check all ConfigMaps for new policies. For information about how to apply the relevant label to your policy ConfigMaps, see [Add the policy to your OPA server]({{< ref "/plugins/policy-engine/use#step-2-add-the-policy-to-your-opa-server" >}}).

<details><summary><strong>Show the manifest</strong></summary>
<code><pre>
---
apiVersion: v1
kind: Namespace
metadata:
  name: opa # Change this to install OPA in a different namespace
---
# Grant service accounts in the 'opa' namespace read-only access to resources.
# This lets OPA/kube-mgmt replicate resources into OPA so they can be used in policies.
# The subject name should be `system:serviceaccounts:<namespace>` where `<namespace>` is the namespace where OPA will be installed
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: opa-viewer-spinnaker
roleRef:
  kind: ClusterRole
  name: view
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: Group
  name: system:serviceaccounts:opa # Change this to the namespace OPA is installed in
  apiGroup: rbac.authorization.k8s.io
---
# Define role in the `opa` namespace for OPA/kube-mgmt to update configmaps with policy status.
# The namespace for this should be the namespace where policy configmaps will be created
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: opa # Change this to the namespace where policies will live
  name: configmap-modifier
rules:
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["update", "patch"]
---
# Bind the above role to all service accounts in the `opa` namespace
# The namespace for this should be the namespace where policy configmaps will be created
# The subject name should be `system:serviceaccounts:<namespace>` where `<namespace>` is the namespace where OPA will be installed
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: opa # Change this to the namespace where policies will live
  name: opa-configmap-modifier
roleRef:
  kind: Role
  name: configmap-modifier
  apiGroup: rbac.authorization.k8s.io
subjects:
- kind: Group
  name: system:serviceaccounts:opa # Change this to the namespace OPA is installed in
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: opa-deployment
  namespace: opa # Change this to the namespace OPA is installed in
  labels:
    app: opa
spec:
  replicas: 1
  selector:
    matchLabels:
      app: opa
  template:
    metadata:
      labels:
        app: opa
    spec:
      containers:
      # WARNING: OPA is NOT running with an authorization policy configured. This
      # means that clients can read and write policies in OPA. If you are
      # deploying OPA in an insecure environment, be sure to configure
      # authentication and authorization on the daemon. See the Security page for
      # details: https://www.openpolicyagent.org/docs/security.html.
        - name: opa
          image: openpolicyagent/opa:{{< param opa-server-version >}}
          args:
            - "run"
            - "--server"
            - "--addr=http://0.0.0.0:8181"
          readinessProbe:
            httpGet:
              path: /health
              scheme: HTTP
              port: 8181
            initialDelaySeconds: 3
            periodSeconds: 5
          livenessProbe:
            httpGet:
              path: /health
              scheme: HTTP
              port: 8181
            initialDelaySeconds: 3
            periodSeconds: 5
        - name: kube-mgmt
          image: openpolicyagent/kube-mgmt:0.9
          args:
          # Change this to the namespace where you want OPA to look for policies
            - "--policies=opa"
          # Configure the OPA server to only check ConfigMaps with the relevant label
            - "--require-policy-label=true"
---
# Create a static DNS endpoint for Spinnaker to reach OPA
apiVersion: v1
kind: Service
metadata:
  name: opa
  namespace: opa # Change this to the namespace OPA is installed in
spec:
  selector:
    app: opa
  ports:
  - protocol: TCP
    port: 8181
    targetPort: 8181
</pre></code>
</details>

## Install the Policy Engine plugin

You have the following options for installing the Policy Engine plugin:

* **Armory CD**: Armory Operator
* **Spinnaker**: Spinnaker Operator, Local Config, or Halyard

{{% alert color="warning" title="A note about installing plugins in Spinnaker" %}}
When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to all services, not just the ones the plugin is for. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. Clouddriver can take an hour or more to restart if you have many accounts configured.

The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. To avoid every Spinnaker service restarting and downloading the plugin, do not add the plugin using Halyard. Instead, follow the **Local Config** installation method, in which you configure the plugin in each extended service’s local profile.

The Spinnaker Operator and Armory Operator add configuration only to extended services.
{{% /alert %}}

{{< tabpane text=true right=true >}}

{{% tab header="**Install Method**:" disabled=true /%}}

{{% tab header="Spinnaker Operator" %}}

You can install the Policy Engine plugin using the the Spinnaker Operator and the sample manifest, which uses Kustomize and is in the [spinnaker-kustomize-patches repository](https://github.com/armory/spinnaker-kustomize-patches/blob/master/armory/patch-policy-engine-plugin.yml).

<details><summary><strong>Show the manifest</strong></summary>
{{< github repo="armory/spinnaker-kustomize-patches" file="armory/patch-policy-engine-plugin.yml" lang="yaml" options="" >}}
</details><br />

**Note: The sample manifest is for the Armory Operator and Armory CD. When using the Spinnaker Operator and Spinnaker, you must replace the `apiVersion` value "spinnaker.armory.io/" with "spinnaker.io/". For example:**
  * **Armory Operator: `apiVersion: spinnaker.armory.io/v1alpha2`**
  * **Spinnaker Operator: `apiVersion: spinnaker.io/v1alpha2`**

This patch uses [YAML anchors](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_advanced_syntax.html#yaml-anchors-and-aliases-sharing-variable-values) to ensure that plugin versions are set correctly throughout Spinnaker's config. In the `gate.spinnaker.extensibility.deck-proxy.plugins.Armory.PolicyEngine.version` entry, make sure to replace the version number listed after `&version` with the version of the plugin you want to use. Refer to the [supported versions](#supported-versions) section to determine the correct plugin version for your installation.

Apply the manifest using `kubectl`.

{{% /tab %}}

{{% tab header="Armory Operator" %}}

You can enable the Policy Engine plugin using the the Armory Operator and the sample manifest, which uses Kustomize and is in the [spinnaker-kustomize-patches repository](https://github.com/armory/spinnaker-kustomize-patches/blob/master/armory/patch-policy-engine-plugin.yml).

<details><summary><strong>Show the manifest</strong></summary>
{{< github repo="armory/spinnaker-kustomize-patches" file="armory/patch-policy-engine-plugin.yml" lang="yaml" options="" >}}
</details><br />

This patch uses [YAML anchors](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_advanced_syntax.html#yaml-anchors-and-aliases-sharing-variable-values) to ensure that plugin versions are set correctly throughout Armory CD's config. In the `gate.spinnaker.extensibility.deck-proxy.plugins.Armory.PolicyEngine.version` entry, make sure to replace the version number listed after `&version` with the version of the plugin you want to use. Refer to the [supported
versions](#supported-versions) section to determine the correct plugin version for your installation.

Apply the manifest using `kubectl`.
{{% /tab %}}


{{% tab header="Local Config" %}}

The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. You should create or update the extended service's local profile in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

1. Add the following to `gate-local.yml`, `orca-local.yml`, `front50-local.yml`, and `clouddriver.yml`:

   {{< prism lang="yaml" >}}
   armory:
      policyEngine:
         failOpen: false
         opa:
            # Replace with the actual URL to your Open Policy Agent deployment
            baseUrl: http://localhost:8181/v1/data
            # Optional. The number of seconds that the Policy Engine will wait for a response from the OPA server. Default is 10 seconds if omitted.
            # timeoutSeconds: <integer>
    spinnaker:
       extensibility:
          plugins:
             Armory.PolicyEngine:
                enabled: true
             policyEngine:
                url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
    {{< /prism >}}

1. Save your files and apply your changes by running `hal deploy apply`.
{{% /tab %}}

{{% tab header="Halyard" %}}

1. Add the plugins repository

   {{< prism lang="bash" >}}
   hal plugins repository add policyEngine \
    --url=https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   {{< /prism >}}

   This creates the following entry in your `.hal/config`:

   {{< prism lang="yaml" >}}
   repositories:
      policyEngine:
         enabled: true
         url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
   {{< /prism >}}

1. Add the plugin
   
   Be sure to replace `<version>` with the version that's compatible with your Spinnaker instance.
   {{< prism lang="bash" >}}
   hal plugins add Armory.PolicyEngine --version=<version> --enabled=true
   {{< /prism >}}

   If you specified version 0.2.2, Halyard creates the following entry in your `.hal/config` file: 
   {{< prism lang="yaml" >}}
   spinnaker:
      extensibility:
         plugins:
            Armory.PolicyEngine:
               id: Armory.PolicyEngine
               enabled: true
               version: 0.2.2
   {{< /prism >}}

1. Apply the changes by executing `hal deploy apply`. 
{{% /tab %}}

{{< /tabpane >}}

#### Timeout settings

You can configure the amount of time that the Policy Engine waits for a response from your OPA server. If you have network or latency issues, increasing the timeout can make Policy Engine more resilient. Use `spec.spinnakerConfig.profiles.spinnaker.armory.policyEngine.opa.timeoutSeconds` to set the timeout in seconds. The default timeout is 10 seconds if you omit the config.

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/policy-engine/use/_index.md" >}}


