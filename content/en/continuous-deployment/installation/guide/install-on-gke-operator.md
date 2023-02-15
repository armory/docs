---
title: Deploy Armory Continuous Deployment in GKE
linkTitle: "Install in GKE using Operator"
weight: 5
aliases:
  - /spinnaker-install-admin-guides/install-on-gke-operator/
description: >
  Use the Armory Operator to deploy Armory Continuous Deployment for Spinnaker in your Google Kubernetes Engine (GKE) cluster.
draft: true
---

{{< include "armory-license.md" >}}

## Overview of installing Armory Continuous Deployment in GKE

Installing Armory using the Armory Operator consists of the following steps:

* [Create a cluster](#create-a-gke-cluster) for the Armory Operator and Armory Continuous Deployment
* [Create a GCS service account](#create-a-gcs-service-account)
* [Create a Kubernetes service account](#create-a-kubernetes-service-account)
* [Create a Google Cloud Storage (GCS) bucket](#create-a-gcs-bucket)
* [Install the Armory Operator](#install-the-armory-operator)
* [Configure your Armory Continuous Deployment installation](#configure-your-armory-enterprise-installation)
* [Deploy Armory Continuous Deployment using the Armory Operator](#deploy-armory-enterprise)

## {{% heading "prereq" %}}

* You have reviewed and met the Armory Continuous Deployment [system requirements]({{< ref "system-requirements.md" >}}).
* You know how to [install the Armory Operator in `cluster` mode]({{< ref "op-quickstart#install-the-operator" >}}).
* You know how to [configure Armory Continuous Deployment using Kustomize patches]({{< ref "op-config-kustomize.md" >}}) from the `spinnaker-kustomize-patches` repo.
* You know how to use the Armory Operator to [deploy Armory Continuous Deployment using Kustomize patches]({{< ref "op-config-kustomize#deploy-spinnaker" >}}).
* You have a machine configured to use the `gcloud` CLI tool and a recent version of the `kubectl` tool
* You have logged into the `gcloud` CLI and have permissions to create GKE clusters and a service account

## Create a GKE cluster

This creates a minimal GKE cluster in your default region and zone.

```bash
gcloud container clusters create spinnaker-cluster
export KUBECONFIG=kubeconfig-gke
gcloud container clusters get-credentials spinnaker-cluster
```

Check that namespaces have been created:

```bash
kubectl --kubeconfig kubeconfig-gke get namespaces
```

Output is similar to:

```bash
NAME STATUS AGE
default Active 2m24s
kube-node-lease Active 2m26s
kube-public Active 2m26s
kube-system Active 2m26s
```

## Create a GCS service account

```bash
export SERVICE_ACCOUNT_NAME=<name-for-your-service-account>
export SERVICE_ACCOUNT_FILE=<name=for-your-service-account.json>
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

## Create a Kubernetes service account

```bash
CONTEXT=$(kubectl config current-context)

# This service account uses the ClusterAdmin role, but this is not necessary.
# More restrictive roles can by applied.
curl -s https://spinnaker.io/downloads/kubernetes/service-account.yml | \
  sed "s/spinnaker-service-account/${SERVICE_ACCOUNT_NAME}/g" | \
  kubectl apply --context $CONTEXT -f -


TOKEN=$(kubectl get secret --context $CONTEXT \
   $(kubectl get serviceaccount ${SERVICE_ACCOUNT_NAME} \
       --context $CONTEXT \
       -n spinnaker \
       -o jsonpath='{.secrets[0].name}') \
   -n spinnaker \
   -o jsonpath='{.data.token}' | base64 --decode)

kubectl config set-credentials ${CONTEXT}-token-user --token $TOKEN

kubectl config set-context $CONTEXT --user ${CONTEXT}-token-user
```

## Create a GCS bucket

Use the GCP Console to [create your bucket](https://cloud.google.com/storage/docs/creating-buckets). If you're going to put secrets in the bucket, make sure to create a secrets directory in that bucket. Also, make sure that the Kubernetes service account you created can access the bucket.

## Install the Armory Operator

Follow the instructions in the _Armory Operator Quickstart_ guide, [Install the Operator section]({{< ref "op-quickstart#install-the-operator" >}}), **Cluster Mode** tab.

## Configure your Armory Continuous Deployment installation

Clone the `spinnnaker-kustomize-patches` template repo by following the directions in the {{< linkWithTitle "op-config-kustomize.md" >}} guide. Make sure you choose or create a `kustomization.yml` file as detailed in the _Choose a `kustomization` file_ [section]({{< ref "op-config-kustomize#choose-a-kustomization-file" >}}). You also need to [set the Armory Continuous Deployment version]({{< ref "op-config-kustomize#set-the-Spinnaker-version">}}).

### Add GCP credentials as a cluster secret

The `spinnnaker-kustomize-patches` template repo enables you
to easily create Secret objects within your Kubernetes cluster so you can
securely access credentials. Place the `${SERVICE_ACCOUNT_FILE}` file in the
`spinnnaker-kustomize-patches/secrets/files` directory and run the `./secrets/create-secrets.sh` script.

### Add your GCS bucket credentials

Update `spinnaker-kustomize-patches/persistence/patch-gcs.yml` with the info for the GCS bucket you created in the [Create a GCS bucket](#create a GCS bucket) section. You should also update the `jsonPath` value with the name of the service account file you added in the [Add GCP credentials as a cluster secret](#add-gcp-credentials-as-a-cluster-secret) section.

Add the `persistence/patch-gcs.yml` file to the `patchesStrategicMerge` section of your `kustomization.yml` file.

### Configure Ingress

The `spinnaker-kustomize-patches` repo contains several examples for
exposing Ingress to your cluster. Consult the examples in the `expose`
directory and choose the most appropriate example for your environment. Make
any modifications to the examples for your environment, then make sure the file
is listed in the `patchesStrategicMerge` section of your `kustomization.yml`
file.

See [spec.expose]({{< ref "op-config-manifest#specexpose" >}}) for configurable fields.

### Configure authentication

The `spinnaker-kustomize-patches` repo contains several examples for adding
authentication to your cluster. Consult the examples in the `security` directory
and choose the most appropriate example for your environment. For example, to
enable basic auth, modify the `security/patch-basic-auth.yml` by changing the
username to one of your choosing. Then, add `security/patch-basic-auth.yml` to
your `kustomization.yml` file in the `patchesStrategicMerge` section. Finally,
modify the `secrets-example.env` file to choose a password unique to you, and
run the `./create-secrets.sh` script to create Kubernetes credentials in your
cluster.

>Make sure you enable the right Auth Scopes on the GKE node pools, or you may see authentication issues trying to write to Google Cloud Storage for logging.

### Configure Dinghy

The `spinnaker-kustomize-patches` repository contains a patch for
enabling Dinghy in your Armory Continuous Deployment deployment. Be sure to modify the
`armory/patch-dinghy.yml` file with configuration specific to your environment.
Then make sure the file is listed in the `patchesStrategicMerge` section of your
`kustomization.yml` file.

## Deploy Armory Continuous Deployment

{{% include "armory-operator/deploy-spin-kust.md" %}}


<!--
## Set Up TLS:
@TODO
-->

## {{% heading "nextSteps" %}}

* See the Armory Operator {{< linkWithTitle "op-troubleshooting.md" >}} guide if you encounter issues.
