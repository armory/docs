---
title: Add a Cloud Foundry Account in Spinnaker
linkTitle: Add a Cloud Foundry Account
description: Add a Cloud Foundry account as a cloud provider deployment target in Spinnaker.
---

## {{% heading "prereq" %}}

This document assumes the following:

* You are familiar with how Spinnaker uses Cloud Foundry as a deployment target. See the {{< linkWithTitle "cloud-foundry-concept.md" >}} guide for details.
* You have access to a running Spinnaker instance.
* You use the Armory Operator or the Spinnaker Operator for Kubernetes to configure your Spinnaker instance.
* You have a valid Cloud Foundry account with at least `Space Developer` access to one or more spaces.

> If you manage Spinnaker using Halyard, see the open source Spinnaker docs' [Cloud Foundry](https://spinnaker.io/setup/install/providers/cf/) guide for how to add a Cloud Foundry account using Halyard.

## Add the Cloud Foundry account to Spinnaker

> Spinnaker must be able to reach your Cloud Foundry API endpoint. See the Cloud Foundry [docs](https://docs.cloudfoundry.org/running/cf-api-endpoint.html) for how to identify the API endpoint and version.

At a minimum, each Cloud Foundry account in Spinnaker should have the following:

* `name`: The name of the Cloud Foundry account in Spinnaker.
* `environment`: The environment name for the account. Many accounts can share the same environment (e.g. dev, test, prod)
* `user`: User name for the account to use on for this CloudFoundry Foundation
* `password`: Password for the account to use on for this CloudFoundry Foundation. Supports encrypted value.
* `apiHost`: Host of the CloudFoundry Foundation API endpoint. Example: `api.sys.somesystem.com`

You may also want to configure:

* `appsManagerUrl`: HTTP(S) URL of the Apps Manager application for the CloudFoundry Foundation. Example: `https://apps.sys.somesystem.com`.
* `metricsUrl`: HTTP(S) URL of the metrics application for the CloudFoundry Foundation. Example: `https://metrics.sys.somesystem.com`

See the Operator [provider configuration reference]({{< ref "providers#cloud-foundry">}} ) for the full list of values supported by Cloud Foundry accounts in Spinnaker.

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
kubectl -n <your-spinnaker-namespace> apply -f <path-to-SpinnakerService.yml>
```

## Verify the Cloud Foundry account appears in the Spinnaker UI

After you apply your changes, you should see the new Cloud Foundry account in your Spinnaker UI and be able to deploy to it.

>To see the changes, you may have to clear your browser cache / hard refresh your browser (`cmd-shift-r` or `control-shift-r`)

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "best-practices-cf.md" >}}