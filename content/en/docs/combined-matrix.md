---
title: Product Compatibility Matrix (combined)
description: "Information about what Armory Enterprise for Spinnaker™ supports."
---

<!-- If you don't want to make markdown tables manually, use something like https://www.tablesgenerator.com/markdown_tables# 
Or you can write raw HTML :shrug: You might want to do that if you need to do bulleted lists etc inside of the table
Or a mixture of html + markdown
-->

Legend:

{{< ea-badge >}} - The feature is in Early Access.

(Beta badge) - The feature is in Beta
{{< ga-badge >}} - The feature is Generally Available.
{{< armory-badge >}} - Indicates an Armory Enterprise only feature

(OSS badge) - Open Source Spinnaker feature

## Application metrics for Canary

(OSS badge)(Armory badge)(GA badge)

> Need to modify these so that they are in a single row. Also need someone with that thing we call talent to make nice badges.

{{< ga-badge >}}{{< armory-badge >}}

Application metrics can be ingested by Kayenta to perform Automated Canary Analysis (ACA). The following table lists application metrics providers that Armory Enterprise supports for application metrics

(Note section should list whether Kayenta supports it for Automated Canary Analysis)

| Provider     | Version   | ACA | Armory Enterprise      | Note                   |
|--------------|-----------|-----|------------------------|------------------------|
| SomeProvider | A.B - C.D | Y   | All supported versions |                        |
| Dynatrace    | A.B - C.D | Y   | All supported versions | Armory Enterprise only |

## * as code solutions

### Pipelines as Code

(Pipelines as Code){{< ref "install-dinghy" >}} gives you the ability to manage your pipelines and their templates in source control.

**Supported version control systems**

| Feature   | Version | Armory Enterprise version | Notes                  |
|-----------|---------|---------------------------|------------------------|
| BitBucket |         | All supported versions    |                        |
| GitHub    |         | All supported versions    | Enterprise and vanilla |

**Features**

| Feature                           | Armory Enterprise | Notes |
|-----------------------------------|---------------------------|-------|
| Slack notifications        | All supported versions    |       |
| Local modules for development | 2.20 or later            |       |

### Pipelines as CRD

### Terraform Integration 

{{< armory-badge >}}
{{< ga-badge >}}

The Terraform Integration gives you the ability to use Terraform within your Spinnaker pipelines to create your infrastructure as part of your software delivery pipeline.

**Supported Terraform versions**
* Versions ABC to XYZ
  
**Features**

| Feature                           | Armory Enterprise | Notes |
|-----------------------------------|---------------------------|-------|
| [Base Terraform Integration]({{< ref "terraform-enable-integration" >}})        | All supported versions    |       |
| [Named Profiles with authorization]({{< ref "terraform-enable-integration#named-profiles" >}}) | 2.20 or later            |       |


## Authentication

The following table lists the authentication protocols that Armory Enterprise supports:

| Identity provider     | Armory Enterprise | Note                                        |
|-----------------------|-------------------|---------------------------------------------|
| SAML                  | All supported versions      |                                             |
| OAuth 2.0/OIDC             | All supported versions      | Can use Auth0, Azure, GitHub, Google, Okta, OneLogin, or Oracle Cloud |
| LDAP/Active Directory | All supported versions      |                                             |
| x509                  |                   |                                             |

## Authorization

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

The following table lists the CI systems that Armory Enterprise supports:

| Provider           | Version | Armory Enterprise      | Note                |
|--------------------|---------|------------------------|---------------------|
| AWS CodeBuild      | n/a     | 2.19.x or later        |                     |
| GitHub Actions     | n/a     | All supported versions | Webhook integration |
| Google Cloud Build |         |                        |                     |
| Jenkins            |         | All supported versions |                     |
| Travis             |         | All supported versions |                     |
| Wercker            |         |                        |                     |


## Deployment targets

| Provider      | Deployment target               | Deployment strategies | Armory Enterprise      | Notes |
|---------------|---------------------------------|-----------------------|------------------------|--|
| Amazon AWS    | EC2, ECS, EKS                   |                       | All supported versions | |
| Cloud Foundry | PKS <ul><li>Versions A.B - X.Y</li></ul>                             |                       | All supported versions | |
| Google Cloud  | App Engine, Compute Engine, GKE |                       | All supported versions | |
| Kubernetes    | Manifest-based deployments <ul><li>Versions A.B - X.Y</li></ul>     |                       | All supported versions | |

## Dynamic accounts

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
| Clouddriver | CLoud provider, artifact    | Automatic configuration refreshing is supported for Cloud Foundry and Kubernetes cloud provider accounts only. |
| Echo        | Pub/Sub                     |                                                                                                                |
| Igor        | CI systems, version control |                                                                                                                |


## Observability

{{% alert %}}Armory Enterprise 2.20 and later require the Observability plugin for monitoring Spinnaker. Versions earlier than 2.20 use the Spinnaker monitoring daemon, which is deprecated. {{% /alert %}}

| Provider   | Armory Enterprise      | Note |
|------------|------------------------|------|
| Datadog    | All supported versions |      |
| ELK        | All supported versions |      |
| Splunk     | All supported versions |      |

## Persistent storage

Depending on the service, Spinnaker can use either Redis or MySQL as the backing store. The following table lists the supported database and the Spinnaker service:

| Database | DB version            | Armory Enterprise      | Spinnaker services                                  | Note                                                                                                                       |
|----------|-----------------------|------------------------|-----------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| Redis    | X.Y.Z                 | All supported versions | All Spinnaker services that require a backing store | The DB versions refer to external Redis instances. By default, Spinnaker deploys Redis internally to support its services. |
| MySQL    | MySQL 5.7 (or Aurora) | All supported versions | Clouddriver, Front50, Orca                          |                                                                                                                            |

Armory recommends using MySQL as the backing store when possible for production instances of Spinnaker. For other services, use an external Redis instance for production instances of Spinnaker.



## Notifications

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



## Secret stores

{{% alert title="Note" %}} This section applies to secrets in configuration files, not application secrets. {{% /alert %}}

The following table lists the secret stores that Armory Enterprise supports for referencing secrets in config files securely:

| Provider             | Armory Enterprise      | Notes                                |
|----------------------|------------------------|--------------------------------------|
| [AWS Secrets Manager]({{< ref "secrets-aws-sm" >}})  | All supported versions |                                      |
| [Encrypted GCS Bucket]({{< ref "secrets-gcs" >}}) | All supported versions |                                      |
| [Encrypted S3 Bucket]({{< ref "secrets-s3" >}})  | All supported versions |                                      |
| [Kubernetes secrets]({{< ref "secrets-kubernetes" >}})   | All supported versions | Spinnaker Operator based deployments |
| [Vault]({{< ref "secrets-vault" >}})                | All supported versions | Armory Enterprise only                 |