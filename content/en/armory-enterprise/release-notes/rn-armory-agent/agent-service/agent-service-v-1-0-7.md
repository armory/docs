---
title: v1.0.7 Armory Agent Service (2022-02-02)
toc_hide: true
version: 01.00.07

---

Add the capability of wait for the delation of a resource.

Before this change when a delete operation was attended by the agent, it will not wait for the resource to be deleted, instead of it it will just send the delete operation to kubernetes and return immediately.
With this change depending on the received delete options, the agent will decide if wait or not for the resource to be delete completed.
For example : 
When specify a gracePeriod of 0, or if the account don't has permissions to create a watcher over the resource to be deleted. The agent will return immediately 
When specify a gracePeriod greater than 0 lets call n, agent will wait a maximum of n seconds to the resource be deleted
When the gracePeriod is not specified, agent will wait a maximum of 30 seconds to the resource be deleted

