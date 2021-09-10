---
title: v0.6.0 Armory Agent Service (2021-09-10)
toc_hide: true
version: 00.06.00

---

## Breaking changes
* The configuration file used by agent was renamed from  to , and its location was moved from  to . The old config file is still used in case  is not present, but users are encouraged to move to the new naming convention.
* Agent docker images are now published to  on dockerhub instead of .
