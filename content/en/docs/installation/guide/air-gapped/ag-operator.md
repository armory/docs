---
title: Air-Gapped with the Armory Operator
weight: 2
description: >
  Guide for hosting the Armory Enterprise BOM and Docker images in an air-gapped environment.
---

## Overview

This guide details how you can host the Armory Enterprise Bill of Materials (BOM) and Docker images in your own environment.


1. Clone the `spinnaker-kustomize-patches` repo, which contains helper scripts as well as Kustomize patches.
1. Install S3-compatible MinIO to store the BOM.
1. Download the BOM.
1. Move the BOM to your MinIO bucket.
1. Download and move Armory Enterprise Docker images to your private Docker registry
1. Update `halyard` to use the custom BOM location.
1. Install the Armory Operator in your Kubernetes cluster.

## {{% heading "prereq" %}}

* You are familiar with the [Armory Operator]({{< ref "armory-operator" >}}) and [configuring Armory Enterprise using Kustomize patches]({{< ref "op-config-kustomize" >}}).
* You have read the [introduction]({{< ref "air-gapped" >}}) to air-gapped environments and have installed the [AWS CLI](https://aws.amazon.com/cli/).
* You have public internet access.
* You have admin access to your Kubernetes cluster.
* You have created two namespaces in Kubernetes: `spinnaker` and `spinnaker-operator`.
* You have access to a private Docker registry with credentials to push images.
* If needed, you have certificates for Custom Certificate Authorities and servers.

## Clone the `spinnaker-kustomize-patches` repo

{{% include "armory-operator/spin-kust-repo.md" %}}

## Deploy MinIO to host the BOM

Now that you have cloned the `spinnaker-kustomize-patches` repo, you need to create a storage bucket to host the BOM. [MinIO](https://min.io) is a good choice for the bucket since it runs as a pod in Kubernetes. You can find the manifest for MinIO in `spinnaker-kustomize-patches/infrastructure/minio.yml`.

When you look at the content of the `minio.yml` manifest, you see that MinIO needs keys:

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

Those keys are stored in a Kubernetes secret called `spin-secrets.` You create the secret by running the script `create-secrets.sh` located in the `spinnaker-kustomize-patches/secrets` folder.

Before executing the following commands, make sure you are in the `spinnaker-kustomize-patches` directory and that you have created the `spinnaker` Kubernetes namespace.

1. Create the MinIO secret key:

   ```bash
   ./secrets/create-secrets.sh
   ```

1. Deploy MinIO:

   ```bash
   kubectl create -f infrastructure/minio.yml -n spinnaker
   ```

## Download the BOM

The BOM contains the image versions used by Armory Enterprise. Decide which Armory Enterprise version you want to deploy. Check [Armory Release Notes]({{< ref "rn-armory-spinnaker" >}}) for the latest supported versions.

The `spinnaker-kustomize-patches/airgap` directory contains helper scripts for air-gapped environments. Use `bomdownloader.sh` to download the version of the Armory Enterprise BOM you require.

`bomdownloader.sh` takes two command line parameters in the following order:

1. Armory Enterprise version; for example, {{< param "armory-version-exact" >}}.
2. The name of your Docker registry; for example, `my.jfrog.io/myteam/armory`.

The script creates a `halconfig` folder, downloads the necessary files, and updates the BOM to use the Docker registry you specified.

Before you run this script, make sure you have installed the [AWS CLI](https://aws.amazon.com/cli/) and [`yq`](https://mikefarah.gitbook.io/yq/)

Run `bomdownloader.sh <armory-version> <docker-registry>`. For example:

```bash
./airgap/bomdownloader.sh 2.25.0 my.jfrog.io/myteam/armory
```

Output is similar to:

```bash
download: s3://halconfig/versions.yml to halconfig/versions.yml
download: s3://halconfig/bom/2.25.0.yml to halconfig/bom/2.25.0.yml
Version 2.25.0 is ready to be uploaded to your private bucket.
For example, with "aws cp --recursive"  or "gsutil cp -m -r ..."
```

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

## Move the BOM

With the MinIO pod running, you set up the terminal to copy the BOM into the bucket.

```bash
export AWS_ACCESS_KEY_ID=minio
export AWS_SECRET_ACCESS_KEY=changeme

kubectl port-forward svc/minio 9000 -n spinnaker
aws s3 mb s3://halconfig --endpoint=http://localhost:9000
aws s3 cp --recursive halconfig s3://halconfig --endpoint=http://localhost:9000
```
* WARNING: If you're using `kustomize-spinnaker-patches` consider removing `infrastructure/minio.yml` from the list of resources to prevent the accidental deletion of the bucket when calling `kubectl delete -k .`.

## Re-Host Images (If necessary)

If possible, configure `docker.io/armory` as a remote repository with your docker registry.  For example these are the instructions for configuring a generic docker hub registry in JFrog Artifactory: https://www.jfrog.com/confluence/display/JFROG/Docker+Registry#DockerRegistry-RemoteDockerRepositories

Otherwise, you can utilize the helper script [`imagedownloader.sh`](https://github.com/armory/spinnaker-kustomize-patches/blob/master/airgap/imagedownloader.sh) to download and push the images to your private docker registry. To use it, simply pass in the version of the bom you previously downloaded. The script looks in the current folder for the downloaded bom and proceeds to download, tag, and push the images for that particular version.

```bash
./imagedownloader.sh 2.25.0
```

## Update Halyard

We now need to point Halyard to the new BOM location.  Update the [`halyard-local.yml`](https://github.com/armory/spinnaker-kustomize-patches/blob/master/operator/halyard-local.yml) with the bucket we just created.

```yml
halyard:
  halconfig:
    directory: /home/spinnaker/.hal

spinnaker:
  config:
    # This section is used in air-gapped environments to specify an alternate location for spinnaker Bill Of Materials (BOM).
    input:
      gcs:
        enabled: false                   # If the BOM is stored in a GCS bucket, switch this to true.
      bucket: halconfig                  # Name of the bucket where spinnaker BOM is located.
      #region: us-west-2                  # Bucket region (region does not matter for Minio).
      enablePathStyleAccess: true       # If you are using a platform that does not support PathStyleAccess, such as Minio, switch this to true (https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro).
      endpoint: http://minio.spinnaker:9000 # For s3 like storage with custom endpoint, such as Minio.
      anonymousAccess: false
```

We also need to update the operator to include the access key and secret access key used by minio.
Update the [`patch-config`](https://github.com/armory/spinnaker-kustomize-patches/blob/master/operator/patch-config.yaml)

```yaml
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
```

## Run the spinnaker operator!

### Download the Spinnaker Manifests
Download and untar the latest operator into the operator folder.
The kustomization.yml already utilizes the packaged spinnaker operator folder structure.

```bash
cd spinnaker-kustomize-patches/operator
curl -L https://github.com/armory-io/spinnaker-operator/releases/download/v1.2.5/manifests.tgz | tar -xz
```
Now you should see the following directory structure:

```bash
operator$ tree -L 2
.
├── deploy
│   ├── crds
│   ├── openshift
│   ├── operator
│   └── spinnaker
├── halyard-local.yml
├── kustomization.yml
├── patch-config.yaml
└── patch-validations.yaml
```

### Rehost the Operator Images

Use the helper script to automatically retrieve and rehost the operator images.

From the operator folder execute the `operatorimageudpate.sh` script:
```bash
../airgap/operatorimageudpate.sh my.jfrog.io/myteam/armory
```

The script does two things: first, it rehosts the images for the spinnaker operator, and second, it updates the kustomization yaml with the new image names.

```yaml

```

### Deploy the Armory Operator

With the updated `halyard-local.yml` and `patch-config.yml` configured in the previous step, we can now deploy the spinnaker operator.  By default the operator deploys to the `spinnaker-operator` namespace.

```bash
kubectl apply -k .
```

Verify that the s3 bucket is properly configured and that the bucket contains the bom with the following command inside the halyard container in the spinnaker-operator pod.

```bash
hal version bom 2.25.0
```
example:
```bash
$ kubectl exec -ti deploy/spinnaker-operator -c halyard -- bash
bash-5.0$ aws s3 ls --endpoint=http://minio:9000 s3://halconfig/
                           PRE bom/
                           PRE profiles/
bash-5.0$ hal version bom 2.25.0
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
  dockerRegistry: my.docker.io/armory
```
You now have the Spinnaker Operator running with a custom BOM and custom docker registry!

Next, we need to deploy Spinnaker!
Check out the Spinnaker-Kustomize-Patches docs on configuring Spinnaker.