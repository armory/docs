---
title: Configure Hashicorp's Vault for Kubernetes Auth
linkTitle: Configure Vault for Kubernetes Auth
weight: 10
aliases:
  - /docs/spinnaker-install-admin-guides/vault-configuration/
  - /docs/spinnaker-install-admin-guides/secrets/vault-configuration/
description: >
  Learn how to configure Vault to utilize the Kubernetes auth method for managing Spinnaker secrets.
---

>Configuration of Vault for the Kubernetes auth method requires configuring both Vault and Kubernetes.

## Configure Kubernetes

Create a Kubernetes Service Account.

**vault-auth-service-account.yml**

```yaml
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: role-tokenreview-binding
  namespace: default
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:auth-delegator
subjects:
- kind: ServiceAccount
  name: vault-auth
  namespace: default
```

```bash
# Create a service account, 'vault-auth'
$ kubectl -n default create serviceaccount vault-auth

# Update the 'vault-auth' service account
$ kubectl -n default apply --filename vault-auth-service-account.yml
```

## Configure Vault

>This guide assumes that [Key/Value version 1](https://www.vaultproject.io/api/secret/kv/kv-v1.html) secret engine is enabled at `secret/`.


Create a read-only policy `spinnaker-kv-ro` in Vault.

**spinnaker-kv-ro.hcl**

```hcl
# For K/V v1 secrets engine
path "secret/spinnaker/*" {
    capabilities = ["read", "list"]
}
# For K/V v2 secrets engine
path "secret/data/spinnaker/*" {
    capabilities = ["read", "list"]
}
```

```bash
$ vault policy write spinnaker-kv-ro spinnaker-kv-ro.hcl
```


Set environment variables required for Vault configuration.

```bash
# Set VAULT_SA_NAME to the service account you created earlier
$ export VAULT_SA_NAME=$(kubectl -n default get sa vault-auth -o jsonpath="{.secrets[*]['name']}")

# Set SA_JWT_TOKEN value to the service account JWT used to access the TokenReview API
$ export SA_JWT_TOKEN=$(kubectl -n default get secret $VAULT_SA_NAME -o jsonpath="{.data.token}" | base64 --decode; echo)

# Set SA_CA_CRT to the PEM encoded CA cert used to talk to Kubernetes API
$ export SA_CA_CRT=$(kubectl -n default get secret $VAULT_SA_NAME -o jsonpath="{.data['ca\.crt']}" | base64 --decode; echo)

# Look in your cloud provider console for this value
$ export K8S_HOST=<https://your_API_server_endpoint>
```

{{% alert title="NOTE on TTL and Token Renewal" color="info" %}}
The Kubernetes Vault Auth Secrets Engine does not currently support token renewal. As such the `spinnaker` role created below provides a `TTL` of `two months`.

**Note** By default, Vault has a max_ttl parameter set to `768h0m0s` - that's 32 days. If you want to set the `TTL` to a higher value, you need to modify this parameter.

**Important:** Spinnaker must be redeployed sometime during the defined `TTL` window -- Armory recommends this be done by updating to a new version of Spinnaker and running `kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>`.
{{% /alert %}}

Next, configure Vault's Kubernetes auth method.

```bash
# Enable the Kubernetes auth method at the default path ("kubernetes")
$ vault auth enable kubernetes

# Tell Vault how to communicate with the Kubernetes cluster
$ vault write auth/kubernetes/config \
        token_reviewer_jwt="$SA_JWT_TOKEN" \
        kubernetes_host="$K8S_HOST" \
        kubernetes_ca_cert="$SA_CA_CRT"

# Create a role named, 'spinnaker' to map Kubernetes Service Account to
# Vault policies and default token TTL
$ vault write auth/kubernetes/role/spinnaker \
        bound_service_account_names=default \
        bound_service_account_namespaces='*' \
        policies=spinnaker-kv-ro \
        ttl=1440h
```

## Verify Configuration

It is time verify that the Kubernetes auth method has been properly configured.

Deploy Armory's [debug container](https://github.com/armory/troubleshooting-toolbox/blob/master/docker-debugging-tools/Dockerfile) into your cluster -- this container has the Vault cli pre-installed.

>This should be deployed into the same namespace as your Spinnaker installation.

```bash
kubectl apply -f  https://raw.githubusercontent.com/armory/troubleshooting-toolbox/master/docker-debugging-tools/deployment.yml
```

`exec` into the pod.

```bash
POD_NAME=$(kubectl get pod -l app=debugging-tools -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' --sort-by=".status.startTime" | tail -n 1)

kubectl exec -it $POD_NAME bash
```

Test the auth method.

```bash
export VAULT_ADDR='http://your.vault.address:port'
SA_TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)

vault write auth/kubernetes/login role=spinnaker jwt=$SA_TOKEN
```

This command should return output like the following

```bash
Key                                       Value
---                                       -----
token                                     s.bKSSrYOcETCADGvGxhbDaaaD
token_accessor                            0ybx2CEPZqxBEwFk8jUPkBk7
token_duration                            24h
token_renewable                           true
token_policies                            ["default" "spinnaker-kv-ro"]
identity_policies                         []
policies                                  ["default" "spinnaker-kv-ro"]
token_meta_role                           spinnaker
token_meta_service_account_name           default
token_meta_service_account_namespace      default
token_meta_service_account_secret_name    default-token-h9knn
token_meta_service_account_uid            13cee6Dbc-0bc2-11e9-9fd2-0a32f8e530cc
```

Using the token from the output above allows for the following:

```bash
vault login s.bKSSrYOcETCADGvGxhbDaaaD
```

Once logged in you should be able to read secrets:

```bash
vault kv get secret/spinnaker/test
```

As a reminder, the policy we created provides RO access *only* so you will need to have written the secret using a separate authenticated client.
