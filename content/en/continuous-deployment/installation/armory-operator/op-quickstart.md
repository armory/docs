---
title: Install Operator and Deploy Armory Continuous Deployment Quickstart
linkTitle: Armory CD Quickstart Orig
weight: 1
description: >
  Install the Operator, create a Kubernetes manifest for Armory Continuous Deployment or Spinnaker, and then deploy using the Operator.
draft: true
---

## {{% heading "prereq" %}}

The goal of this guide is to deploy Armory Continuous Deployment with bare minimum configuration. The [What's next](#whats-next) section contains links to advanced configuration guides.

{{% include "armory-operator/k8s-reqs.md" %}}

Depending on your Kubernetes version, you may need to adjust the following
instructions to use a support Operator version. The following table outlines
the supported combinations of Kubernetes, Operator, and Armory Continuous Deployment:

{{< include "armory-operator/operator-compat-matrix.md" >}}

## {{% heading "installOperator" %}}

{{< tabpane text=true right=true >}}
  {{< tab header="**Mode**:" disabled=true />}}
  {{% tab header="Cluster" text=true %}}
  {{< include "armory-operator/op-install-cluster.md" >}}
  {{% /tab %}}
  {{% tab header="Basic" text=true %}}
  {{< include "armory-operator/op-install-basic.md" >}}
  {{% /tab %}}
{{< /tabpane >}}

## Deploy an Armory Continuous Deployment instance

### Single manifest file option

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
