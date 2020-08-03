---
title: Plugins Config
weight: 2
description: >
  This page describes `spec.spinnakerConfig.config.spinnaker.extensibility.plugins`.
aliases:
  - /operator_reference/plugins/
---

{{% alert title="Warning" color="warning" %}}
Plugins are an experimental feature in Armory Spinnaker 2.20.3 (Spinnaker 1.20.6). Please see the [Plugins User Guide]<https://spinnaker.io/guides/user/plugins> for a detailed explanation of how to add and configure plugins. The examples in the _Plugins User Guide_ use Halyard, but the concepts apply to plugins added using Operator.
{{% /alert %}}

## Parameters

**spec.spinnakerConfig.config.spinnaker.extensibility.plugins**

```yaml
spinnaker:
    extensibility:
      plugins:
        <plugin-name>:
          id:
          enabled:
          version:
          extensions:
            <extension-name>:
              id:
              enabled:
              config: {}
      repositories:
        <repository-name>:
          id: <same-as-repository-name>
          url: <url-to-repositories.json-or-plugins.json>
```

- `plugins`:
  - `<plugin-name>`: suggested format is creator.plugin
    - `id`: plugin ID as defined in plugins.json
    - `enabled`: true or false
    - `version`:  version of the plugin to use
    - `extensions`:
      - `<extension-name>`:
        - `id`: same as the name of the plugin extension
        - `enabled`: true or false
        - `config`: {} - configuration for this specific plugin
- `repositories`:
  - `<repository-name>`:
    - `id`: same as <repository-name>
    - `url`: URL to `repositories.json` or `plugins.json`

See the Plugin Users Guide _Add a plugin repository using Halyard_ [section](https://spinnaker.io/guides/user/plugins/#add-a-plugin-repository-using-halyard) for when you can use `plugins.json` instead of `repositories.json`.

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
                 <plugin-name>
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
  # spec.spinnakerConfig - This section is how to specify configuration spinnaker
  spinnakerConfig:
    # spec.spinnakerConfig.config - This section contains the contents of a deployment found in a halconfig .deploymentConfigurations[0]
    config:
      spinnaker:
        extensibility:
          plugins:
            Armory.RandomWaitPlugin
              enabled: true
              version: 1.1.14
              extensions:
                id: armory.randomWaitStage
                enabled: true
                config:
                  defaultMaxWaitTime: 15
          repositories:
            examplePluginsRepo:
              id: examplePluginsRepo
              url: https://raw.githubusercontent.com/spinnaker-plugin-examples/examplePluginRepository/master/plugins.json


    # spec.spinnakerConfig.profiles - This section contains the YAML of each service's profile
    profiles:
      gate:    # is the contents of ~/.hal/default/profiles/gate.yml
        spinnaker:
          extensibility:
            deck-proxy:
              enabled: true
              plugins:
                Armory.RandomWaitPlugin:
                  enabled: true
                  version: 1.1.14
            repositories:
              examplePluginsRepo:
                url: https://raw.githubusercontent.com/spinnaker-plugin-examples/examplePluginRepository/master/plugins.json
```





