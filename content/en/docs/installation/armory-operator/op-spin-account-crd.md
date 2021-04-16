---
title: Spinnaker Accounts CRD
linkTitle: Spinnaker Accounts CRD
weight: 50
description: >
  Define and manage Kubernetes accounts outside of Spinnaker's mainfest file.
---

{{< include "experimental-feature.html" >}}

## `SpinnakerAcount` Custom Resource Definition overview

The Operator comes with a `SpinnakerAccount` Custom Resource Definition (CRD) for configuring Kubernetes accounts that you want to use with Spinnaker.  This `SpinnakerAccount` enables defining and managing Kubernetes accounts outside of Spinnaker's manifest file. You create a separate manifest for each Kubernetes account and `kubectl apply` each manifest. Operator processes the manifest into the requisite configuration and adds the account to Spinnaker.

For example, you have a pipeline that provisions a Kubernetes
cluster with Terraform. If you want that new cluster to be available, you can
create a `SpinnakerAccount` of type `Kubernetes` in Spinnaker's namespace.

## Format

```yaml
apiVersion: spinnaker.io/v1alpha2
kind: SpinnakerAccount
metadata:
  name: account-inline
spec:
  type: <Account type>
  enabled: true
  permissions: {} # List of permissions - see below
  settings: {} # Settings see below
```

### `metadata.name`
This is the name of the `SpinnakerAccount`. It needs to be unique across all accounts - not just type of account as in Spinnaker.

### `spec.type`
Account type. See below for current support:

| Account type | Status | Notes |
|------------|----------|-------|
| `Kubernetes` | alpha | Only V2 supported |


### `spec.enabled`
Determines if the account is enabled. If not enabled, it will not be used by `SpinnakerService`.

### `spec.permissions`
Map of authorizations similar to most accounts in Spinnaker.

```yaml
spec:
  permissions:
    READ: ['role1', 'role2']
    WRITE: ['role1', 'role3']
```

### `spec.settings`

Map of settings that are supported by Halyard. For instance:

```yaml
spec:
  type: Kubernetes
  settings:
    cacheThreads: 2
    omitKinds:
    - podPreset
```


### `spec.kubernetes`
Auth options for Kubernetes account type. Pick only one of the options below:

#### `spec.kubernetes.kubeconfigFile`
References a file loaded either out of band to Clouddriver or (more likely) [stored in a secret](./managing-spinnaker.md).

#### `spec.kubernetes.kubeconfigSecret`
Reference to a Kubernetes secret in the same namespace that contains the kubeconfig file:

```yaml
spec:
  type: Kubernetes
  kubernetes:
    kubeconfigSecret:
      name: my-secret
      key: account1-kubeconfig
```

#### `spec.kubernetes.kubeconfig`
You can also inline the kubeconfig file if it does not contain secrets:
```yaml
spec:
  type: Kubernetes
  kubernetes:
    kubeconfig:
      apiVersion: v1
      kind: Config
      clusters:
      - cluster:
          certificate-authority-data:  LS0t...
          server: https://mycluster.url
        name: my-cluster
      contexts:
      - context:
          cluster: my-cluster
          user: my-user
        name: my-context
      current-context: my-context
      preferences: {}
      users:
      - name: my-user
        user:
          exec:
            apiVersion: client.authentication.k8s.io/v1alpha1
            args:
            - token
            - -i
            - my-eks-cluster
            command: aws-iam-authenticator
```