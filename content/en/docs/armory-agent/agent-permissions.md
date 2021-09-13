---
title: "Kubernetes Permissions for the Armory Agent"
linkTitle: "Permissions"
description: >
  Kubernetes permissions required by the Armory Agent.
weight: 65
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

## Permissions

The Agent can use a `kubeconfig` file loaded as a Kubernetes secret when deploying to a remote cluster. Also, you can configure Agent permissions using a Kubernetes Service Account when deploying to the cluster the Agent resides in.

The Agent should have `ClusterRole` authorization if you need to deploy pods across your cluster or `Role` authorization if you deploy pods only to a single namespace.

* If Agent is running in [Agent Mode]({{< ref "armory-agent#agent-mode" >}}), then the `ClusterRole` or `Role` is the one attached to the Kubernetes Service Account mounted by the Agent pod.
* If Agent is running in any of the other modes, then the `ClusterRole` or `Role` is the one the `kubeconfigFile` uses to interact with the target cluster. `kubeconfigFile` is configured in `armory-agent.yml` of the Agent pod.

Example configuration for deploying `Pod` manifests:

{{< tabs name="agent-permissions" >}}
{{% tab name="ClusterRole" %}}

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: agent-role
rules:
- apiGroups: ""
  resources:
  - pods
  - pods/log
  - pods/finalizers  
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
```

{{% /tab %}}
{{% tab name="Role" %}}

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: agent-role
rules:
- apiGroups: ""
  resources:
  - pods
  - pods/log
  - pods/finalizers  
  verbs:
  - get
  - list
  - watch
  - create
  - update
  - patch
  - delete
```

{{% /tab %}}
{{< /tabs >}}

See the Quickstart's _Configure permissions_ [section]({{< ref "armory-agent-quick#configure-permissions" >}}) for a complete example that uses `ClusterRole`, `ClusterRoleBinding`, and `ServiceAccount`.

See the Kubernetes [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) guide for details on configuring `ClusterRole` and `Role` authorization.

