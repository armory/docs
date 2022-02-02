---
title: v1.0.7 Armory Agent Service (2022-02-02)
toc_hide: true
version: 01.00.07

---


## New feature

> This feature requires Agent Plugin 0.10.19/0.9.35/0.8.43 or later.

The Agent can now wait for the deletion of a resource. You configure the wait behavior with the `gracePeriod` parameter and providing a duration in seconds. (Default is 30 seconds if the parameter is omitted.) When you specify a `gracePeriod` greater than 0, the Agent waits up to the configured number of seconds for the resource be deleted.

If specify a `gracePeriod` of 0 or if the account doesn't have permissions to create a watcher over the resource getting deleted, the Agent returns immediately.

Before this change, the Agent did not wait for a resource to be deleted when a delete operation was attended to by the Agent. Instead, it sent the delete operation to Kubernetes and returns immediately.

