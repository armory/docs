---
title: System Requirements for Armory Enterprise
linkTitle: System Requirements
weight: 1
description: >
  Armory Enterprise is a collection of services that run in a Kubernetes cluster. In addition to the cluster, other requirements, such as storage, need to be met to run Armory Enterprise for production environments.
---

The requirements described on this page are meant as a minimum starting point for installing Armory Enterprise. You may need to increase the resources based on the number of applications, pipelines, and executions.

## Installation targets

> This section defines where you can run Armory Enterprise, not where you can deploy your applications. For information about where you can deploy applications to, see the [Product Compatibility Matrix]({{< ref "armory-enterprise-matrix#deployment-targets" >}}).

Armory Enterprise can be installed on any [certified Kubernetes cluster](https://www.cncf.io/certification/software-conformance/). Armory does not produce marketplace specific images that can be used by different certified Kubernetes offerings. The cluster needs to run one of the following supported versions:

* **Minimum version**: 1.16
* **Maximum version**: 1.20
<!-- track EKS versions -->
To install Armory Enterprise, use the Armory Operator (a Kubernetes operator). Note that you must be able to apply Kubernetes manifests, either directly using `kubectl` commands from your machine or another method.

## Browsers

The UI for Armory Enterprise works best on Firefox or Chromium-based browsers.

## External storage

Armory Enterprise requires external storage for storing metadata and history.

### Bucket storage

You need an S3-compatible object store, such as an S3 bucket or Minio, for persisting your application settings and pipelines. The account you use to install and run Armory Enterprise needs read/write access to the buckets.

### RDBMS (SQL)

Depending on the service, Armory Enterprise also uses either Redis, MySQL, or Postgres as a backing store. The following table lists the supported database and the  service:

| Database | DB version             | Armory                 | Spinnaker services                                  | Note                                                                                                                       |
| -------- | ---------------------- | ---------------------- | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| Redis    | All supported versions | All supported versions | All Spinnaker services that require a backing store | The DB versions refer to external Redis instances. Supported only for services that still require Redis for a feature, such as Gate sessions. Redis is not supported as a core persistent storage engine. Although Spinnaker deploys internal Redis instances, do not use these instances for production deployments. Armory recommends only using them for testing and proof-of-concept deployments. |
| MySQL    | MySQL 5.7 (or Aurora)  | All supported versions | Clouddriver, Front50, Orca                          |                                                                                                                            |
| PostgreSQL    | PostgreSQL 10.0 or later  | 2.24.0 or later | Clouddriver                          |                                                                                                                            |

Armory recommends using MySQL or PostgreSQL as the backing store when possible for production instances of Spinnaker. For other services, use an external Redis instance for production instances of Spinnaker.

## Hardware requirements

Armory recommends a minimum of 3 nodes that match the following profile:

* **CPUS**: 8
* **Memory (GiB)**: 32

## kubectl

To install and manage Armory Enterprise, any actively maintained version of `kubectl` is supported unless you want to use the [Armory Kustomize Repo](https://github.com/armory/spinnaker-kustomize-patches). The Kustomize Repo is a collection of Kustomize files that help you configure Armory Enterprise. The repo supports the following versions of `kubectl`: 1.16 to 1.19.
<!-- this is cause of the go-yaml bug: https://github.com/kubernetes-sigs/kustomize/issues/3605 -->

## Networking

The ports for the API gateway (the Gate service) and the UI (the Deck service) need to be exposed. All interactions with Armory Enterprise go through these two services.

**Gate ports**

* 8084
* 8085 when secured by x509

**Deck port**

* 9000

Additionally, pods in your Kubernetes cluster must be able to communicate with each other without restrictions.