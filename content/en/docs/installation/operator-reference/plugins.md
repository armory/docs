---
title: Plugins Config
weight: 2
description: >
  This page describes `spec.spinnakerConfig.config.spinnaker.extensibility.plugins`.
aliases:
  - /operator_reference/plugins/
---

{{% alert title="Warning" color="warning" %}}
Plugins are an experimental feature in Armory Spinnaker 2.20.3 (Spinnaker 1.20.6). Please see the [Plugins User Guide]<https://www.spinnaker.io/guides/user/plugin-users/> for a detailed explanation of how to add and configure plugins.
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
          url: <url-to-repositories.json>
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
    - `id`: <same-as-repository-name>
    - `url`: <url-to-repositories.json>


### Example

The example below configures the [`pf4jStagePlugin`](https://github.com/spinnaker-plugin-examples/pf4jStagePlugin).

```yaml
spinnaker:
    extensibility:
      plugins:
        Armory.RandomWeightPlugin:
          id: Armory.RandomWeightPlugin
          enabled: true
          version: 1.1.14
          extensions:
            armory.randomWaitStage:
              id: armory.randomWaitStage
              enabled: true
              config:
                defaultMaxWaitTime: 25
      repositories:
        examplePluginsRepo:
          id: examplePluginsRepo
          url: https://raw.githubusercontent.com/spinnaker-plugin-examples/examplePluginRepository/master/plugins.json
```

You need to configure a `deck-proxy` in Gate if your plugin has a Deck component. Locate the `profiles` section in `SpinnakerService.yml` and add the proxy information to the `gate` section.

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
                Armory.RandomWaitPlugin
                  enabled: true
                  version: 1.1.14
              repositories:
                examplePluginsRepo:
                  url: https://raw.githubusercontent.com/spinnaker-plugin-examples/examplePluginRepository/master/plugins.json
      igor: {}    # is the contents of ~/.hal/default/profiles/igor.yml
      kayenta: {} # is the contents of ~/.hal/default/profiles/kayenta.yml
      orca: {}    # is the contents of ~/.hal/default/profiles/orca.yml
```