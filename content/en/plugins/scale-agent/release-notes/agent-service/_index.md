---
title: Armory Scale Agent Service Release Notes
layout: release-notes-agent-service
weight: 1
description: Release notes for the Armory Scale Agent, which runs as a service and keeps track of your Kubernetes cluster. It works together with the Armory Scale Agent Plugin.
---

{{< include "plugins/scale-agent/agent-compat-matrix.md" >}}

## Release Notes

<h3><a class="fas fa-rss" target="_blank" href="{{< ref "/plugins/scale-agent/release-notes/agent-service" >}}/index.xml"></a></h3>

{{% alert title="Known Issue" color="warning" %}}
Note the following before upgrading the Armory Scale Agent service:

- Starting from v1.0.42, the `clouddriver.insecure` flag is set to `true` by default. If you are using TLS, make sure to set it to `false`.
- Versions v1.0.32 to v1.0.46 may have an inconsistent `last-applied-configuration` annotation and `.metadata.managedFields`. This may prevent you from deleting container sidecars, volumeMounts, envs, and other lists representing Maps in manifests. Since v1.0.47, agent is able to keep both the annotation and field managers consistent when configured to use server side apply. To use server side apply after v1.0.47, add a `agent-k8s.armory.io/serverside-apply: true` annotation to your manifest in case by case basis, or set `kubernetes.serverSideApply.enabled: always` in the configuration to use server side apply on all manifests. Running `kubectl apply --server-side --force-conflicts` with kubectl version>=v1.26.0 will also keep both the annotation and field managers consistent. After that, both server side and client side apply deploymets will work normally.


Timeouts can occur after restarting Clouddriver or Agent. This issue is intermittent. It may occur when you upgrade the Armory Scale Agent service or plugin because the upgrade process involves restarting, but it is due to the restart and not the upgrade. These timeouts should resolve after a few minutes.

{{% /alert %}}



