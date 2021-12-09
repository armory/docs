---
title: System Requirements for Armory Enterprise
linkTitle: System Requirements
weight: 1
description: >
  Armory Enterprise is a collection of services that run in a Kubernetes cluster. In addition to the cluster, other requirements, such as storage, need to be met to run Armory Enterprise for production environments.
---

The requirements described on this page are meant as a minimum starting point for installing Armory Enterprise. You may need to increase the resources based on the number of applications, pipelines, and executions. Work with your IT organization to make sure that the requirements are met.

## Installation targets

> This section defines where you can run Armory Enterprise, not where you can deploy your applications. For information about where you can deploy applications to, see the [Product Compatibility Matrix]({{< ref "armory-enterprise-matrix#deployment-targets" >}}).

Armory Enterprise can be installed on any [certified Kubernetes cluster](https://www.cncf.io/certification/software-conformance/) that meets the following version requirements:

* **Minimum version**: 1.16
* **Maximum version**: 1.20
<!-- track EKS versions -->

You install Armory Enterprise using the [Armory Operator]({{< ref "armory-operator" >}}) (a Kubernetes operator), which has the following requirements:

- You must be able to apply Kubernetes manifests and CRDs, either directly using `kubectl` commands from your machine or another method.
- By default, the Operator pulls images from a public registry. If you cannot pull images from public registries, see {{< linkWithTitle "ag-operator.md" >}}.

Note that Armory does not produce marketplace specific images that can be used by different certified Kubernetes offerings.

The Kubernetes cluster itself must meet the following requirements:

* You have administrator rights to install the Custom Resource Definition (CRD) for the Armory Operator.
* If you are managing your own Kubernetes cluster (**not** EKS), be sure:
   * You have enabled admission controllers in Kubernetes (`-enable-admission-plugins`).
   * You have `ValidatingAdmissionWebhook` enabled in `kube-apiserver`. Alternatively, you can pass the `--disable-admission-controller` parameter to the to the `deployment.yaml` file that deploys the Operator.

If you do not have a cluster already, consult guides for [Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html)or the equivalent for your Kubernetes provider.

## Browsers

The UI for Armory Enterprise works best on Firefox or Chromium-based browsers.

## External storage

Armory Enterprise requires external storage for storing metadata and history.

### Bucket storage

You need an S3-compatible object store, such as an S3 bucket or Minio, for persisting your application settings and pipelines. The account you use to install and run Armory Enterprise needs read/write access to the buckets.

### RDBMS (SQL)

Depending on the service, Armory Enterprise also uses either Redis, MySQL, or Postgres as a backing store. The following table lists the supported database and the  service:

| Database | DB version             | Armory                 | Services                                  | Note                                                                                                                       |
| -------- | ---------------------- | ---------------------- | --------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| Redis    | All supported versions | All supported versions | All Armory Enterprise services that require a backing store | The DB versions refer to external Redis instances. Supported only for services that still require Redis for a feature, such as Gate sessions. Redis is not supported as a core persistent storage engine. Although Armory Enterprise deploys internal Redis instances, do not use these instances for production deployments. Armory recommends only using them for testing and proof-of-concept deployments. <br/><br/> For AWS ElastiCache for Redis, the instance type should minimally be set to `cache.m5.large`. |
| MySQL    | {{< param mysql-version >}}  | All supported versions | Clouddriver, Front50, Orca                          | For AWS RDS, the instance type should minimally be set to `db.r5`.                                                                                                                           |
| PostgreSQL    | {{< param postgresql-version >}}  | 2.24.0 or later | Clouddriver                          | For AWS RDS, the instance type should minimally be set to `db.r5`.                                                                                                                           |

Armory recommends using MySQL or PostgreSQL as the backing store when possible for production instances of Armory Enterprise. For other services, use an external Redis instance for production instances of Armory Enterprise.

## Hardware requirements

Armory recommends a minimum of 3 nodes that match the following profile:

* **CPUS**: 8
* **Memory (GiB)**: 32

## kubectl

To install and manage Armory Enterprise, Armory recommends using the [Armory Operator with Kustomize]({{< ref "op-config-kustomize" >}}) and tailoring the Kustomize files to meet the requirements of your instance and environment. This installation method supports the following versions of `kubectl`: 1.16 to 1.19.
<!-- this is cause of the go-yaml bug: https://github.com/kubernetes-sigs/kustomize/issues/3605 -->

It is possible to use the Operator to [install Armory Enterprise without the Kustomize repo]({{< ref "op-config-manifest" >}}). In that case, any actively maintained version of `kubectl` is supported.

## Networking

Pods in your Kubernetes cluster must be able to communicate with each other without restrictions.

Additionally, the ports for the API gateway (the Gate service) and the UI (the Deck service) need to be exposed. All interactions with Armory Enterprise go through these two services.

**Gate ports**

* 8084
* 8085 when secured by x509

**Deck port**

* 9000

## Security

Armory Enterprise needs to be able to assume roles in the accounts that it deploys applications to. For example, Armory Enterprise needs the `sts:AssumeRole` permission for AWS. Elevated access (equivalent to the level of **PowerUser** access in AWS) is helpful so that Armory Enterprise can cache data from deployment target accounts and deploy without errors.

In addition to the security requirements that Armory Enterprise needs to run, Armory recommends securing your installation by using a [secret store]({{< ref "armory-enterprise-matrix#secret-stores" >}}) for sensitive values in your configs as well as configuring [authentication]({{< ref "armory-enterprise-matrix#authentication" >}}) and [authorization]({{< ref "armory-enterprise-matrix#authorization" >}}).
