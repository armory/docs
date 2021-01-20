---
title: Installing Armory in the Google Kubernetes Engine using the Armory Operator
linkTitle: "Install in GKE using Operator"
weight: 7
aliases:
  - /spinnaker-install-admin-guides/install-on-gke-operator/
description: >
  Learn how to install Armory or Spinnaker in a Google Kubernetes Engine cluster using the Armory Operator.
---

This guide contains instructions for installing Armory on a Google Kubernetes Engine (GKE) cluster using the [Armory Operator]({{< ref "operator" >}}). Refer to the [Armory Operator Reference]({{< ref "operator-config" >}}) for manifest entry details.

>If you want to install Spinnaker<sup>TM</sup>, use the open source Operator, which you can download from its GitHub [repo](https://github.com/armory/spinnaker-operator).

## Prerequisites for installing Armory and the Armory Operator

* You have a machine configured to use the `gcloud` CLI tool and a recent
  version of the `kubectl` tool
* You have logged into the `gcloud` CLI and have permissions to create GKE
  clusters and a service account


## Armory installation summary

Installing Armory using the Armory Operator consists of the following steps:

* Create a cluster where Armory and the Armory Operator will reside
* Deploy Armory Operator pods to the cluster
* Create a GCS service account
* Create a Kubernetes service account
* Create a Google Cloud Storage (GCS) bucket
* Modify the Armory Operator kustomize files for your installation
* Deploy Armory using the Armory Operator

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

{{% include "armory-operator/installation.md" %}}

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

## Create Kubernetes service account

```bash
CONTEXT=$(kubectl config current-context)

# This service account uses the ClusterAdmin role -- this is not necessary,
# more restrictive roles can by applied.
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

Use the Cloud Console to create your bucket. If you're going to put secrets in the bucket, make sure to create a secrets directory in the bucket. Also, ensure the bucket is accessible from the service account you created.

{{% include "armory-operator/kustomize-patches.md" %}}

## Customize the Kustomize Files

**persistence/patch-gcs.yml**

- Set the persistent storage type, bucket, rootFolder, project, jsonPath (pick something unique)
- Add `gcs` to the config patch
- Add a file for `your-unique-gcs-account.json`. This will be the content from
the GCS service account you created above. The file is named `gcs-account.json`
in the following example:

```yaml
files:
  gcs-account.json: |
    {
      "type": "service_account",
      "project_id": "cloud-project",
      "private_key_id": "cf04d5d545bOTHERSTUFFHERE9f9d134f",
      "private_key": "-----BEGIN PRIVATE KEY-----\nSTUFF HERE\n-----END PRIVATE KEY-----\n",
      "client_email": <your-client-email>,
      "client_id": <your-client-id>,
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": <your-cert-url>
    }
```

## Install Kustomize (optional)

You can do a `kubectl -k` to deploy Kustomize templates, but what may be more
helpful is to install Kustomize standalone so that you can build Kustomize and
look at the YAML first.

```bash
curl -s "https://raw.githubusercontent.com/\
kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
sudo mv kustomize /usr/local/bin/
```

## Deploy Armory using Kustomize

```bash
kubectl create ns <spinnaker-namespace>
kustomize build | kubectl apply -f -
```

## Configure ingress

The `spinnaker-kustomize-patches` repository contains several examples for
exposing ingress to your cluster. Consult the examples in the `expose`
directory and choose the most appropriate example for your environment. Make
any modifications to the examples for your environment, then make sure the file
is listed in the `patchesStrategicMerge` section of your `kustomization.yml`
file.

See [spec.expose](/operator_reference/operator-config/#specexpose) for more
information.

## Configure authentication

The `spinnaker-kustomize-patches` repository contains several examples for
adding authentication to your cluster. Consult the examples in the `security`
directory and choose the most appropriate example for your environment. For
example, to enable basic auth, modify the `security/patch-basic-auth.yml` by
changing the username to one of your choosing. Then, add the file path to your
`kustomization.yml` file in the `patchesStrategicMerge` section. Finally,
modify the `secrets-example.env` file to choose a password unique to you, and
run the `./create-secrets.sh` script to create Kubernetes credentials in your
cluster.

>Make sure you enable the right Auth Scopes on the GKE node pools, or you may see authentication issues trying to write to Google Cloud Storage for logging.

## Configure Dinghy

The `spinnaker-kustomize-patches` repository contains a patch for enabling
Dinghy in your Armory cluster.  Be sure to modify the `armory/patch-dinghy.yml`
file with configuration specific to your environment, then make sure the file
is listed in the `patchesStrategicMerge` section of your `kustomization.yml`
file.

Now add an entry to the end of `kustomization.yml` to include
`patch-dinghy.yml`.

## Other patch files

The `spinnaker-kustomize-patches` repository contains many more example patches
to further customize your Armory cluster. Explore the
[repository](https://github.com/armory/spinnaker-kustomize-patches/tree/master)to
see if there are features you'd like to try out.

<!--
## Set Up TLS:
@TODO
-->
