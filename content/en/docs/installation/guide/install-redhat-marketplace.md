---
title: Install Armory Enterprise for Spinnaker on OpenShift using the Armory Operator
linkTitle: Install on OpenShift
weight: 5
description: >
  Use the Armory Operator from the Red Hat Marketplace to deploy Armory Enterprise for Spinnaker in your OpenShift cluster.
---

> This document is intended for users who have purchased the Armory Red Hat Marketplace offering. It will not work if you have not purchased the Armory Operator. Please contact [Armory](mailto:hello@armory.io) if you're interested in a Red Hat Marketplace Private Offer.

## Overview of the Armory Operator Red Hat Marketplace offering

The {{< linkWithTitle "operator.md" >}} is a Kubernetes Operator that makes it easier to install, deploy, and upgrade Armory. You can get the Armory Operator from the [Red Hat Marketplace](https://marketplace.redhat.com/), which is available directly from your OpenShift web console. See the Red Hat Marketplace [docs](https://marketplace.redhat.com/en-us/documentation/) for how to use marketplace.

Installing Armory consists of the following:

1. [Install the Armory Operator](#install-the-armory-operator)
1. [Deploy Armory](#deploy-armory)
1. [Expose Armory](#expose-armory)

## Prerequisites for installing Armory

1. You have an active [Red Hat Marketplace account](https://marketplace.redhat.com/en-us/documentation/account-management).
1. You have a Red Hat Marketplace `Cluster Admin` [role](https://marketplace.redhat.com/en-us/documentation/user-roles), which enables you to install Operators from the Red Hat Marketplace.
1. You are familiar with [installing](https://marketplace.redhat.com/en-us/documentation/operators) OpenShift Operators.
1. You have [registered](https://marketplace.redhat.com/en-us/documentation/clusters#register-openshift-cluster-with-red-hat-marketplace) your OpenShift cluster with the Red Hat Marketplace.
1. You have a Kubernetes cluster available in OpenShift Container Platform v4.4+.
1. You have configured persistent storage for Armory's Front50 service.

   Front50 requires persistent storage for application and pipeline definitions.  There are a number of options for this:

      * [Amazon S3 Bucket](https://docs.aws.amazon.com/AmazonS3/latest/gsg/GetStartedWithS3.html)
      * [Google Cloud Storage (GCS) Bucket](https://cloud.google.com/storage)
      * [Azure Storage Bucket](https://azure.microsoft.com/en-us/services/storage/)

   Configure the persistent storage option that works best for your situation.


## Install the Armory Operator

You can install the Armory Operator from the [Red Hat Marketplace](https://marketplace.redhat.com/) or from the OpenShift web console's **OperatorHub**.

1. Search for `Armory Operator`.
1. Choose to start a free trial or to purchase the Armory Operator. After you have made your choice, follow the instructions from Red Hat to install the Armory Operator into your cluster.

## Deploy Armory

After you have deployed the Armory Operator in your cluster, it appears in the **Installed Operators** list in the **Operators** section of the OpenShift web console.

{{< figure src="/images/installation/guide/redhat/operator.png" >}}

Click on **Armory Operator** to load details about the Operator. There is one available instance listed under **Provided APIs**.

{{< figure src="/images/installation/guide/redhat/provided_apis.png" >}}

Click **Create Instance** on the **spinnakerservices.spinnaker.armory.io** tile.

A page opens with a basic console specification of parameters that you need to customize.

{{< figure src="/images/installation/guide/redhat/create-spin-svc.png" width="85%" height="85%" >}}

Select **YAML View** to open the YAML editor. The specification you see is abbreviated to only the required parameters:

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

Add your configuration using the example `SpinnakerService.yml` file below as a guide. Consult the {{< linkWithTitle "op-config-manifest.md" >}} page for detailed explanations of each config section. Be sure to configure the `spec.spinnakerConfig.config.persistentStorage` section based on the persistent storage option you created for your Armory instance. See the {{< linkWithTitle "persistent-storage.md" >}} page for details.

<details><summary>Show  complete SpinnakerService.yml file</summary>
{{< gist armory-gists d3385d4dc964956435e16a090561b487 >}}
</details><br/>

>Spacing is very important in YAML files. Make sure that the spacing is correct, and that here are no tabs instead of spaces. Incorrect spacing or tabs cause errors when you install Armory.

Click **Create** after you are satisfied with your edits to the specification.

If everything is configured properly, the Armory Operator sees the `SpinnakerService` custom resource and starts creating Kubernetes Deployments, ServiceAccounts, and Secrets.  You can monitor this on the `spinnakerservices.spinnaker.armory.io` tab:

{{< figure src="/images/installation/guide/redhat/spinnaker-services.png" >}}

## Expose Armory

Once your Armory instance is running, you need to configure it to be accessible.  There are two main parts to this:

1. Expose the `spin-deck` and `spin-gate` services so that they can be reached by your end users and client services.
1. Configure Armory to know about its exposed endpoints.

Given a domain name or IP address such as `spinnaker.domain.com` or `55.55.55.55`, you should be able to:

* Reach the `spin-deck` service at the root of the domain (`http://spinnaker.domain.com` or `http://55.55.55.55`)
* Reach the `spin-gate` service at the root of the domain (`http://spinnaker.domain.com/api/v1` or `http://55.55.55.55/api/v1`)

You can use either `http` or `https`, as long as you use the same for both.  

### Create a Route for `spin-deck` and `spin-gate`

Determine a DNS name that you can use for Armory within your OpenShift cluster.

Then, create an Openshift Route (**Networking** -> **Routes**) to expose `spin-deck` and  another to expose `spin-gate`.  

For `spin-deck`, use the following content to create your route, replacing `metadata.namespace` and `spec.host` with your values:

```yaml
kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: ui-spinnaker
  namespace: <your-project-name>
spec:
  host: <ui-spinnaker.apps.my-cluster.company.io>
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

For `spin-gate`, use the following content to create your route, replacing `metadata.namespace` and `spec.host` with your values:

```yaml
kind: Route
apiVersion: route.openshift.io/v1
metadata:
  name: api-spinnaker
  namespace: <your-project-name>
spec:
  host: <api-spinnaker.apps.my-cluster.company.io>
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

### Configure Armory to be aware of its endpoints

Go to the **Installed Operators** page and select `spinnakerservices.spinnaker.armory.io` to access the details of your deployed Armory instance.

{{< figure src="/images/installation/guide/redhat/select-provided-api.png" width="85%" height="85%" >}}

Select the `spinnaker` instance you created earlier.

{{< figure src="/images/installation/guide/redhat/select-spin-svc.png" width="85%" height="85%" >}}

This opens the page with details of your installation. Select **Edit SpinnakerService** from the **Actions** drop-down menu.

{{< figure src="/images/installation/guide/redhat/edit-spin-svc.png" width="85%" height="85%" >}}

Add or update the `spec.spinnakerConfig.config.security` section, replacing `security.uiSecurity.overrideBaseUrl` and `security.apiSecurity.overrideBaseUrl` with your endpoints. _**Make sure to specify `http` or `https` according to your environment**_

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

**Save** to apply the changes.

## Access your Armory instance

The Armory URL is the `spec.host` value you configured in your `spin-deck` route. You can find the URL on the details page for your installation.

{{< figure src="/images/installation/guide/redhat/armory-url.png" width="85%" height="85%" >}}

## Next steps

Now that Armory is running, here are potential next steps:

* Configure certificates to secure your cluster (see [this section](#configuring-tls-certificates) for notes on this)
* Configure authentication/authorization (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/security/))
* Add external Kubernetes accounts to deploy applications to (see [Creating and Adding a Kubernetes Account to Spinnaker (Deployment Target)]({{< ref "kubernetes-account-add" >}}))
* Add AWS accounts to deploy applications to (see the [Open Source Spinnaker documentation](https://www.spinnaker.io/setup/install/providers/aws/))
