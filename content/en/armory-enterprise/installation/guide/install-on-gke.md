---
title: Install Armory Enterprise for Spinnaker in the Google Kubernetes Engine (GKE)
linkTitle: "Install in GKE"
draft: true
weight: 5
aliases:
  - /spinnaker_install_admin_guides/install_on_gke/
  - /spinnaker_install_admin_guides/install-on-gke/
  - /spinnaker-install-admin-guides/install_on_gke/
  - /spinnaker-install-admin-guides/install-on-gke/
description: >
  Use Armory-extended Halyard and Armory's Spinnaker<sup>TM</sup> tools CLI to deploy Armory Enterprise for Spinnaker in your Google Kubernetes Engine (GKE) cluster.
---

{{< include "armory-license.md" >}}

## Overview of installing Armory

This guide describes how to install Armory in Google Kubernetes Engine (GKE).  It will create / use the following Google Cloud resources:

* A GKE (Google Kubernetes Engine) cluster (you can use an existing one if you already have one)
* A GCS (Google Cloud Storage) bucket (you can use an existing one if you already have one)
* An NGINX Ingress controller in your GKE cluster. This step is only needed if your cluster doesn't already have an ingress installed. Note that the examples on this page for NGINX only work on Kubernetes version 1.14 or later.

This document currently does not fully cover the following (see [Next Steps](#next-steps) for some links to achieve these)

* TLS Encryption
* Authentication/Authorization
* Add K8s accounts to deploy to
* Add cloud accounts to deploy to

> This document is focused on Armory but can be adapted to install Open Source Spinnaker<sup>TM</sup> by using a different Halyard container and a corresponding different Spinnaker version


## Prerequisites for installing Armory

This document is written with the following workflow in mind:

* You have a machine (referred to as the `workstation machine` in this document) configured to use the `gcloud` CLI tool and a recent version of `kubectl` tool
* You have a machine (referred to as the `Halyard machine` in this document) with the Docker daemon installed, and can run Docker containers on it
* You can transfer files created on the `workstation machine` to the `Halyard machine` (to a directory mounted on a running Docker container)
* These two machines can be the same machine

Furthermore:

On the `Halyard machine`:

* Halyard (the tool used to install and manage Armory) is run in a Docker container on the `Halyard machine`
* The Halyard container on the `Halyard machine` will be configured with the following volume mounts, which should be persisted or preserved to manage your Armory cluster
  * `.hal` directory (mounted to `/home/spinnaker/.hal`) - stores all Halyard Armory configurations in a `.hal/config` YAML file and assorted subdirectories
  * `.secret` directory (mounted to `/home/spinnaker/.secret`) stores all external secret keys and files used by Halyard
  * `resources` directory (mounted to `/home/spinnaker/resources`) stores all Kubernetes manifests and other resources that help create Kubernetes resources
* You will create `kubeconfig` files that will be added to the `.secret` directory
* You will create a Google IAM service account key that will be added to the `.secret` directory

On the `workstation machine`:

* You can use `gcloud` to create Google resources:
  * GKE clusters (or, alternately, have a GKE cluster already built)
  * GCS buckets (or, alternately, have a GCS bucket already built)
* You have the `kubectl` (Kubernetes CLI tool) installed and are able to use it to interact with your GKE cluster, if you're using a prebuilt GKE cluster
* You have a persistent working directory in which to work in.  One option here is `~/gke-spinnaker`
* You will create GKE resources, such as service accounts, that will be permanently associated with your Armory cluster

## Installation summary

In order to install Armory, this document covers the following things:

* Generating a `kubeconfig` file, which is a Kubernetes credential file that Halyard and Armory will use to communicate with the Kubernetes cluster where Armory will be installed
* Creating an GCS bucket for Armory to store persistent configuration in
* Creating an IAM service account that Armory will use to access the GCS bucket
* Running the Halyard daemon in a Docker container
  * Persistent configuration directories from the workstation/host will be mounted into the container
* Running the `hal` client interactively in the same Docker container to:
  * Build out the halconfig YAML file (`.hal/config`)
  * Configure Armory/Halyard to use the kubeconfig to install Armory
  * Configure Armory with the IAM credentials and bucket information
  * Turn on other recommended settings (artifacts and http artifact provider)
  * Install Armory
  * Expose Armory


## Create the GKE cluster

This assumes you have already configured the `gcloud` SDK with a project, zone, and region (see directions [here](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-a-cluster)

This creates a minimal GKE cluster in your default region and zone.  Follow the official GKE instructions to set up a different type of GKE cluster.

1. Create the local working directory on your workstation.  For the purposes of this document, we will be using `~/gke-spinnaker`, but this can be any persistent directory on any Linux or OSX machine.

   ```bash
   mkdir ~/gke-spinnaker
   cd ~/gke-spinnaker
   ```

1. Run this command to create the GKE cluster (from the `workstation machine`):

   ```bash
   gcloud container clusters create spinnaker-cluster
   ```

1. Run this command to configure `kubectl` to use the cluster you've created:

   ```bash
   export KUBECONFIG=kubeconfig-gke
   gcloud container clusters get-credentials spinnaker-cluster
   ```

1. Alternately, if you're using a pre-existing GKE cluster:

   ```bash
   export KUBECONFIG=kubeconfig-gke
   gcloud container clusters get-credentials <your-cluster-name>
   ```

   (Feel free to use a different region and zones)

1. From here, you can validate access to the cluster with this command:

   ```bash
   kubectl --kubeconfig kubeconfig-gke get namespaces
   ```

## Create a `kubeconfig` file for Halyard/Armory

Armory will be installed in its own namespace in your GKE cluster.
For the purposes of this document, we will be installing Armory in the `spinnaker-system` namespace; you're welcome to use a different namespace for this.

We're going to create the following:

* A namespace called `spinnaker-system` to install Armory in
* A service account for that namespace
* A role and rolebinding in that namespace, granting permissions to the service account
* A kubeconfig containing credentials for the service account

Halyard uses this Kubeconfig file to create the Kubernetes deployment objects that create the microservices that compose Armory.  This same Kubeconfig is passed to Armory so that Armory can see and manage its own resources.

This document uses the Armory `spinnaker-tools` Go CLI (available on [Github](https://github.com/armory/spinnaker-tools)) to create many of these resources.  There are separate instructions to perform these steps manually.

By default, Google IAM users do not have all necessary permissions on GKE clusters.  You can grant them with this:

```bash
kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $(gcloud config get-value account)
```

1. Obtain the `spinnaker-tools` CLI tool.  Go to <https://github.com/armory/spinnaker-tools/releases>, and download the latest release for your operating system (OSX and Linux available).  You can also use curl:

   ```bash
   # If you're not already in the directory
   cd ~/gke-spinnaker
   # If you're on Linux instead of OSX, use this URL instead:
   # https://github.com/armory/spinnaker-tools/releases/download/0.0.6/spinnaker-tools-linux
   curl -L https://github.com/armory/spinnaker-tools/releases/download/0.0.6/spinnaker-tools-darwin -o spinnaker-tools
   chmod +x spinnaker-tools
   ```

1. Run the tool.  Feel free to substitute other values for the parameters:

   ```bash
   # The 'gcloud container clusters get-credentials' command from above will create/update this file
   SOURCE_KUBECONFIG=kubeconfig-gke
   CONTEXT=$(kubectl --kubeconfig ${SOURCE_KUBECONFIG} config current-context)
   DEST_KUBECONFIG=kubeconfig-spinnaker-system-sa
   SPINNAKER_NAMESPACE=spinnaker-system
   SPINNAKER_SERVICE_ACCOUNT_NAME=spinnaker-service-account

   ./spinnaker-tools create-service-account \
     --kubeconfig ${SOURCE_KUBECONFIG} \
     --context ${CONTEXT} \
     --output ${DEST_KUBECONFIG} \
     --namespace ${SPINNAKER_NAMESPACE} \
     --service-account-name ${SPINNAKER_SERVICE_ACCOUNT_NAME}
   ```

You should be left with a file called `kubeconfig-spinnaker-system-sa` (or something similar, if you're using a different namespace for spinnaker)

## Create a GCS service account for Armory

Armory uses a GCS bucket to store persistent configuration (such as pipeline definitions).  This section will create a Google IAM service account as well as a Google credential file for use by Halyard and Armory.

By default, this account will have the `roles/storage.admin` IAM role; if you have an existing GCS bucket to use, you can specify a different set of permissions.

```bash
export SERVICE_ACCOUNT_NAME=spinnaker-gcs-account-trial
export SERVICE_ACCOUNT_FILE=spinnaker-gcs-account.json
export PROJECT=$(gcloud info --format='value(config.project)')

gcloud --project ${PROJECT} iam service-accounts create \
    ${SERVICE_ACCOUNT_NAME} \
    --display-name ${SERVICE_ACCOUNT_NAME}

SA_EMAIL=$(gcloud --project ${PROJECT} iam service-accounts list \
    --filter="displayName:${SERVICE_ACCOUNT_NAME}" \
    --format='value(email)')

gcloud --project ${PROJECT} projects add-iam-policy-binding ${PROJECT} \
    --role roles/storage.admin --member serviceAccount:${SA_EMAIL}

mkdir -p $(dirname ${SERVICE_ACCOUNT_FILE})

gcloud --project ${PROJECT} iam service-accounts keys create ${SERVICE_ACCOUNT_FILE} \
    --iam-account ${SA_EMAIL}
```

## Stage files on the `Halyard machine`

On the `Halyard machine`, choose a local working directory for Halyard.  In it, we will create two folders:

* `WORKING_DIRECTORY/.hal`
* `WORKING_DIRECTORY/.secret`
* `WORKING_DIRECTORY/resources`

```bash
# Feel free to use some other directory for this; make sure it is a persistent directory.
# Also, make sure this directory doesn't live on an NFS mount, as that can cause issues
WORKING_DIRECTORY=~/gke-spinnaker/
mkdir -p ${WORKING_DIRECTORY}/.hal
mkdir -p ${WORKING_DIRECTORY}/.secret
mkdir -p ${WORKING_DIRECTORY}/resources
```

You should have two files:

* A kubeconfig file (`kubeconfig-spinnaker-system-sa`) with the credentials for a service account in your GKE cluster
* A JSON key file (`spinnaker-gcs-account.json`) with credentials for a Google IAM service account with Google storage permissions

Copy both into `.secret` so it is available to your Halyard docker container:

```bash
cp kubeconfig-spinnaker-system-sa ${WORKING_DIRECTORY}/.secret
cp spinnaker-gcs-account.json ${WORKING_DIRECTORY}/.secret
```

## Start the Halyard container

{{< include "halyard-note.md" >}}

On the `Halyard machine`, start the Halyard container.

*If you want to install open source Spinnaker instead, use `gcr.io/spinnaker-marketplace/halyard:stable` for the Docker Halyard image reference in substitution of `armory/halyard-armory:<image_version>` in the commands below*

{{< include "install/docker-note.md" >}}

```bash
docker run --name armory-halyard -it --rm \
  -v ${WORKING_DIRECTORY}/.hal:/home/spinnaker/.hal \
  -v ${WORKING_DIRECTORY}/.secret:/home/spinnaker/.secret \
  -v ${WORKING_DIRECTORY}/resources:/home/spinnaker/resources \
  armory/halyard-armory:{{< param halyard-armory-version >}}
```

## Enter the Halyard container

From a separate terminal session on your `docker machine`, create a second bash/shell session on the Docker container:

```bash
docker exec -it armory-halyard bash

# Also, once in the container, you can run these commands for a friendlier environment to:
# - prompt with information
# - alias for ls
# - cd to the home directory
export PS1="\h:\w \u\$ "
alias ll='ls -alh'
cd ~
```

## Add the kubeconfig and cloud provider to Armory (via Halyard)

From the `docker exec` separate terminal session, add (re-export) the relevant environment variables

```bash
###### Use the same values as the start of the document
# Enter the namespace that you want to install Armory in.  This should have been created in the previous step.
export NAMESPACE="spinnaker-system"

# Enter the name you want Armory to use to identify the cloud provider account
export ACCOUNT_NAME="spinnaker"

# Update this with the full path to your kubeconfig inside the container)
export KUBECONFIG_FULL=/home/spinnaker/.secret/kubeconfig-spinnaker-system-sa
```

Use the Halyard `hal` command line tool to add a Kubernetes account using your minified kubeconfig

Configure the kubeconfig and account:

```bash
# Enable the Kubernetes cloud provider
hal config provider kubernetes enable

# Add account
hal config provider kubernetes account add ${ACCOUNT_NAME} \
  --provider-version v2 \
  --kubeconfig-file ${KUBECONFIG_FULL} \
  --only-spinnaker-managed true \
  --namespaces ${NAMESPACE}
```

## Configure Armory to install in Kubernetes

**Important: This will by default limit your Armory to deploying to the namespace specified.  If you want to be able to deploy to other namespaces, either add a second cloud provider target or remove the `--namespaces` flag.**

Use the Halyard `hal` command line tool to configure Halyard to install Armory in your Kubernetes cluster

```bash
hal config deploy edit \
  --type distributed \
  --account-name ${ACCOUNT_NAME} \
  --location ${NAMESPACE}
```

## Enable Artifacts

Within Armory, 'artifacts' are consumable references to items that live outside of Armory (for example, a file in a git repository or a file in an S3 bucket are two examples of artifacts).  This feature must be explicitly turned on.

Enable the "Artifacts" feature and the "http" artifact artifact provider:

```bash
# Enable artifacts
hal config features edit --artifacts true
hal config artifact http enable
```

(In order to add specific types of artifacts, there are further configuration
items that must be completed.  For now, it is sufficient to just turn on the
artifacts feature with the http artifact provider.  This will allow Armory
to retrieve files via unauthenticated http.)

## Configure Armory to use your GCS bucket

Use the Halyard `hal` command line tool to configure Halyard to configure Armory to use your GCS bucket

**You MUST update the PROJECT field with your GCP project name**

*If you're using a pre-existing bucket, you can update ROOT_FOLDER with a different path within your folder.*

```bash
####### Inside container
PROJECT=GOOGLE_CLOUD_PROJECT_NAME
BUCKET_LOCATION=us
SERVICE_ACCOUNT_FILE=~/.secret/spinnaker-gcs-account.json
ROOT_FOLDER=front-50

hal config storage gcs edit --project ${PROJECT} \
    --bucket-location ${BUCKET_LOCATION} \
    --root-folder ${ROOT_FOLDER} \
    --json-path ${SERVICE_ACCOUNT_FILE}

hal config storage edit --type gcs
```

## Choose the Armory version

Before Halyard will install Armory, you should specify the version of Armory you want to use.

You can get a list of available versions of spinnaker with this command:

```bash
hal version list
```

*If you are installing Armory, you will get a version that starts with `2.x.x`*

*If you are installing open source Spinnaker and using `gcr.io/spinnaker-marketplace/halyard:stable`, you will get a version that starts with `1.x.x`*

And then you can select the version with this:

```bash
# Replace with version of choice:
export VERSION=2.3.4
hal config version edit --version $VERSION
```

## Install Armory

Now that your halconfig is completely configured for the initial Armory, you can tell Halyard to actually install Armory:

```bash
hal deploy apply
```

Once this is complete, congratulations!  Armory is installed.  Now we have to access and expose it.

## Connect to Armory using `kubectl port-forward`

If you have kubectl on a local machine with access to your Kubernetes cluster, you can test connecting to it with the following:

```bash
NAMESPACE=spinnaker-system
DECK_POD=$(kubectl -n ${NAMESPACE} get pod -l cluster=spin-deck -ojsonpath='{.items[0].metadata.name}')
GATE_POD=$(kubectl -n ${NAMESPACE} get pod -l cluster=spin-gate -ojsonpath='{.items[0].metadata.name}')
kubectl -n ${NAMESPACE} port-forward ${DECK_POD} 9000 &
kubectl -n ${NAMESPACE} port-forward ${GATE_POD} 8084 &
```

Then, you can access Armory at http://localhost:9000

(If you are doing this on a remote machine, this will not work because your browser attempts to access localhost on your local workstation rather than on the remote machine where the port is forwarded)

__Note:__ Even if the `hal deploy apply` command returns successfully, the
installation may not be complete yet. This is especially the case with
distributed Kubernetes installs. If you see errors such as `Connection refused`,
the containers may not be available yet. You can either wait
or check the status of all of the containers using the command for your cloud provider
(such as `kubectl get pods --namespace spinnaker`).

## Install the NGINX ingress controller

In order to expose Armory to end users, you have perform the following actions:

* Expose the spin-deck (UI) Kubernetes service on some URL endpoint
* Expose the spin-gate (API) Kubernetes service on some URL endpoint
* Update Armory (via Halyard) to be aware of the new endpoints

We're going to install the NGINX ingress controller on GKE because of these two limitations of the built-in GKE Ingress controller:

* It only exposes NodePort services
* It only exposes services that respond with an `HTTP 200` to a `GET` on `/` (or have a `readinessProbe` configured)

If you already have an NGINX ingress controller installed on your cluster, skip this step.

(Both of these are configurable with Armory, but the NGINX ingress controller is also generally much more configurable)

{{< include "install/nginx-common.md" >}}


## Set up the Ingress for `spin-deck` and `spin-gate`

Identify the URLs you will use to expose Armory's UI and API.

```bash
# Replace with actual values
SPIN_DECK_ENDPOINT=spinnaker.some-url.com
SPIN_GATE_ENDPOINT=api.some-url.com
NAMESPACE=spinnaker-system
```

Create a Kubernetes Ingress manifest to expose spin-deck and spin-gate (change your hosts and namespace accordingly):

```bash
tee spin-ingress.yaml <<-'EOF'
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: spin-ingress
  namespace: NAMESPACE
  labels:
    app: spin
    cluster: spin-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  - host: SPIN_DECK_ENDPOINT
    http:
      paths:
      - backend:
          serviceName: spin-deck
          servicePort: 9000
        path: /
  - host: SPIN_GATE_ENDPOINT
    http:
      paths:
      - backend:
          serviceName: spin-gate
          servicePort: 8084
        path: /
EOF

sed -i.bak \
  -e "s|NAMESPACE|${NAMESPACE}|g" \
  -e "s|SPIN_DECK_ENDPOINT|${SPIN_DECK_ENDPOINT}|g" \
  -e "s|SPIN_GATE_ENDPOINT|${SPIN_GATE_ENDPOINT}|g" \
  spin-ingress.yaml
```

Create the Ingress

```bash
kubectl apply -f spin-ingress.yaml
```

## Configure Armory to be aware of its endpoints

Armory must be aware of its endpoints to work properly.

This should be done from the halyard container:

```bash
SPIN_DECK_ENDPOINT=spinnaker.some-url.com
SPIN_GATE_ENDPOINT=api.some-url.com
SPIN_DECK_URL=http://${SPIN_DECK_ENDPOINT}
SPIN_GATE_URL=http://${SPIN_GATE_ENDPOINT}

hal config security ui edit --override-base-url ${SPIN_DECK_URL}
hal config security api edit --override-base-url ${SPIN_GATE_URL}

hal deploy apply
```

## Set up DNS

Once the ingress is up (this may take some time), you can get the IP address for the ingress:

```bash
$ kubectl describe -n spinnaker-system ingress spin-ingress
Name:             spin-ingress
Namespace:        spinnaker
Address:          35.233.216.189
Default backend:  default-http-backend:80 (10.36.2.7:8080)
Rules:
  Host                    Path  Backends
  ----                    ----  --------
  spinnaker.some-url.com
                          /   spin-deck:9000 (<none>)
  api.some-url.com
                          /   spin-gate:8084 (<none>)
Annotations:
  kubectl.kubernetes.io/last-applied-configuration:  {"apiVersion":"extensions/v1beta1","kind":"Ingress","metadata":{"annotations":{"kubernetes.io/ingress.class":"nginx"},"name":"spinnaker-nginx-ingress","namespace":"spinnaker"},"spec":{"rules":[{"host":"spinnaker.some-url.com","http":{"paths":[{"backend":{"serviceName":"spin-deck","servicePort":9000},"path":"/"}]}},{"host":"api.some-url.com","http":{"paths":[{"backend":{"serviceName":"spin-gate","servicePort":8084},"path":"/"}]}}]}}

  kubernetes.io/ingress.class:  nginx
Events:
  Type    Reason  Age   From                      Message
  ----    ------  ----  ----                      -------
  Normal  CREATE  28s   nginx-ingress-controller  Ingress spinnaker/spinnaker-nginx-ingress
  Normal  UPDATE  20s   nginx-ingress-controller  Ingress spinnaker/spinnaker-nginx-ingress
```

Set up DNS so that your two URLs point to the IP address for the ingress (in the above, configure `spinnaker.some-url.com` and `api.some-url.com` to point to `35.233.216.189`).  This can be done via whatever your organization uses for DNS.

## Configuring TLS certificates

Configuration of TLS certificates for ingresses is often very organization-specific.  In general, you would want to do the following:

* Add certificate(s) so that your ingress controller can use them
* Configure the ingress(es) so that NGINX (or your ingress) terminates TLS using the certificate(s)
* Update Armory to be aware of the new TLS endpoints (note `https` instead of `http`)

  ```bash
  SPIN_DECK_ENDPOINT=spinnaker.some-url.com
  SPIN_GATE_ENDPOINT=api.some-url.com
  SPIN_DECK_URL=https://${SPIN_DECK_ENDPOINT}
  SPIN_GATE_URL=https://${SPIN_GATE_ENDPOINT}

  hal config security ui edit --override-base-url ${SPIN_DECK_URL}
  hal config security api edit --override-base-url ${SPIN_GATE_URL}

  hal deploy apply
  ```

## Next steps

Now that you have Armory up and running, here are some of the next things you may want to do:

* Configuration of certificates to secure your cluster (see [this section](#configuring-tls-certificates) for notes on this)
* Configuration of Authentication/Authorization (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/security/))
* Add Kubernetes accounts to deploy applications to (see [Creating and Adding a Kubernetes Account to Armory as a Deployment Target]({{< ref "kubernetes-account-add" >}}))
* Add GCP accounts to deploy applications to (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/install/providers/gce/))
* Add AWS accounts to deploy applications to (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/install/providers/aws/))
