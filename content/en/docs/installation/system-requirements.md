---
title: System Requirements for Armory Enterprise
linkTitle: System Requirements
description: >
  Hardware and other requirements to run Armory Enterprise
---

## Browsers

You can use any modern browser to interact with the UI.

## External storage

Armory Enterprise requires external storage for information such as persisting app settings and pipelines. 

### Bucket storage

You need an S3 bucket or Minio

### RDBMS (SQL)

Armory Enterprise also uses either Redis, MySQL, or Postgres as a backing store. The following table lists the supported database and the service that requires it:

| Database   | DB version               | Armory services                                     | Note                                                                                                                                                                                                                                                                                                                                                                                                  |
|------------|--------------------------|-----------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Redis      | All supported versions   | All services that require a backing store | The DB version refers to external Redis instances. Supported only for services that still require Redis for a feature, such as Gate sessions. Redis is not supported as a core persistent storage engine. Although Armory Enterprise can deploy internal Redis instances, do not use these for production deployments. Armory recommends only using them for testing and proof-of-concept deployments. |
| MySQL      | MySQL 5.7 (or Aurora)    | Clouddriver, Front50, Orca, Fiat, Echo                |                                                                                                                                                                                                                                                                                                                                                                                                       |
| PostgreSQL | PostgreSQL 10.0 or later | Clouddriver, Front50, Orca, Fiat                     |                                                                                                                                                                                                                                                                                                                                                                                                       |

Armory recommends using MySQL or PostgreSQL as the backing store when possible for production instances. For services where this is not an option, use an external Redis instance.

## Hardware requirements

## Java

Java 11 is required to run Halyard (one method of configuring and managing Armory Enterprise) on your machine.

## Kubernetes version

Armory Enterprise is a collection of services that run in a Kubernetes cluster. This section defines the versions that you can run Armory Enterprise on, not where you can deploy your applications. For information about what versions of Kubernetes you can deploy to, see the [Product Compatibility Matrix]({{< ref "armory-platform-matrix.md" >}}).

> If you want to manage Armory Enterprise using the Operator, you must be able to apply Kubernetes manifests. This can be done directly using `kubectl` commands from your machine or another method.

## Networking
