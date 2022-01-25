---
title: v0.8.40 Armory Agent Clouddriver Plugin (2022-01-21)
toc_hide: true
version: 00.08.40

---

## Fixes

* Fixed a race condition where accounts onboarded by the Agent were not available in Clouddriver. This occurred when an internal load balancing process ran exactly at the same time as the initial Agent registration.
* Redis errors like `ERR wrong number of arguments for 'subscribe' command` or `class java.util.ArrayList cannot be cast to class java.lang.Long` no longer appear. The Redis pools from Agent and the Redis scheduler have been separated.

## New features

There are two new Clouddriver REST endpoints:

* `/armory/agents` returns information about all registered agents, which accounts they have and to which clouddriver instance they are connected.
* `/armory/agent/operations/{opId}` returns details about which pods processed the operation in question and at which times.
