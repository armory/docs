> Note: You can use encrypted secrets instead of providing plaintext values. For more information, see the [Secrets Guide]({{< ref "secrets" >}}).

Each Kubernetes cluster that you install the RNA on should have a unique account name that you set using the `agent-k8s.accountName` parameter. You select the deployment target by specifying the account name you gave it.

```bash
# Add the Armory helm repo. This only needs to be done once.
helm repo add armory https://armory.jfrog.io/artifactory/charts

# Refresh your repo cache.
helm repo update

# The `accountName` opt is what this cluster will render as in the
# Spinnaker Stage and Armory Cloud APIs.
helm install aurora \
    --set agent-k8s.accountName=my-k8s-cluster \
    --set agent-k8s.clientId=${CLIENT_ID_FOR_AGENT_FROM_ABOVE} \
    --set agent-k8s.clientSecret=${CLIENT_SECRET_FOR_AGENT_FROM_ABOVE} \
    --namespace armory \
    # Omit --create-namespace if installing into existing namespace.
    --create-namespace \
    armory/aurora
```

If you already have Argo Rollouts configured in your environment you may disable
that part of the Helm chart by setting the `enabled` key to false as in the following example:

```shell
helm install aurora \
    # ... other config options
    --set argo-rollouts.enabled=false
    # ... other config options
```
