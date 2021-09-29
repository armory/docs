> Note: You can use encrypted secrets instead of providing plaintext values. For more information, see the [Secrets Guide]({{< ref "secrets" >}}).

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

If your Armory Enterprise (Spinnaker) environment is behind an HTTPS proxy, you need to configure HTTPS proxy settings. 

<details><summary>Learn more</summary>

To set an HTTPS proxy, use the following config:

```yaml
env[0].name=”HTTPS_PROXY”,env[0].value="<hostname>:<port>"
``` 

You can include the following snippet in your `helm install` command:

```yaml
--set env[0].name=”HTTPS_PROXY”,env[0].value="<hostname>:<port>" 
```

Alternatively, you can create a `values.yaml` file to include the parameters:

```yaml
env:
  - name: HTTPS_PROXY
    value: <hostname>:<port>
```
With the file, you can configure multiple configs in addition to the `env` config in your `helm install` command. Instead of using `--set`, include the `--values` parameter as part of the Helm install command:

```
--values=<path>/values.yaml
```

</details>


