---
title: Policy Engine for Armory Enterprise
linkTitle: Policy Engine
description: >
  The Policy Engine enforces policies on your Armory Enterprise instance. Policies can help you make sure that best practices are followed by preventing pipelines from being saved, stopping pipelines from running, or preventing certain users from taking certain actions.
---

![Proprietary](/images/proprietary.svg)

## Overview

The Armory Policy Engine is a proprietary feature for Armory Enterprise that is designed to allow enterprises more complete control of their software delivery process by providing you with the hooks necessary to perform extensive verification of pipelines and processes in Armory Enterprise.  The Policy Engine uses the [Open Policy Agent](https://www.openpolicyagent.org/) (OPA) and input style documents to perform validations on the following:

* **Save time validation** - Validate pipelines as they're created or modified. Tasks with no policies are not validated.
* **Runtime validation** - Validate deployments as a pipeline is executing. Tasks with no policies are not validated.
* **Entitlements using API Authorization** - Requires the Policy Engine Plugin. Enforce restrictions on who can perform certain actions in Armory Enterprise. Note that if you enable policies for API authorization, you must configure who can make API calls or else the API service (Gate) rejects all API calls.

> If no policies are configured for these policy checks, all actions are allowed.

The Policy Engine exists as a plugin, which is its newer iteration, and as an extension of Armory Enterprise. The plugin has additional features that are not present in the extension. If you are getting started with the Policy Engine, Armory recommends using the plugin version of the Policy Engine. If you want to migrate from the extension to the plugin, see [Migrating to the Policy Engine Plugin](#migrating-to-the-policy-engine-plugin).

At a high level, adding policies for the Policy Engine to use is a two-step process:

1. Create the policies and save them to a `.rego` file.
2. Add the policies to the OPA server with a ConfigMap or API request.

These policies are evaluated against the packages that Armory Enterprise services sends between its services. For list of packages that you can write policies against, see [Policy Engine Packages]({{< ref "packages.md" >}}), and for example policies that use those packages, see [Example Policies]({{< ref "example-policies.md" >}})

For information about how to use the Policy Engine, see [Using the Policy Engine]({{< ref "policy-engine-use" >}}).