---
title: Install Operator and Deploy Armory Continuous Deployment Quickstart
linkTitle: Quickstart
weight: 1
description: >
  Install the Operator, create a Kubernetes manifest for Armory Continuous Deployment or Spinnaker, and then deploy using the Operator.
---

{{< include "armory-operator/os-operator-blurb.md" >}}

## {{% heading "prereq" %}}

The goal of this guide is to deploy Armory Continuous Deployment with bare minimum configuration. The [What's next](#whats-next) section contains links to advanced configuration guides.

{{% include "armory-operator/k8s-reqs.md" %}}

Depending on your Kubernetes version, you may need to adjust the following
instructions to use a support Operator version. The following table outlines
the supported combinations of Kubernetes, Operator, and Armory Continuous Deployment:

{{< include "armory-operator/operator-compat-matrix.md" >}}

## Operator installation options

The Operator has `basic` and `cluster` installation modes. The option you use depends on which namespace you want to deploy Armory Continuous Deployment or Spinnaker to.


|                                                           |Basic Mode | Cluster Mode |
|:-------------------------------------------------------- |:------------------:|:---------------:|
| Must deploy Armory Continuous Deployment in the same namespace as the Operator;<br>permissions scoped to single namespace; suitable for a Proof of Concept (POC)   |      &#9989;       |    &#10060;     |
| Can deploy Armory Continuous Deployment to multiple namespaces<br>(requires Kubernetes ClusterRole)                 |      &#10060;      |     &#9989;     |
| Configure Armory Continuous Deployment using a single manifest file            |      &#9989;       |     &#9989;     |
| Configure Armory Continuous Deployment using Kustomize patches            |      &#9989;       |     &#9989;     |
| Perform pre-flight checks to prevent misconfiguration             |     &#10060;       |     &#9989;     |



## {{% heading "installOperator" %}}

{{< tabs name="install-operator" >}}
{{% tabbody name="Cluster Mode"%}}
{{% include "armory-operator/op-install-cluster.md" %}}
{{% /tabbody %}}
{{% tabbody name="Basic Mode"%}}
{{% include "armory-operator/op-install-basic.md" %}}
{{% /tabbody %}}
{{< /tabs >}}

## Deploy an Armory Continuous Deployment instance

### Single manifest file option

{{< tabs name="deploy-spinnaker-manifest" >}}

{{% tabbody name="Armory Continuous Deployment"%}}

![Proprietary](/images/proprietary.svg)

You can find the `SpinnakerService.yml` manifest file in `/spinnaker-operator/deploy/spinnaker/basic/`. You need to specify persistent storage details and the version to deploy before you can use the manifest to deploy Armory Continuous Deployment.

The following example uses an AWS S3 bucket. You can find configuration for other storage types in the [Persistent Storage]({{< ref "persistent-storage" >}}) reference.

You can see the list of Armory Continuous Deployment versions on the [Release Notes]({{< ref "rn-armory-spinnaker" >}}) page.

```yaml
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: <version>   # the version of Armory Continuous Deployment to deploy
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: <change-me> # Armory Continuous Deployment stores application and pipeline definitions here. Create an S3 bucket and provide the name here.
          rootFolder: front50
  # spec.expose - This section defines how Armory Continuous Deployment should be publicly exposed
  expose:
    type: service  # Kubernetes LoadBalancer type (service/ingress), note: only "service" is supported for now
    service:
      type: LoadBalancer
```

The Armory Operator uses Halyard to deploy Armory Continuous Deployment.
See [Custom Halyard Configuration]({{< ref "op-advanced-config.md" >}}) if you need to modify Halyard so you can use Armory Continuous Deployment features.

Deploy using `kubectl`:

```bash
kubectl create ns spinnaker
kubectl -n spinnaker apply -f deploy/spinnaker/basic/SpinnakerService.yml
```

{{% /tabbody %}}
{{% tabbody name="Spinnaker"%}}

You can find the basic `spinnakerservice.yml` manifest file in `/spinnaker-operator/deploy/spinnaker/basic/`.

You need to specify persistent storage details and the version to deploy before you can use the manifest to deploy Spinnaker. The following example uses an AWS S3 bucket. You can find configuration for other storage types in the [Persistent Storage]({{< ref "persistent-storage" >}}) reference.

You can see the list of Spinnaker versions on the Spinnaker [Versions](https://spinnaker.io/community/releases/versions/) page.

```yaml
apiVersion: spinnaker.io/{{< param "operator-oss-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: <version>   # the version of Spinnaker to deploy
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: <change-me> # Spinnaker stores application and pipeline definitions here. Create an S3 bucket and provide the name here.
          rootFolder: front50
  # spec.expose - This section defines how Spinnaker should be publicly exposed
  expose:
    type: service  # Kubernetes LoadBalancer type (service/ingress), note: only "service" is supported for now
    service:
      type: LoadBalancer
```

Deploy using `kubectl`:

```bash
kubectl create ns spinnaker
kubectl -n spinnaker apply -f deploy/spinnaker/basic/spinnakerservice.yml
```

{{% /tabbody %}}
{{< /tabs >}}

You can watch the installation progress by executing:

```bash
kubectl -n spinnaker get spinsvc spinnaker -w
```

You can verify pod status by executing:

```bash
 kubectl -n spinnaker get pods
 ```

The included manifest file is only for a very basic installation.
{{< linkWithTitle "op-config-manifest.md" >}} contains detailed manifest configuration options.

### Kustomize patches option

> This example assumes you deploy Armory Continuous Deployment to the `spinnaker-operator` namespace.

{{< include "armory-operator/how-kustomize-works.md" >}}

{{% include "armory-operator/kust-ver-note.md" %}}

For this quickstart, you can find bare minimum patches in `/spinnaker-operator/deploy/spinnaker/kustomize`. Before you deploy Armory Continuous Deployment, you need to update the `version` and `persistentStorage` values in `config-patch.yml`.

The following example uses an AWS S3 bucket. You can find configuration for other storage types in the [Persistent Storage]({{< ref "persistent-storage" >}}) reference.

>This quickstart example is suitable for a proof of concept. For production environments, you should use a robust set of Kustomize patches. See the [Configure Armory Continuous Deployment Using Kustomize]({{< ref "op-config-Kustomize" >}}) guide for details.

{{< tabs name="deploy-spinnaker-kustomize" >}}

{{% tabbody name="Armory Continuous Deployment"%}}
![Proprietary](/images/proprietary.svg)

You can see the list of Armory Continuous Deployment versions on the [Release Notes]({{< ref "rn-armory-spinnaker" >}}) page.

```yaml
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version">}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  # spec.spinnakerConfig - This section is how to specify configuration spinnaker
  spinnakerConfig:
  # spec.spinnakerConfig.config - This section contains the contents of a deployment found in a halconfig .deploymentConfigurations[0]
    config:
      version: <version>  # the version of Armory Continuous Deployment to be deployed
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: mybucket
          rootFolder: front50
```

The Armory Operator uses Halyard to deploy Armory Continuous Deployment.
See [Custom Halyard Configuration]({{< ref "op-advanced-config.md" >}}) if you need to modify Halyard so you can use Armory Continuous Deployment features.

{{% /tabbody %}}
{{% tabbody name="Spinnaker"%}}

You can see the list of Spinnaker versions on the Spinnaker [Versions](https://spinnaker.io/community/releases/versions/) page.

```yaml
apiVersion: spinnaker.io/{{< param "operator-oss-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  # spec.spinnakerConfig - This section is how to specify configuration Spinnaker
  spinnakerConfig:
  # spec.spinnakerConfig.config - This section contains the contents of a deployment found in a halconfig .deploymentConfigurations[0]
    config:
      version: <version>  # the version of Spinnaker to be deployed
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: mybucket
          rootFolder: front50
```

{{% /tabbody %}}
{{< /tabs >}}

1. If you want to verify the contents of the manifest file, execute from the `/spinnaker-operator/deploy/spinnaker/kustomize/` directory:

   ```bash
   kubectl kustomize .
   ```

   This prints out the contents of the manifest file that Kustomize built based on your `kustomization.yml` file.


1. Deploy from the `/spinnaker-operator/deploy/spinnaker/kustomize/` directory:

   ```bash
   kubectl create ns spinnaker
   kubectl -n spinnaker apply -k .
   ```

1. You can watch the installation progress by executing:

   ```bash
   kubectl -n spinnaker get spinsvc spinnaker -w
   ```

1. You can verify pod status by executing:

   ```bash
   kubectl -n spinnaker get pods
   ```

## Help resources

{{% include "armory-operator/help-resources.md" %}}

## {{% heading "nextSteps" %}}

* [Register your Armory Continuous Deployment instance]({{< ref "ae-instance-reg" >}}).
* Learn how to {{< linkWithTitle "op-manage-spinnaker.md" >}}.
* See advanced manifest configuration in the  {{< linkWithTitle "op-config-manifest.md" >}} guide.
* See advanced configuration using Kustomize in the {{< linkWithTitle "op-config-kustomize.md" >}} guide.
* See the {{< linkWithTitle "op-troubleshooting.md" >}} guide if you encounter issues.
* If you are deploying Armory Continuous Deployment, you may need to configure Halyard. See the {{< linkWithTitle "op-advanced-config.md" >}} guide.
* Learn how to {{< linkWithTitle "op-manage-operator.md" >}}.
