---
title: Enable the Policy Engine in Armory Continuous Deployment or Spinnaker
linkTitle: Enable the Policy Engine 
description: >
   Enable the Policy Engine to enforce policies on your Armory Continuous Deployment or Spinnaker instance. This page includes information about how to deploy and configure an Open Policy Agent server, which the Policy Engine requires. With the Policy Engine enabled, you can write policies that the Policy Engine enforces during save time, runtime validation, or when a user interacts with Armory CD or Spinnaker.
no_list: true
aliases:
  - /continuous-deployment/armory-admin/policy-engine/policy-engine-enable/
  - /continuous-deployment/armory-admin/policy-engine/policy-engine-enable/policy-engine-plug-enable/
  - /continuous-deployment/armory-admin/policy-engine/policy-engine-enable/policy-engine-ext-enable/
---

![Proprietary](/images/proprietary.svg)

## Overview of the Armory Policy Engine

The Armory Policy Engine is a proprietary feature for Armory Continuous Deployment and open source Spinnaker. It is designed to enable more complete control of your software delivery process by providing you with the hooks necessary to perform extensive verification of pipelines and processes. The Policy Engine uses the [Open Policy Agent](https://www.openpolicyagent.org/) (OPA) and input style documents to perform validations on the following:

* **Save time validation** - Validate pipelines as they're created or modified. Tasks with no policies are not validated.
* **Runtime validation** - Validate deployments as a pipeline is executing. Tasks with no policies are not validated.
* **Entitlements using API Authorization** - Enforce restrictions on who can perform certain actions. Note that if you enable policies for API authorization, you must configure who can make API calls or else the API service (Gate) rejects all API calls.

> If no policies are configured for these policy checks, all actions are allowed.

At a high level, adding policies for the Policy Engine to use is a two-step process:

1. Create the policies and save them to a `.rego` file.
2. Add the policies to the OPA server with a ConfigMap or API request.

These policies are evaluated against the packages that Armory Continuous Deployment sends between its services. For a list of packages that you can write policies against, see {{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/packages/_index.md" >}}. 

Enabling the Policy Engine consists of the following steps:

1. [Deploy an OPA server](#deploy-an-opa-server)
1. [Enable the Policy Engine plugin](#enable-the-policy-engine-plugin)

## {{% heading "prereq" %}}

* The Policy Engine requires an [Open Policy Agent (OPA)](https://www.openpolicyagent.org/) server, version 0.12.x or later. You can either use the example on this page to deploy a server in the same Kubernetes cluster as Armory Continuous Deployment or see the OPA documentation for information about how to [deploy an OPA server](https://www.openpolicyagent.org/docs/latest/deployments/). Specifically, the OPA v1 API must be available.
* You have identified the Policy Engine plugin that is compatible with your version of Armory Continuous Deployment or Spinnaker.
* If you are using Spinnaker, you are familiar with [installing and using plugins](https://spinnaker.io/docs/guides/user/plugins-users/) in Spinnaker.

### Supported versions

{{< include "policy-engine/plugin-compat-matrix.md" >}}

## Deploy an OPA server

The Policy Engine supports the following OPA server deployments:

* An OPA server deployed in the same Kubernetes cluster as an Armory CD or Spinnaker deployment. The [Using ConfigMaps for OPA policies](#using-configmaps-for-opa-policies) section contains a ConfigMap you can use.
* An OPA cluster that is **not** in the same Kubernetes cluster as an Armory CD or Spinnaker deployment . See the [OPA documentation](https://www.openpolicyagent.org/docs/latest/) for more information about installing an OPA server in a separate cluster.

### Using ConfigMaps for Open Policy Agent policies

If you want to use ConfigMaps for OPA policies, you can use the following manifest as a starting point. This example manifest deploys an OPA server and applies the configuration for things like rolebinding and a static DNS. When using the example, keep the following guidelines in mind:

* The manifest does not configure any authorization requirements for the OPA server it deploys. This means that anyone can add a policy.
* The manifest deploys the OPA server to a namespace called `opa`.
* The OPA server uses the following config: `"--require-policy-label=true"`. This configures the OPA server to look for a specific label so that it does not check all configmaps for new policies. For information about how to apply the relevant label to your policy configmaps, see [Creating a policy]({{< ref "policy-engine-use#step-2-add-the-policy-to-your-opa-server" >}}).

<details><summary>Show the manifest</summary>
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

## Enable the Policy Engine plugin

You have three options for enabling the Policy Engine plugin:

1. [Armory Operator or Spinnaker Operator](#armory-operator-or-spinnaker-operator)
1. [Spinnaker services local files](#spinnaker-services-local-files) (Spinnaker only)
1. [Halyard](#halyard) (Spinnaker only)

### Armory Operator or Spinnaker Operator              

You can enable the Policy Engine plugin using the Armory Operator or the Spinnaker Operator and the sample manifest, which is in the [spinnaker-kustomize-patches repository](https://github.com/armory/spinnaker-kustomize-patches/blob/master/armory/patch-policy-engine-plugin.yml).

* The sample manifest is for the Armory Operator and Armory CD. If you are using the Spinnaker Operator and Spinnaker, you must replace the `apiVersion` value "spinnaker.armory.io/" with "spinnaker.io/". For example:

  * Armory Operator: `apiVersion: spinnaker.armory.io/v1alpha2`
  * Spinnaker Operator: `apiVersion: spinnaker.io/v1alpha2`

* In the `gate.spinnaker.extensibility.deck-proxy.plugins.Armory.PolicyEngine.version` entry, make sure to replace the version number listed after `&version` with the version of the plugin you want to use. For example, if you are using Armory CD 2.27.x (Spinnaker 1.27.x), you would use version 0.2.1:

   {{< prism lang="yaml" line="12" >}}
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
                version: &version 0.2.1
   {{< /prism>}}

<details><summary>Show the manifest</summary>
{{< github repo="armory/spinnaker-kustomize-patches" file="/armory/patch-policy-engine-plugin.yml" lang="yaml" options="" >}}
</details>

#### Optional settings
##### Timeout settings

You can configure the amount of time that the Policy Engine waits for a response from your OPA server. If you have network or latency issues, increasing the timeout can make Policy Engine more resilient. Use the following config to set the timeout in seconds: `spec.spinnakerConfig.profiles.spinnaker.armory.policyEngine.opa.timeoutSeconds`. The default timeout is 10 seconds if you omit the config.

##### JSON validation

You can configure strict JSON validation as a boolean in `spec.spinnakerConfig.profiles.dinghy.jsonValidationDisabled`:


{{< prism lang="yaml" >}}
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        jsonValidationDisabled: <boolean>
{{< /prism >}}

The config is optional. If omitted, strict validation is on by default. When strict validation is on, existing pipelines may fail if any JSON is invalid.

### Spinnaker services local files

{{% alert title="Warning" color="warning" %}}
The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. To avoid each service restarting and downloading the plugin, do not add the plugin using Halyard. Instead, configure the plugin in the service’s local file.
{{% /alert %}}

The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. You must create or update the service's local file in the same directory as the other Halyard configuration files. This is usually `~/.hal/default/profiles` on the machine where Halyard is running.

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

### Halyard

{{% alert title="Warning" color="warning" %}}
The Policy Engine plugin extends Orca, Gate, Front50, Clouddriver, and Deck. When Halyard adds a plugin to a Spinnaker installation, it adds the plugin repository information to each service. This means that when you restart Spinnaker, each service restarts, downloads the plugin, and checks if an extension exists for that service. Each service restarting is not ideal for large Spinnaker installations due to service restart times. Clouddriver can take an hour or more to restart if you have many accounts configured.
{{% /alert %}}

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


## Release notes

<details><summary>Show the release notes</summary>

* 0.2.2 - Fixed bug for createApplication button with Spinnaker 1.28, to be included in 2.28 release
* 0.2.1 - Fixed bug with the projects tab on deck for Armory Continuous Deployment 2.27.1 and later
* 0.2.0 - Update plugin to be compatible with Armory Continuous Deployment 2.27.0 and later.
* 0.1.6 - The Policy Engine Plugin is now generally available.
  * If you are new to using the Policy Engine, use the plugin instead of the extension project.
  * Entitlements using API Authorization no longer requires at least one policy. Previously, if you had no policies set, Policy Engine prevented any action from being taken. Now, Entitlements for Policy Engine allows any action to be taken if there are no policies set.
* 0.1.4 - Adds the `opa.timeoutSeconds` property, which allows you to configure how long the Policy Engine waits for a response from the OPA server.
* 0.1.3 - Fixes an issue introduced in v0.1.2 where the **Project Configuration** button's name was changing when Policy Engine is enabled.
* 0.1.2  - Adds support for writing policies against the package `spinnaker.ui.entitlements.isFeatureEnabled` to show/hide the following UI buttons:
  * Create Application
  * Application Config
  * Create Project
* 0.0.25 - Fixes an unsatisfied dependency error in the API (Gate) when using SAML and x509 certificates. This fix requires Armory Continuous Deployment 2.26.0 later.
* 0.0.19 - Adds forced authentication feature and fixes NPE bug
* 0.0.17 - Initial plugin release

</details>

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "continuous-deployment/armory-admin/policy-engine/policy-engine-use/_index.md" >}}