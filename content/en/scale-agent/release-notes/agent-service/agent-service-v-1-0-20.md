---
title: v1.0.20 Armory Agent Service (2022-04-08)
toc_hide: true
version: 01.00.20
date: 2022-04-08
---

{{% alert title="Known Issue" color="warning" %}}

* Sometimes during reconnections, agents don't register again with clouddriver. To avoid impacts to agent installations, this version was taken out of service.

{{% /alert %}}

### Changes

* Removed usage of native grpc keep alives in favor of existing agent specific keep alives, so there are not two different keep alive logics.


### Fixes

* Fixed an issue causing agent to reconnect several times to clouddriver during transient disconnections.
