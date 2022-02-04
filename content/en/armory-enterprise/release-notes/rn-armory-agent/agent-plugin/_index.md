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
**Do not use plugin versions v0.8.35-v0.8.38, v0.9.27-v0.9.30, v0.10.11-v0.10.14 with more than one Clouddriver replica in a production environment.**

You may encounter timeout errors during a restart of Clouddriver or Agent after upgrading the Agent service or plugin. This behavior is intermittent and temporary. These timeout errors are most likely due to the restart, not the upgrade. Any timeout errors should stop after a certain amount of time - around 4 minutes if on Agent 1.0.5 or newer or around 10 minutes if on an older version.
{{% /alert %}}

