---
title: Product compatibility matrix
description: "Information about what Armory Enterprise supports."
---

<!-- If you don't want to make markdown tables manually, use something like https://www.tablesgenerator.com/markdown_tables# -->

This page describes the tools that Spinnaker integrates with.

## Authentication

The following table lists the authentication protocols that Spinnaker supports:

| Identity provider              	| Spinnaker version 	| Note                                        	|
|-----------------------	|-------------------	|---------------------------------------------	|
| SAML                  	| All versions      	|                                             	|
| OAuth 2.0             	| All versions      	| Can use Azure, GitHub, Google, Oracle Cloud 	|
| LDAP/Active Directory 	| All versions      	|                                             	|
| x509                  	|                   	|                                             	|

## Authorization

The following table lists the authorization methods that Spinnaker supports: 

| Provider              	| Spinnaker version 	| Note                                                                            	|
|-----------------------	|-------------------	|---------------------------------------------------------------------------------	|
| SAML                  	| All versions      	|                                                                                 	|
| LDAP/Active Directory 	| All versions      	|                                                                                 	|
| GitHub Teams          	| All versions      	| Roles from GitHub are mapped to the Teams under a specific GitHub organization. 	|
| Google Groups         	|                   	|                                                                                 	|

## CI systems

The following table lists the CI systems that Spinnaker supports:

| Provider           	| Spinnaker version 	| Note 	|   	|
|--------------------	|-------------------	|------	|---	|
| AWS CodeBuild      	| 2.19.x or later   	|      	|   	|
| Google Cloud Build 	|                   	|      	|   	|
| Jenkins            	| All versions      	|      	|   	|
| Travis             	| All versions      	|      	|   	|
| Wercker             	|                   	|      	|   	|

## Databases

Depending on the service, Spinnaker can use either Redis or MySQL as the backing store. The following table lists the supported database and the Spinnaker service:

| Database 	| DB version 	| Spinnaker version 	| Spinnaker services 	|
|----------	|------------	|-------------------	|--------------------	|
| Redis    	|            	| All versions      	|                    	|
| MySQL    	|            	| All versions      	|                    	|

## Deployment targets



## Metrics

The following table lists the monitoring and analytics:

| Provider   	| Spinnaker version 	| Note                                 	|
|------------	|-------------------	|--------------------------------------	|
| Prometheus 	| All versions      	| Paired with Grafana for dashboarding 	|
| Datadog    	| All versions      	|                                      	|

{{% alert title="Note" %}}Armory Enterprise for Spinnaker versions 2.20 and later require the Observability plugin for monitoring and analytics. Versions earlier than 2.20 use the Spinnaker monitoring daemon, which is deprecated. {{% /alert %}}

## Secret stores

The following table lists the secret stores that Spinnaker supports for referencing secrets in config files securely:

| Provider             | Spinnaker version | Notes  |
|----------------------|--------------------|---|
| AWS Secrets Manager   |                    |   |
| Encrypted GCS Bucket |                    |   |
| Encrypted S3 Bucket  |                    |   |
| Kubernetes secrets   |                    | Requires Spinnaker Operator based deployments |
| Vault                |                    |   |