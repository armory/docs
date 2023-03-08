---
title: v1.0.47 Armory Agent Service (2023-02-27)
toc_hide: true
version: 01.00.46
date: 2023-03-08
---

Context:
* Original customer blocker: Default Client-Side apply is unable to handle some of the configMaps through spinnaker because the manifest starting hitting annotation length hard limits and CSA requires a copy of the previous manifest in the annnoation named `last-applied-configuration`
* Serverside Apply includes a new structure called field managers under `.metadata.managedFields` which allow to store the same information as last-applied-configuration without relying on annotations. Each field manager tell who set what fields and who can modify them (i.e. end-users, k8s controllers, kubeapi)

* Serverside apply uses a similar syntax to StrategicMerge (i.e. CSA payloads) but it removes the `$patch` directive. The only option to delete a side-car is to remove it from the payload
* Serverside apply removes field managers that have no corresponding field included in the payload
* The last two points combine to prevent SSA from deleting a side-car and own the side in order to be allowed to deleted it
* ~The only workaround it to clear or the fieldManagers so that the next apply becomes the sole owner of the complete manifest. Whoever that approach might lead to issues that the CSA's last-applied-configuration annotation and the SSA's field manager are trying to prevent down the road.~
* There's a new bookkeeping logic in kuebctl 1.26.0 that handles both csa annotation and field managers to keep  both consistent and allow CSA and SSA to coexist. In case a third fieldManager (i.e. a k8s controller) insists on retaining ownership, you can clear the field managers in order to become the sole owner. But it is unlikely to be necessary

* Earlier versions of k8s (e.g. 1.18) some optional fields with defaults are expected to be assigned by kubectl, and agent now is able to send those defaults as well. However, it is not recommended to do so, since in SSA not including fields means yielding ownership.


###Changes:
* ConfigMap and Secrets default to SSA to allow handle large payloads for them; in addition this manifests are immutable so that prevents multiple ownership.
* All other manifests are ClientSide-Apply by default unless an annotation is set:
  * `agent-k8s.armory.io/serverside-apply: true` will send the payload through SSA. otherwise will use CSA
  * `agent-k8s.armory.io/ssa-manifest-defaults: true` will include missing fields with known defaults (e.g. `containerPort = TCP`) Only necesary for some older k8s cluster versions e.g. 1.18
  * `agent-k8s.armory.io/ssa-clear-managed-fields: true` will clear the field managers

###Add:
* Per Manifest-Kind configuration:
  * `kubernetes.serverSideApply.kinds[].kind`
    Kind name to override.
  * `kubernetes.serverSideApply.kinds[].enabled: always|never|allowed`
    always|never: Override annotations to Always/Never use SSA.
    allowed: Use CSA unless annotation `agent-k8s.armory.io/serverside-apply: true` is present
  * `kubernetes.serverSideApply.kinds[].manifestDefaults: always|never|allowed`
    always|never: Override annotations to Always/Never modify applied manifests to include field defaults.
    allowed: Send manifest as-is unless annotation `agent-k8s.armory.io/ssa-manifest-defaults: true` is present
  * `kubernetes.serverSideApply.kinds[].clearManagedFields: always|never|allowed`
    always|never: Override annotations to Always/Never modify applied manifests to clear managed fields and become sole owner, Partial manifess _will_ fail, and information from controller might be lost.
    allowed: Respect managed fields unless annotation `agent-k8s.armory.io/ssa-manifest-defaults: true` is present

* Agent global configuration
  * `kubernetes.serverSideApply.enabled: always|never|allowed`   
    always|never: Override annotations and kind list to Always/Never use SSA.
    allowed: Use CSA unless annotation `agent-k8s.armory.io/serverside-apply: enabled` is present or config `kubernetes.serverSideApply.kinds[].enabled` is present in configuration file.

  * `kubernetes.serverSideApply.manifestDefaults: always|never|allowed`
    always|never: Override annotations and kind list to Always/Never modify applied manifests to include field defaults.
    allowed: Send manifest as-is unless annotation `agent-k8s.armory.io/ssa-manifest-defaults: enabled` is present or `kubernetes.serverSideApply.kinds[].manifestDefaults` is present in configuration file

  * `kubernetes.serverSideApply.clearManagedFields: always|never|allowed`
    always|never: Override annotations and kind list to Always/Never modify applied manifests to include field defaults.
    allowed: Send manifest as-is unless annotation `agent-k8s.armory.io/ssa-manifest-defaults: enabled` is present or `kubernetes.serverSideApply.kinds[].manifestDefaults` is present in configuration file


---



Defaults:
```
kubernetes.serverSideApply.enabled=allowed
kubernetes.serverSideApply.manifestDefaults=allowed
kubernetes.serverSideApply.clearManagedFields=allowed
```


---

CSA migration logic:
https://github.com/kubernetes/kubernetes/issues/107980
https://github.com/kubernetes/kubernetes/issues/108081
https://github.com/kubernetes/kubernetes/issues/107417
https://github.com/kubernetes/kubernetes/issues/112826
https://github.com/kubernetes/kubernetes/pull/112905
https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.26.md#bug-or-regression-5
> For kubectl, --server-side now migrates ownership of all fields used by client-side-apply to the specified --fieldmanager. This prevents fields previously specified using kubectl from being able to live outside of server-side-apply's management and become undeleteable. ([#112905](https://github.com/kubernetes/kubernetes/pull/112905), [@alexzielenski](https://github.com/alexzielenski)) [SIG API Machinery, CLI and Testing]

## Summary:
Using server side apply now ensures that all fields are managed by the server, making it easier to manage Kubernetes objects and avoid data inconsistencies.