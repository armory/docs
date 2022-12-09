---
title: v1.0.5 Armory Agent Service (2022-02-01)
toc_hide: true
version: 01.00.05
date: 2022-02-01
---

### Fixes
* Fix for a concurrency issue in which Agent sometimes took about 10 minutes to register with Clouddriver after Clouddriver restarted. This led to timeout errors when running pipelines during that timeframe.
