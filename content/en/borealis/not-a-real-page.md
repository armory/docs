---
title: Fake page to watch changes
linkTitle: 
weight: 99999
summary: "This is not a real page. It's a draft file I use to update include files so that they render in builds dynamically."
draft: true
---

Each Kubernetes cluster that you install the RNA on should have a unique name that you set using the `agentIdentifier` parameter. This identifier is used in the Status UI and in other places to identify the cluster. Note that older versions of the RNA used the `agent-k8s.accountName` parameter for this.

1. Verify that you are in the correct Kubernetes context. The RNA is installed in the target deployment cluster.

2. Add the Armory Helm repo:

   ```bash
   helm repo add armory https://armory.jfrog.io/artifactory/charts
   ```

   You only need to do this once.

3. Refresh the repo cache:

   ```bash
   helm repo update
   ```

4. Install the Helm chart. Keep the following in mind when you install the RNA:

   * You can create the `armory-rna` namespace before running the `helm upgrade --install` command or include the `--create-namespace` option.

   * The `agentIdentifier` option is the name that is used to refer to the deployment target cluster in the Status UI, your deployment file, and other places, so use a descriptive name.

   * Armory recommends storing and using the values for`clientID` and `clientSecret` as secrets. You can use either a secret engine directly or environment variables to store and pass the encrypted values.

     * If you use a secret engine, pass the encrypted value for the parameter in the command, such as `'encrypted:k8s!n:rna-client-credentials!k:client-secret'`. Armory supports the following secret engines: Vault, Kubernetes secrets, encrypted GCS buckets, encrypted S3 buckets, and AWS Secrets Manager. See the documentation for your secrets engine for the format of the encrypted value.
     * The values for `clientId` and `clientSecret` can be passed as secrets by using environment variables. Instead of supplying the plaintext value, use an environment variable such as `${RNA_CLIENT_ID}` and `${RNA_CLIENT_SECRET}`. Then, attach environment variables with the same names to the pod. For more information, see the [Kubernetes documentation on using secrets as environment variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

   *  If you set `kubernetes.enableClusterAccountMode` to true, the RNA creates a service account, cluster role, and cluster role binding. These are applied to the RNA, and the RNA registers itself as a target deployment cluster for Project Borealis.


    The following example includes the `--create-namespace` option:

    ```bash
    helm upgrade --install armory-rna armory/remote-network-agent \
        --set agentIdentifier=<target-cluster-name> \
        --set clientId=<clientID-for-rna> \
        --set clientSecret=<clientSecret-for-rna> \
        --set kubernetes.enableClusterAccountMode=<false|true> \
        --namespace armory-rna \
        --create-namespace 
    ```

   Optionally, you can also add labels and annotations to the RNA install:

   ```bash
   --set podAnnotations.<annotationName>="<annotation>" \
   --set podLabels.<labelName>="<label>"
   ```

## Migrate to the new RNA

If you installed an older version of the RNA that used the Helm chart stored in `armory/aurora`, migrate to the new version by updating the Helm chart that is used. You do not need to do this if you are installing the RNA for the first time.


1. Navigate to the [Machine to Machine Client Credentials](https://console.cloud.armory.io/configuration/credentials) page in the Cloud Console.
2. Update the permissions for the RNA you are using for your deployment targets. They must have the `connect:agentHub` scope. This permission is used to connect the new RNA endpoint.
3. Verify that you are in the correct Kubernetes context. The context should be for the deployment target cluster.
4. Change the Helm chart that is being used.

   If you installed the RNA by providing your `clientID` and `clientSecret` in plaintext, now is a good time to update those values to use a secret engine.

     * If you use a secret engine, pass the encrypted value for the parameter in the command, such as `'encrypted:k8s!n:rna-client-credentials!k:client-secret'`. Armory supports the following secret engines: Vault, Kubernetes secrets, encrypted GCS buckets, encrypted S3 buckets, and AWS Secrets Manager. See the documentation for your secrets engine for the format of the encrypted value.
     * The values for `clientId` and `clientSecret` can be passed as secrets by using environment variables. Instead of supplying the plaintext value, use an environment variable such as `${RNA_CLIENT_ID}` and `${RNA_CLIENT_SECRET}`. Then, attach environment variables with the same names to the pod. For more information, see the [Kubernetes documentation on using secrets as environment variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

   ```bash
   helm repo update
   helm upgrade armory-rna armory/remote-network-agent \
     --set agent-k8s.clientId='encrypted:k8s!n:rna-client-credentials!k:client-id' \
     --set agent-k8s.clientSecret='encrypted:k8s!n:rna-client-credentials!k:client-secret'
    ```

    Omit the two `set` options if you are already using a secret engine.