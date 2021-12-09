---
title: Cloud Foundry Best Practices
description: >
  Tips on how to use Cloud Foundry with Spinnaker™.
---

## Buildpacks and Procfiles

Buildpacks typically define processes that run with some default values. These default values include things like starting process and commands. Some buildpacks, like Python, do not specify any default processes. During staging, the following error occurs if there are no processes defined: `StagingError - Staging error: No process types returned from stager.` Any buildpacks that do not specify a default process run into the same issue.

When developers use the `COMMAND` option in a manifest with the Cloud Foundry (CF) CLI, this command gets propagated to the process, and it gets used as expected. This is, in part, due to the fact that the CF CLI uses the v2 endpoints for most of the operations. Spinnaker, however, is configured to use various v3 endpoints. These allow more granular control over the deployment.

The solution is to use [Procfiles](https://docs.cloudfoundry.org/buildpacks/prod-server.html#procfile) if the buildpack does not include any default processes, like the Python buildpack. These Procfiles live at the root of an application and are evaluated during staging. This ensures that the staging does not fail because no processes are present.

Once you have a Procfile, additional customization can be added by using the `COMMAND` option in manifests. Any options supplied this way override the Procfile. But, start with a Procfile to ensure that stages do not fail because of missing commands.
