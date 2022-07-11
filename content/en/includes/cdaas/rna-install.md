### Kubernetes permissions for the Remote Network Agent

By default, the RNA is installed with full access to the cluster. At a minimum, the RNA needs permissions to create, edit, and delete all `kind` objects that you plan to deploy with CD-as-a-Service, in all namespaces to which you plan to deploy. The RNA also requires network access to any monitoring solutions or webhook APIs that you plan to forward through it.

For advanced use cases such as restricting permissions, proxy configurations, custom annotations, labels, or environment variables, download and modify the [`values.yaml` for the RNA](https://github.com/armory-io/remote-network-agent-helm-chart/blob/main/values.yaml) or override existing values on the command line using `--set`. For information about using a `values file`, see the [Helm Values Files guide](https://helm.sh/docs/chart_template_guide/values_files/) and the [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) section of the _Using Helm_ guide.

### Installation

1. In your terminal, configure your `kubectl` [context](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-set-context-em-) to connect to the cluster where you want to deploy your app:

   ```bash
   kubectl config set-context <NAME>
   ```

1. Create the namespace for the RNA:

   ```bash
   kubectl create ns armory-rna
   ```

1. Create secrets from your Client ID and Client Secret:

   ```bash
   kubectl --namespace armory-rna create secret generic rna-client-credentials --type=string --from-literal=client-secret=<your-client-secret> --from-literal=client-id=<your-client-id>
   ```

   The examples use Kubernetes secrets to encrypt the value. You supply the encrypted values in the Helm command to install the RNA.

1. You can install the RNA with default permissions and values or you can customize using a `values.yaml` file.

   For most scenarios, you install one RNA per cluster. Use the `agentIdentifier` parameter to give each RNA a unique name. When you deploy your app, you specify which RNA to use, so Armory recommends creating a meaningful name that identifies the cluster.

   **Default values**

   The encrypted values for `clientId` and `clientSecret` reference the Kubernetes secrets you generated in an earlier step.

   ```bash
   helm upgrade --install armory-rna armory/remote-network-agent \
        --set agentIdentifier=<rna-name> \
        --set 'clientId=encrypted:k8s!n:rna-client-credentials!k:client-id' \
        --set 'clientSecret=encrypted:k8s!n:rna-client-credentials!k:client-secret' \
        --namespace armory-rna
   ```

   **Customized values**

   You can specify the path to your customized values file using `-f <your-path>values.yaml` or you can override values using the command line `--set <key:value>`. Refer to the [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing) section in the Helm docs.

1. You can go to the [Agents page](https://console.cloud.armory.io/configuration/agents) in the CD-as-a-Service Console to verify that your RNA has been installed and is communicating with CD-as-a-Service. If you do not see the RNA, check the cluster logs to see if the RNA is running.
