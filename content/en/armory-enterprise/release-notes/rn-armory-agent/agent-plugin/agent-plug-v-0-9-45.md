---
title: v0.9.45 Armory Agent Clouddriver Plugin (2022-03-25)
toc_hide: true
version: 00.09.45

---

### Changes

* Namespaces and CustomResourceDefinitions were added to the default list of kinds to watch. This information is needed to correctly populate some parts of the Spinnaker UI when configuring pipelines.

* Available CRDs are now shown in dropdowns listing cluster kinds in Spinnaker UI, for example in "Delete (Manifest)" stage configuration.

### Known Issues

* `/credentials` endpoint hits the database twice per account. When having a large number of accounts this can become an issue.
