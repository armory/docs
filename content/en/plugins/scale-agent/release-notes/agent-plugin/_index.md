---
title: Armory Scale Agent Clouddriver Plugin Release Notes
linkTitle: Clouddriver Plugin Release Notes
layout: release-notes-agent-plugin
weight: 2
description: Release notes for the Armory Scale Agent Clouddriver Plugin. The plugin runs as part of your Armory CD or Spinnaker instance and communicates with the Armory Scale Agent service.
---

{{< include "scale-agent/agent-compat-matrix.md" >}}

## Release Notes
<h3><a class="fas fa-rss" target="_blank" href="{{< ref "/plugins/scale-agent/release-notes/agent-plugin" >}}/index.xml"></a></h3>

{{% alert title="Known Issue" color="warning" %}}
Note the following before upgrading the Armory Scale Agent Plugin:

* Do not use plugin versions v0.8.35 - v0.8.38, v0.9.27 - v0.9.30, v0.10.11 - v0.10.14 with more than one Clouddriver replica in a production environment.

* Timeouts can occur after restarting Clouddriver or Agent. This issue is intermittent. It may occur when you upgrade the Armory Scale Agent Service or Plugin because the upgrade process involves restarting, but it is due to the restart and not the upgrade.

   These timeout errors should resolve after several minutes. This issue affects all current versions of the Armory Scale Agent.

* Do not use plugin versions v0.9.75 - v0.9.82, v0.10.60 - v0.10.66, v0.11.22 - v0.11.28 with agent version >= v1.0.26, otherwise it could cause to have Timeouts issues.

{{% /alert %}}

