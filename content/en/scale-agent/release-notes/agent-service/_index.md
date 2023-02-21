---
title: Armory Scale Agent Service Release Notes
layout: release-notes-agent-service
weight: 1
description: Release notes for the Armory Scale Agent, which runs as a service and keeps track of your Kubernetes cluster. It works together with the Armory Scale Agent Plugin.
---

{{< include "scale-agent/agent-compat-matrix.md" >}}

## Release Notes
<h3><a class="fas fa-rss" target="_blank" href="{{< ref "/scale-agent/release-notes/agent-service" >}}/index.xml"></a></h3>

{{% alert title="Known Issue" color="warning" %}}
Note the following before upgrading the Armory Scale Agent Service:
- Starting from v1.0.42 the `clouddriver.insecure` flag is set to `true` by default, if using tls make sure to set it to `false`.

Timeouts can occur after restarting Clouddriver or Agent. This issue is intermittent. It may occur when you upgrade the Armory Scale Agent Service or Plugin because the upgrade process involves restarting, but it is due to the restart and not the upgrade.

These timeouts should resolve after few minutes.

{{% /alert %}}



