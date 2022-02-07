---
title: v1.0.8 Armory Agent Service (2022-02-05)
toc_hide: true
version: 01.00.08

---

## Fixes

* Fixed an issue that prevented CRDs from being listed when the `onlyNamespaceResources` parameter is set to `true`. You must provide an accurate definition of CRDs for the `customResourceDefinitions` parameter when `onlyNamespaceResources` is `true`. For example:

   ```yaml
   kind: CronTab.stable.example.com
   scope: Namespaced
   ```

   If scope is unspecified, it defaults to cluster.