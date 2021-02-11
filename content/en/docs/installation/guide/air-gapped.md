---
title: Install Armory Enterprise for Spinnaker in Air-Gapped Environments
linkTitle: Air-Gapped Environments
weight: 1
description: >
  Options for deploying Armory Enterprise for Spinnaker in an environment that is isolated from the internet.
---

{{< include "armory-license.md" >}}

## Overview of air-gapped environments

An air-gapped environment is one where any combination of the following conditions are true:
- No access to Armory Bill Of Materials (BOM), which are published on S3
- No ability to pull images from docker.io/armory
- No ability for engineers to deploy with Halyard from their machines

If your environment is air-gapped, you have several options for deploying Armory.

## Host Armory's Bill Of Materials (BOM)

Armory's BOMs are stored in the following bucket and are publicly available: `s3://halconfig`.

If you are unable to access this bucket from the machine running Halyard, host the BOM in either a GCS or S3 compatible storage, such as MinIO.

### Using a custom bucket and BOM

Your GCS or S3 compatible bucket needs to contain a `versions.yml` at the root of the bucket with the following information:

```yaml
latestHalyard: {{< param halyard-armory-version >}}
latestSpinnaker: {{< param armory-version >}}
versions:
- version: {{< param armory-version >}}
  alias: OSS Release <ossVersion> # The corresponding OSS version can be found in the Release Notes
  changelog: <Link to Armory Release Notes for this version>
  minimumHalyardVersion: 1.2.0
  lastUpdate: "1568853000000"
```

`latestHalyard` and `latestSpinnaker` are used to notify users of new version of Halyard and Armory. You can optionally update them with newer versions. `versions` is a list of available versions. It is optional if you don't intend to show new versions when `hal version list` is run.

### Enabling a custom bucket From Halyard

To enable custom storage in Halyard, create `/opt/spinnaker/config/halyard-local.yml` with the following content and restart Halyard:

```yaml
spinnaker:
  config:
    input:
      # To use a custom GCS bucket, switch this to true
      gcs:
        enabled: false
      # Name of your private bucket
      bucket: myownbucket
      # If your s3 bucket is not in us-west-2 (region does not matter for Minio)
      region: us-east-1
      # If you are using a platform that does not support PathStyleAccess, such as Minio, switch this to true
      # https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro
      enablePathStyleAccess: false
      # For s3 like storage with custom endpoint, such as Minio:
      # endpoint: https://minio.minio:9000
      # anonymousAccess: false
```

If you're running Halyard in Kubernetes or Armory Operator, you need to create `halyard-local.yml` in your local directory. Then, create a `configmap` in the same namespace as Halyard or Operator with the `halyard-local.yml` file:

```bash
kubectl create configmap halyard-custom-config --from-file=halyard-local.yml=path/to/halyard-local.yml -n halyard
```

If you're running Halyard in Kubernetes, you then need to mount the configmap with the following addition in volumeMounts / volume in your Halyard manifest:

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: halyard
  namespace: halyard
spec:
  replicas: 1
  selector:
    matchLabels:
      app: halyard
  serviceName: halyard
  template:
    metadata:
      labels:
        app: halyard
    spec:
      containers:
      - name: halyard
        image: index.docker.io/armory/halyard-armory:{{< param halyard-armory-version >}}
        volumeMounts:
        - name: halconfig
          mountPath: /home/spinnaker/
        ### mount halyard-local.yml into /opt/spinnaker/config/
        - name: halyard-custom-config
          mountPath: /opt/spinnaker/config
        ### add AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY if necessary
        env:
        - name: AWS_ACCESS_KEY_ID
          value: xxxx
        - name: AWS_SECRET_ACCESS_KEY
          value: xxxx
      securityContext:
        fsGroup: 65533
      volumes:
      - name: halconfig
        persistentVolumeClaim:
          claimName: halconfig-pvc
      ### use configMap/halyard-custom-config
      - name: halyard-custom-config
        configMap:
          name: halyard-custom-config
```

It may be necessary to include your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY for your custom/private s3 bucket.

### Enabling a new version of Armory

You can download version `x.y.z` of Armory with this script:

<details><summary>Show the script</summary>

{{< gist armory-gists 1d14179659bd0f2c5026443efc136253 >}}

Set the value for `NEW_DOCKER_REGISTRY` to point to your docker repository if needed.
</details><br>

For example, run the following command to download version {{< param armory-version >}}:

```bash
# Replace `x` with the edge release you want to use.
$ download-bom.sh {{< param armory-version >}} versions/
```

You can then upload the files you just downloaded to your storage. Make sure they are readable from wherever Halyard (not necessarily Armory services) will run. For example:

**AWS**

```bash
$ aws cp --recursive versions/ s3://myownbucket
```           
**GCS**

```bash
$ gsutil cp -m -r ...
```

## Use a custom Docker registry

If you're unable to pull from `docker.io/armory` directly, you can use your own registry.

### Docker registry proxy

Some registries allow pulling remote Docker images from another source. You can replace the `dockerRegistry` value in the script above via `NEW_DOCKER_REGISTRY`.

### Isolated Docker registry

If you cannot proxy `docker.io/armory`, push images to your own registry. Images are determined from the BOM. For instance:

```yaml
...
services:
  deck:
    version: 2.11.0-896d15d-b0aac47-rc8
  gate:
    version: 1.11.0-83b97ab-fd0128a-rc4
  ...
artifactSources:
  dockerRegistry: docker.io/armory
```

You need to copy `docker.io/armory/deck/2.11.0-896d15d-b0aac47-rc8` and `docker.io/armory/gate/1.11.0-83b97ab-fd0128a-rc4` to your own registry.

## Halyard cannot run on the local machine

The following solutions assume the that you can use `kubectl` to access the cluster where Armory is installed.

### Option 1: Halyard as a deployment

You can run Halyard as a `Deployment` within the cluster that runs Armory if the following conditions are true:

* You cannot run Halyard directly on your machine. This might be because the local machine cannot run Docker.
* You have `kubectl` access to the cluster you are deploying to

The `halyard-deployment.yml`manifest file can be found here: https://gist.github.com/imosquera/e6b42a187bd921dbb8a61e523cf568d8

Fetch the deployment manifest and edit values that are relevant to your deployment, such as `namespace`. After you edit the manifest, deploy it with the following command:

```
kubectl apply -f manifest.yml
```

Finally, to access the deployed Halyard environment, perform the following steps:

1. Get the name for the Halyard pod:
   ```bash
   kubectl get pods
   ```
2. Exec into the pod:
   ```bash
   kubectl exec -it {pod-name} /bin/bash
   ```

### Option 2: Armory Operator

The [Armory Operator]({{< ref "armory-operator" >}}) lets you manage Armory with `kubectl`.

If you also need to use privately hosted bill of materials, configure the operator to point to your bucket. See [Custom Halyard Configuration]({{< ref "armory-operator#custom-halyard-configuration" >}}).
