---
title: Get Started with Project Aurora for Spinnaker™
description: Use this self-service guide to install Project Aurora, which enables you to perform canary and blue/green deployments in a single stage.
exclude_search: true
toc_hide: true
hide_summary: true
aliases:
  - /docs/installation/armory-deployments-for-spinnaker/
---

{{< alert title="Early Access" color="primary" >}}
{{% include "aurora-borealis/borealis-ea-banner.md" %}}
{{< /alert >}}

> If you installed an older version of the Remote Network Agent (RNA) using the Helm chart in `armory/aurora`, migrate to the new version by updating the Helm chart that is used. For more information, see [Migrate to the new RNA](#migrate-to-the-new-rna).

## Overview

Project Aurora is plugin that adds new stages to your Armory Enterprise (Spinnaker) instance. When you use one of these stages to deploy an app, you can configure how to deploy the stage incrementally by setting percentage thresholds for the deployment. For example, you can deploy the new version of your app to 25% of your target cluster and then wait for a manual judgement or a configurable amount of time. This wait gives you time to assess the impact of your changes. From there, either continue the deployment to the next threshold you set or roll back the deployment.

See the [Architecture]({{< ref "borealis/architecture-borealis" >}}) page for an overview of Project Aurora and how it fits in with Armory Enterprise.

This guide walks you through the following:

- Registering your Armory Enterprise environment
- Installing the Remote Network Agent (RNA) on your deployment target cluster
- Connecting to Armory Cloud services
- Installing the Project Aurora plugin
- Deploying a "hello world" manifest

### Release notes

For the Project Aurora release notes, see the [Armory Changelog](https://armory.releases.live/?labels=Armory+Deployments+Plugin).

## Requirements

Verify that you meet or can meet these requirements before getting started.

### Armory Enterprise (Spinnaker)

Your Armory Enterprise (or open source Spinnaker) instance must meet the following requirements:

- Version 2.24 or later (or Spinnaker 1.24 or later)
- A supported Operator or Halyard version. For information about what version of Halyard or Operator is supported, see the [release notes]({{< ref "rn-armory-spinnaker" >}}) for your Armory Enterprise version.

### Networking

Ensure that your Armory Enterprise (or Spinnaker) instance and Armory Agents have the following networking access:

| Protocol                    | DNS                       | Port | Used By           | Notes                                                                                                                                                                                                                                                                    |
|-----------------------------|---------------------------|------|-------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| HTTPS                       | armory.jfrog.io           | 443  | Helm              | **Armory's Artifact Repository**<br><br>Used to download official Armory artifacts during installation, such as Helm charts.                                                                                                                                             |
| HTTPS                       | api.cloud.armory.io       | 443  | Spinnaker         | **Armory Cloud REST API**<br><br>Used fetch information from the Kubernetes cache                                                                                                                                                                                        |
| TLS enabled gRPC over HTTP2 | agent-hub.cloud.armory.io | 443  | Spinnaker, Agents | **Armory Cloud Agent-Hub**<br><br>Used to connect agents to the Agent Hub through encrypted long-lived gRPC HTTP2 connections. The connections are used for bi-directional communication between Armory Enterprise or Armory Cloud Services and customer infrastructure. |
| HTTPS                       | auth.cloud.armory.io      | 443  | Spinnaker, Agents | **Armory’s OIDC authorization server**<br><br>Used to exchange the client ID and secret for a Java Web Token () to verify identity.                                                                                                                                      |
| HTTPS                       | github.com                | 443  | Spinnaker         | **Github**<br><br>Used to download official Armory plugins at startup time.                                                                                                                                                                                              |


### Target Kubernetes cluster

Project Aurora is a separate product from Armory Enterprise (Spinnaker). It does not use Clouddriver to source its accounts. Instead, it uses Remote Network Agents (RNAs) that are deployed in your target Kubernetes clusters. An RNA is a lightweight, scalable service that enables Project Aurora to interact with your infrastructure. You must install RNAs in every target cluster.

The Helm chart described in [Enable Project Aurora in target Kubernetes clusters](#enable-aurora-in-target-kubernetes-clusters) manages the installation of both of these requirements for you.

## Register your Armory Enterprise environment

Register your Armory Enterprise environment so that it can communicate with Armory services. Each environment needs to get registered if you, for example, have production and development environments.

1. Get your registration link from Armory.
2. Register your Armory Enterprise [environment]({{< ref "ae-instance-reg" >}}).

## Create client credentials for your Agents

1. Log in to the Armory Cloud Console: https://console.cloud.armory.io/.
2. If you have more than one environment, ensure the proper environment is selected in the user context menu:

   {{< figure src="/images/deploy-engine/cloud-env-context.png" alt="The upper right section of the window shows what environment you are currently in." >}}

3. In the left navigation menu, select **Access Management > Client Credentials**.
4. In the upper right corner, select **New Credential**.
5. Create a credential for your RNA. Use a descriptive name for the credential, such as `us-west RNA`
6. Set the permission scope to `connect:agentHub`.

   > Removing a preconfigured scope group does not deselect the permissions that the group assigned. You must remove the permissions manually.

7. Note both the **Client ID** and **Client Secret**. You need these values when configuring the Remote Network Agent or other services that you want to use to interact with Aurora and Armory's hosted cloud services. Make sure to store the secret somewhere safe. You are not shown the value again.

## Enable Aurora in target Kubernetes clusters

This section walks you through installing the Remote Network Agent (RNA) using a Helm chart.

{{< include "aurora-borealis/rna-install.md" >}}

### Migrate to the new RNA

You do not need to do this migration if you are installing the RNA for the first time.

Before you start the migration process, make sure that you are running version 0.29.2 or later of the Project Aurora plugin. This is set in the `version` field of the YAML file you use to install the plugin.

{{< include "aurora-borealis/borealis-rna-wormhole-migrate.md" >}}

### Verify the Agent deployment

Go to the [Agents page in the Configuration UI](https://console.cloud.armory.io/configuration/agents) and verify the connection. If you do not see your cluster, verify that you are in the correct Armory Cloud environment.

> Note that you may see a "No Data message" when first loading the Agent page.

{{< figure src="/images/borealis/borealis-ui-rna-status.jpg" alt="The Connected Remote Network Agents page shows connected agents and the following information: Agent Identifier, Agent Version, Connection Time when the connection was established, Last Heartbeat time, Client ID, and IP Address." >}}



If you do not see the RNA for your target deployment cluster, check the logs for the target deployment cluster to see if the RNA is up and running.

You should see messages similar to the following that show your client ID and your account getting registered in the Armory Cloud Hub:

```
time="2021-07-16T17:41:45Z" level=info msg="registering with uuid: f69daec0-0a32-4ded-b3ed-dc84bc0e93d0"
time="2021-07-16T17:41:45Z" level=info msg="registering with 1 servers"
time="2021-07-16T17:48:30Z" level=info msg="handling registration 01FAR6Y7EDJW1B5G8JQ109D53G"
time="2021-07-16T17:48:30Z" level=info msg="starting agentCreator provider:\"kubernetes\" name:\"account-test\""
```

## Install the Project Aurora Plugin

> You can configure secrets as outlined in the [Secrets Guide]({{< ref "secrets" >}}). This means you can set the clientSecret value to be a secret token instead of the plain text value.

{{< tabs name="DeploymentPlugin" >}}
{{% tabbody name="Operator" %}}

If you are running Armory Enterprise 2.26.3, `armory.cloud` block goes in a different location. Instead of `spec.spinnakerConfig.spinnaker`, the block needs to go under both `spec.spinnakerConfig.gate` and `spec.spinnakerConfig.orca`. For more information see [Known issues](#known-issues). Additionally there is a `plugins` block that needs to be added.

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

Apply the changes to your Armory Enterprise instance.

```bash
kubectl apply -k <path-to-kustomize-file>.yml
```

{{% /tabbody %}}
{{% tabbody name="Halyard" %}}

If you are running Armory Enterprise 2.26.3, `armory.cloud` block needs to go in `gate-local.yml` and `orca-local.yml` instead of `spinnaker-local.yml`. For more information see [Known issues](#known-issues). Other than the change in location, the installation instructions remain the same.

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

Apply the changes to your Armory Enterprise instance.

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

2. Navigate to the Armory Enterprise UI.
3. In a new or existing application, create a new pipeline.
4. In this pipeline, select **Add stage** and search for **Kubernetes Progressive**. The stage should appear if the plugin is properly configured.

   {{< figure src="/images/deploy-engine/deploy-engine-stage-UI.jpg" alt="The Kubernetes Progressive stage appears in the Type dropdown when you search for it." >}}

5. In the **Basic Settings** section, verify that you can see the target deployment account in the **Account** dropdown.

   {{< figure src="/images/deploy-engine/deploy-engine-accounts.png" alt="If the plugin is configured properly, you should see the target deployment account in the Account dropdown." >}}.

## Use Project Aurora

Project Aurora provides the following pipeline stages that you can use to deploy your app:

* [Borealis Progressive Deployment YAML](#borealis-progressive-deployment-yaml-stage): You create the Borealis deployment YAML configuration, so you have access to the full set of options for deploying your app to a single environment.
* [Kubernetes Progressive](#kubernetes-progressive-stage): This is a basic deployment stage with a limited set of options. Blue/green deployment is not supported in Early Access.

### Borealis Progressive Deployment YAML stage

{{< alert title="Limitations" color="primary" >}}
* This stage only supports deploying to a single environment.
{{< /alert >}}

This stage uses YAML deployment configuration to deploy your app. The YAML that you create must be in the same format as the [Deployment File]({{< ref "ref-deployment-file" >}}) that you would use with the Borealis CLI.

You have the following options for adding your Borealis deployment YAML configuration:

1. **Text**: You create and store your deployment YAML within Armory Enterprise.
1. **Artifact**: You store your deployment YAML file in source control.

#### {{% heading "prereq" %}}

1. Add the Kubernetes manifest for your app as a pipeline artifact in the Configuration section of your pipeline. Or you can generate it using the 'Bake (Manifest)' stage, as you would for a standard Kubernetes deployment in Armory Enterprise.

1. Prepare your Borealis deployment YAML. You can use the [Borealis CLI]({{< ref "borealis-cli-get-started#manually-deploy-apps-using-the-cli" >}}) to generate a deployment file template. In your deployment YAML `manifests.path` section, you have to specify the file name of the app's Kubernetes manifest artifact, which may vary from the **Display Name** on the **Expected Artifact** screen.

#### Configure the stage

The **Deployment Configuration** section is where you define your Borealis progressive deployment and consists of the following parts:

**Manifest Source**

{{< tabs name="BorealisDeploymentYAMLManifestSource" >}}
{{% tabbody name="Text" %}}

1. Choose **Text** for the **Manifest Source**.
1. Paste your deployment file YAML into the **Deployment YAML** text box. For example:

{{< figure src="/images/installation/aurora/borealis-prog-deploy-yaml.png" alt="Example of a deployment YAML file pasted into the Deployment YAML text box." >}}

{{% /tabbody %}}
{{% tabbody name="Artifact" %}}

Before you select **Artifact**, make sure you have added your Borealis deployment file as a pipeline artifact.

1. Select **Artifact** as the **Manifest Source**.
1. Select your Borealis deployment file from the **Manifest Artifact** drop down list.

{{< figure src="/images/installation/aurora/borealis-prog-deploy-artifact.png" alt="Example of a deployment YAML file attached as an artifact." >}}

{{% /tabbody %}}
{{< /tabs >}}
<br>
<br>
**Required Artifacts to Bind**

For each manifest you list in the `manifests.path` section of your Borealis deployment file, you must bind the artifact to the stage.

For example, if your deployment file specifies:

```yaml
...
manifests:
  - path: manifests/potato-facts.yml
...
```

Then you must bind `potato-facts.yml` as a required artifact:

{{< figure src="/images/installation/aurora/req-artifact-to-bind.png" alt="Example of an artifact added to Required Artifacts to Bind" >}}

### Kubernetes Progressive stage

If you have deployed Kubernetes apps before using Armory Enterprise, this page may look familiar. The key difference between a Kubernetes deployment using Armory Enterprise and Armory Enterprise with Project Aurora is in the **How to Deploy** section.

The **How to Deploy** section is where you define your progressive deployment and consists of two parts:

**Strategy**

This is the deployment strategy you want to use to deploy your Kubernetes app. As part of the early access program, the **Canary** strategy is available. Canary deployments allow you to roll out changes to a predefined percentage of your cluster and increment from there as you monitor the effects of your changes. If something doesn't look quite right, you can initiate a rollback to a previous known good state.

**Steps**

These settings control how the your Kubernetes deployment behaves as Project Aurora deploys it. You can tune two separate but related characteristics of the deployment:

- **Rollout Ratio**: set the percentage threshold (integer) for how widely an app should get rolled out before pausing.
- **Then wait**: define what triggers the rollout to continue. The trigger can either be a manual approval (**until approved**) or for a set amount of time, either seconds, minutes or hours (integer).

Create a step for each **Rollout Ratio** you want to define. For example, if you want a deployment to pause at 25%, 50%, and 75% of the app rollout, you need to define 3 steps, one for each of those thresholds. The steps have independent **Then wait** behaviors and can be set to all follow the same behavior or different ones.

#### Try out the stage

You can try out the **Kubernetes Progressive** stage using either the `hello-world` sample manifest described below or an artifact that you have. The `hello-world` example deploys NGINX that intentionally takes longer than usual for demonstration purposes.

Perform the following steps:

1. In the Armory Enterprise UI, select an existing app or create a new one.
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

   Select an existing artifact or define a new one as you would for a standard Kubernetes deployment in Armory Enterprise.

7. In the **How to Deploy** section, configure the **Rollout Ratio** and **Then wait** attributes for the deployment.

   Optionally, add more steps to the deployment to configure the rollout behavior. You do not need to create a step for 100% Rollout Ratio. Project Aurora automatically scales the deployment to 100% after the final step you configure.

8.  Save the pipeline.
9.  Trigger a manual execution of the pipeline.

On the **Pipelines** page of the Armory Enterprise UI, select the pipeline and watch the deployment progress. If you set the **Then wait** behavior of any step to **until approved**, this is where you approve the rollout and allow it to continue. After completing the final step you configured, Project Aurora scales the deployment to 100% of the cluster if needed.

## Known issues and limitations

### Manifest limitations

{{< include "known-issues/ki-borealis-manifest-limitation.md" >}}

### `armory.cloud` block location

In Armory Enterprise 2.26.3, the location of where you put the `armory.cloud` config block is different from other versions. Additionally, there is an additional config block for `spec.spinnakerConfig.profiles.gate.spinnaker.extensibility` that contains information for the plugin named `plugins`.

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

Your `spinnaker-local.yml` file should not have the `armory.cloud` block anymore and only contain the block to install the Aurora plugin:

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
