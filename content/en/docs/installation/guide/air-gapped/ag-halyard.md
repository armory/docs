---
title: Air-Gapped with Halyard
weight: 3
description: >
  Options for deploying Armory Enterprise using Armory Halyard in an air-gapped environment.
categories: ["install"]
tags: ["Halyard", "air-gapped"]
---

## Overview

This guide shows how you can host the Armory Enterprise Bill of Materials (BOM) and Docker images in your air-gapped environment.

>Halyard is scheduled for deprecation in 2021, so Armory recommends using the [Armory Operator]({{< ref "armory-operator" >}}) to deploy and manage Armory Enterprise on Kubernetes. See {{< linkWithTitle "ag-operator.md" >}} for instructions.


## {{% heading "prereq" %}}

* You have read the [introduction]({{< ref "air-gapped" >}}) to air-gapped environments.
* You are using Armory-extended Halyard to deploy and manage Armory Enterprise.
* You have public internet access and access to the environment where you want to deploy Armory Enterprise.
* You have access to a private Docker registry with credentials to push images.
* You have installed the [AWS CLI](https://aws.amazon.com/cli/).
* You have installed [`yq`](https://mikefarah.gitbook.io/yq/#install) **version 4+**. This is used by helper scripts.

## Host Armory's Bill Of Materials (BOM)

Armory's BOMs are stored in public AWS S3 bucket: `s3://halconfig`.

If you are unable to access this bucket from the machine running Halyard, host the BOM in storage that is compatible with AWS S3 or Google Cloud Storage (GCS). [MinIO](https://min.io) is a good option.

### Update Halyard to use your custom storage bucket

>If you're running Halyard in Kubernetes, Armory recommends using the [Armory Operator]({{< ref "armory-operator" >}}) to deploy and manage Armory Enterprise on Kubernetes. See {{< linkWithTitle "ag-operator.md" >}} for instructions.

After you have created your custom storage bucket, you need to enable custom storage in Halyard. Create `/opt/spinnaker/config/halyard-local.yml` with the following content:

```yaml
spinnaker:
  config:
    input:
      # To use a custom GCS bucket, switch this to true
      gcs:
        enabled: false
      # Name of your private bucket
      bucket: <your-bucket-name>
      # If your s3 bucket is not in us-west-2 (region does not matter for Minio)
      region: <aws-s3-bucket-region>
      # If you are using a platform that does not support PathStyleAccess, such as Minio, switch this to true
      # https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro
      enablePathStyleAccess: false
      # For s3 like storage with custom endpoint, such as Minio:
      # endpoint: https://minio.minio:9000
      # anonymousAccess: false
```

Restart Halyard.


### Host the Armory Enterprise BOM

Use [`bomdownloader.sh`](https://github.com/armory/spinnaker-kustomize-patches/blob/master/airgap/bomdownloader.sh) to download the version of the Armory Enterprise BOM that you require.

<details><summary>Show the script</summary>

{{< github repo="armory/spinnaker-kustomize-patches" file="/airgap/bomdownloader.sh" lang="bash" options="" >}}

</details><br>

The script creates a `halconfig` folder, downloads the necessary files, and updates the BOM to use the Docker registry you specified.

To download the BOM, run `bomdownloader.sh <armory-version> <docker-registry>`. For example, if you want to download the 2.25.0 BOM and your registry is `my.jfrog.io/myteam/armory`:

```bash
./bomdownloader.sh 2.25.0 my.jfrog.io/myteam/armory
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

### Copy the BOM to your custom storage bucket

Upload the files you just downloaded to your storage bucket. Make sure they are readable from wherever Halyard is running.

For example:

{{< tabs name="copyBOM" >}}
{{% tab name="AWS" %}}

```bash
$ aws s3 cp --recursive halconfig s3://halconfig
```           
{{% /tab %}}
{{% tab name="GCS" %}}
```bash
$ gsutil cp -m -r ...
```
{{% /tab %}}
{{< /tabs >}}

## Use a custom Docker registry

There are two options for hosting the Docker images: 1) configure your Docker registry as a proxy for `docker.io/armory`; or 2) download the images and push them to your private Docker registry.

### Proxy to `docker.io/armory`

Configure `docker.io/armory` as a remote repository within your private Docker registry.  If you are using JFrog Artifactory, you can follow the instructions in the [Remote Docker Repositories](https://www.jfrog.com/confluence/display/JFROG/Docker+Registry#DockerRegistry-RemoteDockerRepositories) section of the JFrog docs.  

### Download images

You can use the [`imagedownloader.sh`](https://github.com/armory/spinnaker-kustomize-patches/blob/master/airgap/imagedownloader.sh) helper script to download and push the images to your private Docker registry.

<details><summary>Show the script</summary>

{{< github repo="armory/spinnaker-kustomize-patches" file="/airgap/imagedownloader.sh" lang="bash" options="" >}}

</details><br>

The script looks for the downloaded BOM and proceeds to download, tag, and push the images for that particular version to the private Docker registry you specified when you ran `bomdownloader.sh`.

The execution format is:

```bash
.imagedownloader.sh <armory-version>
```

Run the script from the parent directory of the `halconfig` directory that the `bomdownloader` script created.

Since you already [updated Halyard to use your custom storage bucket](#update-halyard-to-use-your-custom-storage-bucket), you can now configure and deploy Armory Enterprise.

## Help resources

Contact [Armory Support](https://support.armory.io/) or use the [Spinnaker Slack](https://join.spinnaker.io/) `#armory` channel.
