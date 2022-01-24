---
title: Get Started with Project Borealis
linktitle: Get Started - Borealis
description: >
  To use Borealis, you must register for Armory's hosted cloud service and connect your deployment target to Armory cloud.
exclude_search: true
---

> If you installed an older version of the Remote Network Agent (RNA) using the Helm chart in `armory/aurora`, migrate to the new version by updating the Helm chart that is used. For more information, see [Migrate to the new RNA](#migrate-to-the-new-rna).

## {{% heading "prereq" %}}

Review the requirements for using Borealis on the [Requirements]({{< ref "borealis-requirements.md" >}}) page.

## Register for Armory Cloud services

{{< include "aurora-borealis/borealis-login-creds" >}}

Every user who wants to deploy to your clusters using Borealis must have an account. For information about inviting users, see [Invite users](#invite-users).

## Create client credentials

After you create an account, you can create machine-to-machine client credentials for the various service accounts that you will need. These credentials are machine credentials that are meant for authentication when using Borealis programmatically. The credentials consist of a client ID and a client secret. Make sure to keep the secret somewhere safe. You cannot retrieve secrets that you lose access to. You would need to create a new set of credentials and update any services that used the credentials that you are replacing.

> Armory recommends creating separate credentials for each cluster or service.

To get started, you need at least one service account to use for authentication between Borealis and your deployment target where a Remote Network Agent (RNA) is installed. For example, if you want to run the Borealis CLI in a Jenkins pipeline, create credentials for the deployment target and for the service account that you use with Jenkins.

To start, create the client credentials for the RNA on your deployment target:

{{< include "aurora-borealis/borealis-client-creds.md" >}}

## Prepare your deployment target

Borealis uses the RNA on your deployment target to communicate with Armory's hosted cloud services and to initiate the deployment. If your Kubernetes cluster is publicly accessible, 


{{< include "aurora-borealis/rna-install.md" >}}

## Next steps

Now that Borealis is configured for your deployment target, you can either try out deploying a sample app or invite more users.

### Deploy an app

Use the [Borealis Quickstart CLI Guide]({{< ref "borealis-cli-get-started.md" >}}) to learn how to manually deploy an app using the Borealis CLI.

### Invite users

For your users to get access to Borealis, you must invite them to your organization. This grants them access to the Cloud Console and the Status UI.

1. Navigate to the Cloud Console: https://console.cloud.armory.io.
2. In the left navigation, go to **Users** and select **Invite User**.
3. Provide the name and email address for the user you want to invite.
4. Send the inviation.

## Migrate to the new RNA

You do not need to do this if you are installing the RNA for the first time.


1. Navigate to the [Machine to Machine Client Credentials](https://console.cloud.armory.io/configuration/credentials) page in the Cloud Console.
2. Verify the permissions for the RNA you are using for your deployment targets. They must have the `connect:agentHub` scope. This permission is used to connect the RNA endpoint.
3. Verify that you are in the correct Kubernetes context. The context should be for the deployment target cluster.
4. Change the Helm chart that is being used.

   If you installed the RNA by providing your `clientID` and `clientSecret` in plain text, now is a good time to update those values to use a secret engine.

     * If you use a secret engine, pass the encrypted value for the parameter in the command, such as `'encrypted:k8s!n:rna-client-credentials!k:client-secret'`. Armory supports the following secret engines: Vault, Kubernetes secrets, encrypted GCS buckets, encrypted S3 buckets, and AWS Secrets Manager. See the documentation for your secrets engine for the format of the encrypted value.
     * The values for `clientId` and `clientSecret` can be passed as secrets by using environment variables. Instead of supplying the plaintext value, use an environment variable such as `${RNA_CLIENT_ID}` and `${RNA_CLIENT_SECRET}`. Then, attach environment variables with the same names to the pod. For more information, see the [Kubernetes documentation on using secrets as environment variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

   ```bash
   helm repo update
   helm upgrade armory-rna armory/remote-network-agent \
     --set agent-k8s.clientId='encrypted:k8s!n:rna-client-credentials!k:client-id' \
     --set agent-k8s.clientSecret='encrypted:k8s!n:rna-client-credentials!k:client-secret'
    ```

    Omit the two `set` options if you are already using a secret engine.