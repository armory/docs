---
title: Armory Policy Engine Release Notes
linkTitle: Release Notes
weight: 99
description: >
  Release notes for the Armory Policy Engine
---


## Release notes

* 0.4.0 - Update plugin to be compatible with Armory Continuous Deployment 2.36.0 and later.
* 0.3.0 - Fixed bug in 1.28 & 2.28 that prevented proper deserialization of Instant values when validating policies
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

