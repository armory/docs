---
title: Policy Engine for Armory Continuous Deployment and Spinnaker
linkTitle: Policy Engine
no_list: true
description: >
  The Policy Engine enforces policies on your Armory Continuous Deployment or open source Spinnaker instance. Policies can help you make sure that best practices are followed by preventing pipelines from being saved, stopping pipelines from running, or preventing certain users from taking certain actions.
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

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "policy-engine-enable.md" >}}