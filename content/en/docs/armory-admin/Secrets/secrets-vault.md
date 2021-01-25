---
title: Storing Spinnaker Secrets in HashiCorp Vault
linkTitle: Secrets with Vault
weight: 10
aliases:
  - /docs/spinnaker-install-admin-guides/secrets-vault/
  - /docs/spinnaker-install-admin-guides/secrets/secrets-vault/
description: >
  Learn how to set up Spinnaker secrets in HashiCorp Vault.
---

>In this example, you use the default KV secret engine called `secret` and store GitHub credentials, a kubeconfig file, and a Java keystore for SAML SSO.

## Authentication with Vault servers

We currently support two methods of authentication with Vault servers.

### 1. Kubernetes service account (recommended)

You'll need to configure Vault to authenticate with Kubernetes per our [Vault Configuration Guide]({{< ref "vault-k8s-configuration" >}}) or HashiCorp's [documentation](https://www.vaultproject.io/docs/auth/kubernetes.html#configuration).

Note: If multiple clusters need to access the same Vault server, you'll need to use the [-path flag](https://www.vaultproject.io/docs/commands/auth/enable.html#usage) and give each cluster a different path name. This becomes `<cluster auth path>` in the example below. If using just one cluster, you can use the default `vault auth enable kubernetes` command, in which case your path will be `kubernetes`.

After configuring authentication on the Vault side, use the following configuration to enable Vault secrets in Spinnaker:

{{< tabs name="serviceAccount" >}}
{{% tab name="Operator" %}}

Add the following snippet to the `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      armory:
        secrets:
          vault:
            enabled: true
            authMethod: KUBERNETES   # Method used to authenticate with the Vault endpoint. Must be either KUBERNETES for Kubernetes service account auth or TOKEN for Vault token auth. The TOKEN method will require a VAULT_TOKEN environment variable set for Operator and the services.  
            url: <Vault server URL>:<port, if required> # URL of the Vault endpoint from Spinnaker services.
            role: <Vault role> # (Applies to KUBERNETES authentication method) Name of the role against which the login is being attempted.
            # path: <k8s cluster path> (Optional; default: kubernetes) Applies to KUBERNETES authentication method) Path of the kubernetes authentication backend mount. Default is "kubernetes"
```
{{% /tab %}}
{{% tab name="Halyard" %}}

```bash
hal armory secrets vault enable
hal armory secrets vault edit \
    --auth-method KUBERNETES \
    --url <Vault server URL>:<port if required> \
    --role <Role in Vault> \
    --path <k8s cluster path> # Optional.default is kubernetes
```

{{% /tab %}}
{{< /tabs >}}

### 2. Token authentication

This method is not recommended, but it is supported if you choose to use it. We recommend this for testing and development purposes only. For token authentication, you need to have a `VAULT_TOKEN` environment variable set in the Halyard container of the Operator pod (or in the Halyard machine if using plain Halyard) as well as each of the services.

Use the following configuration to enable Vault secrets using token auth:

{{< tabs name="token" >}}
{{% tab name="Operator" %}}


Add the following snippet to the `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      armory:
        secrets:
          vault:
            enabled: true
            authMethod: TOKEN                           # Method used to authenticate with the Vault endpoint. Must be either KUBERNETES for Kubernetes service account auth or TOKEN for Vault token auth. The TOKEN method will require a VAULT_TOKEN environment variable set for Operator and the services.  
            url: <Vault server URL>:<port if required> # URL of the Vault endpoint from Spinnaker services.
```

{{% /tab %}}
{{% tab name="Halyard" %}}


```bash
hal armory secrets vault enable
hal armory secrets vault edit \
    --auth-method TOKEN \
    --url <Vault server URL>:<port if required>
```
{{% /tab %}}
{{< /tabs >}}

## Configuring the Operator to use Vault secrets

If you are using the Spinnaker Operator, set up a custom Halyard configuration per [this section]({{< ref "operator#custom-halyard-configuration" >}}) with this content:

```yaml
secrets:
  vault:
    enabled: true
    url: <Vault server URL>
    authMethod: KUBERNETES
    role: <Vault role>
    path: <k8s cluster path>
```

Once you've mounted your `ConfigMap` to the `spinnaker-operator` deployment, it will restart the Halyard container with your Vault config.

## Configuring Halyard to use Vault secrets

Halyard will need access to the Vault server in order to decrypt secrets for validation and deployment. While the Spinnaker services are configured through `~/.hal/config`, the Halyard daemon has its own configuration file found at `/opt/spinnaker/config/halyard.yml`. The contents of your file may look different than this example, but just make sure to add the secrets block somewhere at the root level.

### Halyard locally or in Docker
If you're running Halyard locally, you can use Token auth method. Set your `VAULT_TOKEN` environment variable and add the secrets block to `halyard.yml` like so:

```yaml
halyard:
  halconfig:
    ...

spinnaker:
  artifacts:
    ...

secrets:
  vault:
    enabled: true
    url: <Vault server URL>
    authMethod: TOKEN
```

Then, restart the daemon if this is the first time you are configuring the Token auth method:

```bash
hal shutdown
```
Your next hal command automatically starts the daemon if you're running Halyard locally. If it's running within a Docker container, mount the volume containing the updated `halyard.yml` and restart the container.

### Halyard in Kubernetes
Or if you're running Halyard in Kubernetes, you can have Halyard use Kubernetes auth:
```yaml
halyard:
  halconfig:
    ...

spinnaker:
  artifacts:
    ...

secrets:
  vault:
    enabled: true
    url: <Vault server URL>
    authMethod: KUBERNETES
    role: <Vault role>
    path: <k8s cluster path>
```
Restart the pod so that Halyard restarts with your new config.

## Storing secrets
To store a file, simply prepend the file path with `@`. It accepts relative paths but cannot resolve `~`:

```bash
vault kv put secret/spinnaker/kubernetes config=@path/to/kube/config
```
The command above stores a single key-value pair at the `secret/spinnaker/kubernetes` path. **Any updates to that path will replace the existing values even if using a different key!** In order to store multiple secrets at the same path, it must be done in a single command, like so:
```bash
vault kv put secret/spinnaker/github password=<password> token=<token>
```
Otherwise, just store different secrets at different paths, like we're doing in these examples.

Make sure to base64 encode any binary files:
```bash
base64 -i saml.jks -o saml.b64
vault kv put secret/spinnaker/saml base64keystore=@saml.b64
```


## Referencing secrets

Now that secrets are safely stored in Vault, reference them in config files with the following syntax:

```yaml
encrypted:vault!e:<secret engine>!p:<path to secret>!k:<key>!b:<is base64 encoded?>
```

### Parameters
Parameters can be provided in any order.

- `!`: **required** is used as a delimiter between parameters
- `e`: **required** Vault's Secret Engine.
- `p`: **required** Path to your secret, ex: `spinnaker/github`
- `k`: **required** Key of the secret.
- `b`: **optional** If the value is a base64 encoded value or file, set this to `true`

Example of how it's used in your YAML configs
```yml
github:
  password: encrypted:vault!e:secret!p:spinnaker/github!k:password

kubernetes:
  kubeconfigFile: encrypted:vault!e:secret!p:spinnaker/kubernetes!k:config

gate:
  javaKeyStoreBinary: encrypted:vault!e:secret!p:spinnaker/saml!k:base64keystore!b:true
```
