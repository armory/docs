---
title: v1.0.7 Armory Agent Service (2022-02-02)
toc_hide: true
version: 01.00.07

---


## Improvements

> This feature requires Agent Plugin 0.10.19/0.9.35/0.8.43 or later.

The Agent Service now waits for Kubernetes to report the deletion of a Kubernetes object before returning.

Before this change, the Agent did not wait for a resource to be deleted. Instead, it sent the delete operation to Kubernetes and returned immediately. This led to pipeline failures.

