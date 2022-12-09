---
title: v0.6.9 Armory Agent Service (2021-11-19)
toc_hide: true
version: 00.06.09
date: 2021-11-19
---

Fixes `clouddriver.keepAliveHeartbeatSeconds` property:

1. Not set: by default the keep alive message is sent every 60 seconds.
1. Set to 0: the keep alive message is not sent.
1. Any `n` value greater than 0: the message is sent every `n` seconds.

