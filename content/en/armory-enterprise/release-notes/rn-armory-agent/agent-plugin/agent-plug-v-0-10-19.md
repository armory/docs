---
title: v0.10.19 Armory Agent Clouddriver Plugin (2022-02-02)
toc_hide: true
version: 00.10.19

---

## Improvements

> This change requires Agent Service version 1.0.6 or later.

The Agent now has a default grace period of 30 seconds for when Kubernetes resources are deleted. Previously, if you did not specify a grace period in the UI, the default was 0. The Agent now waits for the resource to be deleted before returning or up to the configured grace period.

Before this change, the default value was 0 seconds, and the Agent did not wait for the deletion to be completed.

