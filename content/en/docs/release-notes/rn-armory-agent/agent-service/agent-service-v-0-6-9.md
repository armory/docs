---
title: v0.6.9 Armory Agent Service (2021-11-19)
toc_hide: true
version: 00.06.09

---

Add grpc keep alive message, configurable by  property;
1. When it  is not set then by default keep alive message will be send every 60 seconds
2. When it is set to 0 keep alive message will be not send
3. Any value greater than 0 (lets call it n) the message will be send every n seconds

