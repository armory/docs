---
title: Install from Red Hat Marketplace
linkTitle: Install from Red Hat Marketplace
weight: 2
aliases: 
  - /spinnaker/openshift-container-platform/red-hat-marketplace
  - /spinnaker/openshift-container-platform/red-hat-marketplace
---

{{% alert title="Note" %}}This document is intended for users who have purchased the Armory Red Hat Marketplace offering. It will not work if you have not purchased the Armory Operator.

Please contact [Armory](mailto:hello@armory.io) if you're interested in a Red Hat Marketplace Private Offer.{{% /alert %}}

## Overview

The Armory Operator is a Kubernetes Operator for Spinnaker<sup>TM</sup> that makes it easier to install, deploy, and upgrade Spinnaker. 

## What is the Red Hat Marketplace?

The Red Hat Marketplace is available directly from your OpenShift web console and provides an open cloud catalog that makes it easier to discover and access certified software for container-based environments in public clouds. With automated deployment, software is immediately available to deploy on any Red Hat OpenShift cluster, providing a fast, integrated experience. Discover and buy certified software, and quickly deploy. Access open source and proprietary software, with responsive support, streamlined billing and contracting, simplified governance, and single-dashboard visibility across clouds. Built in partnership by Red Hat and IBM, this marketplace helps organizations deliver enterprise software and improve workload portability.

## Before you begin

{{% alert title="Note" %}}You must have the cluster administrator role to install the operators from the Red Hat Marketplace.{{% /alert %}}
 
1. These instructions assume you already have a Kubernetes cluster available in OpenShift Container Platform v4.4+
2. Browse to the [Red Hat Marketplace](https://marketplace.redhat.com/en-us?_ga=2.94000664.441560370.1604955054-123808014.1597373423) and log in or create a new account.
3. Follow the [instructions](https://marketplace.redhat.com/en-us/documentation/clusters?&_ga=2.94000664.441560370.1604955054-123808014.1597373423#register-openshift-cluster-with-red-hat-marketplace) to register your OpenShift cluster with the Red Hat Marketplace.
4. When prompted `Would you like to go back to the Red Hat Marketplace now? [Y/n]`, type `Y` and the Red Hat Marketplace page is opened in your browser.
5. Click <b>My software</b> >  <b>Visit the Marketplace.</b>
6. In the search bar, type <b>armory</b> to load the armory tile.
7. Click Purchase or Free trial to get started. From the Purchase complete page, click Install now. This installs the Armory operator into your cluster. Note that during the installation process you are required to select which OpenShift project to deploy the operator to from the Namespace scope drop-down list. After the operator is installed, your cluster connects back to Red Hat Marketplace and then becomes a target cluster for installing and managing the operator from Red Hat Marketplace.

## Installation

This document covers the following high-level steps:

1. Configuring application and pipeline storage 
2. Creating a SpinnakerService Custom Resource
3. Exposing your Armory instance

## Configure application and pipeline configuration storage

The Armory microservice Front50 requires a backing store to store Armory Application and Pipeline definitions.  There are a number of options for this:

* Amazon S3 Bucket
* Google Cloud Storage (GCS) Bucket
* Azure Storage Bucket
* Minio
* MySQL

**You _must_ set up a backing store for Armory to use for persistent application and pipeline configuration.**

### Using S3 for Front50

Armory (the `Front50` service, specifically) needs access to an S3 bucket. There are a number of ways to achieve this.

This section describes how to do the following:
* Create an S3 bucket
* Configure access to the bucket:
  * (Option 1) Add an IAM Policy to an IAM Role, granting access to the S3 bucket
  * (Option 2) Create an IAM User with access to the S3 bucket

<details><summary><b>Click to expand instructions</b></summary>

<details><summary>Creating an S3 bucket</summary>

<p>If you do not have an S3 bucket, create an S3 bucket.</p>

<p>By default, Armory stores all Armory information in a folder called <code>front50</code> in your bucket. Optionally, you can specify a different directory. You might want to do this if you're using an existing or shared S3 bucket..</p>

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
  <li>Save the Access Key ID and Secret Access Key. You need this information later during Halyard configuration.</li>
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

## Creating a SpinnakerService Custom Resource

You have deployed the Armory operator in your cluster. 
{{< figure src="/images/redhat/operator.png" >}}

Let's deploy an Armory instance.

First, click on <b>Armory Operator</b> in the Installed Operators page. There is one instances available listed under <b>"Provided APIs"</b>:
{{< figure src="/images/redhat/provided_apis.png" >}}

Click <b>Create Instance</b> on the <b>spinnakerservices.spinnaker.armory.io</b> tile.

{{% alert title="Important" %}}A page opens with a sample console specification of parameters that you need to customize. The spec is abbreviated to only the required parameters. A complete list of customizable options is provided in the following sample.{{% /alert %}}


```yaml
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  # spec.spinnakerConfig - This section is how to specify configuration spinnaker
  spinnakerConfig:
    # spec.spinnakerConfig.config - This section contains the contents of a deployment found in a halconfig .deploymentConfigurations[0]
    config:
      version: 2.21.4-ubi   # the version of Spinnaker to be deployed for Openshift
      persistentStorage:
        persistentStoreType: s3
        s3:
          bucket: my-s3-bucket
          rootFolder: front50 
```

Spacing is very important in YAML files. Make sure that the spacing is correct and there are no tabs instead of spaces. Incorrect spacing or tabs cause errors when you install Spinnaker.

<details><summary>Show  complete SpinnakerService.yml file</summary>
{{< gist armory-gists d3385d4dc964956435e16a090561b487 >}}
</details><br/>

When you are satisfied with your edits to the specification, click <b>Create</b>.

If everything is configured properly, the Armory Operator should see the SpinnakerService custom resource, and start creating Kubernetes Deployments, ServiceAccounts, and Secrets in `your-project` project.  You can monitor this on `spinnakerservices.spinnaker.armory.io` tab:

{{< figure src="/images/redhat/spinnakerservices.png" >}}

## Exposing your Armory instance

Once your Armory instance is running, you need to configure it so that it is accessible.  There are two main parts to this:

1. Expose the `spin-deck` and `spin-gate` services so that they can be reached by your end users (and client services)
1. Configure Armory so that it knows about the endpoints it is exposed on

Given a domain name (or IP address) (such as spinnaker.domain.com or 55.55.55.55), you should be able to:

* Reach the `spin-deck` service at the root of the domain (`http://spinnaker.domain.com` or `http://55.55.55.55`)
* Reach the `spin-gate` service at the root of the domain (`http://spinnaker.domain.com/api/v1` or `http://55.55.55.55/api/v1`)

You can use either `http` or `https`, as long as you use the same for both. Additionally, you have to configure Armory to be aware of its endpoints.  

### Set up a Route for `spin-deck` and `spin-gate`

First, determine a DNS name that you can use for Armory within your Openshift cluster. 

Then, create an Openshift Route to expose `spin-deck` and `spin-gate`.  

Paste the following content on Route wizard:

```yaml
kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: api-spinnaker
  namespace: your-project
spec:
  host: api-spinnaker.apps.my-cluster.company.io
  to:
    kind: Service
    name: spin-gate
    weight: 100
  port:
    targetPort: gate-tcp
  tls:
    termination: edge
    insecureEdgeTerminationPolicy: Allow
  wildcardPolicy: None 
```

```yaml
kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: ui-spinnaker
  namespace: your-project
spec:
  host: ui-spinnaker.apps.my-cluster.company.io
  to:
    kind: Service
    name: spin-deck
    weight: 100
  port:
    targetPort: deck-tcp
  tls:
    termination: edge
    insecureEdgeTerminationPolicy: Allow
  wildcardPolicy: None 
```

### Configure Armory to be aware of its endpoints

Update the spec.spinnakerConfig.config.security section of `SpinnakerService`:

```yaml
spec:
  spinnakerConfig:
    config:
      # ... more configuration
      security:
        uiSecurity:
          overrideBaseUrl: http://ui-spinnaker.apps.my-cluster.company.io        # Replace this with the IP address or DNS that points to our nginx ingress instance
        apiSecurity:
          overrideBaseUrl: http://api-spinnaker.apps.my-cluster.company.io  # Replace this with the IP address or DNS that points to our nginx ingress instance
      # ... more configuration
```

_**Make sure to specify `http` or `https` according to your environment**_

Apply the changes

## Next steps

Now that Armory is running, here are potential next steps:

* Configure certificates to secure our cluster (see [this section](#configuring-tls-certificates) for notes on this)
* Configure authentication/authorization (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/security/))
* Add external Kubernetes accounts to deploy applications to (see [Creating and Adding a Kubernetes Account to Spinnaker (Deployment Target)]({{< ref "kubernetes-account-add" >}}))
* Add AWS accounts to deploy applications to (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/install/providers/aws/))
