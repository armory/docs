---
title: v0.10.10 Armory Agent Clouddriver Plugin (2021-12-29)
toc_hide: true
version: 00.10.10
---

Make Namespaces and CustomResourceDefinitions cacheable 
despite the use of `kubesvc.runtime.defaults.onlySpinnakerManaged` 
configuration set to true; in this way the Spinnaker UI could show the
information without matter of the value of that configuration.
