Each Kubernetes cluster that you install the RNA on should have a unique account name that you set using the `agent-k8s.accountName` parameter. This account name is used in the Status UI and in other places to identify the cluster.

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

4. Install the Helm chart. You can create the `armory-rna` namespace before running the `helm install` command or include the `--create-namespace` option. 
> The value for the `agent-k8s.account` option is the name that is used to refer to the deployment target cluster in the Status UI and other places, so use a descriptive name.

   The following example includes the `--create-namespace` option:


   ```bash
   helm install armory-rna armory/aurora \
       --set agent-k8s.account=<RNA-accountName> \
       --set agent-k8s.clientId=${CLIENT_ID_FOR_AGENT_FROM_ABOVE} \
       --set agent-k8s.clientSecret=${CLIENT_SECRET_FOR_AGENT_FROM_ABOVE} \
       --namespace armory-rna \
       --create-namespace
   ```

   If you already have Argo Rollouts configured in your environment you may disable
   that part of the Helm chart by setting the `enabled` key to false as in the following example:
   
   ```bash
   helm install aurora \
       # ... other config options
       --set argo-rollouts.enabled=false
       # ... other config options
   ```