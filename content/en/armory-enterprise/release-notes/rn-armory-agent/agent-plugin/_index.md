---
title: Armory Agent Clouddriver Plugin Release Notes
linkTitle: Clouddriver Plugin Release Notes
layout: release-notes-agent-plugin
weight: 2
description: Release notes for the Agent Clouddriver Plugin. The plugin runs as part of your Armory Enterprise or Spinnaker instance and communicates with the Agent service.
---

{{< include "agent/agent-compat-matrix.md" >}}

## Release Notes
<h3><a class="fas fa-rss" target="_blank" href="https://docs.armory.io/armory-enterprise/release-notes/rn-armory-agent/agent-plugin/index.xml"></a></h3>

{{% alert title="Known Issue" color="warning" %}}
Note the following before upgrading the Agent Plugin:

* Do not use plugin versions v0.8.35-v0.8.38, v0.9.27-v0.9.30, v0.10.11-v0.10.14 with more than one Clouddriver replica in a production environment.

* Timeouts can occur after restarting Clouddriver or Agent. This issue is intermittent. It may occur when you upgrade the Agent Service or Plugin because the upgrade process involves restarting, but it is due to the restart and not the upgrade.

   These timeout errors should resolve after several minutes. This issue affects all current versions of the Agent.

{{% /alert %}}

