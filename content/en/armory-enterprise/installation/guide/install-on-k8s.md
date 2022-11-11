---
title: Install Armory Enterprise for Spinnaker in Kubernetes
linkTitle: Install in Kubernetes
weight: 3
draft: true
aliases:
  - /spinnaker-install-admin-guides/install-on-k8s/
description: >
  Use the Armory Operator to deploy Armory Enterprise for Spinnaker in Kubernetes.
---

{{< include "armory-license.md" >}}

## Overview of installing Armory Enterprise in Kubernetes

This guide describes the initial installation of Armory Enterprise in Kubernetes. By the end of this guide, you have an instance of Armory Enterprise deployed on your Kubernetes cluster. This guide does not fully cover the following:

* TLS Encryption
* Authentication/Authorization
* Add K8s accounts to deploy to
* Add cloud accounts to deploy to

See [Next Steps](#next-steps) for information related to these topics.

## Choosing an installation method

{{< tabs name="install-methods" >}}
{{% tabbody name="Armory Operator" %}}

The _Armory Operator_ is the newest installation and configuration method for Armory Enterprise. Using the Operator, you can entirely manage Armory Enterprise using only Kubernetes manifest files. You treat Armory Enterprise like any other Kubernetes application, running standard tools like `kubectl`, `helm`, and `kustomize`. You can even use an Armory Enterprise pipeline to roll out configuration changes to itself. The Operator runs a few "hot" validations before accepting a manifest into the cluster, preventing some configuration problems from affecting a running Armory Enterprise installation.

*Prerequisites*

* Your Kubernetes API Server is running version `1.13` or later.
* You have admin rights to install the Custom Resource Definition (CRD) for Operator.
* You can assign a ClusterRole to Operator. This means that Operator has access to all namespaces in the cluster. Operator can still run in an isolated namespace in [Basic]({{< ref "armory-operator#installing-operator-in-basic-mode" >}}) mode (not covered in this installation guide), but it will not be able to run admission validations.

*General workflow*

* Install Armory Operator CRDs cluster wide.
* Create a Kubernetes namespace for the Operator.
* Install the Operator in that namespace, using a ServiceAccount with a ClusterRole to access other namespaces.
* Create an S3 bucket for Armory Enterprise to store persistent configuration.
* Create an IAM user that Armory Enterprise will use to access the S3 bucket (or alternately, granting access to the bucket via IAM roles).
* Create a Kubernetes namespace for Armory Enterprise.
* Install Armory Enterprise in that namespace.

{{% /tabbody %}}
{{< /tabs >}}

## Prerequisites for installing Armory Enterprise

* Your Kubernetes cluster is up and running with at least 4 CPUs and 12 GB of memory.  This is the bare minimum to install and run Armory Enterprise; depending on our Armory Enterprise workload, you may need more resources.
* You have `kubectl` installed and are able to access and create Kubernetes resources.
* You have access to an existing object storage bucket or the ability to create an object storage bucket (Amazon S3, Google GCS, Azure Storage, or Minio).  _For the initial version of this document, **only** Amazon S3 is used._
* You have access to an IAM role or user with access to the S3 bucket. If neither of these exists, you need to create an IAM role or user with access to the S3 bucket.
* Your cluster has either an existing Kubernetes Ingress controller or the permissions to install the NGINX Ingress Controller

These instructions set up the Armory Enterprise microservice called "Front50", which stores Armory Enterprise Application and Pipeline configuration to an object store, with the following permission:

* Front50 has full access to an S3 bucket through either an IAM user (with an AWS access key and secret access key) or an IAM role (attached to your Kubernetes cluster).

At the end of this guide, you have a Armory Enterprise deployment that is:

* Accessible from your browser
* Able to deploy other Kubernetes resources to the namespace where it runs, but not to any other namespace

## Configure application and pipeline configuration storage

The Armory Enterprise microservice Front50 requires a backing store to store Armory Enterprise Application and Pipeline definitions.  There are a number of options for this:

* Amazon S3 Bucket
* Google Cloud Storage (GCS) Bucket
* Azure Storage Bucket
* Minio
* MySQL

> You _must_ set up a backing store for Armory Enterprise to use for persistent application and pipeline configuration.

### Using S3 for Front50

Armory Enterprise (the `Front50` service, specifically) needs access to an S3 bucket. There are a number of ways to achieve this.

This section describes how to do the following:
* Create an S3 bucket
* Configure access to the bucket:
  * (Option 1) Add an IAM Policy to an IAM Role, granting access to the S3 bucket
  * (Option 2) Create an IAM User with access to the S3 bucket

<details><summary><b>Click to expand instructions</b></summary>

<details><summary>Creating an S3 bucket</summary>

<p>If you do not have an S3 bucket, create an S3 bucket.</p>

<p>By default, Armory Enterprise stores all Armory Enterprise information in a folder called <code>front50</code> in your bucket. Optionally, you can specify a different directory. You might want to do this if you're using an existing or shared S3 bucket..</p>

<p>Perform the following steps:</p>
<ol>
 <li>Log into the AWS Console (web UI).</li>
 <li>Navigate to the S3 Console. Click on <b>Services</b> > <b>Storage</b> > <b>S3</b>.</li>
 <li>Click on <b>Create Bucket</b>.</li>
 <li>Specify a globally unique name for this bucket in your AWS region of choice. If your organization has a standard naming convention, follow it. For its examples, this guide uses <code>spinnaker-abcxyz</code>.</li>
 <li>Click <b>Next</b>.</li>
 <li>Select the following two checkboxes:
    <ul>
      <li>Keep all versions of an object in the same bucket</li>
      <li>Automatically encrypt objects when they are stored in S3</li>
    </ul>
  </li>
 <li>Click <b>Next</b>.</li>
 <li>Do not add any additional permissions unless required by your organization. Click <b>Next</b>.</li>
 <li>Click <b>Create bucket</b>.</li>
</ol>

</details>

<details><summary>(Option 1) S3 using the IAM Policy/Role</summary>

<p>First, identify the role attached to your Kubernetes instance and attach an inline IAM policy to it. This grants access to your S3 bucket.</p>

<ol>
 <li>Log into the AWS Console (Web UI).</li>
 <li>Navigate to EC2. Click on <b>Services</b> > <b>Compute</b> > <b>EC2</b>.</li>
 <li>Click on one of your Kubernetes nodes.</li>
 <li>In the bottom section, look for <b>IAM role</b> and click on the role.</li>
 <li>Click on <b>Add inline policy</b>.</li>
 <li>On the <b>JSON</b> tab, add the following snippet:</li>

<pre class="highlight"><code>{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::spinnaker-abcxyz",
        "arn:aws:s3:::spinnaker-abcxyz/*"
      ]
    }
  ]
}
</code></pre>

 <li>Click on <b>Review Policy</b>.</li>
 <li>Give your inline policy a name, such as <code>s3-spinnaker-abcxyz</code>.</li>
 <li>Click <b>Create Policy</b></li>
</ol>
</details>

<details><summary>(Option 2) S3 using an IAM User</summary>

<p>First, create the IAM user and grant it permissions on your bucket:</p>

<ol>
  <li>Log into the AWS Console (Web UI).</li>
  <li>Navigate to the IAM Console. Click on <b>Services</b> > <b>Security, Identity, & Compliance</b> > <b>IAM</b>.</li>
  <li>Click on <b>Users</b> on the left.</li>
  <li>Click on <b>Add user</b>.</li>
  <li>Give your user a distinct name based on your organization's naming conventions. This guide uses <code>spinnaker-abcxyz</code>.</li>
  <li>Click on <b>Programmatic access</b>.</li>
  <li>For this guide, do not add a distinct policy to this user. Click on <b>Next: Tags</b>. <i>You may receive a warning about how there are no policies attached to this user. You can ignore this warning.</i></li>
  <li>Optionally, add tags, then click on <b>Next: Review</b>.</li>
  <li>Click <b>Create user</b>.</li>
  <li>Save the Access Key ID and Secret Access Key. You need this information later during Operator configuration.</li>
  <li>Click <b>Close</b>.</li>
</ol>

<p>Then, add an inline policy to your IAM user:</p>

<ol>
  <li>Click on our newly-created IAM user.</li>
  <li>Click on <b>Add inline policy</b> (on the right).</li>
  <li>On the <b>JSON</b> tab, add the following snippet:</li>

<pre class="highlight"><code>{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
        "arn:aws:s3:::spinnaker-abcxyz",
        "arn:aws:s3:::spinnaker-abcxyz/*"
      ]
    }
  ]
}
</code></pre>
<p>Replace <code>s3-spinnaker-abcxyz</code> with the name of your bucket.</p>
  <li>Click on <b>Review Policy</b></li>
  <li>Give your inline policy a name, for example <code>s3-spinnaker-abcxyz</code>.</li>
  <li>Click <b>Create Policy</b></li>
</ol>

</details>


</details>

## Connect to the Kubernetes cluster

You must be able to connect to the Kubernetes cluster with `kubectl`.  Depending on the type of your Kubernetes cluster, there are a number of ways of achieving this.

### Connecting to an AWS EKS cluster

If you use an AWS EKS cluster, you must be able to deploy resources to it. Before you start this section, make sure you have configured the `aws` CLI with credentials and a default region / availability zone. For more information, see the `aws` [installation directions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) and [configuration directions](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)).  Armory recommends using the V2 version of the AWS CLI.

If you have access to the role that created the EKS cluster, update your kubeconfig with access to the Kubernetes cluster using this command:

```bash
aws eks update-kubeconfig --name <EKS_CLUSTER_NAME>
```

From here, validate access to the cluster with this command:

```bash
kubectl get namespaces
```

The command returns the namespaces in the EKS cluster.

### Connecting to other Kubernetes clusters

If you created a Kubernetes on AWS with KOPS or another Kubernetes tool, ensure that you can communicate with the Kubernetes cluster with `kubectl`:

```bash
kubectl get namespaces
```

The command returns the namespaces in the EKS cluster.

## Install Armory Enterprise

{{< tabs name="install-steps" >}}
{{% tabbody name="Armory Operator" %}}

### Install Armory Operator

You need Kubernetes `ClusterRole` authority to install the Operator in `cluster` mode.

You can find the Operator's deployment configuration in `spinnaker-operator/deploy/operator/cluster` after you download and unpack the archive. You don't need to update any configuration values.

1. Get the latest Operator release:

   **Armory Operator** ![Proprietary](/images/proprietary.svg)

   ```bash
   mkdir -p spinnaker-operator && cd spinnaker-operator
   bash -c 'curl -L https://github.com/armory-io/spinnaker-operator/releases/latest/download/manifests.tgz | tar -xz'
   ```

1. Install or update CRDs across the cluster:

   ```bash
   kubectl apply -f deploy/crds/
   ```

1. Create the namespace for the Operator:

   In `cluster` mode, if you want to use a namespace other than `spinnaker-operator`, you need to edit the namespace in `deploy/operator/kustomize/role_binding.yaml`.

   ```bash
   kubectl create ns spinnaker-operator
   ```

1. Install the Operator:

   ```bash
   kubectl -n spinnaker-operator apply -f deploy/operator/kustomize
   ```

1. Verify that the Operator is running:

   ```bash
   kubectl -n spinnaker-operator get pods
   ```

   The command returns output similar to the following if the pod for the Operator is running:

   ```
   NAMESPACE                             READY         STATUS       RESTARTS      AGE
   spinnaker-operator-7cd659654b-4vktl   2/2           Running      0             6s
   ```

### Deploy Armory Enterprise

First, create the namespace where you want to deploy Armory Enterprise. In this guide you use `spinnaker`, but it can have any name:

```bash
kubectl create namespace spinnaker
```

You define and configure Armory Enterprise in a YAML file and use `kubectl` to create the service. Copy the contents below to a configuration file called `spinnakerservice.yml`. The code creates a Kubernetes `ServiceAccount` with permissions only to the namespace where Armory Enterprise is installed. Applying this file creates a base Armory Enterprise installation with one Kubernetes target account, which enables Armory Enterprise to deploy to the same namespace where it is installed.

Note the values that you need to modify:

- Armory Enterprise `version`: Use the version of Armory Enterprise that you want to deploy, which can be found [here]({{< ref "rn-armory-spinnaker#list-of-stable-armory-releases" >}}).
- S3 `bucket`: Use the name of the S3 bucket created above.
- S3 `region`: Region where the S3 bucket is located.
- S3 `accessKeyId`: Optional, set when using IAM user credentials to authenticate to the S3 bucket.
- S3 `secretAccessKey`: Optional, set when using IAM user credentials to authenticate to the S3 bucket.
- metadata `name`: Change if you're installing Armory Enterprise to a namespace other than `spinnaker`.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  creationTimestamp: null
  name: spin-role
rules:
- apiGroups:
  - ""
  resources:
  - pods
  - services
  - endpoints
  - persistentvolumeclaims
  - events
  - configmaps
  - secrets
  - namespaces
  verbs:
  - '*'
- apiGroups:
  - batch
  - extensions
  resources:
  - jobs
  verbs:
  - '*'
- apiGroups:
  - apps
  - extensions
  resources:
  - deployments
  - daemonsets
  - replicasets
  - statefulsets
  verbs:
  - '*'
- apiGroups:
  - monitoring.coreos.com
  resources:
  - servicemonitors
  verbs:
  - get
  - create
- apiGroups:
  - apps
  resourceNames:
  - spinnaker-operator
  resources:
  - deployments/finalizers
  verbs:
  - update
- apiGroups:
  - metrics.k8s.io
  resources:
  - pods
  verbs:
  - '*'
- apiGroups:
  - apps
  resourceNames:
  - spinnaker-operator
  resources:
  - deployments/finalizers
  verbs:
  - update
- apiGroups:
  - spinnaker.io
  resources:
  - '*'
  - spinnakeraccounts
  verbs:
  - '*'
- apiGroups:
  - spinnaker.armory.io
  resources:
  - '*'
  - spinnakerservices
  verbs:
  - '*'
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: spin-sa
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: spin-role-binding
subjects:
- kind: ServiceAccount
  name: spin-sa
roleRef:
  kind: Role
  name: spin-role
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      version: 2.17.1  # Replace with desired version of Armory Enterprise to deploy
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: spinnaker-abcxyz # Replace with the name of the S3 bucket created previously
          region: us-west-2        # Replace with correct bucket's region
          accessKeyId: XYZ         # (Optional, set only when using an IAM user to authenticate to the bucket instead of an IAM role)
          secretAccessKey: XYZ     # (Optional, set only when using an IAM user to authenticate to the bucket instead of an IAM role)
          rootFolder: front50
      features:
        artifacts: true
      providers:
        kubernetes:
          accounts:
          - name: spinnaker
            cacheThreads: 1
            cachingPolicies: []
            configureImagePullSecrets: true
            customResources: []
            dockerRegistries: []
            kinds: []
            namespaces:
            - spinnaker  # Name of the namespace where Armory Enterprise is installed
            oAuthScopes: []
            omitKinds: []
            omitNamespaces: []
            onlySpinnakerManaged: false
            permissions: {}
            providerVersion: V2
            requiredGroupMembership: []
            serviceAccount: true
          enabled: true
          primaryAccount: spinnaker
    service-settings:
      clouddriver:
        kubernetes:
          serviceAccountName: spin-sa
```

Deploy the manifest with the following command:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

{{% /tabbody %}}
{{< /tabs >}}

## Ingress

There several ways to expose Armory Enterprise, but there are a some basic requirements.

Given a domain name (or IP address) (such as spinnaker.domain.com or 55.55.55.55), you should be able to:

* Reach the `spin-deck` service at the root of the domain (`http://spinnaker.domain.com` or `http://55.55.55.55`)
* Reach the `spin-gate` service at the root of the domain (`http://spinnaker.domain.com/api/v1` or `http://55.55.55.55/api/v1`)

You  can use either http or https, as long as you use the same for both. Additionally, you have to configure Armory Enterprise to be aware of its endpoints.

The Install the NGINX ingress controller section details how to do that with the NGINX ingress controller.

### Install the NGINX ingress controller

In order to expose Armory Enterprise to end users, perform the following actions:

* Expose the spin-deck (UI) Kubernetes service on a URL endpoint
* Expose the spin-gate (API) Kubernetes service on a URL endpoint
* Update Armory Enterprise to be aware of the new endpoints

**If you already have an ingress controller, use that ingress controller instead.  You can check for the existence of the NGINX Ingress Controller by running `kubectl get ns` and looking for a namespace called `ingress-nginx`. If the namespace exists, you likely already have an NGINX Ingress Controller running in your cluster.**

The following instructions walk you through how to install the NGINX ingress controller on AWS. This uses the Layer 4 ELB, as indicated in the NGINX ingress controller [documentation](https://github.com/kubernetes/ingress-nginx/blob/master/docs/deploy/index.md#aws). You can use other NGINX ingress controller configurations, such as the Layer 7 load balancer, based on your organization's ingress policy.)

Both of these are configurable with Armory Enterprise, but the NGINX ingress controller is also generally much more configurable.

{{< include "install/nginx-common.md" >}}

Then, install the NGINX ingress controller AWS-specific service:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/aws/service-l4.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/nginx-0.30.0/deploy/static/provider/aws/patch-configmap-l4.yaml
```

### Set up an Ingress for `spin-deck` and `spin-gate`

Get the external IP for the NGINX ingress controller:

```bash
kubectl get svc -n ingress-nginx
```

The command returns a DNS name or IP address in the `EXTERNAL-IP` field.

If you stood up a new NGINX ingress controller, you can likely use this value (IP address or DNS name) for your ingress.

For example, if the command returns `abcd1234abcd1234abcd1234abcd1234-123456789.us-west-2.elb.amazonaws.com`, then you can use `abcd1234abcd1234abcd1234abcd1234-123456789.us-west-2.elb.amazonaws.com` for the `SPINNAKER_ENDPOINT` in the following steps. If the command returns `55.55.55.55`, then use `55.55.55.55` for the `SPINNAKER_ENDPOINT`.

If you use an existing NGINX ingress controller or other services are likely to be using the same NGINX ingress controller, create a DNS entry that points at the NGINX ingress controller endpoint you are using for Armory Enterprise. You can create either a `CNAME Record` that points at the DNS name or an `A Record` that points at the IP address.

For the example `abcd1234abcd1234abcd1234abcd1234-123456789.us-west-2.elb.amazonaws.com` DNS name, do the following:
* Create a CNAME pointing `spinnaker.domain.com` at `abcd1234abcd1234abcd1234abcd1234-123456789.us-west-2.elb.amazonaws.com`
* Put `spinnaker.domain.com` in the `host` field in the below manifest and uncomment it
* Use `spinnaker.domain.com` for the `SPINNAKER_ENDPOINT` in the below steps
* (Alternately, for testing, create an `/etc/hosts` entry pointing `spinnaker.domain.com` at the IP address that `abcd1234abcd1234abcd1234abcd1234-123456789.us-west-2.elb.amazonaws.com` resolves to)

For the `55.55.55.55` IP address example, do the following:
* Create an `A Record` pointing to `spinnaker.domain.com` at `55.55.55.55`
* Put `spinnaker.domain.com` in the `host` field in the below manifest and uncomment it
* Use `spinnaker.domain.com` for my SPINNAKER_ENDPOINT in the below steps
* (Alternately, for testing, create an `/etc/hosts` entry pointing `spinnaker.domain.com` at `55.55.55.55`)

Create a Kubernetes Ingress manifest to expose `spin-deck` and `spin-gate`.

Create a file called `spin-ingress.yml` with the following content.  If you are on Kubernetes 1.14 or above, you should replace `extensions/v1beta1` with `networking.k8s.io/v1`.

(Make sure the hosts and namespace match your actual host and namespace.)

```bash
---
apiVersion: extensions/v1beta1
# apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: spin-ingress
  labels:
    app: spin
    cluster: spin-ingress
  annotations:
    kubernetes.io/ingress.class: "nginx"
spec:
  rules:
  -
    # host: spinnaker.some-url.com
    # ^ If we have other things running in our cluster, we should uncomment this line and specify a valid DNS name
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

Apply the ingress file you just created:

```bash
kubectl -n spinnaker apply -f spin-ingress.yml
```

### Configure Armory Enterprise to be aware of its endpoints

Armory Enterprise must be aware of its endpoints to work properly.

**Operator**

Update `spinnakerservice.yml` adding the `security` section:

```yaml
spec:
  spinnakerConfig:
    config:
      security:
        apiSecurity:
          overrideBaseUrl: http://spinnaker.domain.com/api/v1  # Replace this with the IP address or DNS that points to our nginx ingress instance
        uiSecurity:
          overrideBaseUrl: http://spinnaker.domain.com         # Replace this with the IP address or DNS that points to our nginx ingress instance
```

Apply the changes:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

### Configuring TLS certificates

Configuring TLS certificates for ingresses is often very environment-specific. In general, you want to do the following:

* Add certificate(s) so that our ingress controller can use them
* Configure the ingress(es) so that NGINX (or the load balancer in front of NGINX, or your alternative ingress controller) terminates TLS using the certificate(s)
* Update Armory Enterprise to be aware of the new TLS endpoints, by replacing `http` by `https` to override the base URLs in the previous section.

## Next steps

Now that Armory Enterprise is running, here are potential next steps:

* Configuration of certificates to secure our cluster (see [this section](#configuring-tls-certificates) for notes on this)
* Configuration of Authentication/Authorization (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/security/))
* Add Kubernetes accounts to deploy applications to (see [Creating and Adding a Kubernetes Account to Armory Enterprise as a Deployment Target]({{< ref "kubernetes-account-add" >}}))
* Add GCP accounts to deploy applications to (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/install/providers/gce/))
* Add AWS accounts to deploy applications to (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/install/providers/aws/))
