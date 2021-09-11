---
title: v0.6.0 Armory Agent Service (2021-09-10)
toc_hide: true
version: 00.06.00

---

## Breaking changes

* The configuration file for Agent has been renamed from `kubesvc.{yml|yaml}` to `armory-agent.{yml|yaml}`. Additionally, its location changed from `/opt/spinnaker/config` to `/opt/armory/config`. The old config file is still used if `armory-agent.{yml|yaml}` is not present, but users are encouraged to move to the new naming convention.
* Agent docker images are now published to `armory/agent-k8s` on Docker Hub. Previously, the images were published to `armory/kubesvc`.
* Configuration options that start with the prefix `clouddriver` (such as `clouddriver.auth.token`) have been replaced with properties that start with `hub` (such as `hub.auth.token`). You must update your configuration files to use the new properties. For more information, see [Configuration options]({{< ref "agent-options#configuration-options" >}})