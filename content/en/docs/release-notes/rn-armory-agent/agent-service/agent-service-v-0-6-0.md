---
title: v0.6.0 Armory Agent Service (2021-09-10)
toc_hide: true
version: 00.06.00

---

## Breaking changes
* The configuration file used by agent was renamed from `kubesvc.{yml|yaml}` to `armory-agent.{yml|yaml}`, and its location was moved from `/opt/spinnaker/config` to `/opt/armory/config`. The old config file is still used in case `armory-agent.{yml|yaml}` is not present, but users are encouraged to move to the new naming convention.
* Agent docker images are now published to `armory/agent-k8s` on dockerhub instead of `armory/kubesvc`.
