---
title: Plugins Config
weight: 2
description: >
  This page describes `spec.spinnakerConfig.config.spinnaker.extensibility.plugins`.
aliases:
  - /operator_reference/plugins/
---

{{% alert title="Warning" color="warning" %}}
Please see the [Plugins User Guide](https://spinnaker.io/guides/user/plugins) for a detailed explanation of plugins and how to add and configure using Halyard. 
{{% /alert %}}

## Parameters

***spec.spinnakerConfig.profiles***

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
              <plugin-name>:
                enabled: <true-or-false>
                version: <version>
                config: {}
            repositories:
              <repository-name>:
                id:
                url:
```

- `plugins`:
  - `<plugin-name>`: suggested format is creator.plugin
    - `id`: plugin ID as defined in plugins.json
    - `enabled`: true or false
    - `version`:  version of the plugin to use
    - `config`: {} - configuration for this specific plugin
- `repositories`:
  - `<repository-name>`:
    - `id`: same as <repository-name>
    - `url`: URL to `repositories.json` or `plugins.json`

See the Plugin Users Guide _Add a plugin repository using Halyard_ [section](https://spinnaker.io/guides/user/plugins/#add-a-plugin-repository-using-halyard) for when you can use `plugins.json` instead of `repositories.json`.

### Deck proxy

You need to configure a `deck-proxy` in Gate if your plugin has a Deck component. Locate the `profiles` section in your `SpinnakerService.yml` and add the proxy information to the `gate` section.

 ```yaml
 # spec.spinnakerConfig.profiles - This section contains the YAML of each service's profile
profiles:
 clouddriver: {} # is the contents of ~/.hal/default/profiles/clouddriver.yml
 # deck has a special key "settings-local.js" for the contents of settings-local.js
 deck:
   # settings-local.js - contents of ~/.hal/default/profiles/settings-local.js
   # Use the | YAML symbol to indicate a block-style multiline string
   settings-local.js: |
     window.spinnakerSettings.feature.kustomizeEnabled = true;
     window.spinnakerSettings.feature.artifactsRewrite = true;
 echo: {}    # is the contents of ~/.hal/default/profiles/echo.yml
 fiat: {}    # is the contents of ~/.hal/default/profiles/fiat.yml
 front50: {} # is the contents of ~/.hal/default/profiles/front50.yml
 gate:
   spinnaker:
     extensibility:
       deck-proxy:
         enabled: true
         plugins:
           <plugin-name>:
             enabled: true
             version: <version>
         repositories:
           <repository-name>:
             url: <url-to-repositories.json-or-plugins.json>
 igor: {}    # is the contents of ~/.hal/default/profiles/igor.yml
 kayenta: {} # is the contents of ~/.hal/default/profiles/kayenta.yml
 orca: {}    # is the contents of ~/.hal/default/profiles/orca.yml
```

### Example

The example below configures the [`pf4jStagePlugin`](https://github.com/spinnaker-plugin-examples/pf4jStagePlugin). The configured repository is a `plugins.json` file rather than a `repositories.json` file.

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
