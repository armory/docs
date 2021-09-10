---
title: "Configure Vault Integration"
linkTitle: "Configure Vault"
weight: 41
description: >
  Configure Armory Agent integration with Vault.
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

## {{% heading "prereq" %}}

* This guide is for experienced Kubernetes and Armory Enterprise users.
* You have read the Armory Agent [overview]({{< ref "armory-agent" >}}).

## Authenticate Agent with Vault

The Armory Agent is compatible with properties Armory Enterprise uses for [storing secrets in HashiCorp Vault]({{< ref "secrets-vault" >}}). You put configuration in `armory-agent.yaml` in the `secrets.vault.*` section. You refer to Vault secrets using the same syntax you use in configuring secrets for Armory Enterprise. See the [Referencing Secrets section]({{< ref "secrets-vault#referencing-secrets" >}}) for details.

This is an example of what the [Kubernetes service account]({{< ref "secrets-vault#1-kubernetes-service-account-recommended" >}}) configuration looks like in Agent, using an `encryptedFile:` reference for `kubeconfigFile`:

{{< prism line="5" lang="yaml" >}}
# ./armory-agent.yaml
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
{{< /prism >}}

## Dynamically load accounts from Vault

>This requires you to install the [Vault Injector Sidecar](https://www.vaultproject.io/docs/platform/k8s/injector/installation).

The Armory Agent detects changes in the configuration file and manages new accounts that it finds. This makes it possible to use a sidecar for
adding and removing accounts dynamically instead of having a static `ConfigMap`. The [Vault guide](https://www.vaultproject.io/docs/commands/kv/put) specifies the following syntax:

```bash
vault kv put secret/kubernetes account01=@kubeconfig.yaml
```

 * Keep `kubeconfig` files in one Vault secret (in this case `secret/kubernetes`).
 * Each field name corresponds to an account name in Armory Enterprise.
 * Each field value is the contents of the `kubeconfigFile` used by that account.

### Configuration template

Replace the configuration files and `kubeconfig` files from the {{< linkWithTitle "armory-agent-quick.md" >}} guide and instead use [Vault injector annotations](https://www.vaultproject.io/docs/platform/k8s/injector/annotations) to provide a template.

{{< prism lang="yaml" line="13-23" >}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: spin-armory-agent
spec:
  template:
    metadata:
      annotations:
        vault.hashicorp.com/agent-inject: "true"
        vault.hashicorp.com/agent-inject-secret-armory-agent-local.yml: ""
        vault.hashicorp.com/secret-volume-path-armory-agent-local.yml: '/opt/armory/config'
        vault.hashicorp.com/agent-inject-file-armory-agent-local.yml: 'armory-agent-local.yml'
        vault.hashicorp.com/agent-inject-template-armory-agent-local.yml: |
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
          name: volume-armory-agent-config
        - $patch: delete
          name: volume-armory-agent-kubeconfigs
      containers:
        - name: armory-agent
          volumeMounts:
            - $patch: delete
              name: volume-armory-agent-config
              mountPath: /opt/armory/config
            - $patch: delete
              name: volume-armory-agent-kubeconfigs
              mounthPath:
              mountPath: /kubeconfigfiles
{{</ prism >}}

 * Make sure to include the required [Vault injector annotations](https://www.vaultproject.io/docs/platform/k8s/injector/annotations) like [`vault.hashicorp.com/role` or `vault.hashicorp.com/agent-configmap`](https://www.vaultproject.io/docs/platform/k8s/injector/annotations#vault-hashicorp-com-role) that correspond to your environment.
 * Be aware of the version of Vault's KV engine currently in your environment. This guide assumes you have the secret engine [KV version 2](https://www.vaultproject.io/docs/secrets/kv/kv-v2). For KV version 1, you need to modify the template to use `{{ range $k, $v := .Data }}` instead. See the Templating Language's [Versioned Read](https://github.com/hashicorp/consul-template/blob/master/docs/templating-language.md#versioned-read) section for more information.
 * This template expects `secret/kubernets` to hold the `kubeconfig file`: Make sure to replace both line 16 and 18 in case that's not the case in your environment.
 * Make sure to include all other [Agent Options]({{< ref "agent-options/#options" >}}) that you require in your environment.

After addressing the preceding points, save the template as `armory-agent-vault-patch.yaml` and refer to it in your `kustomization.yaml`:


{{< prism lang="yaml" line="10-11" >}}
# ./kustomization.yaml
# Pre-existing SpinnakerService resource (may be different)
namespace: spinnaker
resources:
  - spinnakerservice.yaml
bases:
# Armory agent deployment
  - armory-agent

patchesStrategicMerge:
  - armory-agent-vault-patch.yaml
{{</ prism >}}

## Troubleshooting

**Agent deployment is to appearing / There are no spin-armory-agent pods**

 * Check the following commands for any error or warning message:
   * `kubectl describe desploy spin-armory-agent | sed -ne '/^Events:$/,$p'`
   * `kubectl describe rs -l cluster=spin-armory-agent | sed -ne '/^Events:$/,$p'`
 * Error message: `Error creating: admission webhook "vault.hashicorp.com" denied the request: error validating agent configuration: no Vault role found`:
   * Make sure that the annotations [`vault.hashicorp.com/role` or `vault.hashicorp.com/agent-configmap`](https://www.vaultproject.io/docs/platform/k8s/injector/annotations#vault-hashicorp-com-role) are set and they correspond to your environment

**Agent gets stuck in status Init**

 * Check for logs of the injector with the following command: `kubectl logs deploy/spin-armory-agent -c vault-agent-init`.
 * Error message: `[WARN] (view) vault.read(secret/kubernetes): no secret exists at secret/data/kubernetes (retry attempt 1 after "250ms")`:
   * Make sure to update the reference in `armory-agent-vault-patch.yaml` to a secret that is accessible in your environment.

**Agent is in Crash loop back off**

 * Check for logs of armory-agent with the following command `kubectl logs deploy/spin-armory-agent -c armory-agent`.
 * Error message: `Error registering vault config: vault configuration error`:
   * Make sure to update `armory-agent-vault-patch.yaml` to include the properties [`secrets.vault.*`]({{< ref "secrets-vault" >}}) that correspond to your environment.
 * Error message `failed to load configuration: error fetching key \"data\"`:
   * Your vault KV engine is using version 2. Make sure the template in `armory-agent-vault-patch.yaml` is using `{{ range $k, $v := .Data.data }}`.

**Agent registers with 0 servers**

 * Check for logs of vault injector with the following command: `kubectl logs -f deploy/spin-armory-agent -c vault-agent`.
 * Error message `missing dependency: vault.read(secret/kubernetes)`:
   * Your vault KV engine is using version 1. Make sure the template in `armory-agent-vault-patch.yaml` is using `{{ range $k, $v := .Data }} `.

