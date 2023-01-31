---
title: v0.9.35 Armory Agent Clouddriver Plugin (2022-02-02)
toc_hide: true
version: 00.09.35
date: 2022-02-02
---

## Changes

> This change requires Agent Service version 1.0.6 or later.

The Agent now has a default grace period of 30 seconds for the Delete Manifest stage. Previously, if you did not specify a grace period in the UI, the default was 0. The Agent waits for up to the configured grace period (or the 30 second default if omitted) for the Delete Manifest stage to complete.
