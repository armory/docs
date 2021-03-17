---
linkTitle: Plugins
title: Creating and Using Plugins in Spinnaker
weight: 25
no_list: true
description: >
  Resources for extending Spinnaker functionality with plugins.
aliases:
  - /spinnaker-user-guides/plugin-creators/
  - /docs/spinnaker-user-guides/plugin-creators/
  - /spinnaker-user-guides/plugin-users/
  - /docs/spinnaker-user-guides/plugin-users/
---

## Spinnaker<sup>TM</sup> plugin guides:

* [Plugin Users Guide](https://spinnaker.io/guides/user/plugins)
  * Explains important concepts and files, such as `plugins.json` and `repositories.json`, that you need to deploy a plugin
  * Specifies what types of plugins you can deploy to Spinnaker
  * Shows how to deploy a plugin using Halyard


* pf4jStagePlugin deployment [walkthrough](https://spinnaker.io/guides/user/plugins/deploy-example/) using Halyard
* pf4jStagePlugin deployment [walkthrough]({{< ref "pf4j-deploy-example" >}}) using the Armory Operator


* Halyard Command Reference

  * [`hal` commands](https://spinnaker.io/reference/halyard/commands/#hal-plugins-repository) to add, update, enable, list, and delete plugin repositories
  * [`hal` commands](https://spinnaker.io/reference/halyard/commands/#hal-plugins) to add, update, enable, list, and delete plugins


* Plugin Creators Guide

  * [Overview](https://spinnaker.io/guides/developer/plugins/) covers taxonomy and types of plugins
  * [Frontend Plugin Development](https://spinnaker.io/guides/developer/plugins/frontend/) shows how to create a frontend plugin using the `pluginsdk`; covers project generation and configuration, development workflow, adding a new stage, and overriding existing Deck components, as well as the plugin build and release process
  * [Backend Service Extension Points](https://spinnaker.io/guides/developer/plugins/backend/) covers creating a new extension point in a Spinnaker service
  * Testing your plugin

    * [Test a Pipeline Stage Plugin](https://spinnaker.io/guides/developer/plugin-creators/deck-plugin/) explains how to set up a local Spinnaker VM environment using Minnaker and Multipass
    * [Plugin Compatibility Testing](https://spinnaker.io/guides/developer/plugins/testing/compatibility-testing/) covers integration testing and automated compatibility testing


## Plugin repositories

* [Spinnaker Plugin Examples](https://github.com/spinnaker-plugin-examples)
* [Armory Plugins](https://github.com/armory-plugins)

## Spinnaker testing environment

The following resources cover how to set up a local development and testing environment:

* [Test a Pipeline Stage Plugin](https://spinnaker.io/guides/developer/plugin-creators/deck-plugin/) explains how to set up a local Spinnaker VM environment using Minnaker and Multiplass
* [Development Environments for Spinnaker Gardening Days](https://spinnaker.io/community/gardening/dev-environment/) covers using Minnaker, connecting to AWS EKS using Telepresence, and the Kubernetes-Docker method with NGROK or Fish   