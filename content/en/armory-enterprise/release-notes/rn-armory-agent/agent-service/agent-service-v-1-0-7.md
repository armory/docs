---
title: v1.0.7 Armory Agent Service (2022-02-02)
toc_hide: true
version: 01.00.07

---


## New feature

The Agent can now wait for the deletion of a resource. Based on the received delete options, the Agent decides if it will wait or not for the resource deletion to be completed.

Before this change, the Agent did not wait for a resource to be deleted when a delete operation was attended to by the Agent. Instead, it sent the delete operation to Kubernetes and returns immediately.

You configure the wait behavior with the `gracePeriod` parameter and providing a duration in seconds. (Default is 30 seconds if the parameter is omitted.)

If specify a `gracePeriod` of 0 or if the account doesn't have permissions to create a watcher over the resource getting deleted, the Agent returns immediately.

When specify a `gracePeriod` greater than 0, the Agent waits up to the configured number of seconds for the resource be deleted.

