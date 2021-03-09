---
title: Adding a Cloud Foundry Account as a Deployment Target in Spinnaker
linkTitle: Adding a Cloud Foundry Account as Deployment Target
description: Learn what Spinnaker does when it deploys to Cloud Foundry targets and then add a Cloud Foundry account to Spinnaker.
---

![Spinnaker Cloud Foundry Diagram](/images/cf/CloudFoundrySpinnaker.png)

## How Spinnaker operates when deploying to Cloud Foundry targets

At a high level, Spinnaker operates in the following ways when deploying to CF:

* Spinnaker is configured with one or more "Cloud Provider" CF accounts (which you can think of as deployment targets)
* At a minimum, each Cloud Foundry account in Spinnaker should have the following:
  * `name`: The name of the Cloud Foundry account in Spinnaker.
  * `apiHost`: Host of the Cloud Foundry foundation API endpoint.
  * `appsManagerUrl`: HTTP(S) URL of the apps manager application for the Cloud Foundry foundation.
  * `user`: The service account or user for the account to use for the Cloud Foundry foundation.
  * `password`: Password for the account to use on for this Cloud Foundry foundation. Supports encrypted value.
  * Please see [this](https://docs.armory.io/docs/installation/operator-reference/providers/#cloud-foundry) for the full list of values supported by Cloud Foundry accounts on Spinnaker.
* Cloud Foundry operators should aim to configure the minimal amount of permissions required by Spinnaker to successfully function. This typically means the account has `Space Developer` permissions 
  for at least 1 organization/space. In some cases, it may make sense to have 1 account for the entire foundation but this isn't suggested.
* In order to perform caching and operations, spinnaker communicates directly with the Cloud Controller via its REST API. 
* Spinnaker currently has caching agents for Cloud Foundry Server Groups, Load Balancers, and Spaces.
  * These agents run on a specific interval, typically every 30 seconds.
* Most of the common CF CLI operations are split up into stages in Spinnaker
  * With the CLI: `cf create-service SERVICE PLAN SERVICE_INSTANCE`
  * With a Spinnaker Stage: `Deploy Service`

## Prerequisites for adding a Cloud Foundry account

This document assumes the following:

* Your Spinnaker is up and running
* Your Spinnaker was installed and configured via the Operator or Halyard
* You have a valid Cloud Foundry account with at least `Space Developer` access to one or more spaces.

## Add the Cloud Foundry account to Spinnaker

{{< tabs name="add" >}}
{{% tab name="Operator" %}}

Add the following configuration to the `SpinnakerServce` manifest, replacing values as needed:

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
            - name: cf-dev-1
              environment: dev
              requiredGroupMembership: []
              permissions: {}
              providerVersion: V1
              user: admin
              password: supersecretpassword
              api: api.sys.coolappsmanager.cf-app.com
              appsManagerUri: https://apps.coolappsmanager.cf-app.com
              metricsUri: https://metrics.coolappsmanager.cf-app.com
              skipSslValidation: false
          primaryAccount: cf-dev-1 
```

## Verify the Cloud Foundry account appears in the Spinnaker UI

After you apply your changes, you should see the new Cloud Foundry account in your Spinnaker UI and be able to deploy to it.

>Don't forget to clear your browser cache / hard refresh your browser (`cmd-shift-r` or `control-shift-r`)
