---
title: Policy Engine Reference
description: >
  Use this reference information to help you create policies for Armory Enterprise that meet your needs.
---

## Package names

Policies for the Policy Engine must have a package name. This package name defines what actions the policy gets enforced on. The following table describes the packages:

| Package(s)                                                                         | Affected service(s)                                                                                                    | Potential uses |
|------------------------------------------|------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| <ul> <li>`spinnaker.persistence.pipelines.*` </li><li> `opa.pipelines.*`</li></ul> | Front50, which is responsible for managing the cache and external storage. |  Saving pipelines, configurations or jobs |
| `spinnaker.execution.pipelines.*` | Orca, which is the orchestration service |  Limiting what kinds of pipelines can be executed |
|  `spinnaker.http.authz` | Gate, the API service for Armory Enterprise | <ul><li>Controlling what groups can save pipelines</li><li>Querying the API</li> |
| <>

