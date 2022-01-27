---
title: Cloud Foundry as a Deployment Target in Armory Enterprise
linkTitle: Cloud Foundry as Deployment Target
description: Learn how to configure Cloud Foundry as a deployment target in Armory Enterprise.
weight: 1
---

## Overview: How Armory Enterprise interacts with Cloud Foundry

{{< figure width="618" height="207" src="/images/cf/CloudFoundrySpinnaker.png"  alt="Spinnaker - Cloud Foundry Deployment Design"  caption="<i>Spinnaker - Cloud Foundry Deployment Design</i>">}}

Armory Enterprise has caching agents for Cloud Foundry Server Groups, Load Balancers, and Spaces. In order to perform caching and operations, these caching agents communicate directly with the Cloud Foundry Cloud Controller via its REST API. The caching agents run on a specific interval, typically every 30 seconds. You can read more about caching agents in the {{< linkWithTitle "caching-agents-concept.md" >}} guide.


> If you are using open source Spinnaker, see the Spinnaker docs' [Cloud Foundry](https://spinnaker.io/setup/install/providers/cf/) guide for how to add a Cloud Foundry account using Halyard.

## {{% heading "prereq" %}}

This document assumes the following:

* You have access to a running Armory Enterprise instance.
* You use the Armory Operator for Kubernetes to configure your Armory Enterprise instance.
* You have a valid Cloud Foundry account with at least `Space Developer` access to one or more spaces.
   - **Cloud Foundry administrators** should configure the minimal amount of permissions required by Armory Enterprise to successfully function. This typically means the Cloud Foundry account has `Space Developer` permissions for at least one organization/space. In some cases, it may make sense to have one account for the entire Foundation, but this configuration isn't normal or desired for security reasons.
   - **Armory Enterprise administrators** can configure one or more Cloud Foundry accounts as cloud providers.
   - **Armory Enterprise users** can use a Cloud Foundry account as a deployment target. Users can perform Cloud Foundry operations by using the Cloud Foundry [stages](https://spinnaker.io/reference/pipeline/stages/#cloud-foundry) in their pipelines.

* Armory Enterprise must be able to reach your Cloud Foundry API endpoint. See the Cloud Foundry [docs](https://docs.cloudfoundry.org/running/cf-api-endpoint.html) for how to identify the API endpoint and version.


## Configure Cloud Foundry as a deployment target

At a minimum, each Cloud Foundry account in Armory Enterprise should have the following:

* `name`: The name of the Cloud Foundry account in Armory Enterprise.
* `environment`: The environment name for the account. Many accounts can share the same environment (e.g. dev, test, prod)
* `user`: User name for the account to use on for this CloudFoundry Foundation
* `password`: Password for the account to use on for this CloudFoundry Foundation. Supports encrypted value.
* `apiHost`: Host of the CloudFoundry Foundation API endpoint. Example: `api.sys.somesystem.com`

You may also want to configure:

* `appsManagerUrl`: HTTP(S) URL of the Apps Manager application for the CloudFoundry Foundation. Example: `https://apps.sys.somesystem.com`.
* `metricsUrl`: HTTP(S) URL of the metrics application for the CloudFoundry Foundation. Example: `https://metrics.sys.somesystem.com`

See the Operator [provider configuration reference]({{< ref "providers#cloud-foundry">}} ) for the full list of values supported by Cloud Foundry accounts in Armory Enterprise.

Add the following Cloud Foundry configuration to your `SpinnakerServce` manifest, replacing placeholders with your values:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
 name: spinnaker
spec:
 spinnakerConfig:
   config:
     providers:
       cloudfoundry:
         enabled: true
         accounts:
           - name: <your-cf-account>
             environment: <your-env>
             requiredGroupMembership: []
             permissions: {}
             providerVersion: V1
             user: <your-user-account>
             password: <your-secret-password>
             apiHost: <your-cf-api-endpoint>
             appsManagerUri: <apps-manager-url>
             metricsUri: <metrics-url>
             skipSslValidation: false
         primaryAccount: <your-cf-primary-account>
```

Apply your changes:

```bash
kubectl -n <your-armory-enterprise-namespace> apply -f <path-to-SpinnakerService.yml>
```

### Verify the Cloud Foundry account appears in the Armory Enterprise UI

After you apply your changes, you should see the new Cloud Foundry account in your Armory Enterprise UI and be able to deploy to it.

>To see the changes, you may have to clear your browser cache / hard refresh your browser (`cmd-shift-r` or `control-shift-r`)

## Best practices

### Buildpacks and Procfiles

Buildpacks typically define processes that run with some default values. These default values include things like starting process and commands. Some buildpacks, like Python, do not specify any default processes. During staging, the following error occurs if there are no processes defined: `StagingError - Staging error: No process types returned from stager.` Any buildpacks that do not specify a default process run into the same issue.

When developers use the `COMMAND` option in a manifest with the Cloud Foundry (CF) CLI, this command gets propagated to the process, and it gets used as expected. This is, in part, due to the fact that the CF CLI uses the v2 endpoints for most of the operations. Spinnaker, however, is configured to use various v3 endpoints. These allow more granular control over the deployment.

The solution is to use [Procfiles](https://docs.cloudfoundry.org/buildpacks/prod-server.html#procfile) if the buildpack does not include any default processes, like the Python buildpack. These Procfiles live at the root of an application and are evaluated during staging. This ensures that the staging does not fail because no processes are present.

Once you have a Procfile, additional customization can be added by using the `COMMAND` option in manifests. Any options supplied this way override the Procfile. But, start with a Procfile to ensure that stages do not fail because of missing commands.




