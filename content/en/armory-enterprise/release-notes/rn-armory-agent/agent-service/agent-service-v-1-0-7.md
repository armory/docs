---
title: v1.0.7 Armory Agent Service (2022-02-02)
toc_hide: true
version: 01.00.07

---

Add the capability of wait for the deletion of a resource.

Before this change when a delete operation was attended by the agent, it would not wait for the resource to be deleted, instead of it it would just send the delete operation to kubernetes and return immediately.
With this change depending on the received delete options, the agent will decide to wait or not for the resource deletion to complete.
For example : 
When specifying a gracePeriod of 0, or if the account doesn't have permissions to create a watcher over the resource to be deleted, the agent will return immediately 
When specify a gracePeriod greater than 0 lets call n, agent will wait a maximum of n seconds for the resource be deleted
When the gracePeriod is not specified, agent will wait a maximum of 30 seconds to the resource be deleted

