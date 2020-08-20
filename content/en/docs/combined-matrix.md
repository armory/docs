---
title: Product Compatibility Matrix (combined)
description: "Information about what Armory Enterprise for Spinnaker™ supports."
---

<!-- If you don't want to make markdown tables manually, use something like https://www.tablesgenerator.com/markdown_tables# 
Or you can write raw HTML :shrug: You might want to do that if you need to do bulleted lists etc inside of the table
Or a mixture of html + markdown. ## Deployment targets has an example of what this might look like
-->

## Legend
<!-- Copy and paste the below badges that apply to your area -->
**Feature status** describes what state the feature is in and where you should install it. For more information, see [Release Definitions]({{< ref "release-definitions" >}}).

![Generally available](/images/ga.svg) The feature as a whole is generally available. There may be newer extended functionality that is in a different state.

![Early Access](/images/ea.svg) The feature is in Early Access. 

![Experiment](/images/exp.svg) The feature is an Experiment. 

**Enterprise availablility**

![OSS](/images/oss.svg) The feature or parts of it are also available in Open Source Spinnaker.

![Armory](/images/armory.svg) The feature or parts of it are available in Armory Enterprise.

**Versions**

**All supported versions** refers to the current minor release and the two previous minor releases. For example, if the current version is 2.21.x, all supported versions include 2.19.x, 2.20.x, and 2.21.x. 

## Application metrics for Canary

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Application metrics can be ingested by Kayenta to perform Automated Canary Analysis (ACA). The following table lists application metrics providers that Armory Enterprise supports for application metrics



| Provider     | Version   | ACA | Armory Enterprise      | Note                   |
|--------------|-----------|-----|------------------------|------------------------|
| SomeProvider | A.B - C.D | Yes/No   | All supported versions |                        |
| Dynatrace    | A.B - C.D |    | All supported versions | Armory Enterprise only |

## Artifact stores

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Artifacts are remote, deployable resources in Spinnaker. Armory supports the following artifact stores:

| Provider                                                          | Armory Enterprise version | Notes                                          |
|-------------------------------------------------------------------|---------------------------|------------------------------------------------|
| [Bitbucket](https://spinnaker.io/setup/artifacts/bitbucket/)      | All supported versions    |                                                |
| [GitHub](https://spinnaker.io/setup/artifacts/github/)            | All supported versions    |                                                |
| [GitLab](https://spinnaker.io/setup/artifacts/gitlab/)            | All supported versions    |                                                |
| [Git Repo](https://spinnaker.io/setup/artifacts/gitrepo/)         | All supported versions    | Supports using the entire repo as an artifact. |
| [Google Cloud Storage](https://spinnaker.io/setup/artifacts/gcs/) | All supported versions    |                                                |
| [HTTP](https://spinnaker.io/setup/artifacts/http)                 | All supported versions    |                                                |
| [Maven](https://spinnaker.io/setup/artifacts/maven/)              | All supported versions    |                                                |
| [Oracle Object](https://spinnaker.io/setup/artifacts/oracle)      | All supported versions    |                                                |
| [S3](https://spinnaker.io/setup/artifacts/s3/)                    | All supported versions    |                                                |

## As code solutions

### Pipelines as Code

![Generally available](/images/ga.svg) ![Armory](/images/armory.svg)

[Pipelines as Code]({{< ref "install-dinghy" >}}) gives you the ability to manage your pipelines and their templates in source control.

**Supported version control systems**

| Feature   | Version | Armory Enterprise version | Notes                  |
|-----------|---------|---------------------------|------------------------|
| BitBucket Cloud |         | All supported versions    |                        |
| BitBucket Server | Previous two major versions |  All supported versions   |                        |
| GitHub    |         | All supported versions    | Enterprise and GitHub.com |
| GitLab    |         | All supported versions    | |

**Features**

| Feature                                                                           | Armory Enterprise      | Notes |
|-----------------------------------------------------------------------------------|------------------------|-------|
| Modules                                                               | All supported versions | Templatize and re-use pipeline snippets across applications and teams |
| Slack notifications                                                               | All supported versions |       |
| Fiat service account integration                                                               | All supported versions |       |
| Webhook secret validation                                                               | 2.20 or later |       |
| Local modules for development                                                     | 2.20 or later          |       |
| [Pull Request Validation]({{< ref "install-dinghy#pull-request-validations" >}}) | 2.21 or later          |       |

### Pipelines as CRD

![Experiment](/images/exp.svg) ![Armory](/images/armory.svg)

[PaCRD]({{< ref "pacrd" >}}) gives you the ability to manage your pipelines as
Kubernetes custom resources.

| Feature | Armory Enterprise | Notes |
|---|---|---|
| Create, modify, and delete pipeline manifests | All supported versions | Working within the same cluster Spinnaker is installed in. |
| Create, modify, and delete application manifests | All supported versions | Working within the same cluster Spinnaker is installed in. |
| Define all stages supported by Spinnaker and Armory Enterprise | 0.10.x and later | Validation support does not exist for all stages. |

### Terraform Integration 

![Generally available](/images/ga.svg) ![Armory](/images/armory.svg)

The Terraform Integration gives you the ability to use Terraform within your Spinnaker pipelines to create your infrastructure as part of your software delivery pipeline.

**Supported Terraform versions**

| Terraform Versions    | Armory Enterprise      | Note                                                                  |
|-----------------------|------------------------|-----------------------------------------------------------------------|
| 0.11.10 - 0.11.14     | All supported versions |                                                                       |
| 0.12.0 - 0.12.24      | All supported versions |                                                                       |
  
**Features**

| Feature                                                                                        | Armory Enterprise      | Notes |
|------------------------------------------------------------------------------------------------|------------------------|-------|
| [Base Terraform Integration]({{< ref "terraform-enable-integration" >}})                       | All supported versions |       |
| [Named Profiles with authorization]({{< ref "terraform-enable-integration#named-profiles" >}}) | 2.20 or later          |       |


## Authentication

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the authentication protocols that Armory Enterprise supports:

| Identity provider     | Armory Enterprise      | Note                                                                  |
|-----------------------|------------------------|-----------------------------------------------------------------------|
| SAML                  | All supported versions |                                                                       |
| OAuth 2.0/OIDC        | All supported versions | Can use Auth0, Azure, GitHub, Google, Okta, OneLogin, or Oracle Cloud |
| LDAP/Active Directory | All supported versions |                                                                       |
| x509                  | All supported versions                       |                                                                       |

## Authorization

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the authorization methods that Armory Enterprise supports: 

| Provider              | Armory Enterprise      | Note                                                                            |
|-----------------------|------------------------|---------------------------------------------------------------------------------|
| GitHub Teams          | All supported versions | Roles from GitHub are mapped to the Teams under a specific GitHub organization. |
| Google Groups         |                        |                                                                                 |
| LDAP/Active Directory | All supported versions |                                                                                 |
| OAuth 2.0/OIDC        | All supported versions |                                                                                 |
| SAML                  | All supported versions |                                                                                 |

## Browsers

Spinnaker's UI (Deck) works with most modern browsers.
>  COMMENT. REMOVE ME BEFORE PUBLISHING.
>  The above seems like the most maintainable/most non-controversial statement

## Build systems

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the CI systems that Armory Enterprise supports:

| Provider           | Version | Armory Enterprise      | Note                |
|--------------------|---------|------------------------|---------------------|
| AWS CodeBuild      | n/a     | 2.19.x or later        |                     |
| GitHub Actions     | n/a     | All supported versions | Webhook integration |
| Google Cloud Build |         |                        |                     |
| Jenkins            |         | All supported versions |                     |
| Travis             |         | All supported versions |                     |
| Wercker            |         | All supported versions                     |                     |


## Deployment targets

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

| Provider      | Deployment target                                               | Deployment strategies | Armory Enterprise      | Notes |
|---------------|-----------------------------------------------------------------|-----------------------|------------------------|-------|
| Amazon AWS    | EC2, ECS, EKS                                                   |                       | All supported versions |       |
| Cloud Foundry | PKS <ul><li>Versions A.B - X.Y</li></ul>                        |                       | All supported versions |       |
| Google Cloud  | App Engine, Compute Engine, GKE                                 |                       | All supported versions |       |
| Kubernetes    | Manifest-based deployments <ul><li>Versions A.B - X.Y</li></ul> |                       | All supported versions |       |
## Dynamic accounts

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Dynamic accounts (external account configurations) for Spinnaker allow you to manage account configuration outside of Spinnaker, including secrets. Armory Enterprise supports the following backend providers:

#### Backend provider

| Provider | Version | Armory Enterprise | Notes |
|---------|---------|---------|---------|
| Git  | x.y.z | All supported versions |
| S3  | n/a | All supported versions |
| Vault  | x.y.z | All supported versions |

#### Supported Spinnaker services

| Service     | Account types               | Note                                                                                                           |
|-------------|-----------------------------|----------------------------------------------------------------------------------------------------------------|
| Clouddriver | Cloud provider, artifact    | Automatic configuration refreshing is supported for Cloud Foundry and Kubernetes cloud provider accounts only. |
| Echo        | Pub/Sub                     |                                                                                                                |
| Igor        | CI systems, version control |                                                                                                                |

## External storage

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Spinnaker requires an external storage provider for persisting application settings and pipelines. Armory supports the following storage solutions:

| Provider              | Armory Enterprise      | Notes |
|-----------------------|------------------------|-------|
| Azure Storage         | All supported versions |       |
| Google Cloud Storage  | All supported versions |       |
| Minio                 | All supported versions |       |
| S3                    | All supported versions |       |
| Oracle Object Storage | All supported versions |       |

## Observability

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

{{% alert %}}Armory Enterprise 2.20 and later require the Observability plugin for monitoring Spinnaker. Versions earlier than 2.20 use the Spinnaker monitoring daemon, which is deprecated. {{% /alert %}}

| Provider   | Armory Enterprise      | Note |
|------------|------------------------|------|
| Datadog    | All supported versions |      |
| ELK        | All supported versions |      |
| Splunk     | All supported versions |      |


## Notifications

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

The following table lists the notification systems that Armory Enterprise supports:

| Provider   | Armory Enterprise      | Notes |
|------------|------------------------|-------|
| Slack      | All supported versions |       |
| PagerDuty  | All supported versions |       |
| GitHub     | All supported versions |       |
| Jira       | All supported versions |       |
| BearyChat  | All supported versions |       |
| Email      | All supported versions |       |
| GoogleChat | All supported versions |       |
| Twilio     | All supported versions |       |

## Persistent storage

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Depending on the service, Spinnaker can use either Redis or MySQL as the backing store. The following table lists the supported database and the Spinnaker service:

| Database | DB version            | Armory Enterprise      | Spinnaker services                                  | Note                                                                                                                       |
|----------|-----------------------|------------------------|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| Redis    | X.Y.Z                 | All supported versions | All Spinnaker services that require a backing store | The DB versions refer to external Redis instances. By default, Spinnaker deploys Redis internally to support its services. |
| MySQL    | MySQL 5.7 (or Aurora) | All supported versions | Clouddriver, Front50, Orca                          |                                                                                                                            |

Armory recommends using MySQL as the backing store when possible for production instances of Spinnaker. For other services, use an external Redis instance for production instances of Spinnaker.

## Pipeline triggers

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Armory supports using the following methods to trigger Spinnaker pipelines:

| Provider   | Armory Enterprise      | Notes |
|------------|------------------------|-------|
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

## Baking Images

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Armory supports baking images in multiple providers

| Provider   | Armory Enterprise      | Notes |
|------------|------------------------|-------|
| AWS | All supported versions |      |
| GCE | All supported versions |      |
| OCI | All supported versions |      |

## Templating Manifests

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

Armory supporting Templating Manifests

| Provider   | Armory Enterprise      | Notes |
|------------|------------------------|-------|
| Helm 2     | All supported versions |       |
| Helm 3     | 2.19.x or later        |       |
| Kustomize  | All supported versions |  Kustomize version installed is 3.3.0     |


## Secret stores

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

{{% alert title="Note" %}} This section applies to secrets in configuration files, not application secrets. {{% /alert %}}

The following table lists the secret stores that Armory Enterprise supports for referencing secrets in config files securely:

| Provider             | Armory Enterprise      | Notes                                |
|----------------------|------------------------|--------------------------------------|
| [AWS Secrets Manager]({{< ref "secrets-aws-sm" >}})  | All supported versions |                                      |
| [Encrypted GCS Bucket]({{< ref "secrets-gcs" >}}) | All supported versions |                                      |
| [Encrypted S3 Bucket]({{< ref "secrets-s3" >}})  | All supported versions |                                      |
| [Kubernetes secrets]({{< ref "secrets-kubernetes" >}})   | All supported versions | Spinnaker Operator based deployments |
| [Vault]({{< ref "secrets-vault" >}})                | All supported versions | Armory Enterprise only                 |

## Spinnaker Operator

![Generally available](/images/ga.svg) ![OSS](/images/oss.svg) ![Armory](/images/armory.svg)

[Spinnaker Operator](https://github.com/armory/spinnaker-operator) and
[Armory Operator]({{< ref "operator" >}}) provide Spinnaker users with the ability
to install, update, and maintain their clusters via a Kubernetes operator.

| Feature   | Version | Armory Version | Notes                  |
|-----------|---------|---------------------------|------------------------|
| Install, update, and maintain Spinnaker clusters | All supported versions | All supported versions    | |
| Automatically determine Deck/Gate URL configuration if Ingress objects are defined | 1.1.0 or later | 1.1.1 or later | Ingress objects must be defined in the same namespace where Spinnaker lives. |
| Support definition of all Halyard configuration options    | All supported versions    | All supported versions | |
| In cluster mode, validate configuration before apply | All supported versions    | All supported versions | Does not work when installed in "basic" mode. Does not guarantee a valid configuration, but does check for most common misconfigurations. |