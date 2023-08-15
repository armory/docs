---
title: v1.0.61 Armory Agent Service (2023-08-15)
toc_hide: true
version: 01.00.61
date: 2023-08-15
---

Feature
* Updated admin endpoint `:8082/accounts` with filters and pagination
* Current filters uses query params:
  * `Config.Name`
  * `Config.Dynamic`  = `true` | `false
  * `State.Name` = `DiscoveryError` | `Healthy` | `ConfigLoaded`
* Pagination uses query string params `limit` `offtset`
