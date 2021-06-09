---
title: "Configure Vault Integration
linkTitle: "Configure with Vault"
weight: 41
description: >
  Configure Agent integration with Vault
---
![Proprietary](/images/proprietary.svg)

## {{% heading "prereq" %}}

* This guide is for experienced Kubernetes and Armory Enterprise users.
* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).

## Authenticate Agent with Vault

Agent is compatible with properties Spinnaker uses for [Storing Secrets in HashiCorp Vault](https://docs.armory.io/docs/armory-admin/secrets/secrets-vault/)
under `secrets.vault.*` in its `kubesvc.yaml` configuration file.
You can also refer to vault secrets with the [same syntax as spinnaker](https://docs.armory.io/docs/armory-admin/secrets/secrets-vault/#referencing-secrets)

This is an example of how the [Kubernetes service account](https://docs.armory.io/docs/armory-admin/secrets/secrets-vault/#1-kubernetes-service-account-recommended) configuration looks like in Agent
And using an `encryptedFile:` reference for `kubeconfigFile`.

```yaml
# ./kubesvc.yaml
kubernetes:
  accounts:
    - name: account01
      kubeconfigFile: encryptedFile:vault!e:secret!p:spinnaker/kubernetes!k:config

secrets:
  vault:
    enabled: true
    authMethod: KUBERNETES
    url: https://your.vault.instance
    role: spinnaker
    path: kubernetes
```

## Dynamically load accounts from Vault

* The following requires [Vault Injector Sidecar](https://www.vaultproject.io/docs/platform/k8s/injector/installation) to be installed and running

It's possible to have dynamic accounts by having a Vault Injector sidecar generate and update the [`kubesvc.yaml` configuration file](https://docs.armory.io/docs/armory-agent/agent-options/) for you.
Agent is able to pickup changes in the configuration file, and manage the new accounts it finds there.

### Saving Agent accounts in Vault

```
vault kv put secret/kubernetes account01=@kubeconfig.yaml
```

 * Make sure to keep all kubeconfig files in one vault secret (in this case `secret/kubernetes`)
 * Each field name will correspond to an account name in Spinnaker
 * Each field value will be the contents of the `kubeconfigFile` used by that account

### Configuration template

```
spec:
  template:
    metadata:
      annotations:
        vault.hashicorp.com/agent-inject: "true"
        vault.hashicorp.com/secret-volume-path-kubesvc-local.yml: '/opt/spinnaker/config'
        vault.hashicorp.com/agent-inject-file-kubesvc-local.yml: 'kubesvc-local.yml'
        vault.hashicorp.com/agent-inject-template-kubesvc-local.yml: |
          kubernetes:
            accounts:
          {{- with secret "secret/kubernetes" -}}
          {{ range $k, $v := .Data.data }}
              - kubeconfigFile: 'encryptedFile:vault!e:secret!n:kubernetes!k:{{ $k }}'
                name: {{ $k -}}
          {{- else }}
              []
          {{ end -}}
          {{- end }}
          secrets:
            vault:
              enabled: true
              authMethod: KUBERNETES
              role:
              path:
              url:
          clouddriver:
            insecure: true
    spec:
      volumes: []
      containers:
        - name: kubesvc
          volumeMounts: []
```

Considerations:
 * Make sure to include the required [Vault Injector Annotations](https://www.vaultproject.io/docs/platform/k8s/injector/annotations) like [`vault.hashicorp.com/role` or `vault.hashicorp.com/agent-configmap`](https://www.vaultproject.io/docs/platform/k8s/injector/annotations#vault-hashicorp-com-role) correspond to your environment
 * Be aware of the kv engine currently on your vault. If you are using [KV version 2](https://www.vaultproject.io/docs/secrets/kv/kv-v2), you will need to modify the template to use `{{ range $k, $v := .Data }}` instead. See [this link](https://github.com/hashicorp/consul-template/blob/master/docs/templating-language.md#versioned-read) for more information
 * This template expects `secret/kubernets` to hold the kubeconfig file make sure to replace both references in line 11 and line 13 above
 * Make sure to include all other [Agent Options](https://docs.armory.io/docs/armory-agent/agent-options/) that you might required in your environment

