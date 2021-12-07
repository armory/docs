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

4. Install the Helm chart. Keep the following in mind when you install the RNA:
   
   * You can create the `armory-rna` namespace before running the `helm install` command or include the `--create-namespace` option. 
   * The `agent-k8s.accountName` option is the name that is used to refer to the deployment target cluster in the Status UI, your deployment file, and other places, so use a descriptive name.
  
   The following example includes the `--create-namespace` option:

    ```bash
    helm install armory-rna armory/aurora \
        --set agent-k8s.accountName=<target-cluster-name> \
        --set agent-k8s.clientId=<clientID-for-rna> \
        --set agent-k8s.clientSecret=<clientSecret-for-rna> \
        --namespace armory-rna \
        --create-namespace 
    ```
    The values for `agent-k8s.clientId` and `agent-k8s.clientSecret` can be passed as secrets by using environment variables. Instead of supplying the plaintext value, use an environment variable such as `${RNA_CLIENT_ID}` and `${RNA_CLIENT_SECRET}`. Then, attach environment variables with the same names to the pod. For more information, see the [Kubernetes documentation on using secrets as environment variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/).

    Optionally, you can also add labels and annotations to the RNA install:

    ```bash
    --set agent-k8s.podAnnotations.<annotationName>="<annotation>" \
    --set agent-k8s.podLabels.<labelName>="<label>"
    ```
