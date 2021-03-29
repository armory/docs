---
title: Install the Operator and Deploy Spinnaker
linkTitle: Quickstart
weight: 1
description: >
  Install the Operator, create a Kubernetes manifest for Spinnaker, and deploy using the Operator.
---

{{< include "armory-operator/os-operator-blurb.md" >}}

## Requirements for using the Spinnaker or Armory Operator

Before you use start, ensure you meet the following requirements:

* You are familiar with [Kubernetes Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/), which use custom resources to manage applications and their components.
* You understand the concept of [managing Kubernetes resources using manifests](https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/).
* Your Kubernetes cluster runs version 1.13 or later. If you do not have a cluster already, consult guides for [Google](https://cloud.google.com/kubernetes-engine/docs/quickstart), [Amazon](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-console.html), or [Microsoft](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough-portal) clouds.
* You have enabled admission controllers in Kubernetes (`-enable-admission-plugins`).
* You have `ValidatingAdmissionWebhook` enabled in `kube-apiserver`. Alternatively, you can pass the `--disable-admission-controller` parameter to the to the `deployment.yaml` file that deploys the Operator.
* You have administrator rights to install the Custom Resource Definition (CRD) for Operator.

## Operator installation options

The Operator has `basic` and `cluster` installation modes. The option you use depends on how you want to deploy Spinnaker.


|                                                           |Basic Mode | Cluster Mode |
|:-------------------------------------------------------- |:------------------:|:---------------:|
| Must deploy Spinnaker in the same namespace as the Operator<br>(permissions scoped to single namespace; suitable for POCs)   |      &#9989;       |    &#10060;     |
| Can deploy Spinnaker to multiple namespaces<br>(requires Kubernetes ClusterRole)                 |      &#10060;      |     &#9989;     |
| Configure Spinnaker using a single manifest file            |      &#9989;       |     &#9989;     |
| Configure Spinnaker using Kustomize patches            |      &#9989;       |     &#9989;     |
| Perform pre-flight checks to prevent misconfiguration             |     &#10060;       |     &#9989;     |



## {{% heading "installOperator" %}}

{{< tabs name="install-operator" >}}
{{% tab name="Basic Mode"%}}
{{% include "armory-operator/op-install-basic.md" %}}
{{% /tab %}}
{{% tab name="Cluster Mode"%}}
{{% include "armory-operator/op-install-cluster.md" %}}
{{% /tab %}}
{{< /tabs >}}

## Deploy a Spinnaker instance

Before you deploy Spinnaker, you must create a persistent storage source for Spinnaker to use to store application settings and configured pipelines. You can find a list of supported external storage providers in the open source Spinnaker [About External Storage](https://spinnaker.io/setup/install/storage/#about-external-storage) documentation.

### Single manifest file option

{{< tabs name="deploy-spinnaker-manifest" >}}
{{% tab name="Spinnaker"%}}

You can find the basic `spinnakerservice.yml` manifest file in `/spinnaker-operator/deploy/spinnaker/basic/`. You need to specify persistent storage details and the version to deploy before you can use the manifest to deploy Spinnaker.

The following example uses an AWS S3 bucket. You can find configuration for other storage types in the [Persistent Storage]({{< ref "persistent-storage" >}}) reference.

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
          bucket: <change-me> # Change to a unique name. Spinnaker stores application and pipeline definitions here
          rootFolder: front50
  # spec.expose - This section defines how Spinnaker should be publicly exposed
  expose:
    type: service  # Kubernetes LoadBalancer type (service/ingress), note: only "service" is supported for now
    service:
      type: LoadBalancer
```

Deploy using `kubectl`:

```bash
kubectl -n spinnaker-operator apply -f deploy/spinnaker/basic/spinnakerservice.yml
```


{{% /tab %}}
{{% tab name="Armory Enterprise"%}}
![Proprietary](/images/proprietary.svg)

You can find the `SpinnakerService.yml` manifest file in `/spinnaker-operator/deploy/spinnaker/basic/`. You need to specify persistent storage details and the version to deploy before you can use the manifest to deploy Spinnaker.

The following example uses an AWS S3 bucket. You can find configuration for other storage types in the [Persistent Storage]({{< ref "persistent-storage" >}}) reference.

You can see the list of Armory Enterprise versions on the [Release Notes]({{< ref "rn-armory-spinnaker" >}}) page.

```yaml
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: <version>   # the version of Armory Enterprise to deploy
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: <change-me> # Change to a unique name. Spinnaker stores application and pipeline definitions here
          rootFolder: front50
  # spec.expose - This section defines how Spinnaker should be publicly exposed
  expose:
    type: service  # Kubernetes LoadBalancer type (service/ingress), note: only "service" is supported for now
    service:
      type: LoadBalancer
```

Deploy using `kubectl`:

```bash
kubectl -n spinnaker-operator apply -f deploy/spinnaker/basic/SpinnakerService.yml
```

{{% /tab %}}
{{< /tabs >}}

You can watch the installation progress by executing:

```bash
kubectl -n spinnaker-operator get spinsvc spinnaker -w
```

You can verify pod status by executing:

```bash
 kubectl -n spinnaker-operator get pods
 ```

### Kustomize patches option

This example assumes you installed the Operator in the `spinnaker-operator` namespace and want to deploy Spinnaker to the `spinnaker-operator` namespace. Consult the {{< linkWithTitle "operator-config.md" >}} guide if you installed the Operator in `cluster` mode and want to use a different namespace.

You can find basic Kustomize patches in `/spinnaker-operator/deploy/spinnaker/kustomize`. You need to update the `version` and `persistentStorage` values in `config-patch.yml`.

The following example uses an AWS S3 bucket. You can find configuration for other storage types in the [Persistent Storage]({{< ref "persistent-storage" >}}) reference.

{{< tabs name="deploy-spinnaker-kustomize" >}}
{{% tab name="Spinnaker"%}}

You can see the list of Spinnaker versions on the Spinnaker [Versions](https://spinnaker.io/community/releases/versions/) page.

```yaml
apiVersion: spinnaker.io/{{< param "operator-oss-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  # spec.spinnakerConfig - This section is how to specify configuration spinnaker
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

{{% /tab %}}
{{% tab name="Armory Enterprise"%}}
![Proprietary](/images/proprietary.svg)

You can see the list of Armory Enterprise versions on the [Release Notes]({{< ref "rn-armory-spinnaker" >}}) page.

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
      version: <version>  # the version of Spinnaker to be deployed
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: mybucket
          rootFolder: front50
```

{{% /tab %}}
{{< /tabs >}}

Deploy from the `/spinnaker-operator/deploy/spinnaker/kustomize/` directory:

```bash
kubctl -n spinnaker-operator apply -k .
```

If you have Kustomize installed, you build first and then apply:

```bash
kustomize build | kubectl apply -f -
```


## {{% heading "nextSteps" %}}

* Read in-depth about [how to configure Spinnaker]({{< ref "operator-config.md" >}})
* Learn how to [manage]({{< ref op-manage-spinnaker >}}) your Spinnaker instance
* See the [Installation Guides]({{< ref "guide">}}) for details on how to deploy Armory Enterprise on various cloud platforms.