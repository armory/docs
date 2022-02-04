1. Check to see if you are running the old iteration of Agent. Run `helm list`. If the command returns `armory/aurora` for the Helm chart name, you need to update.
2. Navigate to the [Machine to Machine Client Credentials](https://console.cloud.armory.io/configuration/credentials) page in the Cloud Console.
3. Verify the permissions for the client credentials you are using for your deployment targets. They must have the `connect:agentHub` scope. This permission is used to connect the RNA endpoint.
4. Verify that you are in the correct Kubernetes context. The context should be for the deployment target cluster.
5. If you installed the RNA by providing your `clientID` and `clientSecret` in plaintext, now is a good time to update those values to use a secret engine.

   Run the following command to encrypt your client ID and client secret using Kubernetes secrets:

   ```bash
   kubectl --namespace armory-rna create secret generic rna-client-credentials --type=string --from-literal=client-secret=<your-client-secret> --from-literal=client-id=<your-client-id>
   ```
6. Change the Helm chart that is being used:

   ```bash
   helm repo update
   helm upgrade armory-rna armory/remote-network-agent \
     --set agent-k8s.clientId='encrypted:k8s!n:rna-client-credentials!k:client-id' \
     --set agent-k8s.clientSecret='encrypted:k8s!n:rna-client-credentials!k:client-secret' \
     --namespace armory-rna
    ```

   The encrypted values for `clientId` and `clientSecret` reference the Kubernetes secrets you generated in an earlier step.

    If you encounter the following error, make sure you specify the namespace in your Helm command: `Error: UPGRADE FAILED: "armory-rna" has no deployed releases.`