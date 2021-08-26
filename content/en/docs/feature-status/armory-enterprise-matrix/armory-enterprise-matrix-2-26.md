---
title: v2.26 Armory Enterprise Compatibility Matrix
description: "Information about support and compatibility for Armory Enterprise and the products and platforms that it integrates with."
toc_hide: true
aliases:
  - /docs/armory-platform-matrix/
  - /docs/armory-enterprise-matrix/
---

<!-- If you don't want to make markdown tables manually, use something like https://www.tablesgenerator.com/markdown_tables#
Or you can write raw HTML :shrug: You might want to do that if you need to do bulleted lists etc inside of the table
Or a mixture of html + markdown. ## Deployment targets has an example of what this might look like
-->

This page describes the features and capabilities that Armory supports. Note that although Spinnaker™ is part of Armory Enterprise, what Open Source Spinnaker supports and what Armory supports is not a one-to-one relationship.

> For information about the system requirements to install Armory Enterprise, see {{< linkWithTitle "system-requirements" >}}. Previously, some of that information, such as storage requirements, was listed on this page.

## Legend
<!-- Copy and paste the below badges that apply to your area -->
**Feature status** describes what state the feature is in and where you should install it. For more information, see [Release Definitions]({{< ref "release-definitions" >}}). You can also click on the feature status badge directly.

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) The feature as a whole is generally available. There may be newer extended functionality that is in a different state.

[Beta]({{< ref "release-definitions#beta" >}}) The feature is in Early Access. For more information about using this feature, [contact us](https://www.armory.io/contact-us/).

[![Early Access](/images/ea.svg)]({{< ref "release-definitions#early-release">}}) The feature is in Early Access. For more information about using this feature, [contact us](https://www.armory.io/contact-us/).

[![Experiment](/images/exp.svg)]({{< ref "release-definitions#experiment">}}) The feature is an Experiment. For more information about using this feature, [contact us](https://www.armory.io/contact-us/).

**Enterprise availablility**

![OSS](/images/oss.svg) The feature or parts of it are available in open source Spinnaker.

![Proprietary](/images/proprietary.svg) The feature or parts of it are available only as part of Armory Enterprise for Spinnaker.[^1]

**Versions**

**All supported versions** for the Armory version refers to the current minor release and the two previous minor releases. For example, if the current version is 2.21.x, all supported versions include 2.19.x, 2.20.x, and 2.21.x. For third-party software, "all supported versions" refers to actively maintained versions by the provider.

## Armory Agent

[![Early Access](/images/ea.svg)]({{< ref "release-definitions#early-release">}})![Proprietary](/images/proprietary.svg)

{{< include "agent/agent-compat-matrix.md" >}}

For a full list of previous releases, see this [page](https://armory.jfrog.io/artifactory/manifests/).

## Armory Operator

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Proprietary](/images/proprietary.svg)

The [Armory Operator]({{< ref "armory-operator" >}}) and [Spinnaker Operator](https://github.com/armory/spinnaker-operator) provide you with the ability to install, update, and maintain your clusters via a Kubernetes operator.

| Feature                                                                            | Version                | Armory Version         | Notes                                                                                                                                     |
| ---------------------------------------------------------------------------------- | ---------------------- | ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| Install, update, and maintain Spinnaker clusters                                   | All supported versions | All supported versions |                                                                                                                                           |
| Automatically determine Deck/Gate URL configuration if Ingress objects are defined | 1.1.0 or later         | 1.1.1 or later         | Ingress objects must be defined in the same namespace where Spinnaker lives.                                                              |
| Support definition of all Halyard configuration options                            | All supported versions | All supported versions |                                                                                                                                           |
| In cluster mode, validate configuration before apply                               | All supported versions | All supported versions | Does not work when installed in "basic" mode. Does not guarantee a valid configuration, but does check for most common misconfigurations. |

[^1]: Some of Armory's features are proprietary and require a license for use. For more information, see the [Terms of Service](https://www.armory.io/terms-of-service/) and [Terms & Conditions](https://www.armory.io/terms-and-conditions/).


## Application metrics for Canary Analysis

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Proprietary](/images/proprietary.svg)

Application metrics can be ingested by Kayenta to perform Canary Analysis or Automated Canary Analysis (ACA). For information about how to enable Canary Analysis, see {{< linkWithTitle kayenta-configure.md >}}.

The following table lists supported app metric providers:

| Provider       | Version                | ACA | Armory                 | Note |
|----------------|------------------------|-----|------------------------|------|
| [AWS Cloudwatch]({{< ref "kayenta-canary-cloudwatch.md" >}}) | All supported versions | Yes | 2.23.1 or later        |      |
| Datadog      | All supported versions | Yes | 2.26.0 or later        | [Beta]({{< ref "release-definitions#beta" >}})     |
| [Dynatrace]({{< ref "kayenta-canary-dynatrace.md" >}})      | All supported versions | Yes | 2.23.0 or later        |      |
| Graphite       | All supported versions | Yes | All supported versions |      |
| New Relic      | All supported versions | Yes | All supported versions |      |
| Prometheus | All supported versions | Yes | All supported versions | Authentication using a bearer token is supported. Armory supports offerings that are proprietary versions of Prometheus, such as Cortex, to the extent that the offering overlaps with open source Prometheus. That is, Armory guarantees functionality that is compatible with open source Prometheus. Compatibility between open source Prometheus and the proprietary version is the responsibility of that vendor, not Armory.    |
| SignalFx       | All supported versions | Yes | All supported versions |      |
| Stackdriver    | All supported versions | Yes | All supported versions |      |

## Artifacts

Artifacts are  deployable resources.

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg)

The following table lists the supported artifact stores:

| Provider                                                          | Armory                 | Notes                                                               |
| ----------------------------------------------------------------- | ---------------------- | ------------------------------------------------------------------- |
| [Bitbucket](https://spinnaker.io/setup/artifacts/bitbucket/)      | All supported versions |                                                                     |
| Container registries                                              | All supported versions | Docker Hub, ECR, and GCR                                                                     |
| [GitHub](https://spinnaker.io/setup/artifacts/github/)            | All supported versions |                                                                     |
| [Git Repo](https://spinnaker.io/setup/artifacts/gitrepo/)         | All supported versions | GitHub or Bitbucket. Supports using the entire repo as an artifact. |
| [Google Cloud Storage](https://spinnaker.io/setup/artifacts/gcs/) | All supported versions |                                                                     |
| [HTTP](https://spinnaker.io/setup/artifacts/http)                 | All supported versions |                                                                     |
| [Maven](https://spinnaker.io/setup/artifacts/maven/)              | All supported versions |                                                                     |
| [S3](https://spinnaker.io/setup/artifacts/s3/)                    | All supported versions |                                                                     |

## As code solutions

### Pipelines as Code

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![Proprietary](/images/proprietary.svg)

[Pipelines as Code]({{< ref "dinghy-enable" >}}) gives you the ability to manage your pipelines and their templates in source control by creating and maintaining `dinghyfiles` that contain text representations of pipelines. These files are then ingested by Armory to generate pipelines that your app devs can use to deploy their apps.

**Templating languages**

To create `dinghyfiles`, you can use one of the following templating languages:

* HashiCorp Configuration Language (HCL) [![Early Access](/images/ea.svg)]({{< ref "release-definitions#early-release">}})
* JSON [![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}})
* YAML [![Early Access](/images/ea.svg)]({{< ref "release-definitions#early-release">}})

**Version control systems**

The following table lists the supported version control systems:

| Feature          | Version                     | Armory version         | Notes           |
| ---------------- | --------------------------- | ---------------------- | --------------- |
| BitBucket Cloud  |                             | All supported versions |                 |
| BitBucket Server | Previous two major versions | All supported versions |                 |
| GitHub           |                             | All supported versions | Hosted or cloud |

**Features**

The following table lists specific features for Pipelines as Code and their supported versions:

| Feature                                                                                | Armory                 | Notes                                                                 |
| -------------------------------------------------------------------------------------- | ---------------------- | --------------------------------------------------------------------- |
| [Fiat service account integration]({{< ref "dinghy-enable#fiat" >}})                   | All supported versions |                                                                       |
| GitHub status notifications                                                            | All supported versions |                                                                       |
| [Local modules for development]({{< ref "using-dinghy#local-module-functionality" >}}) | All supported versions |                                                                       |
| Modules                                                                                | All supported versions | Templatize and re-use pipeline snippets across applications and teams |
| [Pull Request Validation]({{< ref "dinghy-enable#pull-request-validations" >}})        | 2.21 or later          |                                                                       |
| [Slack notifications]({{< ref "dinghy-enable#slack-notifications" >}})                 | All supported versions |                                                                       |
| [Webhook secret validation]({{< ref "using-dinghy#webhook-secret-validation" >}})      | All supported versions |                                                                       |

#### ARM CLI

The ARM CLI is a tool to render `dinghyfiles` and modules. Use it to help develop and validate your pipelines locally.

You can find the latest version on [Docker Hub](https://hub.docker.com/r/armory/arm-cli).

### Pipelines as CRD

> This feature is deprecated. For more information, see [PaCRD Deprecation]{{< ref "pacrd-deprecation.md" >}}.

[PaCRD]({{< ref "pacrd" >}}) gives you the ability to manage your pipelines as
Kubernetes custom resources.

The following table lists the PaCRD features and their supported versions:

| Feature                                             | Armory                         | Notes                                                      |
| --------------------------------------------------- | ------------------------------ | ---------------------------------------------------------- |
| Create, modify, and delete pipeline manifests       | All supported versions         | Working within the same cluster Spinnaker is installed in. |
| Create, modify, and delete application manifests    | All supported versions         | Working within the same cluster Spinnaker is installed in. |
| Define all stages supported by Spinnaker and Armory | PaCRD version 0.10.x and later | Validation support does not exist for all stages.          |

### Terraform Integration

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![Proprietary](/images/proprietary.svg)

The Terraform Integration gives you the ability to use Terraform within your Spinnaker pipelines to create your infrastructure as part of your software delivery pipeline.

**Supported Terraform versions**

The following table lists the supported Terraform versions:

| Terraform Versions | Armory                 | Note |
| ------------------ | ---------------------- | ---- |
| 0.11.10 - 0.11.14  | All supported versions |      |
| 0.12.0 - 0.12.24   | All supported versions |      |
| 0.13.4 - 0.13.5   | 2.24.0 or later |      |
| 0.14.0 - 0.14.2   | 2.24.0 or later |      |

Although other Terraform versions may be usable with Armory and the Terraform Integration, only the versions listed here are supported.

**Features**

The following table lists the Terraform Integration features and their supported versions:

| Feature                                                                                        | Armory                 | Notes |
| ---------------------------------------------------------------------------------------------- | ---------------------- | ----- |
| [Base Terraform Integration]({{< ref "terraform-enable-integration" >}})                       | All supported versions |       |
| [Named Profiles with authorization]({{< ref "terraform-enable-integration#named-profiles" >}}) | All supported versions          |       |


## Authentication

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg)

The following table lists the supported authentication protocols:

| Identity provider     | Armory                 | Note                                                                                                     |
| --------------------- | ---------------------- | -------------------------------------------------------------------------------------------------------- |
| None                  | All supported versions | Armory recommends having Armory Enterprise only accessible through a VPN if this is turned on.                     |
| SAML                  | All supported versions |                                                                                                          |
| OAuth 2.0/OIDC        | All supported versions | You can use any OAuth 2.0 provider such as Auth0, Azure, GitHub, Google, Okta, OneLogin, or Oracle Cloud. |
| LDAP/Active Directory | All supported versions |                                                                                                          |
| x509                  | All supported versions |                                                                                                          |

## Authorization

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg)

The following table lists the supported authorization methods:

| Provider              | Armory                 | Note                                                                                 |
| --------------------- | ---------------------- | ------------------------------------------------------------------------------------ |
| None                  | All supported versions | Armory recommends having Armory Enterprise only accessible through a VPN if this is turned on. |
| GitHub Teams          | All supported versions | Roles from GitHub are mapped to the Teams under a specific GitHub organization.      |
| Google Groups         | All supported versions |                                                                                      |
| LDAP/Active Directory | All supported versions |                                                                                      |
| OAuth 2.0/OIDC        | All supported versions | Requires the provider to include groups in claims or be a supported third party integration.                                                                                     |
| SAML                  | All supported versions |                                                                                      |

## Baking machine images

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg)

The following table lists the supported image bakeries:

| Provider | Armory                 | Notes                      |
| -------- | ---------------------- | -------------------------- |
| AWS      | All supported versions |                            |
| GCE      | All supported versions |                            |
| Packer   | All supported versions | The following lists the included Packer versions: <ul><li> Armory 2.22.x includes Packer 1.4.4</li><li>Armory 2.23.x and later include Packer 1.6.4</li></ul> |

## Baking Kubernetes manifests

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) 

The following table lists the supported manifest templating engines:

| Provider  | Armory                 | Notes                                |
| --------- | ---------------------- | ------------------------------------ |
| Helm 2    | All supported versions |                                      |
| Helm 3    | 2.19.x or later        |                                      |
| Kustomize | All supported versions | Kustomize version installed is 3.8.1 |

## Build systems

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) 

The following table lists the supported CI systems:

| Provider           | Version                | Armory                 | Note                |
| ------------------ | ---------------------- | ---------------------- | ------------------- |
| GitHub Actions     | n/a                    | All supported versions | Webhook integration |
| Jenkins            | All supported versions | All supported versions |                     |

## Custom stages

![Proprietary](/images/proprietary.svg)

Armory Enterprise includes custom stages that you can use to extend the capabilities of Armory Enterprise. Some of these stages are available out of the box while others are available as plugins to Armory Enterprise.

| Stage              | Armory           | Notes                 |
|--------------------|------------------|-----------------------|
| [Evaluate Artifacts]({{< ref "evaluate-artifacts-stage-enable.md" >}}) | 2.24.0 and later | [![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) Available as a plugin |

## Deployment targets

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Proprietary](/images/proprietary.svg)

Armory supports various deployment targets.

Here's a [great chart by Google](https://cloud.google.com/docs/compare/aws#service_comparisons) to help you understand how the different deployment targets are categorized. 

### Compute as a Service

<!--
{{< caas-ec2-deploy-strategies.inline >}}
<ul>
    <li>None (always adds a new one)</li>
    <li>Highlander</li>
    <li>Red/Back aka Blue/Green</li>
    <li>Custom (run a custom pipeline)</li>
    <li>Rolling Red/Black</li>
</ul>
{{</ caas-ec2-deploy-strategies.inline >}}
-->

<!--
{{< caas-gce-deploy-strategies.inline >}}
<ul>
    <li>Red/Black aka Blue/Green</li>
    <li>Custom</li>
</ul>
{{</ caas-gce-deploy-strategies.inline >}}
-->

| Provider                    | Deployment strategies                      | Armory         | Notes |
| --------------------------- | ------------------------------------------ | ---------------------- | ----- |
| Amazon AWS EC2              | {{< caas-ec2-deploy-strategies.inline />}} | All supported versions |  AWS Public Cloud only. Armory does not support GovCloud.     |

### Container as a Service Platforms

These are providers that are manifest based, so Armory applies the manifest and leaves the rollout logic to the platform itself.

| Provider           | Version | Armory         | Notes |
| -----------------  | ------------------ | ---------------------- | ----- |
| Kubernetes         | 1.16 or later       | All supported versions |       |
| Amazon AWS EKS     | All versions       | All supported versions |       |
| Google GKE         | All versions       | All supported versions |       |


| Provider       | Deployment strategies                      | Armory         | Notes |
| -------------- | ------------------------------------------ | ---------------------- | ----- |
| Amazon AWS ECS | <ul><li>Red/Black aka Blue/Green</li></ul> | All supported versions |  AWS Public Cloud only. Armory does not support GovCloud.     |


### Platform as a Service

<!--
{{< caas-cf-deploy-strategies.inline >}}
<ul>
    <li>None (always adds a new one)</li>
    <li>Highlander</li>
    <li>Red/Back aka Blue/Green</li>
    <li>Rolling Red/Black</li>
    <li>Custom (run a custom pipeline)</li>
</ul>
{{</ caas-cf-deploy-strategies.inline >}}
-->

| Provider                | Version                   | Deployment strategies                      | Armory         | Notes                    |
| ----------------------- | ------------------------------------ | ------------------------------------------ | ---------------------- | ------------------------ |
| Google Cloud App Engine |                                      | <ul><li>Custom</li></ul>                   | All supported versions |                          |
| Cloud Foundry           | CC API Version: 2.103.0+ and 3.38.0+ | {{< caas-cf-deploy-strategies.inline />}}  | All supported versions | Support for the Cloud Foundry provider is based  on your license agreement with Armory. If you have questions, contact your assigned Technical Account Manager and/or Account Executive. Alternatively, you can reach our Customer Care team at [support@armory.io](mailto:support@armory.io) or visit the [Help Center](https://support.armory.io/) to submit a case. |

### Serverless

You write the function and use Armory to manage the rollout of iterative versions. These are usually hosted by Cloud Providers.


<!--
{{< aws-lambda-deploy-strategies.inline >}}
<ul>
    <li>Red/Black aka Blue Green</li>
    <li>Highlander</li>
    <li>Custom (run a custom pipeline)</li>
</ul>
{{</ aws-lambda-deploy-strategies.inline >}}
-->


| Provider          | Deployment strategies                        | Armory         | Notes |
| ----------------- | -------------------------------------------- | ---------------------- | ----- |
| Amazon AWS Lambda | {{< aws-lambda-deploy-strategies.inline />}} | All supported versions |  AWS Public Cloud only. Armory does not support GovCloud.     |

## Dynamic accounts

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg)

Dynamic accounts (external account configurations) for Spinnaker allow you to manage account configuration outside of Spinnaker, including secrets.

> Note that Armory does not support using dynamic account configuration with Spring Cloud Config Server.

**Backend provider**

The following table lists the supported backends:

| Provider | Version                | Armory                 | Notes |
| -------- | ---------------------- | ---------------------- | ----- |
| Git      | All supported versions | All supported versions |       |
| S3       | n/a                    | All supported versions |       |
| Vault    | All supported versions | All supported versions |       |

**Supported Spinnaker services**

The following table lists the services that support dynamic accounts:

| Service     | Account types               | Note                                                                                                           |
| ----------- | --------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Clouddriver | Cloud provider, artifact    | Automatic configuration refreshing is supported for Cloud Foundry and Kubernetes cloud provider accounts only. |
| Echo        | Pub/Sub                     |                                                                                                                |
| Igor        | CI systems, version control |                                                                                                                |

## Notifications

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg)

The following table lists the supported notification systems:

| Provider   | Armory                 | Notes |
| ---------- | ---------------------- | ----- |
| Email      | All supported versions |       |
| GitHub     | All supported versions |       |
| [MS Teams](https://spinnaker.io/setup/features/notifications/#microsoft-teams)      | 2.23.2 or later |       |
| Slack      | All supported versions |       |
| PagerDuty  | All supported versions |       |

## Observability

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg)

The following table lists the supported observability providers:

| Provider   | Version                | Armory                 | Note                        |
| ---------- | ---------------------- | ---------------------- | --------------------------- |
| New Relic  | All supported versions | All supported versions |                             |
| Prometheus | All supported versions | All supported versions | Use Grafana for dashboards. Armory supports offerings that are proprietary versions of Prometheus, such as Cortex, to the extent that the offering overlaps with open source Prometheus. That is, Armory guarantees functionality that is compatible with open source Prometheus. Compatibility between open source Prometheus and the proprietary version is the responsibility of that vendor, not Armory. |


## Pipeline triggers

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg)

The following table lists the supported pipeline triggers:

| Provider           | Armory                 | Notes |
| ------------------ | ---------------------- | ----- |
| AWS Pub/Sub        | All supported versions |       |
| Cron               | All supported versions |       |
| Docker             | All supported versions | Docker Registry API v2 required      |
| Git                | All supported versions |       |
| GitHub Webhook     | All supported versions |       |
| Google Pub/Sub     | All supported versions |       |
| Jenkins Job        | All supported versions |       |
| Manual             | All supported versions |       |
| Webhook            | All supported versions |       |



## Policy Engine

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![Proprietary](/images/proprietary.svg)

The [Policy Engine]({{< ref "policy-engine-enable" >}}) gives you the ability to ensure any Spinnaker pipeline meets certain requirements you specify.

**OPA requirements**

The Policy Engine requires an Open Policy Agent server. This can be deployed in the same cluster as Spinnaker or in an external cluster.

The following table lists the requirements:

| Requirement | Version         | Note                                                                                                                                  |
| ----------- | --------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| OPA Server  | 0.12.x or later | Specifically, the v1 API must be available. When you specify the OPA server URL in the Armory configs, include `v1` in the URL: `http://<your-opa-server>:<port>/v1`.                                                                                                                                      |

**Supported validations**

| Validation           | Armory                 | Note                                                                                                             |
| -------------------- | ---------------------- | ---------------------------------------------------------------------------------------------------------------- |
| Save time validation | All supported versions | If no policies are set, you cannot save any pipelines until you set any policy or turn off save time validation. |
| Runtime validation   | All supported versions | If no policies are set, no policy enforcement occurs and pipelines run as they do normally.                      |

## Secret stores

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Proprietary](/images/proprietary.svg)

{{% alert title="Note" %}} This section applies to secrets in configuration files, not application secrets. {{% /alert %}}

The following table lists the supported secret stores for referencing secrets in config files securely:

| Provider                                               | Armory                 | Notes                                |
| ------------------------------------------------------ | ---------------------- | ------------------------------------ |
| [AWS Secrets Manager]({{< ref "secrets-aws-sm" >}})    | All supported versions |                                      |
| [Encrypted GCS Bucket]({{< ref "secrets-gcs" >}})      | All supported versions |                                      |
| [Encrypted S3 Bucket]({{< ref "secrets-s3" >}})        | All supported versions |                                      |
| [Kubernetes secrets]({{< ref "secrets-kubernetes" >}}) | All supported versions | Armory Operator based deployments |
| [Vault]({{< ref "secrets-vault" >}})                   | All supported versions | Proprietary feature                          |

