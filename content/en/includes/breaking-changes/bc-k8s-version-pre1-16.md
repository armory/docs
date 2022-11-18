### Kubernetes version for deployment targets

Armory CD 2.26 no longer supports Kubernetes deployment targets prior to version 1.16.

**Impact**

Any Kubernetes deployment target must run version 1.16 or higher. If you try to deploy to clusters older than 1.16, you may see errors like the following in the UI:

{{< figure src="/images/release/226/bc-k8s-version-pre1-16.jpg" alt="The UI shows an Unexpected Task Failure error." height="50%" width="50%" >}}

Additionally, errors like the following appear in the Clouddriver logs:

```
2021-05-04 21:17:16.032 WARN 1 --- [0.0-7002-exec-9] c.n.s.c.k.c.ManifestController : Failed to read manifest

com.netflix.spinnaker.clouddriver.kubernetes.op.handler.UnsupportedVersionException: No replicaSet is supported at api version extensions/v1beta1
at com.netflix.spinnaker.clouddriver.kubernetes.op.handler.KubernetesReplicaSetHandler.status(KubernetesReplicaSetHandler.java:98) ~[clouddriver-kubernetes.jar:na]
```

```
2021-05-05 14:29:09.653 WARN 1 --- [utionAction-538] c.n.s.c.k.c.a.KubernetesCachingAgent : kubernetes/KubernetesCoreCachingAgent[1/1]: Failure adding relationships for service

com.netflix.spinnaker.clouddriver.kubernetes.op.handler.UnsupportedVersionException: No replicaSet is supported at api version extensions/v1beta1
at com.netflix.spinnaker.clouddriver.kubernetes.op.handler.KubernetesReplicaSetHandler.getPodTemplateLabels(KubernetesReplicaSetHandler.java:167)
```

**Workaround**

If you are affected by this change, perform the following tasks to update your applications:

- Upgrade the Kubernetes clusters that you are trying to deploy to. They must run version 1.16 or higher.
- If you have manifest files using deprecated APIs, update them to use newer APIs. For more information on which APIs are deprecated in each Kubernetes version and how to migrate, see the [Kubernetes Deprecated API Migration Guide](https://kubernetes.io/docs/reference/using-api/deprecation-guide/).

**Introduced in**: Armory CD 2.26.0
