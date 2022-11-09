---
title: Armory CD-as-a-Service Plugin for Armory CD and Spinnaker
linkTitle: Spinnaker Plugin
description: >
  Use this guide to install the Armory Continuous Deployment-as-a-Service plugin for Spinnaker and Armory CD. This plugin enables performing canary and blue/green deployments in a single stage.
weight: 500
---

## Overview of the CD-as-a-Service Spinnaker plugin

{{< include "cdaas/desc-plugin.md" >}}

See the [Architecture]({{< ref "cd-as-a-service/concepts/architecture" >}}) page for an overview of the Armory CD-as-a-Service Spinnaker plugin and how it fits in with Armory CD.

This guide walks you through the following:

- Registering your Armory CD environment
- Installing the Remote Network Agent (RNA) on your deployment target cluster
- Connecting to Armory Continuous Deployment-as-a-Service
- Installing the plugin
- Deploying a "hello world" manifest

### Release notes

You can find the plugin release notes in the [Armory CD-as-a-Service release notes](https://armory.releases.live/ledger/embed/).

## {{% heading "prereq" %}}

Verify that you meet or can meet these requirements before getting started.

### Armory CD (Spinnaker)

Your Armory CD (or open source Spinnaker) instance must meet the following requirements:

- Version 2.24 or later (or Spinnaker 1.24 or later)
- A supported Operator version. For information about what version of Operator is supported, see the [release notes]({{< ref "rn-armory-spinnaker" >}}) for your Armory CD version.

### Networking

Ensure that your Armory CD (or Spinnaker) instance and Armory Agents have the following networking access:

{{< include "cdaas/req-networking.md" >}}

Additionally, your Armory CD instance needs access to GitHub to download the plugin during installation.

### Target Kubernetes cluster

The Spinnaker plugin does not use Clouddriver to source its accounts. Instead, it uses Remote Network Agents (RNAs) that are deployed in your target Kubernetes clusters. An RNA is a lightweight, scalable service that enables the Spinnaker plugin to interact with your infrastructure. You must install RNAs in every target cluster.

The Helm chart described in [Enable the Armory CD-as-a-Service Remote Network Agent in target Kubernetes clusters](#enable-the-armory-cd-as-a-service-remote-network-agent-in-target-kubernetes-clusters) manages the installation of both of these requirements for you.

## Register your Armory CD environment

Register your Armory CD environment so that it can communicate with Armory services. Each environment needs to get registered if you, for example, have production and development environments.

1. [Register](https://go.armory.io/signup/) to use Armory CD-as-a-Service.
1. Register your Armory CD [environment]({{< ref "ae-instance-reg" >}}).

## Create a credential for your Remote Network Agent

{{< include "cdaas/client-creds.md" >}}

## Enable the Armory CD-as-a-Service Remote Network Agent in target Kubernetes clusters

This section walks you through installing the Remote Network Agent (RNA) using a Helm chart.

{{< include "cdaas/rna-install.md" >}}

### Verify the Agent deployment

Go to the [Agents page in the Configuration UI](https://console.cloud.armory.io/configuration/agents) and verify the connection. If you do not see your cluster, verify that you are in the correct CD-as-a-Service tenant.

> Note that you may see a "No Data message" when first loading the Agent page.

{{< figure src="/images/cdaas/ui-rna-status.jpg" alt="The Connected Remote Network Agents page shows connected Agents and the following information: Agent Identifier, Agent Version, Connection Time when the connection was established, Last Heartbeat time, Client ID, and IP Address." >}}



If you do not see the RNA for your target deployment cluster, check the logs for the target deployment cluster to see if the RNA is up and running.

You should see messages similar to the following that show your client ID and your account getting registered in Armory CD-as-a-Service:

```
time="2021-07-16T17:41:45Z" level=info msg="registering with uuid: f69daec0-0a32-4ded-b3ed-dc84bc0e93d0"
time="2021-07-16T17:41:45Z" level=info msg="registering with 1 servers"
time="2021-07-16T17:48:30Z" level=info msg="handling registration 01FAR6Y7EDJW1B5G8JQ109D53G"
time="2021-07-16T17:48:30Z" level=info msg="starting agentCreator provider:\"kubernetes\" name:\"account-test\""
```

## Install the plugin

> You can configure secrets as outlined in the [Secrets Guide]({{< ref "armory-enterprise/armory-admin/secrets" >}}). This means you can set the clientSecret value to be a secret token instead of the plain text value.

{{< tabs name="DeploymentPlugin" >}}
{{% tabbody name="Operator" %}}

If you are running Armory CD 2.26.3, `armory.cloud` block goes in a different location. Instead of `spec.spinnakerConfig.spinnaker`, the block needs to go under both `spec.spinnakerConfig.gate` and `spec.spinnakerConfig.orca`. For more information see [Known issues](#known-issues). Additionally there is a `plugins` block that needs to be added.

The installation instructions using the Operator are the same except for where the `armory.cloud` and this `plugins` block go.

In your Kustomize patches directory, create a file named **patch-plugin-deployment.yml** and add the following manifest to it.

```yaml
#patch-plugin-deployment.yml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
  namespace: <namespace>
spec:
  spinnakerConfig:
    profiles:
      gate:
        spinnaker:
          extensibility:
            # This snippet is necessary so that Gate can serve your plugin code to Deck
            deck-proxy:
              enabled: true
              plugins:
                Armory.Deployments:
                  enabled: true
                  version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
      # Global Settings
      spinnaker:
        armory.cloud:
          enabled: true
          iam:
            clientId: <clientId for Spinnaker from earlier>
            clientSecret: <clientSecret for Spinnaker from earlier>
            tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
          api:
            baseUrl: https://api.cloud.armory.io
        spinnaker:
          extensibility:
            plugins:
              Armory.Deployments:
                enabled: true
                version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

Then, include the file under the `patchesStrategicMerge` section of your `kustomization` file:

```yaml
bases:
  - spinnaker.yml
patchesStrategicMerge:
  - patches/patch-plugin-deployment.yml
```      

Apply the changes to your Armory CD instance.

```bash
kubectl apply -k <path-to-kustomize-file>.yml
```

{{% /tabbody %}}
{{% tabbody name="Halyard" %}}

If you are running Armory CD 2.26.3, `armory.cloud` block needs to go in `gate-local.yml` and `orca-local.yml` instead of `spinnaker-local.yml`. For more information see [Known issues](#known-issues). Other than the change in location, the installation instructions remain the same.

In the `/.hal/default/profiles` directory, add the following configuration to `spinnaker-local.yml`. If the file does not exist, create it and add the configuration.

```yaml
#spinnaker-local.yml
armory.cloud:
  enabled: true
  iam:
    clientId: <clientId for Spinnaker from earlier>
    clientSecret: <clientSecret for Spinnaker from earlier>
    tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
  api:
    baseUrl: https://api.cloud.armory.io
spinnaker:
  extensibility:
    plugins:
      Armory.Deployments:
        enabled: true
        version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

In the `/.hal/default/profiles` directory, add the following configuration to `gate-local.yml`. If the file does not exist, create it and add the configuration.

```yaml
#gate-local.yml
spinnaker:
  extensibility:
    # This snippet is necessary so that Gate can serve your plugin code to Deck
    deck-proxy:
      enabled: true
      plugins:
        Armory.Deployments:
          enabled: true
          version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

Apply the changes to your Armory CD instance.

```bash
hal deploy apply
```

{{% /tabbody %}}
{{< /tabs >}}

## Verify that the plugin is configured

1. Check that all the services are up and running:

   ```bash
   kubectl -n <Armory-Enterprise-namespace> get pods
   ```

2. Navigate to the Armory CD UI.
3. In a new or existing application, create a new pipeline.
4. In this pipeline, select **Add stage** and search for **Kubernetes Progressive**. The stage should appear if the plugin is properly configured.

   {{< figure src="/images/deploy-engine/deploy-engine-stage-UI.jpg" alt="The Kubernetes Progressive stage appears in the Type dropdown when you search for it." >}}

5. In the **Basic Settings** section, verify that you can see the target deployment account in the **Account** dropdown.

   {{< figure src="/images/deploy-engine/deploy-engine-accounts.png" alt="If the plugin is configured properly, you should see the target deployment account in the Account dropdown." >}}.

## Use the plugin

The plugin provides the following pipeline stages that you can use to deploy your app:

* [Borealis Progressive Deployment YAML](#armory-cd-as-a-service-progressive-deployment-yaml-stage): You create the Armory CD-as-a-Service deployment YAML configuration, so you have access to the full set of options for deploying your app to a single environment.
* [Kubernetes Progressive](#kubernetes-progressive-stage): This is a basic deployment stage with a limited set of options. Blue/green deployment is not supported in Early Access.

### Armory CD-as-a-Service Progressive Deployment YAML stage

{{< alert title="Limitations" color="primary" >}}
* This stage only supports deploying to a single environment.
{{< /alert >}}

This stage uses YAML deployment configuration to deploy your app. The YAML that you create must be in the same format as the [Deployment File]({{< ref "ref-deployment-file" >}}) that you would use with the Armory CD-as-a-Service CLI.

You have the following options for adding your Armory CD-as-a-Service deployment YAML configuration:

1. **Text**: You create and store your deployment YAML within Armory CD.
1. **Artifact**: You store your deployment YAML file in source control.

#### {{% heading "prereq" %}}

1. Add the Kubernetes manifest for your app as a pipeline artifact in the Configuration section of your pipeline. Or you can generate it using the 'Bake (Manifest)' stage, as you would for a standard Kubernetes deployment in Armory CD.

1. Prepare your Armory CD-as-a-Service deployment YAML. You can use the [Armory CD-as-a-Service CLI]({{< ref "cd-as-a-service/setup/cli#manually-deploy-apps-using-the-cli" >}}) to generate a deployment file template. In your deployment YAML `manifests.path` section, you have to specify the file name of the app's Kubernetes manifest artifact, which may vary from the **Display Name** on the **Expected Artifact** screen.

#### Configure the stage

The **Deployment Configuration** section is where you define your Armory CD-as-a-Service progressive deployment and consists of the following parts:

**Manifest Source**

{{< tabs name="DeploymentYAMLManifestSource" >}}
{{% tabbody name="Text" %}}

1. Choose **Text** for the **Manifest Source**.
1. Paste your deployment file YAML into the **Deployment YAML** text box. For example:

{{< figure src="/images/cdaas/plugin/prog-deploy-yaml.png" alt="Example of a deployment YAML file pasted into the Deployment YAML text box." >}}

{{% /tabbody %}}
{{% tabbody name="Artifact" %}}

Before you select **Artifact**, make sure you have added your Armory CD-as-a-Service deployment file as a pipeline artifact.

1. Select **Artifact** as the **Manifest Source**.
1. Select your Armory CD-as-a-Service deployment file from the **Manifest Artifact** drop down list.

{{< figure src="/images/cdaas/plugin/prog-deploy-artifact.png" alt="Example of a deployment YAML file attached as an artifact." >}}

{{% /tabbody %}}
{{< /tabs >}}
<br>
<br>
**Required Artifacts to Bind**

For each manifest you list in the `manifests.path` section of your Armory CD-as-a-Service deployment file, you must bind the artifact to the stage.

For example, if your deployment file specifies:

```yaml
...
manifests:
  - path: manifests/potato-facts.yml
...
```

Then you must bind `potato-facts.yml` as a required artifact:

{{< figure src="/images/cdaas/plugin/req-artifact-to-bind.png" alt="Example of an artifact added to Required Artifacts to Bind" >}}

### Kubernetes Progressive stage

If you have deployed Kubernetes apps before using Armory CD, this page may look familiar. The key difference between a Kubernetes deployment using Armory CD and Armory CD with the Armory CD-as-a-Service Spinnaker Plugin is in the **How to Deploy** section.

The **How to Deploy** section is where you define your progressive deployment and consists of two parts:

**Strategy**

This is the deployment strategy you want to use to deploy your Kubernetes app. As part of the early access program, the **Canary** strategy is available. Canary deployments allow you to roll out changes to a predefined percentage of your cluster and increment from there as you monitor the effects of your changes. If something doesn't look quite right, you can initiate a rollback to a previous known good state.

**Steps**

These settings control how the your Kubernetes deployment behaves as Armory CD-as-a-Service deploys it. You can tune two separate but related characteristics of the deployment:

- **Rollout Ratio**: set the percentage threshold (integer) for how widely an app should get rolled out before pausing.
- **Then wait**: define what triggers the rollout to continue. The trigger can either be a manual approval (**until approved**) or for a set amount of time, either seconds, minutes or hours (integer).

Create a step for each **Rollout Ratio** you want to define. For example, if you want a deployment to pause at 25%, 50%, and 75% of the app rollout, you need to define 3 steps, one for each of those thresholds. The steps have independent **Then wait** behaviors and can be set to all follow the same behavior or different ones.

#### Try out the stage

You can try out the **Kubernetes Progressive** stage using either the `hello-world` sample manifest described below or an artifact that you have. The `hello-world` example deploys NGINX that intentionally takes longer than usual for demonstration purposes.

Perform the following steps:

1. In the Armory CD UI, select an existing app or create a new one.
2. Create a new pipeline.
3. Add a stage to your pipeline with the following attributes:
   - **Type**: select **Kubernetes Progressive**
   - **Stage Name**: provide a descriptive name or use the autogenerated name.
4. In the **Account** field, select the target Kubernetes cluster you want to deploy to. This is a cluster where the Remote Network Agent is installed
5. For **Manifest Source**, ensure that you select your manifest source. If you are using the `hello-world` sample manifest described later, select **Text**.
6. **Using text as the manifest source:**

   In the **Manifest** field, provide your manifest. If you are using the `hello-world` manifest, enter that manifest.

   <details><summary>Show me the <code>hello-world</code> manifest</summary>

   ```yaml
   # A simple nginx deployment with an init container that causes deployment to take longer than usual
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: demo-app
   spec:
     replicas: 10
     selector:
       matchLabels:
         app: demo-app
     template:
       metadata:
         labels:
           app: demo-app
       spec:
         containers:
           - env:
               - name: TEST_ID
                 value: __TEST_ID_VALUE__
             image: 'nginx:1.14.1'
             name: demo-app
             ports:
               - containerPort: 80
                 name: http
                 protocol: TCP
         initContainers:
           - command:
               - sh
               - '-c'
               - sleep 10
             image: 'busybox:stable'
             name: sleep
   ```

   </details>

   **Using an existing artifact**

   Select an existing artifact or define a new one as you would for a standard Kubernetes deployment in Armory CD.

7. In the **How to Deploy** section, configure the **Rollout Ratio** and **Then wait** attributes for the deployment.

   Optionally, add more steps to the deployment to configure the rollout behavior. You do not need to create a step for 100% Rollout Ratio. Armory CD-as-a-Service automatically scales the deployment to 100% after the final step you configure.

8.  Save the pipeline.
9.  Trigger a manual execution of the pipeline.

On the **Pipelines** page of the Armory CD UI, select the pipeline and watch the deployment progress. If you set the **Then wait** behavior of any step to **until approved**, this is where you approve the rollout and allow it to continue. After completing the final step you configured, Armory CD-as-a-Service scales the deployment to 100% of the cluster if needed.

## Known issues and limitations

### Manifest limitations

{{< include "cdaas/ki-manifest-limitation.md" >}}

### `armory.cloud` block location

In Armory CD 2.26.3, the location of where you put the `armory.cloud` config block is different from other versions. Additionally, there is an additional config block for `spec.spinnakerConfig.profiles.gate.spinnaker.extensibility` that contains information for the plugin named `plugins`.

{{< tabs name="KnownIssue" >}}
{{% tabbody name="Operator" %}}

Your Kustomize patch file should resemble the following where `armory.cloud` is a child of the `gate` and `orca` blocks instead of a `spinnaker` block:

```yaml
#patch-plugin-deployment.yml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
  namespace: <namespace>
spec:
  spinnakerConfig:
    profiles:
      gate:
        spinnaker:
          extensibility:
            # This snippet is necessary so that Gate can serve your plugin code to Deck
            deck-proxy:
              enabled: true
              plugins:
                Armory.Deployments:
                  enabled: true
                  version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            plugins:
              Armory.Deployments:
                enabled: true
                version: <Latest-version> # Replace this with the latest version
            repositories:
              armory-deployment-plugin-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
        # Note how armory.cloud is a child of gate instead of spinnaker
        armory.cloud:
          enabled: true
          iam:
            clientId: <clientId for Spinnaker from earlier>
            clientSecret: <clientSecret for Spinnaker from earlier>
            tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
          api:
            baseUrl: https://api.cloud.armory.io
      # Note how armory.cloud is a child of orca instead of spinnaker
      orca:
        armory.cloud:
          enabled: true
          iam:
            clientId: <clientId for Spinnaker from earlier>
            clientSecret: <clientSecret for Spinnaker from earlier>
            tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
          api:
            baseUrl: https://api.cloud.armory.io
        spinnaker:
          extensibility:
            plugins:
              Armory.Deployments:
                enabled: true
                version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```



{{% /tabbody %}}
{{% tabbody name="Halyard" %}}

Your `spinnaker-local.yml` file should not have the `armory.cloud` block anymore and only contain the block to install the plugin:

```yaml
#spinnaker-local.yml
spinnaker:
  extensibility:
    plugins:
      Armory.Deployments:
        enabled: true
        version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

Your `gate-local.yml` file should include the `extensibility` and the `armory.cloud` configurations like the following example:

```yaml
#gate-local.yml
spinnaker:
  extensibility:
    plugins:
      Armory.Deployments:
        enabled: true
        version: <Latest-version> # Replace this with the latest version
    # This snippet is necessary so that Gate can serve your plugin code to Deck
    deck-proxy:
      enabled: true
      plugins:
        Armory.Deployments:
          enabled: true
          version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
armory.cloud:
  enabled: true
  iam:
    clientId: <clientId for Spinnaker from earlier>
    clientSecret: <clientSecret for Spinnaker from earlier>
    tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
  api:
    baseUrl: https://api.cloud.armory.io
```

Your `orca-local.yml` file should include the `armory.cloud` configration like the following:

```yaml
#orca-local.yml
armory.cloud:
  enabled: true
  iam:
    clientId: <clientId for Spinnaker from earlier>
    clientSecret: <clientSecret for Spinnaker from earlier>
    tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
  api:
    baseUrl: https://api.cloud.armory.io
```

{{% /tabbody %}}
{{< /tabs >}}

> This product documentation page is Armory confidential information.
