---
title: v1.0.3 Armory Operator
toc_hide: true
version: 01.00.03
---

## 08/03/2020 Release Notes

## Known Issues
No known issues.

## Armory Operator

* Fixed a bug in `FreeForm`. It caused transformers that attempt to modify the config (or profiles) in memory to  leak the change into the operator's informer cache.
* Validation webhooks now patch the status. Operator cannot return the patches directly because we're changing the status. This resolves some validation errors when trying to apply a new `SpinnakerService`.
* Validation service has ports named for Istio support
* Fixed an issue that caused crashes when using `SpinnakerAccount` with sharded services ("HA mode").
* Made `kustomization.yml` more compatible.
