---
title: Product compatibility matrix
description: "Information about what Armory Enterprise for Spinnaker supports."
---

## CI systems

The following table lists the CI systems that Spinnaker supports:

| Provider           	| Spinnaker version 	| Note 	|   	|
|--------------------	|-------------------	|------	|---	|
| AWS CodeBuild      	| 2.19.x or later   	|      	|   	|
| Google Cloud Build 	|                   	|      	|   	|
| Jenkins            	| All versions      	|      	|   	|
| Travis             	| All versions      	|      	|   	|
|                    	|                   	|      	|   	|

## Identity providers

The following table lists the identity providers that Spinnaker supports:



## Secret stores

The following table lists the secret stores that Spinnaker supports for referencing secrets in config files securely:

| Provider             | Spinnaker version | Notes  |
|----------------------|--------------------|---|
| AWS Secrets Manager   |                    |   |
| Encrypted GCS Bucket |                    |   |
| Encrypted S3 Bucket  |                    |   |
| Kubernetes secrets   |                    | Requires Spinnaker Operator based deployments |
| Vault                |                    |   |