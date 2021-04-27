---
title: Air-Gapped using the Armory Operator
weight: 2
description: >
  Options for deploying Armory Enterprise using the Armory Operator in an air-gapped environment.
---

### Enabling a custom bucket with the Spinnaker Operator

To enable custom storage with the Operator start with the manifests located in this subdirectory: https://github.com/armory/spinnaker-kustomize-patches/tree/master/operator

hint: You can clone this repo in its entirety to install and configure Spinnaker.  `git clone https://github.com/armory/spinnaker-kustomize-patches.git`

hint: The [spinnaker-kustomize-patches]({{op-config-kustomize#spinnaker-kustomize-patches-repo}}) repo provides various templates for configuring Spinnaker.

hint: This repo uses kustomize to deploy the spinnaker operator.  To learn more about kustomize check out this [link on kustomize]({{op-config-kustomize#how-kustomize-works}})

Download and install the spinnaker operator into the `operator` folder mentioned above.

```bash
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

Update the `halyard-local.yml` so that it points to your new s3 bucket.

```yaml
spinnaker:
  config:
    # This section is used in air-gapped environments to specify an alternate location for spinnaker Bill Of Materials (BOM).
    input:
      gcs:
        enabled: false                   # If the BOM is stored in a GCS bucket, switch this to true.
      bucket: myownbucket                  # Name of the bucket where spinnaker BOM is located.
      # region: us-west-2                  # Bucket region (region does not matter for Minio).
      enablePathStyleAccess: true       # If you are using a platform that does not support PathStyleAccess, such as Minio, switch this to true (https://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro).
      # endpoint: https://minio.minio:9000 # For s3 like storage with custom endpoint, such as Minio.
      # anonymousAccess: false
```

### Option 2: Armory Operator

The [Armory Operator]({{< ref "armory-operator" >}}) lets you manage Armory with `kubectl`.


FIX-ME

If you also need to use privately hosted bill of materials, configure the Operator to point to your bucket. See {{< linkWithTitle "op-hal-config.md" >}}

If you also need to use privately hosted bill of materials, configure the operator to point to your bucket. See above [Enabling a custom bucket with the Spinnaker Operator](#enabling-a-custom-bucket-with-the-Spinnaker-Operator) and [Custom Halyard Configuration]({{< ref "op-hal-config" >}}).


# Walkthrough Guide
This is a guide for configuring Spinnaker in an air-gapped environment using the Spinnaker Operator. We will be working from the [spinnaker-kustomize-patches](https://github.com/armory/spinnaker-kustomize-patches) which contains useful manifests and scripts that we will use.

## Pre-requisites
* access to public s3 buckets, and docker.io
* aws-cli installed
* s3 bucket or equivalent
* private docker registry (if necessary, with credentials to push images)
* if necessary, certificates for Custom Certificate Authorities and servers
* admin access to K8s cluster, with two namespaces created: `spinnaker` and `spinnaker-operator`

## Overview
1. Re-host Bill-of-Materials (BOM): Download, and re-host BOM in an S3 bucket
1. Download and re-host Armory images to a private docker registry
1. Update `halyard` to use the custom bom location
1. Deploy spinnaker-operator with custom halyard

## Setup environment

You need access to the kubernetes environment you will be using to host Armory, and you will need access to the public internet to retrieve the resources described.
Start by cloning [`spinnaker-kustomize-patches`](https://github.com/armory/spinnaker-kustomize-patches).
To learn more about this repo check out this [guide]({{op-config-kustomize#spinnaker-kustomize-patches-repo}})

## Re-host Bill-of-Materials (BOM)

### Download the BOM
The BOM contains the image versions used by Armory.  First, we will download the version of the BOM that we need.  Check [Armory Release Notes]({{Armory-Enterprise-for-Spinnaker-Release-Notes}) for the latest supported versions.

Use the [bomdownloader.sh](https://github.com/armory/spinnaker-kustomize-patches/blob/master/airgap/bomdownloader.sh) script in spinnaker-kustomize-patches to download the version of Armory you require. Specify the version you want to download and the private registry you want to use.

```bash
$ ./bomdownloader.sh 2.25.0 my.jfrog.io/myteam/armory
```
*note*: you need to have access to the public internet and the aws cli

The script will create a folder `halconfig` and download the necessary files as well as update the BOM to use the docker registy you specified.  If you need to make any changes, you can manually edit the version file located under `halconfig/bom` and update the value under the key `artifactSources.dockerRegistry`.  e.g.

```bash
$ cat halconfig/bom/2.25.0.yml
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
```

### Re-host BOM

Now that we have the BOM, the next step is to copy the BOM into our S3 bucket.
We will use [MinIO](https://min.io) as our destination bucket. MinIO runs as a pod in k8s, and there is a template for MinIO under [`infrastructure/minio.yml`](https://github.com/armory/spinnaker-kustomize-patches/blob/master/infrastructure/minio.yml).

note: The template relies on the creation of a k8s secret called `spin-secrets.` We will create the secret by running the script `create-secrets.sh` located under the secrets folder. MinIO will

```bash
$ ./secrets/create-secrets.sh
```
reminder: Please make sure you have a namespace called `spinnaker`

With the secret created, we will now create the MinIO pod.

```bash
$ kubectl create -f infrastructure/minio.yml -n spinnaker
```

With the MinIO pod running, we will now setup the terminal to copy the BOM into the bucket.

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

### Deploy the Spinnaker Operator

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