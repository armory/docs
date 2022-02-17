---
title: v0.8.48 Armory Agent Clouddriver Plugin (2022-02-17)
toc_hide: true
version: 00.08.48

---

### New features

Agent no longer needs redis. Communication between clouddrivers can now be through direct HTTP requests instead of using the redis pubusb, the plugin will watch changes to the kubernetes kind  where clouddriver pods are running, in order to know the IP address of each clouddriver replica.

**Prerequisites**
Clouddriver pods need to mount a service account with permissions to  and  the kubernetes kind  in their current namespace.

**Configuration**
This is an opt-in change and can be enabled by changing in  file this config:



To this config:



These are the full configuration options:


**Troubleshooting**
A new REST endpoint is available in clouddriver, which indicates all the discovered clouddriver pods, their IP addressess and status (ready/not ready):

