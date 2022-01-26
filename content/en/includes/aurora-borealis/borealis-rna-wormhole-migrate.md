1. Navigate to the [Machine to Machine Client Credentials](https://console.cloud.armory.io/configuration/credentials) page in the Cloud Console.
2. Verify the permissions for the RNA you are using for your deployment targets. They must have the `connect:agentHub` scope. This permission is used to connect the RNA endpoint.
3. Verify that you are in the correct Kubernetes context. The context should be for the deployment target cluster.
4. Change the Helm chart that is being used.

   If you installed the RNA by providing your `clientID` and `clientSecret` in plaintext, now is a good time to update those values to use a secret engine.

     * If you use a secret engine, pass the encrypted value for the parameter in the command, such as `'encrypted:k8s!n:rna-client-credentials!k:client-secret'`. Armory supports the following secret engines: Vault, Kubernetes secrets, encrypted GCS buckets, encrypted S3 buckets, and AWS Secrets Manager. See the documentation for your secrets engine for the format of the encrypted value.
     * The values for `clientId` and `clientSecret` can be passed as secrets by using environment variables. Instead of supplying the plaintext value, use an environment variable such as `${RNA_CLIENT_ID}` and `${RNA_CLIENT_SECRET}`. Then, attach environment variables with the same names to the pod. For more information, see the [Kubernetes documentation on using secrets as environment variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

   ```bash
   helm repo update
   helm upgrade armory-rna armory/remote-network-agent \
     --set agent-k8s.clientId='encrypted:k8s!n:rna-client-credentials!k:client-id' \
     --set agent-k8s.clientSecret='encrypted:k8s!n:rna-client-credentials!k:client-secret' \
     --namespace armory-rna
    ```

    Omit the two `set` options if you are already using a secret engine.

    If you encounter the following error, make sure you specify the namespace in your Helm command: `Error: UPGRADE FAILED: "armory-rna" has no deployed releases.`