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
- Versions v1.0.32 to v1.0.46 may have inconsistent last-applied-configuration flag and serverside apply's field managers. Which may prevent from deleting container sidecars, volumeMounts, and other List representing Maps in manifests. v1.0.47 with `kubernetes.serverSideApply.enabled: always` or applying once with kubectl >=v1.26.0 and flag `--server-side` will fix the annotations and field managers to allow both serverside and normal client side apply to work as normal

Timeouts can occur after restarting Clouddriver or Agent. This issue is intermittent. It may occur when you upgrade the Armory Scale Agent service or plugin because the upgrade process involves restarting, but it is due to the restart and not the upgrade. These timeouts should resolve after a few minutes.

{{% /alert %}}



