---
title: "pf4jStagePlugin Deployment Using the Armory Operator"
linkTitle: "Plugin Deployment - Operator"
description: >
  Deploy the RandomWait Stage plugin to an Operator-managed Armory instance.
---

## Overview of the Random Wait Stage plugin

In this guide, you deploy the `pf4jStagePlugin` plugin from the [spinnaker-plugin-examples](https://github.com/spinnaker-plugin-examples/examplePluginRepository) repository.

By implementing Orca's SimpleStage PF4J extension point, the `pf4jStagePlugin` creates a custom pipeline stage that waits a random number of seconds before signaling success. This plugin consists of a `random-wait-orca` Kotlin server component and a `random-wait-deck` React UI component that uses the rollup.js plugin library.

## Prerequisites

- You are familiar with [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/), which use custom resources to manage applications and their components
- You understand the concept of [managing Kubernetes resources using manifests](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/)
- You have a basic understanding of how the [Armory Operator]({{< ref "armory-operator" >}}) deploys Armory to [Kubernetes](https://kubernetes.io/)
- You have `kubectl` access to an instance of Armory installed using the Armory Operator in `basic` and have permissions to modify and apply the manifest that deploys Armory
- You have read the [Plugin Users Guide](https://spinnaker.io/guides/user/plugins); you are familiar with plugin concepts and the files used when deploying plugins (`repositories.json`, `plugins.json`)

### Armory environment

**This guide assumes you have access to an Armory instance installed using the Armory Operator in `basic` mode. See the [Installing Armory in Lightweight Kubernetes (K3s) using the Armory Operator]({{< ref "operator-k3s" >}}) guide for how to set up a lightweight POC environment.**

The Armory Operator in `basic` mode requires that Armory be installed in the Armory Operator's namespace, which is `spinnaker-operator`. All the examples in this guide use that namespace. If you are using an Armory instance installed by the Armory Operator in `cluster` mode, use the namespace in which Armory was installed rather than `spinnaker-operator`.

## Configure the plugin

Each plugin should provide configuration information. The `pf4jStagePlugin` has details in its repository [README](https://github.com/spinnaker-plugin-examples/pf4jStagePlugin) file.

**This guide assumes you are using Armory installed by the Armory Operator in `basic` mode.** Add plugin configuration in the `/spinnaker-operator/deploy/spinnaker/basic/SpinnakerService.yml` manifest file. Complete configuration information is in the _Operator Reference_ Plugins [section]({{< ref "plugins" >}}).


### `spec.spinnakerConfig.profiles.<service>`

Put configuration in the `service` that the plugin extends.  Only the impacted service will restart when you apply the manifest.

Example:

```yaml
spec:
  # spec.spinnakerConfig - This section is how to specify configuration spinnaker
  spinnakerConfig:
    # spec.spinnakerConfig.config - This section contains the contents of a deployment found in a halconfig .deploymentConfigurations[0]
    profiles:
      orca:
        spinnaker:
          extensibility:
            plugins:
              Armory.RandomWaitPlugin:
                enabled: true
                version: 1.1.17
                config:
                  defaultMaxWaitTime: 15
            repositories:
              examplePluginsRepo:
                id: examplePluginsRepo
                url: https://raw.githubusercontent.com/spinnaker-plugin-examples/examplePluginRepository/master/plugins.json
```

### Deck proxy

You need to configure a `deck-proxy` in Gate if your plugin has a Deck component. Locate the `profiles` section in your `SpinnakerService.yml` and add the proxy information to the `gate` section. This example shows plugin configuration in the `spec.spinnakerConfig.profiles` section and the Deck proxy in the `spec.spinnakerConfig.profiles.gate` section:

```yaml
spec:
  spinnakerConfig:
    # spec.spinnakerConfig.profiles - This section contains the YAML of each service's profile
    profiles:
      gate:
        spinnaker:
          extensibility:
            deck-proxy: # you need this for plugins with a Deck component
              enabled: true
              plugins:
                Armory.RandomWaitPlugin:
                  enabled: true
                  version: 1.1.17
            repositories:
              examplePluginsRepo:
                url: https://raw.githubusercontent.com/spinnaker-plugin-examples/examplePluginRepository/master/plugins.json
      orca:
        spinnaker:
          extensibility:
           plugins:
             Armory.RandomWaitPlugin:
              enabled: true
              version: 1.1.17
              config:
                defaultMaxWaitTime: 15
           repositories:
             examplePluginsRepo:
              id: examplePluginsRepo
              url: https://raw.githubusercontent.com/spinnaker-plugin-examples/examplePluginRepository/master/plugins.json
```

Note: `repositories`, `plugins`, and `deck-proxy` are all at the same level, which is directly below `extensibility`.

<details><summary>Show  complete SpinnakerService.yml file</summary>
{{< gist armory-gists 5c104bc6602861862eab13169b67fbb5 >}}
</details><br/>

## Redeploy Armory

From the `spinnaker-operator` directory:

```bash
kubectl -n spinnaker-operator apply -f deploy/spinnaker/basic/SpinnakerService.yml
```

You can check pod status by executing:

```bash
kubectl -n spinnaker-operator get pods
```

## Access the RandomWait plugin in the UI

The RandomWait stage appears in the **Type** select list when you create a new Pipeline stage.

{{< figure src="/images/plugins/randomWaitTypeUI.png" caption="Random Wait stage in Type select list" >}}

{{< figure src="/images/plugins/randomWaitStageUI.png" caption="Random Wait stage after it has been selected and the configuration panel is visible." >}}

## Troubleshooting

If the plugin doesn't appear in the **Type** select list, check the following logs:

- Orca, for the plugin backend

  ```bash
  kubectl -n spinnaker-operator logs -f <orca-pod-name>
  ```

  You should see output similar to this when the plugin has been successfully loaded:

  ```bash
   2020-08-25 20:10:34.103  INFO 1 --- [           main] .k.p.u.r.s.LatestPluginInfoReleaseSource : [] Latest release version '1.1.14' for plugin 'Armory.RandomWaitPlugin'
   2020-08-25 20:10:34.116  INFO 1 --- [           main] .k.p.u.r.s.SpringPluginInfoReleaseSource : [] Spring configured release version '1.1.14' for plugin 'Armory.RandomWaitPlugin'
   2020-08-25 20:10:34.117  INFO 1 --- [           main] p.u.r.s.PreferredPluginInfoReleaseSource : [] No preferred release version found for 'Armory.RandomWaitPlugin'
   2020-08-25 20:10:34.501  INFO 1 --- [           main] org.pf4j.util.FileUtils                  : [] Expanded plugin zip 'Armory.RandomWaitPlugin-pf4jStagePlugin-v1.1.14.zip' in 'Armory.RandomWaitPlugin-pf4jStagePlugin-v1.1.14'
   2020-08-25 20:10:34.512  INFO 1 --- [           main] org.pf4j.util.FileUtils                  : [] Expanded plugin zip 'orca.zip' in 'orca'
   2020-08-25 20:10:34.525  INFO 1 --- [           main] org.pf4j.AbstractPluginManager           : [] Plugin 'Armory.RandomWaitPlugin@unspecified' resolved
   2020-08-25 20:10:34.528  INFO 1 --- [           main] org.pf4j.AbstractPluginManager           : [] Start plugin 'Armory.RandomWaitPlugin@unspecified'
   2020-08-25 20:10:34.542  INFO 1 --- [           main] i.a.p.s.wait.random.RandomWaitPlugin     : [] RandomWaitPlugin.start()
  ```

  If you see log output similar to

  ```bash
  Plugin 'Armory.RandomWaitPlugin@unspecified' requires a minimum system version of orca>=8.0.0, and you have 1.0.0
  2020-07-01 16:52:13.170  WARN 1 --- [           main] org.pf4j.AbstractPluginManager           : [] Plugin '/opt/orca/plugins/Armory.RandomWaitPlugin-pf4jStagePlugin-v1.1.13/orca' is invalid and it will be disabled
  ```

  ...the plugin doesn't work with the version of Spinnaker you are using. Contact the plugin's developer.

  If you see `this.pluginId must not be null`, the plugin manifest file is missing values. Contact the plugin's developer.

- Gate, for the plugin frontend

  ```bash
  kubectl -n spinnaker-operator logs -f <gate-pod-name>
  ```

  You should see output similar to this when the plugin has been successfully loaded:

  ```bash
  2020-08-26 18:42:49.154  INFO 1 --- [TaskScheduler-8] c.n.s.gate.plugins.deck.DeckPluginCache  : Refreshing plugin cache
  2020-08-26 18:42:49.229  INFO 1 --- [TaskScheduler-8] .k.p.u.r.s.LatestPluginInfoReleaseSource : Latest release version '1.1.14' for plugin 'Armory.RandomWaitPlugin'
  2020-08-26 18:42:49.229  INFO 1 --- [TaskScheduler-8] .k.p.u.r.s.SpringPluginInfoReleaseSource : Spring configured release version '1.1.14' for plugin 'Armory.RandomWaitPlugin'
  2020-08-26 18:42:49.229  INFO 1 --- [TaskScheduler-8] c.n.s.gate.plugins.deck.DeckPluginCache  : Cached 1 deck plugins
  ```

  If Gate can't find your frontend plugin, make sure you configured `deck-proxy` correctly.

## Upgrade a plugin

Edit the plugin's entry in the `SpinnakerService.yml` file and [redeploy Armory](#redeploy-armory).

## Delete a plugin

Delete the plugin's entry in the `SpinnakerService.yml` file and [redeploy Armory](#redeploy-armory).
