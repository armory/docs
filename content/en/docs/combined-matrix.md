---
title: Armory Platform Compatibility Matrix
linkTitle: Armory Platform Compatibility
description: "Information about support and compatibility for the Armory Platform."
---

<!-- If you don't want to make markdown tables manually, use something like https://www.tablesgenerator.com/markdown_tables#
Or you can write raw HTML :shrug: You might want to do that if you need to do bulleted lists etc inside of the table
Or a mixture of html + markdown. ## Deployment targets has an example of what this might look like
-->

## Legend
<!-- Copy and paste the below badges that apply to your area -->
**Feature status** describes what state the feature is in and where you should install it. For more information, see [Release Definitions]({{< ref "release-definitions" >}}). You can also click on the feature status badge directly.

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) The feature as a whole is generally available. There may be newer extended functionality that is in a different state.

[![Early Access](/images/ea.svg)]({{< ref "release-definitions#early-release">}}) The feature is in Early Access.

[![Experiment](/images/exp.svg)]({{< ref "release-definitions#experiment">}}) The feature is an Experiment.

**Enterprise availablility**

![OSS](/images/oss.svg) The feature or parts of it are also available in Open Source Spinnaker.

![Armory](/images/armory.svg) The feature or parts of it are available in Armory.

**Versions**

**All supported versions** for the Armory version refers to the current minor release and the two previous minor releases. For example, if the current version is 2.21.x, all supported versions include 2.19.x, 2.20.x, and 2.21.x. For third-party software, "all supported versions" refers to actively maintained versions by the provider.

## Application metrics for Canary Analysis

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Application metrics can be ingested by Kayenta to perform Canary Analysis or Automated Canary Analysis (ACA). The following table lists supported app metric providers:

| Provider    | Version                | ACA | Armory                 | Note |
|:------------|:-----------------------|:----|:-----------------------|:-----|
| Graphite    | All supported versions | Yes | All supported versions |      |
| New Relic   | All supported versions | Yes | All supported versions |      |
| Prometheus  | All supported versions | Yes | All supported versions |      |
| SignalFx    | All supported versions | Yes | All supported versions |      |
| Stackdriver | All supported versions | Yes | All supported versions |      |

## Artifacts

Artifacts are  deployable resources.

### Stores

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported artifact stores:

| Provider                                                          | Armory                 | Notes                                                               |
|:------------------------------------------------------------------|:-----------------------|:--------------------------------------------------------------------|
| [Bitbucket](https://spinnaker.io/setup/artifacts/bitbucket/)      | All supported versions |                                                                     |
| [GitHub](https://spinnaker.io/setup/artifacts/github/)            | All supported versions |                                                                     |
| [GitLab](https://spinnaker.io/setup/artifacts/gitlab/)            | All supported versions |                                                                     |
| [Git Repo](https://spinnaker.io/setup/artifacts/gitrepo/)         | All supported versions | GitHub or Bitbucket. Supports using the entire repo as an artifact. |
| [Google Cloud Storage](https://spinnaker.io/setup/artifacts/gcs/) | All supported versions |                                                                     |
| [HTTP](https://spinnaker.io/setup/artifacts/http)                 | All supported versions |                                                                     |
| [Maven](https://spinnaker.io/setup/artifacts/maven/)              | All supported versions |                                                                     |
| [Oracle Object](https://spinnaker.io/setup/artifacts/oracle)      | All supported versions |                                                                     |
| [S3](https://spinnaker.io/setup/artifacts/s3/)                    | All supported versions |                                                                     |

### Types

The following table lists the supported artifact types:

| Type                                                                                                             | Armory                 | Notes                                     |
|:-----------------------------------------------------------------------------------------------------------------|:-----------------------|:------------------------------------------|
| [Bitbucket file](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/bitbucket-file/)       | All supported versions |                                           |
| [Docker Image](https://spinnaker.io/reference/artifacts-with-artifactsrewrite/types/docker-image/)               | All supported versions | Can be hosted on DockerHub, GCR, ECR, etc |
| [Embedded Base64](https://spinnaker.io/reference/artifacts-with-artifactsrewrite/types/embedded-base64/)         | All supported versions |                                           |
| [GCS Object](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/gcs-object/)               | All supported versions |                                           |
| [Git Repo](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/git-repo/)                   | All supported versions |                                           |
| [GitHub file](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/github-file/)             | All supported versions |                                           |
| [GitLab file](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/gitlab-file/)             | All supported versions |                                           |
| [HTTP file](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/http-file/)                 | All supported versions |                                           |
| [Kubernetes object](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/kubernetes-object/) | All supported versions |                                           |
| [Maven artifact](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/maven-artifact/)       | All supported versions |                                           |
| [Oracle Object](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/oracle-object/)         | All supported versions |                                           |
| [S3 object](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/s3-object/)                 | All supported versions |                                           |

## As code solutions

### Pipelines as Code

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![Armory](/images/armory.svg)

[Pipelines as Code]({{< ref "dinghy-enable" >}}) gives you the ability to manage your pipelines and their templates in source control.

**Supported version control systems**

The following table lists the supported version control systems:

| Feature          | Version                     | Armory version         | Notes           |
|:-----------------|:----------------------------|:-----------------------|:----------------|
| BitBucket Cloud  |                             | All supported versions |                 |
| BitBucket Server | Previous two major versions | All supported versions |                 |
| GitHub           |                             | All supported versions | Hosted or cloud |
| GitLab           |                             | All supported versions |                 |

**Features**

The following table lists specific features for Pipelines as Code and their supported versions:

| Feature                                                                          | Armory                 | Notes                                                                 |
|:---------------------------------------------------------------------------------|:-----------------------|:----------------------------------------------------------------------|
| Modules                                                                          | All supported versions | Templatize and re-use pipeline snippets across applications and teams |
| Slack notifications                                                              | All supported versions |                                                                       |
| Fiat service account integration                                                 | All supported versions |                                                                       |
| Webhook secret validation                                                        | 2.20 or later          |                                                                       |
| Local modules for development                                                    | 2.20 or later          |                                                                       |
| [Pull Request Validation]({{< ref "dinghy-enable#pull-request-validations" >}}) | 2.21 or later          |                                                                       |

### Pipelines as CRD

[![Experiment](/images/exp.svg)]({{< ref "release-definitions#experiment">}}) ![Armory](/images/armory.svg)

[PaCRD]({{< ref "pacrd" >}}) gives you the ability to manage your pipelines as
Kubernetes custom resources.

The following table lists the PaCRD features and their supported versions:

| Feature                                             | Armory                         | Notes                                                      |
|:----------------------------------------------------|:-------------------------------|:-----------------------------------------------------------|
| Create, modify, and delete pipeline manifests       | All supported versions         | Working within the same cluster Spinnaker is installed in. |
| Create, modify, and delete application manifests    | All supported versions         | Working within the same cluster Spinnaker is installed in. |
| Define all stages supported by Spinnaker and Armory | PaCRD version 0.10.x and later | Validation support does not exist for all stages.          |

### Terraform Integration

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![Armory](/images/armory.svg)

The Terraform Integration gives you the ability to use Terraform within your Spinnaker pipelines to create your infrastructure as part of your software delivery pipeline.

**Supported Terraform versions**

The following table lists the supported Terraform versions:

| Terraform Versions | Armory                 | Note |
|:-------------------|:-----------------------|:-----|
| 0.11.10 - 0.11.14  | All supported versions |      |
| 0.12.0 - 0.12.24   | All supported versions |      |

**Features**

The following table lists the Terraform Integration features and their supported versions:

| Feature                                                                                        | Armory                 | Notes |
|:-----------------------------------------------------------------------------------------------|:-----------------------|:------|
| [Base Terraform Integration]({{< ref "terraform-enable-integration" >}})                       | All supported versions |       |
| [Named Profiles with authorization]({{< ref "terraform-enable-integration#named-profiles" >}}) | 2.20 or later          |       |


## Authentication

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported authentication protocols:

| Identity provider     | Armory                 | Note                                                                  |
|:----------------------|:-----------------------|:----------------------------------------------------------------------|
| SAML                  | All supported versions |                                                                       |
| OAuth 2.0/OIDC        | All supported versions | Can use Auth0, Azure, GitHub, Google, Okta, OneLogin, or Oracle Cloud |
| LDAP/Active Directory | All supported versions |                                                                       |
| x509                  | All supported versions |                                                                       |

## Authorization

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported authorization methods:

| Provider              | Armory                 | Note                                                                            |
|:----------------------|:-----------------------|:--------------------------------------------------------------------------------|
| GitHub Teams          | All supported versions | Roles from GitHub are mapped to the Teams under a specific GitHub organization. |
| Google Groups         | All supported versions |                                                                                 |
| LDAP/Active Directory | All supported versions |                                                                                 |
| OAuth 2.0/OIDC        | All supported versions |                                                                                 |
| SAML                  | All supported versions |                                                                                 |

## Baking Images

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported image bakeries:

| Provider | Armory                 | Notes                      |
|:---------|:-----------------------|:---------------------------|
| AWS      | All supported versions |                            |
| GCE      | All supported versions |                            |
| OCI      | All supported versions |                            |
| Packer   | All supported versions | Spinnaker includes Packer. |

## Browsers

Spinnaker's UI (Deck) works with most modern browsers.

## Build systems

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported CI systems:

| Provider           | Version                | Armory                 | Note                |
|:-------------------|:-----------------------|:-----------------------|:--------------------|
| AWS CodeBuild      | n/a                    | 2.19.x or later        |                     |
| GitHub Actions     | n/a                    | All supported versions | Webhook integration |
| Google Cloud Build | n/a                    |                        |                     |
| Jenkins            | All supported versions | All supported versions |                     |
| Travis             | All supported versions | All supported versions |                     |
| Wercker            | All supported versions | All supported versions |                     |

## Deployment targets

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported deployment targets:

| Provider      | Deployment target                                               | Deployment strategies | Armory                 | Notes |
|:--------------|:----------------------------------------------------------------|:----------------------|:-----------------------|:------|
| Amazon AWS    | EC2, ECS, EKS                                                   |                       | All supported versions |       |
| Cloud Foundry | PKS <ul><li>Versions A.B - X.Y</li></ul>                        |                       | All supported versions |       |
| Google Cloud  | App Engine, Compute Engine, GKE                                 |                       | All supported versions |       |
| Kubernetes    | Manifest-based deployments <ul><li>Versions A.B - X.Y</li></ul> |                       | All supported versions |       |
| Docker        | Docker Registry                                                 |                       | All supported versions |       |

## Dynamic accounts

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Dynamic accounts (external account configurations) for Spinnaker allow you to manage account configuration outside of Spinnaker, including secrets.

**Backend provider**

The following table lists the supported backends:

| Provider | Version                | Armory                 | Notes |
|:---------|:-----------------------|:-----------------------|:------|
| Git      | All supported versions | All supported versions |       |
| S3       | n/a                    | All supported versions |       |
| Vault    | All supported versions | All supported versions |       |

**Supported Spinnaker services**

The following table lists the services that support dynamic accounts:

| Service     | Account types               | Note                                                                                                           |
|:------------|:----------------------------|:---------------------------------------------------------------------------------------------------------------|
| Clouddriver | Cloud provider, artifact    | Automatic configuration refreshing is supported for Cloud Foundry and Kubernetes cloud provider accounts only. |
| Echo        | Pub/Sub                     |                                                                                                                |
| Igor        | CI systems, version control |                                                                                                                |

## External storage

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Spinnaker requires an external storage provider for persisting app settings and pipelines. The following table lists the supported storage solutions:

| Provider              | Armory                 | Notes |
|:----------------------|:-----------------------|:------|
| Azure Storage         | All supported versions |       |
| Google Cloud Storage  | All supported versions |       |
| Minio                 | All supported versions |       |
| S3                    | All supported versions |       |
| Oracle Object Storage | All supported versions |       |

## Manifest templating

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported manifest templating engines:

| Provider  | Armory                 | Notes                                |
|:----------|:-----------------------|:-------------------------------------|
| Helm 2    | All supported versions |                                      |
| Helm 3    | 2.19.x or later        |                                      |
| Kustomize | All supported versions | Kustomize version installed is 3.3.0 |

## Notifications

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported notification systems:

| Provider   | Armory                 | Notes |
|:-----------|:-----------------------|:------|
| Slack      | All supported versions |       |
| PagerDuty  | All supported versions |       |
| GitHub     | All supported versions |       |
| Jira       | All supported versions |       |
| BearyChat  | All supported versions |       |
| Email      | All supported versions |       |
| GoogleChat | All supported versions |       |
| Twilio     | All supported versions |       |

<!--## Observability

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

{{% alert %}}Armory 2.20 and later require the Observability plugin for monitoring Spinnaker. Versions earlier than 2.20 use the Spinnaker monitoring daemon, which is deprecated. {{% /alert %}}

The following table lists the supported observabilty providers:

| Provider   | Version                | Armory                 | Note                        |
|:-----------|:-----------------------|:-----------------------|:----------------------------|
| New Relic  | All supported versions | All supported versions |                             |
| Prometheus | All supported versions | All supported versions | Use Grafana for dashboards. |
-->
## Persistent storage

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Depending on the service, Spinnaker can use either Redis or MySQL as the backing store. The following table lists the supported database and the Spinnaker service:

| Database | DB version             | Armory                 | Spinnaker services                                  | Note                                                                                                                       |
|:---------|:-----------------------|:-----------------------|:----------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------|
| Redis    | All supported versions | All supported versions | All Spinnaker services that require a backing store | The DB versions refer to external Redis instances. By default, Spinnaker deploys Redis internally to support its services. |
| MySQL    | MySQL 5.7 (or Aurora)  | All supported versions | Clouddriver, Front50, Orca                          |                                                                                                                            |

Armory recommends using MySQL as the backing store when possible for production instances of Spinnaker. For other services, use an external Redis instance for production instances of Spinnaker.

## Pipeline triggers

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the supported pipeline triggers:

| Provider           | Armory                 | Notes |
|:-------------------|:-----------------------|:------|
| Artifactory        | All supported versions |       |
| AWS CodeBuild      | All supported versions |       |
| AWS Pub/Sub        | All supported versions |       |
| Cron               | All supported versions |       |
| Docker             | All supported versions |       |
| Git                | All supported versions |       |
| GitHub Webhook     | All supported versions |       |
| Google Cloud Build | All supported versions |       |
| Google Pub/Sub     | All supported versions |       |
| Jenkins Job        | All supported versions |       |
| Webhook            | All supported versions |       |
| Manual             | All supported versions |       |
| TravisCI Job       | All supported versions |       |
| Wercker            | All supported versions |       |
| Quay               | All supported versions |       |
| Nexus              | All supported versions |       |
| GitLab             | All supported versions |       |

## Policy Engine

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![Armory](/images/armory.svg)

The [Policy Engine]({{< ref "policy-engine-enable" >}}) gives you the ability to ensure any Spinnaker pipeline meets certain requirements you specify.

**OPA requirements**

The Policy Engine requires an Open Policy Agent server. This can be deployed in the same cluster as Spinnaker or in an external cluster.

The following table lists the requirements

| Requirement | Version         | Note                                                                                                                                  |
|:------------|:----------------|:--------------------------------------------------------------------------------------------------------------------------------------|
| OPA Server  | 0.12.x - 0.13.x |                                                                                                                                       |
| OPA API     | v1              | Only compatible with OPA’s v1 API. When specifying the OPA server URL, include `v1` in the URL: `http://<your-opa-server>:<port>/v1`. |

**Supported validations**

| Validation           | Armory                 | Note                                                                                                             |
|:---------------------|:-----------------------|:-----------------------------------------------------------------------------------------------------------------|
| Save time validation | All supported versions | If no policies are set, you cannot save any pipelines until you set any policy or turn off save time validation. |
| Runtime validation   | All supported versions | If no policies are set, no policy enforcement occurs and pipelines run as they do normally.                      |

## Secret stores

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

{{% alert title="Note" %}} This section applies to secrets in configuration files, not application secrets. {{% /alert %}}

The following table lists the supported secret stores for referencing secrets in config files securely:

| Provider                                               | Armory                 | Notes                                |
|:-------------------------------------------------------|:-----------------------|:-------------------------------------|
| [AWS Secrets Manager]({{< ref "secrets-aws-sm" >}})    | All supported versions |                                      |
| [Encrypted GCS Bucket]({{< ref "secrets-gcs" >}})      | All supported versions |                                      |
| [Encrypted S3 Bucket]({{< ref "secrets-s3" >}})        | All supported versions |                                      |
| [Kubernetes secrets]({{< ref "secrets-kubernetes" >}}) | All supported versions | Spinnaker Operator based deployments |
| [Vault]({{< ref "secrets-vault" >}})                   | All supported versions | Armory only                          |

## Spinnaker Operator

[![Generally available](/images/ga.svg)]({{< ref "release-definitions#ga" >}}) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

[Spinnaker Operator](https://github.com/armory/spinnaker-operator) and
[Armory Operator]({{< ref "operator" >}}) provide Spinnaker users with the ability
to install, update, and maintain their clusters via a Kubernetes operator.

| Feature                                                                            | Version                | Armory Version         | Notes                                                                                                                                     |
|:-----------------------------------------------------------------------------------|:-----------------------|:-----------------------|:------------------------------------------------------------------------------------------------------------------------------------------|
| Install, update, and maintain Spinnaker clusters                                   | All supported versions | All supported versions |                                                                                                                                           |
| Automatically determine Deck/Gate URL configuration if Ingress objects are defined | 1.1.0 or later         | 1.1.1 or later         | Ingress objects must be defined in the same namespace where Spinnaker lives.                                                              |
| Support definition of all Halyard configuration options                            | All supported versions | All supported versions |                                                                                                                                           |
| In cluster mode, validate configuration before apply                               | All supported versions | All supported versions | Does not work when installed in "basic" mode. Does not guarantee a valid configuration, but does check for most common misconfigurations. |
