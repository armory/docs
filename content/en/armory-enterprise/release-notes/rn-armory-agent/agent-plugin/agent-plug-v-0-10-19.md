---
title: v0.10.19 Armory Agent Clouddriver Plugin (2022-02-02)
toc_hide: true
version: 00.10.19

---

Fix the default value for gracePeriod while deleting operation is perform.

Before this change when didn't specify a value for gracePeriod on spinnaker ui, the default value will be 0 seconds, because of that the agent will not wait for the deletion to be completed.
With this change if the gracePeriod is not specified on spinnaker ui the agent will not send this data to kubernetes while deleting  the resource and will wait for the deletion to be completed.

NOTE: This change will only have effect with agent versions greater than 1.0.6
