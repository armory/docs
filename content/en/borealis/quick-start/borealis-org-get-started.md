---
title: Get Started with Project Borealis
linktitle: Get Started - Borealis
description: >
  To use Borealis, you must register for Armory's hosted cloud service and connect your deployment target to Armory cloud.

---

> If you installed an older version of the Remote Network Agent (RNA) using the Helm chart in `armory/aurora`, migrate to the new version by updating the Helm chart that is used. For more information, see [Migrate to the new RNA](#migrate-to-the-new-rna).

## {{% heading "prereq" %}}

Review the requirements for using Borealis on the [Requirements]({{< ref "borealis-requirements.md" >}}) page.

## Register for Armory Cloud services

{{< include "aurora-borealis/borealis-login-creds" >}}

Every user who wants to deploy to your clusters using Borealis must have an account. For information about inviting users, see [Invite users]({{< ref "borealis-configuration-ui#invite-users" >}}).

## Prepare your deployment target

<!--There are two ways to add a deployment target to Borealis. If your deployment target is accessible through the public internet, you can use the **Configuration UI** to [add the target to Borealis](#add-the-cluster-to-borealis) If the cluster is not accessible, -->

You need to manually install the Remote Network Agent (RNA) to the target deployment cluster. Borealis uses the RNA on your deployment target to communicate with Armory's hosted cloud services and to initiate the deployment. 

### Create client credentials

<!--Skip this section if your Kubernetes cluster is accessible through the public internet. Go to [Add the cluster to Borealis](#add-the-cluster-to-borealis).-->

Create machine-to-machine client credentials for the various service accounts that you will need. These credentials are machine credentials that are meant for authentication when using Borealis programmatically. The credentials consist of a client ID and a client secret. Make sure to keep the secret somewhere safe. You cannot retrieve secrets that you lose access to. You would need to create a new set of credentials and update any services that used the credentials that you are replacing.

> Armory recommends creating separate credentials for each cluster or service.

To get started, you need at least one service account to use for authentication between Borealis and your deployment target where a Remote Network Agent (RNA) is installed.

Create the client credentials for the RNA on your deployment target:

{{< include "aurora-borealis/borealis-client-creds.md" >}}

</details>

### Install the RNA

<!--Skip this section if your Kubernetes cluster is accessible through the public internet. Go to [Add the cluster to Borealis](#add-the-cluster-to-borealis).

<details><summary>Show me how to install the RNA</summary> -->

{{< include "aurora-borealis/rna-install.md" >}}


<!--### Add the cluster to Borealis

If your cluster is accessible through the public internet, start here. If your cluster is not accessible through the public internet, make sure that you have [created the client credentials](#create-client-credentials) and [installed the Remote Network Agent (RNA)](#install-the-rna) on your deployment target.

1. Navigate to the [**Deployment Targets > Kubernetes**](https://console.cloud.armory.io/configuration/accounts/kubernetes) page in the **Configuration UI**.
2. Add a new Kubernetes account and supply the following information:

   - **Account Name**: (Required) This is how the account is labeled in the **Configuration** and **Armory Deployments Status UI**. Use a descriptive name. It is the equivalent of the `agentIdentifier`, so use the same value for clusters that are connected manually by installing an RNA. 
   - **Kubeconfig**: (Optional) The kubeconfig used to access the cluster. Provide this if you did not install the RNA manually and want Borealis to use the kubeconfig to access the cluster.
   - **Context**: (Optional) The context used to access the cluster. When no context is configured for an account the current-context in your kubeconfig is assumed. For more information, see [Configure Access to Multiple Clusters](https://kubernetes.io/docs/tasks/access-cluster-api/configure-access-multiple-clusters/).
   - **Remote Network Agent**: (Optional) The RNA that is installed on the cluster. This is required if the cluster is not accessible through the public internet.
3. Save your changes.

-->

## Next steps

Now that Borealis is configured for your deployment target, you can either try out deploying a sample app or invite more users.

### Deploy an app

Use the [Borealis Quickstart CLI Guide]({{< ref "borealis-cli-get-started.md" >}}) to learn how to manually deploy an app using the Borealis CLI.

## Migrate to the new RNA

You do not need to do this migration if you are installing the RNA for the first time.

{{< include "aurora-borealis/borealis-rna-wormhole-migrate.md" >}}