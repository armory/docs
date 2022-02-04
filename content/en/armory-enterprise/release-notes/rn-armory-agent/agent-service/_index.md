---
title: Armory Agent Service Release Notes
layout: release-notes-agent-service
weight: 1
description: Release notes for the Armory Agent, which runs as a service and keeps track of your Kubernetes cluster. It works together with the Agent Plugin.
---

{{< include "agent/agent-compat-matrix.md" >}}

## Release Notes

{{% alert title="Known Issue" color="warning" %}}
Note the following before upgrading the Agent Service:

Timeouts can occur after restarting Clouddriver or Agent. This issue is intermittent. It may occur when you upgrade the Agent Service or Plugin because the upgrade process involves restarting, but it is due to the restart and not the upgrade.

These timeout errors should resolve after several minutes. This issue affects all current versions of the Agent.

{{% /alert %}}


<h3><a class="fas fa-rss" target="_blank" href="https://docs.armory.io/armory-enterprise/release-notes/rn-armory-agent/agent-service/index.xml"></a></h3>

