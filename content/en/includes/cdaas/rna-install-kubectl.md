You need [Client Credentials]{{< ref "cd-as-a-service/tasks/iam/client-creds" >}}) (**Client Secret** and **Client ID**) so your RNA can communicate with CD-as-a-Service.

1. Set your `kubectl` [context](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#-em-set-context-em-) to connect to the cluster where you want to deploy the RNA.

   ```bash
   kubectl config use-context <NAME>
   ```

1. Install the RNA.

   Replace `<client-secret>` and `<client-id>` with your Client Credentials.

   ```bash
   kubectl create ns armory-rna; 
   kubectl --namespace armory-rna create secret generic rna-client-credentials \
   --type=string \
   --from-literal=client-secret="<client-secret>" \
   --from-literal=client-id="<client-id>";
   kubectl apply -f "https://api.cloud.armory.io/kubernetes/agent/manifest?agentIdentifier=sample-cluster&namespace=armory-rna"
   ```
