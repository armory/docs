---
title: v0.8.53 Armory Agent Clouddriver Plugin (2022-03-25)
toc_hide: true
version: 00.08.53

---

### Changes

* Namespaces and CustomResourceDefinitions were added to the default list of kinds to watch. This information is needed to correctly populate some parts of the Spinnaker UI when configuring pipelines.

* Available CRDs are now shown in dropdowns listing cluster kinds in Spinnaker UI, for example in "Delete (Manifest)" stage configuration.

### Known Issues

* The plugin makes a request to fiat `/sync/roles` endpoint every time an agent connects or accounts are deleted. This can become an issue when having a large number of agents connected to a clouddriver pod that is restarted.
* Clouddriver `/credentials` endpoint hits the database twice per account. When having a large number of accounts this can become an issue.
