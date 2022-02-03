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

4. Create the namespace where the RNA gets installed:

   ```bash
   kubectl create ns armory-rna
   ```

5. Create secrets from your client ID and client secret:
   
   ```bash
   kubectl --namespace armory-rna create secret generic rna-client-credentials --type=string --from-literal=client-secret=<your-client-secret> --from-literal=client-id=<your-client-id>
   ```

   The examples use Kubernetes secrets to encrypt the value. You supply the encrypted values in the Helm command to install the RNA. 

6. Install the Helm chart. Keep the following in mind when you install the RNA:

   * The `agentIdentifier` option is the name that is used to refer to the deployment target cluster in the  UI, your deployment file, and other places, so use a descriptive name.

    ```bash
    helm upgrade --install armory-rna armory/remote-network-agent \
        --set agentIdentifier=<target-cluster-name> \
        --set clientId=encrypted:k8s!n:rna-client-credentials!k:client-id \
        --set clientSecret=encrypted:k8s!n:rna-client-credentials!k:client-secret \
        --namespace armory-rna 
    ```

    The encrypted values for `clientId` and `clientSecret` reference the Kubernetes secrets you generated in an earlier step.

   For advanced use cases such as proxy configurations, custom annotations, labels, or environment variables, see the [`values.yaml` for the RNA](https://github.com/armory-io/remote-network-agent-helm-chart/blob/master/values.yaml?rgh-link-date=2022-02-02T22%3A38%3A35Z). For information about using a `values file`, see the [Helm documentation](https://helm.sh/docs/chart_template_guide/values_files/).

7. Verify the RNA connection. Go to the [Agents page](https://console.cloud.armory.io/configuration/agents) in the Configuration UI UI, and look for the Agent identifier you assigned to your target deployment cluster. You should see it along with some basic information:

   > Note that you may see a "No Data message" when first loading the Agent page.

   {{< figure src="/images/borealis/borealis-ui-rna-status.jpg" alt="The Connected Remote Network Agents page shows connected agents and the following information: Agent Identifier, Agent Version, Connection Time when the connection was established, Last Heartbeat time, Client ID, and IP Address." >}}



   If you do not see the RNA for your target deployment cluster, verify that you are in the correct Armory cloud environment. Additionally, check the logs for the target deployment cluster to see if the RNA is up and running.


## Migrate to the new RNA

1. Check to see if you are running the old iteration of Agent. Run `helm list`. If the command returns `armory/aurora` for the Helm chart name, you need to update.
2. Navigate to the [Machine to Machine Client Credentials](https://console.cloud.armory.io/configuration/credentials) page in the Cloud Console.
3. Verify the permissions for the RNA you are using for your deployment targets. They must have the `connect:agentHub` scope. This permission is used to connect the RNA endpoint.
4. Verify that you are in the correct Kubernetes context. The context should be for the deployment target cluster.
    If you installed the RNA by providing your `clientID` and `clientSecret` in plaintext, now is a good time to update those values to use a secret engine.

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