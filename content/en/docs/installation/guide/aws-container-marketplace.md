---
title: Install Armory Enterprise from the AWS Container Marketplace
linkTitle: Install from AWS Marketplace
weight: 2
draft: false
aliases:
  - /spinnaker/aws_container_marketplace/
  - /spinnaker/aws-container-marketplace/
description: >
  Use the Armory Operator from the AWS Container Marketplace to deploy Armory Enterprise for Spinnaker in your Amazon Kubernetes (EKS) cluster.
categories: ["install"]
tags: ["AWS Marketplace", "Operator"]
---

{{% alert title="Note" %}}This document is intended for users who have purchased Armory's AWS Container Marketplace offering. It will not work if you have not subscribed to the Armory Container Marketplace offering.

Please contact [Armory](mailto:hello@armory.io) if you're interested in an AWS Marketplace Private Offer.{{% /alert %}}

## Overview of the Armory Operator

The Armory Operator is a Kubernetes Operator for Spinnaker<sup>TM</sup> that makes it easier to install, deploy, and upgrade Spinnaker or Armory. The AWS Container Marketplace offering for Armory installs a version of the Armory Operator in an EKS cluster. After that, Armory can be installed in any namespace in your EKS cluster; this document assumes that Armory will be installed in the `spinnaker` namespace.

## AWS Resources

Before you install Armory on AWS, it is essential that you familiarize yourself with [relevant AWS services]({{< ref "resources-aws" >}}).

## Prerequisites for using the Armory Operator

To use the Marketplace's Armory offering, make sure you meet the following requirements:

* You have reviewed and met the Armory Enterprise [system requirements]({{< ref "system-requirements.md" >}}).
* You have access to an EKS cluster configured with [IAM roles for service accounts](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).
* You have an ingress controller for your EKS cluster. This document assumes the EKS cluster is using the NGINX Ingress Controller.
* You have `cluster-admin` access on the EKS cluster.
* You have An AWS S3 bucket to store Armory application and pipeline configuration.

## Installation summary

This document covers the following high-level steps:

1. Creating and configuring the necessary AWS IAM roles for your Kubernetes cluster
2. Installing the Armory Operator Custom Resource Definitions (CRDs) for Armory into your Kubernetes cluster
3. Installing the Armory Operator
4. Creating a SpinnakerService Custom Resource
5. Exposing your Armory instance

## Create an AWS bucket

If you do not already have an AWS S3 bucket, create one with these settings:

* Versioning turned on ("Keep all versions of an object in the same bucket")
* Default encryption turned on
* All public access blocked

## Create and configure the AWS IAM roles for your Kubernetes cluster

AWS IAM permissions are granted to Armory through the use of AWS's IAM roles for Kubernetes Service Accounts. This feature must be enabled at a cluster level.  You need to create three IAM roles:

* An IAM role for the Armory Operator (`spinnaker-operator` ServiceAccount in `spinnaker-operator` namespace) that has these permissions:
    * `aws-marketplace:RegisterUsage`
    * `s3:*` on your AWS Bucket
* An IAM role for the Front50 service (`front50` ServiceAccount in the `spinnaker` namespace), that has these permissions:
    * `s3:*` on your AWS Bucket
* An IAM role for the Clouddriver service (`clouddriver` ServiceAccount in the  `spinnaker` namespace).  This IAM role does not require any explicit permissions. If you want Armory to deploy AWS resources (AWS EC2, AWS ECS, AWS Lambda, or other AWS EKS clusters), you can add these permissions later.
    * _AWS permissions are **not** needed to deploy to the EKS cluster where Spinnaker is installed._

Upon completion of this section, you should have these three IAM roles:
* `arn:aws:iam::AWS_ACCOUNT_ID:role/eks-spinnaker-operator` granted to the Kubernetes Service Account `system:serviceaccount:spinnaker-operator:spinnaker-operator`
* `arn:aws:iam::AWS_ACCOUNT_ID:role/eks-spinnaker-front50` granted to the Kubernetes Service Account `system:serviceaccount:spinnaker:front50`
* `arn:aws:iam::AWS_ACCOUNT_ID:role/eks-spinnaker-clouddriver` granted to the Kubernetes Service Account `system:serviceaccount:spinnaker:clouddriver`


### IAM role for Armory Operator Pod

Create an IAM role for the Armory Operator pod (call it `eks-spinnaker-operator`) and configure it for use by EC2. You will replace the trust relationship later.

Grant the role the AWS managed policy `AWSMarketplaceMeteringRegisterUsage`.

Grant the role an inline policy granting permissions on your S3 bucket (replace `BUCKET_NAME` with the name of your bucket):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Effect": "Allow",
    "Action": "s3:*",
    "Resource": [
      "arn:aws:s3:::BUCKET_NAME",
      "arn:aws:s3:::BUCKET_NAME/*"
    ]
    }
  ]
}
```

For example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Effect": "Allow",
    "Action": "s3:*",
    "Resource": [
      "arn:aws:s3:::my-spinnaker-bucket",
      "arn:aws:s3:::my-spinnaker-bucket/*"
    ]
    }
  ]
}
```

Create this trust relationship on the IAM role, with these fields replaced:

* replace `AWS_ACCOUNT_ID` with your AWS account ID
* replace `OIDC_PROVIDER` with the "OpenID Connect provider URL" for your Kubernetes cluster (_with the `https://` removed_)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::AWS_ACCOUNT_ID:oidc-provider/OIDC_PROVIDER"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "OIDC_PROVIDER:sub": "system:serviceaccount:spinnaker-operator:spinnaker-operator"
        }
      }
    }
  ]
}
```

For example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::111222333444:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/AAAABBBBCCCCDDDDEEEEFFFF00001111"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/AAAABBBBCCCCDDDDEEEEFFFF00001111:sub": "system:serviceaccount:spinnaker-operator:spinnaker-operator"
        }
      }
    }
  ]
}
```

### IAM role for Front50 Pod

Create an IAM role for the Armory Operator pod (call it `eks-spinnaker-front50`)  and configure it for use by EC2. You will replace the trust relationship later.

Grant the role an inline policy granting permissions on your S3 bucket (replace `BUCKET_NAME` with the name of your bucket):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Effect": "Allow",
    "Action": "s3:*",
    "Resource": [
      "arn:aws:s3:::BUCKET_NAME",
      "arn:aws:s3:::BUCKET_NAME/*"
    ]
    }
  ]
}
```

For example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
    "Effect": "Allow",
    "Action": "s3:*",
    "Resource": [
      "arn:aws:s3:::my-spinnaker-bucket",
      "arn:aws:s3:::my-spinnaker-bucket/*"
    ]
    }
  ]
}
```

Create this trust relationship on the IAM role, with these fields replaced:

* Replace `AWS_ACCOUNT_ID` with your AWS account ID
* Replace `OIDC_PROVIDER` with the "OpenID Connect provider URL" for your Kubernetes cluster (_with the `https://` removed_)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::AWS_ACCOUNT_ID:oidc-provider/OIDC_PROVIDER"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "OIDC_PROVIDER:sub": "system:serviceaccount:spinnaker:front50"
        }
      }
    }
  ]
}
```

For example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::111222333444:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/AAAABBBBCCCCDDDDEEEEFFFF00001111"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/AAAABBBBCCCCDDDDEEEEFFFF00001111:sub": "system:serviceaccount:spinnaker:front50"
        }
      }
    }
  ]
}
```



### IAM role for Clouddriver pod

Create an IAM role for the Armory Operator pod (call it `eks-spinnaker-clouddriver`) and configure it for use by EC2. You will replace the trust relationship later. It does not need explicit AWS permissions.

Create this trust relationship on the IAM role, with these fields replaced:

* Replace `AWS_ACCOUNT_ID` with your AWS account ID
* Replace `OIDC_PROVIDER` with the "OpenID Connect provider URL" for your Kubernetes cluster (_with the `https://` removed_)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::AWS_ACCOUNT_ID:oidc-provider/OIDC_PROVIDER"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "OIDC_PROVIDER:sub": "system:serviceaccount:spinnaker:clouddriver"
        }
      }
    }
  ]
}
```

For example:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::111222333444:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/AAAABBBBCCCCDDDDEEEEFFFF00001111"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "oidc.eks.us-east-1.amazonaws.com/id/AAAABBBBCCCCDDDDEEEEFFFF00001111:sub": "system:serviceaccount:spinnaker:clouddriver"
        }
      }
    }
  ]
}
```

## Install the Armory Operator Custom Resource Definitions (CRDs)

Download the Kubernetes manifest for Armory Operator and install it into your Kubernetes cluster:

```bash
mkdir -p spinnaker-operator && cd spinnaker-operator
bash -c 'curl -L https://github.com/armory/marketplace/releases/latest/download/marketplace.tgz | tar -xz'

# Install or update CRDs cluster wide
kubectl apply -f manifests/crds/
```

## Install the Armory Operator

Update the manifest for the Armory Operator with your AWS Account ID:

* You must update `AWS_ACCOUNT_ID` (in the ServiceAccount annotation) with your account ID, so the ServiceAccount can access your AWS IAM roles.

```bash
export AWS_ACCOUNT_ID=111122223333

sed -i.bak "s|AWS_ACCOUNT_ID|${AWS_ACCOUNT_ID}|g" manifests/operator/ServiceAccount.yaml
rm manifests/operator/ServiceAccount.yaml.bak

# Install the armory operator
kubectl apply -f manifests/operator
```

Deploying the Armory Operator may take a little bit of time.  You can monitor its status by running this command:

```bash
kubectl -n spinnaker-operator get pod -owide
```

You're looking for the deployment to be completely up (READY of `2/2` and STATUS of `Running`).

### Creating a SpinnakerService Custom Resource

Update the manifest for the SpinnakerService object with these:

* `AWS_ACCOUNT_ID` (in both ServiceAccount annotations) - your account ID, so the ServiceAccount can access your AWS IAM roles
* `BUCKET_NAME` (in the SpinnakerService) - the name of your AWS S3 Bucket

```bash
export AWS_ACCOUNT_ID=111122223333
export BUCKET_NAME=my-spinnaker-bucket

sed -i.bak "s|AWS_ACCOUNT_ID|${AWS_ACCOUNT_ID}|g" manifests/spinnaker/ServiceAccount-clouddriver.yaml
sed -i.bak "s|AWS_ACCOUNT_ID|${AWS_ACCOUNT_ID}|g" manifests/spinnaker/ServiceAccount-front50.yaml
rm manifests/spinnaker/ServiceAccount-clouddriver.yaml.bak
rm manifests/spinnaker/ServiceAccount-front50.yaml.bak

sed -i.bak "s|BUCKET_NAME|${BUCKET_NAME}|g" manifests/spinnaker/SpinnakerService.yaml
rm manifests/spinnaker/SpinnakerService.yaml.bak

# Install the operator
kubectl apply -f manifests/spinnaker
```

If everything is configured properly, the Armory Operator should see the SpinnakerService custom resource, and start creating Kubernetes Deployments, ServiceAccounts, and Secrets in the `spinnaker` Namespace.  You can monitor this with the following:

```bash
kubectl -n spinnaker get all -owide
```

## Exposing your Armory instance

Once your Armory instance is running, you need to configure it so that it is accessible.  There are two main parts to this:

1. Expose the `spin-deck` and `spin-gate` services so that they can be reached by your end users (and client services)
1. Configure Armory so that it knows about the endpoints it is exposed on

Given a domain name (or IP address) (such as spinnaker.domain.com or 55.55.55.55), you should be able to:

* Reach the `spin-deck` service at the root of the domain (`http://spinnaker.domain.com` or `http://55.55.55.55`)
* Reach the `spin-gate` service at the root of the domain (`http://spinnaker.domain.com/api/v1` or `http://55.55.55.55/api/v1`)

You can use either `http` or `https`, as long as you use the same for both. Additionally, you have to configure Armory to be aware of its endpoints.  

This section assumes the following:

* You have installed the [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/#aws) in the EKS cluster
* You can set up a DNS CNAME Record pointing at the AWS Load Balancer in front of your NGINX Ingress Controller

## Set up an Ingress for `spin-deck` and `spin-gate`

First, determine a DNS name that you can use for Armory, and set up a CNAME pointing that DNS name at your AWS Load Balancer.  For example:

* NGINX Ingress Controller has created an NLB at `abcd1234abcd1234abcd1234abcd1234-1234567812345678.elb.us-east-1.amazonaws.com`
* Desired domain name for Armory is `spinnaker.domain.com`
* Create a CNAME DNS Record pointing `spinnaker.domain.com` at `abcd1234abcd1234abcd1234abcd1234-1234567812345678.elb.us-east-1.amazonaws.com` (you may also use an ALIAS Record in Route 53)

Then, create a Kubernetes Ingress to expose `spin-deck` and `spin-gate`.  Create a file called `spin-ingress.yml` with the following content:

```yaml
---
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: spin-ingress
  namespace: spinnaker
  labels:
    app: spin
    cluster: spin-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  -
    host: spinnaker.domain.com # Make sure to update this field
    http:
      paths:
      - backend:
          serviceName: spin-deck
          servicePort: 9000
        path: /
      - backend:
          serviceName: spin-gate
          servicePort: 8084
        path: /api/v1
```

_**Make sure the host field is updated with the correct DNS record.**_

Apply the ingress file you just created:

```bash
kubectl -n spinnaker apply -f spin-ingress.yml
```

## Configure Armory to be aware of its endpoints

Update the spec.spinnakerConfig.config.security section of `manifests/spinnaker/SpinnakerService.yaml`:

```yaml
spec:
  spinnakerConfig:
    config:
      # ... more configuration
      security:
        uiSecurity:
          overrideBaseUrl: http://spinnaker.domain.com         # Replace this with the IP address or DNS that points to our nginx ingress instance
        apiSecurity:
          overrideBaseUrl: http://spinnaker.domain.com/api/v1  # Replace this with the IP address or DNS that points to our nginx ingress instance
      # ... more configuration
```

_**Make sure to specify `http` or `https` according to your environment**_

Apply the changes:

```bash
kubectl apply -f manifests/spinnaker/SpinnakerService.yaml
```

If you encounter an error, delete and recreate the SpinnakerService.

## Configure TLS certificates

Configuring TLS certificates for ingresses is environment-specific. In general, you want to do the following:

* Add certificate(s) so that our ingress controller can use them
* Configure the ingress(es) so that NGINX (or the load balancer in front of NGINX, or your alternative ingress controller) terminates TLS using the certificate(s)
* Update Spinnaker to be aware of the new TLS endpoints, by replacing `http` by `https` to override the base URLs in the previous section.

## Next steps

Now that Armory is running, here are potential next steps:

* Configure certificates to secure our cluster (see [this section](#configuring-tls-certificates) for notes on this)
* Configure authentication/authorization (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/security/))
* Add external Kubernetes accounts to deploy applications to (see [Creating and Adding a Kubernetes Account to Spinnaker (Deployment Target)]({{< ref "kubernetes-account-add" >}}))
* Add AWS accounts to deploy applications to (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/install/providers/aws/))
