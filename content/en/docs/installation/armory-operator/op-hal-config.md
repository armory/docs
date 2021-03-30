---
title: Custom Halyard Configuration
linkTitle: Custom Halyard Config
weight: 80
description: >
  Override Halyard configuration with a Kubernetes `ConfigMap`.
---
{{< include "armory-operator/os-operator-blurb.md">}}

## Custom Halyard configuration

To override Halyard's configuration, create a Kubernetes [ConfigMap](https://kubernetes.io/docs/concepts/configuration/configmap/) with the configuration changes you need. For example, if you using [secrets management with Vault]({{< ref "secrets-vault" >}})(![Proprietary](/images/proprietary.svg)), Halyard and Operator containers need your Vault configuration:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: halyard-custom-config
data:
  halyard-local.yml: |
    secrets:
      vault:
        enabled: true
        url: <URL of vault server>
        path: <cluster path>
        role: <k8s role>
        authMethod: KUBERNETES
```

Then, you can mount it in the Operator deployment and make it available to the Halyard and Operator containers:

```yaml
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: spinnaker-operator
  ...
spec:
  template:
    spec:
      containers:
      - name: spinnaker-operator
        ...
        volumeMounts:
        - mountPath: /opt/spinnaker/config/halyard.yml
          name: halconfig-volume
          subPath: halyard-local.yml
      - name: halyard
        ...
        volumeMounts:
        - mountPath: /opt/spinnaker/config/halyard-local.yml
          name: halconfig-volume
          subPath: halyard-local.yml
      volumes:
      - configMap:
          defaultMode: 420
          name: halyard-custom-config
        name: halconfig-volume
```