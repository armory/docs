---
title: "Configure Vault Integration"
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

Agent is compatible with properties Spinnaker uses for [Storing Secrets in HashiCorp Vault]({{< ref "secrets-vault" >}})
under `secrets.vault.*` in its `kubesvc.yaml` configuration file.
You can also refer to vault secrets with the [same syntax as spinnaker]({{< ref "secrets-vault#referencing-secrets" >}})

This is an example of how the [Kubernetes service account]({{< ref "secrets-vault#1-kubernetes-service-account-recommended" >}}) configuration looks like in Agent
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

Agent is able to pickup changes in the configuration file, and start managing any new accounts it finds. That makes it possible to use a sidecar for
onboarding and offboarding dynamic accounts, instead of a static `ConfigMap`. The current guide presents one example using vault.

```
vault kv put secret/kubernetes account01=@kubeconfig.yaml
```

 * We will keep `kubeconfig` files in one vault secret (in this case `secret/kubernetes`)
 * Each field name will correspond to an account name in Spinnaker
 * Each field value will be the contents of the `kubeconfigFile` used by that account

### Configuration template

We will replace the configuration files and `kubeconfig` files from the [Quick Start Installation Guide]({{< ref "armory-agent-quick" >}})
and use [Vault Injector Annotations](https://www.vaultproject.io/docs/platform/k8s/injector/annotations) to provide a template instead.

{{< prism lang="yaml" line="13-23" >}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: spin-kubesvc
spec:
  template:
    metadata:
      annotations:
        vault.hashicorp.com/agent-inject: "true"
        vault.hashicorp.com/agent-inject-secret-kubesvc-local.yml: ""
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
      volumes:
        - $patch: delete
          name: volume-kubesvc-config
        - $patch: delete
          name: volume-kubesvc-kubeconfigs
      containers:
        - name: kubesvc
          volumeMounts:
            - $patch: delete
              name: volume-kubesvc-config
              mountPath: /opt/spinnaker/config
            - $patch: delete
              name: volume-kubesvc-kubeconfigs
              mounthPath:
              mountPath: /kubeconfigfiles
{{</ prism >}}

Considerations:
 * Make sure to include the required [Vault Injector Annotations](https://www.vaultproject.io/docs/platform/k8s/injector/annotations) like [`vault.hashicorp.com/role` or `vault.hashicorp.com/agent-configmap`](https://www.vaultproject.io/docs/platform/k8s/injector/annotations#vault-hashicorp-com-role) correspond to your environment
 * Be aware of the version of Vault's KV engine currently in your environment. This guide assumes you have the secret engine [KV version 2](https://www.vaultproject.io/docs/secrets/kv/kv-v2). For you KV version 1, will need to modify the template to use `{{ range $k, $v := .Data }}` instead. See [this link](https://github.com/hashicorp/consul-template/blob/master/docs/templating-language.md#versioned-read) for more information
 * This template expects `secret/kubernets` to hold the kubeconfig file: Make sure to replace both line 16 and 18 in case that's not the case in your environment
 * Make sure to include all other [Agent Options]({{< ref "agent-options/#options" >}}) that you might required in your environment

After taking those considerations, save the template as `armory-agent-vault-patch.yaml`, and refer to it in your `kustomization.yaml`:


{{< prism lang="yaml" line="10-11" >}}
# ./kustomization.yaml
# Pre-existing SpinnakerService resource (may be different)
namespace: spinnaker
resources:
  - spinnakerservice.yaml
bases:
# Armory agent deployment
  - https://armory.jfrog.io/artifactory/manifests/kubesvc/armory-agent-0.5.11-kustomize.tar.gz

patchesStrategicMerge:
  - armory-agent-vault-patch.yaml
{{</ prism >}}

### Troubleshooting

Agent deployment is to appearing / There are no spin-kubesvc pods:

 * Check the following commands for any error or warning message:
 * * `kubectl describe desploy spin-kubesvc | sed -ne '/^Events:$/,$p'`
 * * `kubectl describe rs -l cluster=spin-kubesvc | sed -ne '/^Events:$/,$p'`
 * Error message: `Error creating: admission webhook "vault.hashicorp.com" denied the request: error validating agent configuration: no Vault role found`
   * Make sure that the annotations [`vault.hashicorp.com/role` or `vault.hashicorp.com/agent-configmap`](https://www.vaultproject.io/docs/platform/k8s/injector/annotations#vault-hashicorp-com-role) are set and they correspond to your environment

Agent gets stuck in status Init

 * Check for logs of the injector with the following command: `kubectl logs deploy/spin-kubesvc -c vault-agent-init`
 * Error message: `[WARN] (view) vault.read(secret/kubernetes): no secret exists at secret/data/kubernetes (retry attempt 1 after "250ms")`
   * Make sure to update the reference in the template above (ln 16 and 18) to a secret that is accesible in your environment

Agent is in Crash loop back off

 * Check for logs of kubesvc with the following command `kubectl logs deploy/spin-kubesvc -c kubesvc`
 * Error message: `Error registering vault config: vault configuration error`
 * * Make sure to update the template above to include the properties [`secrets.vault.*`]({{< ref "secrets-vault" >}}) that correspond to your environment
 * Error message `failed to load configuration: error fetching key \"data\"`
   * Your vault KV engine is using version 2. Make sure the template in `armory-agent-vault-patch.yaml` above is using `{{ range $k, $v := .Data.data }}` in line 17

Agent registers with 0 servers

 * Check for logs of vault injector with the following command: `kubectl logs -f deploy/spin-kubesvc -c vault-agent`
 * Error message `missing dependency: vault.read(secret/kubernetes)`
   * Your vault KV engine is using version 1. Make sure the template in `armory-agent-vault-patch.yaml` above is using `{{ range $k, $v := .Data }} ` in line 17

