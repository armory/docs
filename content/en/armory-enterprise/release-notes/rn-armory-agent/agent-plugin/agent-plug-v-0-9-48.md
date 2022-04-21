---
title: v0.9.48 Armory Agent Clouddriver Plugin (2022-04-21)
toc_hide: true
version: 00.09.48

---

### Changes

* Performance improvement: The plugin doesn't make requests to fiat to refresh fiat credentials cache anymore, because that process is resource intensive. As a side effect, every time agent accounts are added they may not be immediately available for usage until fiat refreshes itself (by default every 10 minutes), resulting in transient "Access denied" errors. The fiat refresh that was removed was introduced in version 0.9.37.

* Performance improvement: Calls to clouddriver "/credentials" endpoint don’t do live db queries anymore, they only read from in-memory cache. As a side effect, every time agent accounts are added they may not be immediately available for usage until the in-memory cache is refreshed (by default every 30 seconds), resulting in transient "account not found" errors.

* UI dropdowns displaying available kubernetes kinds don't include CRDs anymore. Including CRDs negatively impacted the performance of clouddriver because they resulted in as many queries to db as accounts are defined.

