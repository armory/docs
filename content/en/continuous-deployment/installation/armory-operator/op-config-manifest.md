---
title: Configure Armory Continuous Deployment Using a Manifest File
linkTitle: Config Using Manifest
weight: 10
aliases:
  - /docs/installation/armory-operator/op-manifest-reference/operator-config
  - /installation/armory-operator/op-manifest-reference/operator-config
description: >
  This guide describes the fields in the `SpinnakerService` manifest that the the Armory Operator uses to deploy Armory Continuous Deployment or the Spinnaker Operator uses to deploy Spinnaker.
---

{{< include "armory-operator/os-operator-blurb.md" >}}

## {{% heading "prereq" %}}

* This guide assumes you want to expand the manifest file used in the Quickstart.
* You know how to deploy Armory Continuous Deployment using a Kubernetes manifest file. See the Quickstart's [Single manifest file section]({{< ref "op-quickstart#single-manifest-file-option">}}).

## Kubernetes manifest file

The structure of the manifest file is the same whether you are using the Armory Operator or the Spinnaker Operator. The value of certain keys, though, depends on whether you are deploying Armory Continuous Deployment or Spinnaker. The following snippet is the first several lines from a `spinnakerservice.yml` manifest that deploys Armory Continuous Deployment.

{{< highlight yaml "linenos=table,hl_lines=1 8" >}}
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: <version>
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: <s3-bucket-name>
          rootFolder: front50
{{< /highlight >}}

* Line 1: `apiVersion` is the CRD version of the `SpinnakerService` custom resource.
   * If you are deploying Armory Continuous Deployment, the value is `spinnaker.armory.io/{{< param "operator-extended-crd-version" >}}`; if you change this value, the Armory Operator won't process the manifest file.
   * If you are deploying Spinnaker, the value is `spinnaker.io/{{< param "operator-oss-crd-version" >}}`; if you change this value, the Spinnaker Operator won't process the manifest file.
* Line 8: `spec.spinnakerConfig.config.version`
   * If you are using the Armory Operator, this is the [version of Armory Continuous Deployment]({{< ref "rn-armory-spinnaker" >}}) you want to deploy; for example, {{< param "armory-version-exact" >}}.  
   * If you are using the Spinnaker Operator, this is the [version of Spinnaker](https://spinnaker.io/community/releases/versions/) you want to deploy; for example, `1.25`.


<details><summary>Expand to see a skeleton manifest file</summary>

This file is from the public `armory/spinnaker-operator` [repo](https://github.com/armory/spinnaker-operator/blob/master/deploy/spinnaker/complete/spinnakerservice.yml). You use this file to configure and deploy Spinnaker. Note that the `apiVersion` is the SpinnakerService CRD used by the Spinnaker Operator.

{{< github repo="armory/spinnaker-operator" file="/deploy/spinnaker/complete/spinnakerservice.yml" lang="yaml" options="" >}}
</details>


## Manifest sections


### metadata.name

```yaml
apiVersion: apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
```

`metadata.name` is the name of your Armory Continuous Deployment service. Use this name to view, edit, or delete Armory Continuous Deployment. The following example uses the name `prod`:

```bash
$ kubectl get spinsvc prod
```

Note that you can use `spinsvc` for brevity. You can also use `spinnakerservices.spinnaker.armory.io` (Armory Continuous Deployment) or `spinnakerservices.spinnaker.io` (Spinnaker).

### spec.spinnakerConfig

Contains the same information as the `deploymentConfigurations` entry in a Halyard configuration.

For example, given the following `~/.hal/config` file:

```yaml
currentDeployment: default
deploymentConfigurations:
- name: default
  version: 2.17.1
  persistentStorage:
    persistentStoreType: s3
    s3:
      bucket: mybucket
      rootFolder: front50
```

The equivalent of that Halyard configuration is the following `spec.spinnakerConfig`:

```yaml
apiVersion: apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: 2.17.1
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: mybucket
          rootFolder: front50
```

`spec.spinnakerConfig.config` contains the following sections:

* [armory]({{< ref "armory" >}}) ![Proprietary](/images/proprietary.svg)
* [artifact]({{< ref "artifact" >}})
* [canary]({{< ref "canary-op-config" >}})
* [ci]({{< ref "ci" >}})
* [deploymentEnvironment]({{< ref "op-manifest-reference/deploy" >}})
* [features]({{< ref "features" >}})
* [metricStores]({{< ref "metricstores" >}})
* [notification]({{< ref "notification" >}})
* [persistentStorage]({{< ref "persistent-storage" >}})
* [plugins]({{< ref "plugins" >}})
* [providers]({{< ref "providers" >}})
* [pubsub]({{< ref "pubsub" >}})
* [repository]({{< ref "repository" >}})
* [security]({{< ref "op-manifest-reference/security" >}})
* [stats]({{< ref "stats" >}})
* [webhook]({{< ref "op-webhook" >}})

### spec.spinnakerConfig.profiles

Configuration for each service profile. This is the equivalent of `~/.hal/default/profiles/<service>-local.yml`. For example the following `profile` is for Gate:

```yaml
spec:
  spinnakerConfig:
    config:
    ...
    profiles:
      gate:
        default:
          apiPort: 8085
```
Note that for Deck, the profile is a string under the key `settings-local.js`:

```yaml
spec:
  spinnakerConfig:
    config:
    ...
    profiles:
      deck:
        settings-local.js: |
          window.spinnakerSettings.feature.artifactsRewrite = true;
```

### spec.spinnakerConfig.service-settings

Settings for each service. This is the equivalent of `~/.hal/default/service-settings/<service>.yml`. For example the following settings are for Clouddriver:

```yaml
spec:
  spinnakerConfig:
    config:
    ...
    service-settings:
      clouddriver:
        kubernetes:
          serviceAccountName: spin-sa
```

### spec.spinnakerConfig.files

Contents of any local files that should be added to the services. For example to reference the contents of a kubeconfig file:

```yaml
spec:
  spinnakerConfig:
    config:
      providers:
        kubernetes:
          enabled: true
          accounts:
          - name: cluster-1
            kubeconfigFile: cluster1-kubeconfig
            ...
    files:
      cluster1-kubeconfig: |
        <FILE CONTENTS HERE>
```

A double underscore (`__`) in the file name is translated to a path separator (`/`). For example to add custom packer templates:

```yaml
    files: {}
      profiles__rosco__packer__example-packer-config.json: |
        {
          "packerSetting": "someValue"
        }
      profiles__rosco__packer__my_custom_script.sh: |
        #!/bin/bash -e
        echo "hello world!"
```

### spec.expose
Optional. Controls how Armory Continuous Deploymentgets exposed. If you omit it, no load balancer gets created. If this section gets removed, the Load Balancer does not get deleted.

Use the following configurations:

- `spec.expose.type`: How Armory Continuous Deploymentgets exposed. Currently, only `service` is supported, which uses Kubernetes services to expose Spinnaker.
- `spec.expose.service`: Service configuration
- `spec.expose.service.type`: Should match a valid Kubernetes service type (i.e. `LoadBalancer`, `NodePort`, or `ClusterIP`).
- `spec.expose.service.annotations`: Map containing annotations to be added to Gate (API) and Deck (UI) services.
- `spec.expose.service.overrides`: Map with key for overriding the service type and specifying extra annotations: Armory Continuous Deploymentservice name (Gate or Deck) and value. By default, all services receive the same annotations. You can override annotations for a Deck (UI) or Gate (API) services.

### spec.validation

**Currently these configurations are experimental. By default, the Operator always validates Kubernetes accounts when applying a SpinnakerService manifest.**

Validation options that apply to all validations that Operator performs:

- `spec.validation.failOnError`: Boolean. Defaults to true. If false, the validation runs and the results are logged, but the service is always considered valid.
- `spec.validation.failFast`: Boolean. Defaults to false. If true, validation stops at the first error.
- `spec.validation.frequencySeconds`: Optional. Integer. Define a grace period before a validation runs again. For example, if you specify a value of `120` and edit the `SpinnakerService` without changing an account within a 120 second window, the validation on that account does not run again.

Additionally, the following settings are specific to Kubernetes, Docker, AWS, AWS S3, CI tools, metric stores, persistent storage, or notification systems:
- `spec.validation.providers.kubernetes`
- `spec.validation.providers.docker`
- `spec.validation.providers.aws`
- `spec.validation.providers.s3`
- `spec.validation.providers.ci`
- `spec.validation.providers.metricStores`
- `spec.validation.providers.persistentStorage`
- `spec.validation.providers.notifications`

Supported settings are `enabled` (set to false to turn off validations), `failOnError`, and `frequencySeconds`.

The following example disables all Kubernetes account validations:
```yaml
spec:
  validation:
    providers:
      kubernetes:
        enabled: false
```
### spec.accounts

Support for `SpinnakerAccount` CRD (**Experimental**):

- `spec.accounts.enabled`: Boolean. Defaults to false. If true, the `SpinnakerService` uses all `SpinnakerAccount` objects enabled.
- `spec.accounts.dynamic` (experimental): Boolean. Defaults to false. If true, `SpinnakerAccount` objects are available to Armory Continuous Deployment as the account is applied (without redeploying any service).

## Example Manifests for exposing Armory Continuous Deployment

### Load balancer Services

```yaml
spec:
  expose:
    type: service
    service:
      type: LoadBalancer
      annotations:
        "service.beta.kubernetes.io/aws-load-balancer-backend-protocol": "http"
        "service.beta.kubernetes.io/aws-load-balancer-ssl-ports": "80,443"
        "service.beta.kubernetes.io/aws-load-balancer-ssl-cert": "arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

The preceding manifest generates these two services:

*spin-deck*

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: 80,443
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert": arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  labels:
    app: spin
    cluster: spin-deck
  name: spin-deck
spec:
  ports:
 - name: deck-tcp
   nodePort: xxxxx
   port: 9000
   protocol: TCP
   targetPort: 9000
  selector:
   app: spin
   cluster: spin-deck
  sessionAffinity: None
  type: LoadBalancer
```

*spin-gate*

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: 80,443
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert": arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  labels:
     app: spin
     cluster: spin-gate
  name: spin-gate
spec:
  ports:
  - name: gate-tcp
    nodePort: xxxxx
    port: 8084
    protocol: TCP
    targetPort: 8084
  selector:
    app: spin
    cluster: spin-gate
  sessionAffinity: None
  type: LoadBalancer
```


### Different service types for Deck (UI) and Gate (API)

```yaml
spec:
  expose:
    type: service
    service:
      type: LoadBalancer
      annotations:
        "service.beta.kubernetes.io/aws-load-balancer-backend-protocol": "http"
        "service.beta.kubernetes.io/aws-load-balancer-ssl-ports": "80,443"
        "service.beta.kubernetes.io/aws-load-balancer-ssl-cert": "arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      overrides:
        gate:
          type: NodePort
```

The preceding manifest generates these two services:

*spin-deck*

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: 80,443
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert": arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  labels:
    app: spin
    cluster: spin-deck
  name: spin-deck
  spec:
  ports:
  - name: deck-tcp
    nodePort: xxxxx
    port: 9000
    protocol: TCP
    targetPort: 9000
  selector:
    app: spin
    cluster: spin-deck
  sessionAffinity: None
  type: LoadBalancer
```

*spin-gate*

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: 80,443
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert": arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  labels:
    app: spin
    cluster: spin-gate
  name: spin-gate
spec:
  ports:
  - name: gate-tcp
    nodePort: xxxxx
    port: 8084
    protocol: TCP
    targetPort: 8084
  selector:
    app: spin
    cluster: spin-gate
  sessionAffinity: None
  type: NodePort
```

### Different annotations for Deck (UI) and Gate (API)

```yaml
spec:
  expose:
    type: service
    service:
      type: LoadBalancer
      annotations:
        "service.beta.kubernetes.io/aws-load-balancer-backend-protocol": "http"
        "service.beta.kubernetes.io/aws-load-balancer-ssl-ports": "80,443"
        "service.beta.kubernetes.io/aws-load-balancer-ssl-cert": "arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      overrides:
        gate:
          annotations:
            "service.beta.kubernetes.io/aws-load-balancer-internal": "true"
```

The preceding manifest file generates these two services:

*spin-deck*

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: 80,443
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert": arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  labels:
    app: spin
    cluster: spin-deck
  name: spin-deck
spec:
  ports:
  - name: deck-tcp
    nodePort: xxxxx
     port: 9000
     protocol: TCP
     targetPort: 9000
  selector:
     app: spin
     cluster: spin-deck
  sessionAffinity: None
  type: LoadBalancer
```

*spin-gate*

```yaml
apiVersion: v1
kind: Service
metadata:
  annotations:
    service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
    service.beta.kubernetes.io/aws-load-balancer-ssl-ports: 80,443
    service.beta.kubernetes.io/aws-load-balancer-ssl-cert": arn:aws:acm:us-west-2:xxxxxxxxxxxx:certificate/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    service.beta.kubernetes.io/aws-load-balancer-internal: true
  labels:
    app: spin
    cluster: spin-gate
  name: spin-gate
spec:
  ports:
 - name: gate-tcp
    nodePort: xxxxx
    port: 8084
    protocol: TCP
    targetPort: 8084
  selector:
    app: spin
    cluster: spin-gate
  sessionAffinity: None
  type: Loadbalancer
```
## X509

```yaml
spec:
  config:
    profiles:
      gate:
        default:
          apiPort: 8085  
  expose:
    type: service
    service:
      type: LoadBalancer

      annotations:
        service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http

      overrides:
      # Provided below is the example config for the Gate-X509 configuration
        deck:
          annotations:
            service.beta.kubernetes.io/aws-load-balancer-ssl-cert: arn:aws:acm:us-west-2:9999999:certificate/abc-123-abc
            service.beta.kubernetes.io/aws-load-balancer-backend-protocol: http
        gate:
          annotations:
            service.beta.kubernetes.io/aws-load-balancer-ssl-cert: arn:aws:acm:us-west-2:9999999:certificate/abc-123-abc
            service.beta.kubernetes.io/aws-load-balancer-backend-protocol: https  # X509 requires https from LoadBalancer -> Gate
       gate-x509:
         annotations:
           service.beta.kubernetes.io/aws-load-balancer-backend-protocol: tcp
           service.beta.kubernetes.io/aws-load-balancer-ssl-cert: null
         publicPort: 443
```

## Help resources

{{% include "armory-operator/help-resources.md" %}}

## {{% heading "nextSteps" %}}

* See the [Manifest Reference]({{< ref "op-manifest-reference" >}}) for configuration options by section.
* Configure Kubernetes accounts using the {{< linkWithTitle "op-spin-account-crd.md" >}} (Experimental)
* See advanced configuration using Kustomize in the {{< linkWithTitle "op-config-kustomize.md" >}} guide.
