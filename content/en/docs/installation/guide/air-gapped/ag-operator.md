---
title: Air-Gapped with the Armory Operator
weight: 2
description: >
  Guide for hosting the Armory Enterprise BOM and Docker images in an air-gapped environment.
categories: ["install"]
tags: ["Operator", "air-gapped"]
---

## Overview

This guide details how you can host the Armory Enterprise Bill of Materials (BOM) and Docker images, as well as the Armory Operator Docker images, in your  air-gapped environment. The steps at a high level are:


1. [Clone the `spinnaker-kustomize-patches` repo](#clone-the-spinnaker-kustomize-patches-repo), which contains helper scripts as well as Kustomize patches.
1. [Deploy S3-compatible MinIO](#deploy-minio-for-storage) to store the BOM.
1. [Download the BOM](#download-the-bom).
1. [Copy the BOM](#copy-the-bom) to your MinIO bucket.
1. [Host Armory Enterprise Docker images](#host-the-armory-enterprise-docker-images) in your private Docker registry.
1. [Download the Armory Operator](#download-the-armory-operator).
1. [Host Armory Operator Docker images](#host-the-armory-operator-docker-images) in your private Docker registry.
1. [Update Armory Operator configuration](#update-armory-operator-configuration).
1. [Deploy the Armory Operator](#deploy-the-armory-operator) in your Kubernetes cluster.

## {{% heading "prereq" %}}

* You are familiar with the [Armory Operator]({{< ref "armory-operator" >}}) and [configuring Armory Enterprise using Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have read the [introduction]({{< ref "air-gapped" >}}) to air-gapped environments.
* You have public internet access.
* You have administrator access to your Kubernetes cluster.
* You have created two namespaces in Kubernetes: `spinnaker` and `spinnaker-operator`.
* You have access to a private Docker registry with credentials to push images.
* You have installed the [AWS CLI](https://aws.amazon.com/cli/).
* You have installed [`yq`](https://mikefarah.gitbook.io/yq/#install) **version 4+**. This is used by helper scripts.

## Clone the `spinnaker-kustomize-patches` repo

{{% include "armory-operator/spin-kust-repo.md" %}}

## Deploy MinIO for storage

Now that you have cloned the `spinnaker-kustomize-patches` repo, you need to create a storage bucket to host the BOM. [MinIO](https://min.io) is a good choice for the bucket since it's S3 compatible and runs as a pod in Kubernetes. You can find the manifest for MinIO in `spinnaker-kustomize-patches/infrastructure/minio.yml`.

When you look at the content of the `minio.yml` manifest, you see that MinIO needs a secret key called `minioAccessKey`:

```yaml
env:
  # MinIO access key and secret key
  - name: MINIO_ACCESS_KEY
    value: "minio"
  - name: MINIO_SECRET_KEY
    valueFrom:
      secretKeyRef:
        name: spin-secrets
        key: minioAccessKey
```

`minioAccessKey` is stored in a Kubernetes secret called `spin-secrets.` You create the secret by running the script `create-secrets.sh` located in the `spinnaker-kustomize-patches/secrets` folder. The script looks for a file called `secrets.env` and if it doesn't find it, uses the contents of `secrets-example.env`, so you should create your own `secrets.env` file before deploying MinIO.

1. Create your own `secrets.env` file in the `spinnaker-kustomize-patches/secrets` directory. The contents of your file should be:

   ```text
   #---------------------------------------------------------------------------
   # Key-value pairs for secrets to store in Kubernetes.
   #
   # Reference secrets in spinnaker config files like this (not all fields support secrets):
   # encrypted:k8s!n:spin-secrets!k:<secret key>
   #---------------------------------------------------------------------------

   minioAccessKey=changeme
   ```

   Update the value for `minioAccessKey` and save the file.

1. Switch to the `spinnaker-kustomize-patches` directory. Create the Kubernetes secret key that contains the MinIO access key:

   ```bash
   ./secrets/create-secrets.sh
   ```

1. Deploy MinIO:

   ```bash
   kubectl create -f infrastructure/minio.yml -n spinnaker
   ```

## Download the BOM

Decide which Armory Enterprise version you want to deploy. Check [Armory Release Notes]({{< ref "rn-armory-spinnaker" >}}) for the latest supported versions.

The `spinnaker-kustomize-patches/airgap` directory contains helper scripts for air-gapped environments. Use `bomdownloader.sh` to download the version of the Armory Enterprise BOM that you require.

`bomdownloader.sh` takes two command line parameters in the following order:

1. Armory Enterprise version; for example, {{< param "armory-version-exact" >}}.
1. The name of your Docker registry; for example, `my.jfrog.io/myteam/armory`.

The script creates a `halconfig` folder, downloads the necessary files, and updates the BOM to use the Docker registry you specified. To download the BOM:

1. Switch to the `spinnaker-kustomize-patches` directory.
1. Run `bomdownloader.sh <armory-version> <docker-registry>`. For example, if you want to download the 2.25.0 BOM and your registry is `my.jfrog.io/myteam/armory`:

   ```bash
   ./airgap/bomdownloader.sh 2.25.0 my.jfrog.io/myteam/armory
   ```

   Output is similar to:

   ```bash
   download: s3://halconfig/versions.yml to halconfig/versions.yml
   download: s3://halconfig/bom/2.25.0.yml to halconfig/bom/2.25.0.yml
   download: s3://halconfig/profiles/clouddriver/2.25.3/clouddriver.yml to halconfig/profiles/clouddriver/2.25.3/clouddriver.yml
   ...
   Version 2.25.0 is ready to be uploaded to your private bucket.
   For example, with "aws cp --recursive"  or "gsutil cp -m -r ..."
   ```

Inspecting your file system, you should see the new `halconfig` folder. For example, if you specified Armory Enterprise v2.25.0, your file system should be:

```bash
halconfig
 ┣ bom
 ┃ ┗ 2.25.0.yml
 ┣ profiles
 ┃ ┣ clouddriver
 ┃ ┣ dinghy
 ┃ ┣ echo
 ┃ ┣ fiat
 ┃ ┣ front50
 ┃ ┣ gate
 ┃ ┣ igor
 ┃ ┣ kayenta
 ┃ ┣ monitoring-daemon
 ┃ ┣ orca
 ┃ ┣ rosco
 ┃ ┗ terraformer
 ┗ versions.yml
```

Each subdirectory in the `profiles` directory contains a `<service-name>.yml` profile file.

If you need to change your Docker registry, you can manually edit the `<armory-version>.yml` file located under `halconfig/bom`.  Update the value for the key `artifactSources.dockerRegistry`.

{{< prism lang="yaml" line="18" >}}
version: 2.25.0
timestamp: "2021-03-25 09:28:32"
services:
    clouddriver:
        commit: de3aa3f0
        version: 2.25.3
    deck:
        commit: 516bcf0a
        version: 2.25.3
    ...
    terraformer:
        commit: 5dcae243
        version: 2.25.0
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: my.jfrog.io/myteam/armory
{{< /prism >}}

## Copy the BOM

With the MinIO pod running, copy your local BOM into your MinIO bucket.

1. Set environment variables:

   Update the `AWS_SECRET_ACCESS_KEY` with the `minioAccessKey` value you created in the [Deploy MinIO to host the BOM](#deploy-minio-to-host-the-bom) section.

   ```bash
   export AWS_ACCESS_KEY_ID=minio
   export AWS_SECRET_ACCESS_KEY=<minioAccessKey>
   ```

1. Port forward the MinIO service:

   ```bash
   kubectl port-forward svc/minio 9000 -n spinnaker
   ```

1. Copy your local BOM to MinIO:

   ```bash
   aws s3 mb s3://halconfig --endpoint=http://localhost:9000
   aws s3 cp --recursive halconfig s3://halconfig --endpoint=http://localhost:9000
   ```

## Host the Armory Enterprise Docker images

There are two options for hosting the Docker images: 1) configure your Docker registry as a proxy for `docker.io/armory`; or 2) download the images and push them to your private Docker registry.

### Proxy to `docker.io/armory`

Configure `docker.io/armory` as a remote repository within your private Docker registry.  If you are using JFrog Artifactory, you can follow the instructions in the [Remote Docker Repositories](https://www.jfrog.com/confluence/display/JFROG/Docker+Registry#DockerRegistry-RemoteDockerRepositories) section of the JFrog docs.  

### Download images

You can use the `imagedownloader.sh` helper script in the `spinnaker-kustomize-patches/airgap` directory to download and push the images to your private Docker registry.

The execution format is:

```bash
./airgap/imagedownloader.sh <armory-version>
```

`<armory-version>` is the version you specified in the [Download the BOM](#download-the-bom) section.

When you run `imagedownloader.sh` from the `spinnaker-patches-repository` directory, the script looks for the downloaded BOM and proceeds to download, tag, and push the images for that particular version to the private Docker registry you specified when you ran `bomdownloader.sh`.

## Download the Armory Operator

Download and unpack the latest Armory Operator release into the `spinnaker-kustomize-patches/operator` folder. Run the following command from your `spinnaker-kustomize-patches/operator` directory:

```bash
bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/latest/download/manifests.tgz | tar -xz'
```

You should see the following directory structure in the `spinnaker-kustomize-patches/operator` folder:

```bash
operator
 ┣ deploy
 ┃ ┣ crds
 ┃ ┣ openshift
 ┃ ┣ operator
 ┃ ┗ spinnaker
 ┣ halyard-local.yml
 ┣ kustomization.yml
 ┣ patch-config.yaml
 ┗ patch-validations.yaml
 ```

## Host the Armory Operator Docker images

You can find the `operatorimageupdate.sh` script in `spinnaker-kustomize-patches/airgap`. The script does the following:

1. Downloads the Armory Operator Docker images and updates their names.
1. Pushes the images to the Docker registry you specify in the command line.
1. Updates the Armory Operator's `kustomization.yml` with the new image names.

From the `spinnaker-kustomize-patches/operator` folder, execute the `operatorimageupdate.sh` script:

```bash
../airgap/operatorimageupdate.sh <your-docker-registry>
```

## Update Armory Operator configuration

### Update MinIO secret access key

You also need to update Armory Operator configuration to include the secret access key for MinIO.
Locate `spinnaker-kustomize-patches/operator/patch-config.yml` and update the `AWS_SECRET_ACCESS_KEY` value with the `minioAccessKey` value you created in the [Deploy MinIO to host the BOM](#deploy-minio-to-host-the-bom) section.

{{< prism lang="yaml" line="14, 24" >}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: spinnaker-operator
spec:
  template:
    spec:
      containers:
        - name: spinnaker-operator
          env:
            - name: AWS_ACCESS_KEY_ID     # you can choose to use a secret for these values
              value: minio
            - name: AWS_SECRET_ACCESS_KEY # you can choose to use a secret for these values
              value: changeme   
          volumeMounts:
            - mountPath: /opt/spinnaker/config/halyard.yml
              name: operator-config
              subPath: halyard-local.yml
        - name: halyard
          env:
            - name: AWS_ACCESS_KEY_ID     # you can choose to use a secret for these values
              value: minio
            - name: AWS_SECRET_ACCESS_KEY # you can choose to use a secret for these values
              value: changeme             
          volumeMounts:
            - mountPath: /opt/spinnaker/config/halyard-local.yml
              name: operator-config
              subPath: halyard-local.yml
      volumes:
        - configMap:
            defaultMode: 420
            name: operator-config
          name: operator-config
{{< /prism >}}

### Update Halyard configuration

The Armory Operator uses its own Halyard installation to deploy and manage Armory Enterprise. You need to configure the new BOM location in `spinnaker-kustomize-patches/operator/halyard-local.yml`.  Update your `halyard-local.yml` to match the content of the highlighted lines in the following example:

{{< prism lang="yaml" line="8-14" >}}
halyard:
  halconfig:
    directory: /home/spinnaker/.hal
spinnaker:
  config:
    # This section is used in air-gapped environments to specify an alternate location for the Bill Of Materials (BOM).
    input:
      gcs:
        enabled: false  # If the BOM is stored in a GCS bucket, switch this to true.
      bucket: halconfig # Name of the bucket where the BOM is located.
      #region: us-west-2  # Bucket region; region does not matter for MinIO.
      enablePathStyleAccess: true # If you are using a platform that does not support PathStyleAccess, such as MinIO, switch this to true (https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro).
      endpoint: http://minio.spinnaker:9000
      anonymousAccess: false
{{< /prism >}}


## Deploy the Armory Operator

Now that you have updated `halyard-local.yml` and `patch-config.yml`, you can deploy the Armory Operator using its `kustomization.yml` file.  By default, the Armory Operator deploys to the `spinnaker-operator` namespace. From the `spinnaker-kustomize-patches/operator` directory, execute:

```bash
kubectl apply -k .
```

After the Armory Operator pod is running, verify that the S3-compatible MinIO bucket is properly configured and that the bucket contains the BOM.

The following example uses version 2.25.0 and a private Docker registry called `my.jfrog.io/myteam/armory`.

1. Run the following to access the Halyard container running in the `spinnaker-operator` pod:

   ```bash
   kubectl exec -ti deploy/spinnaker-operator -c halyard -- bash
   ```

1. Verify that the bucket is properly configured by running:

   ```bash
   aws s3 ls --endpoint=http://minio.spinnaker:9000 s3://halconfig/

   ```

1. Inspect the contents of the BOM for the version you downloaded in [Download the BOM](#download-the-bom):

   ```bash
   hal version bom <version-number>
   ```

   If you run the command passing in `2.25.0`, output is similar to:

   ```bash
   + Get BOM for 2.25.0
   Success
   version: 2.25.0
   timestamp: '2021-03-25 09:28:32'
   services:
     echo:
       version: 2.25.2
       commit: 3a098acc
     clouddriver:
       version: 2.25.3
       commit: de3aa3f0
   ...
   dependencies:
     redis:
       version: 2:2.8.4-2
   artifactSources:
     dockerRegistry: my.jfrog.io/myteam/armory
   ```

## Help resources

Contact [Armory Support](https://support.armory.io/) or use the [Spinnaker Slack](https://join.spinnaker.io/) `#armory` channel.

## {{% heading "nextSteps" %}}

[Configure and deploy Armory Enterprise using Kustomize patches]({{< ref "op-config-kustomize#configure-armory-enterprise">}}).
