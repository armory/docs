---

title: v1.0.3 Armory Operator
toc_hide: true
---

# 08/03/2020 Release Notes

### Known Issues
No known issues

## Armory Operator

- fix: a long time bug in `FreeForm` is also fixed. It was causing transformers that attempts to modify the config (or profiles) in memory to also leak the change into the operator's informer cache.
- fix: Validation webhook now patches the status. We cannot return the patches directly because we're changing the status. That should fix some validation errors trying to apply a new `SpinnakerService`
- fix: Validation service has ports named for Istio support
- fix: Crash when using `SpinnakerAccount` with sharded services ("HA mode")
- fix: Make kustomization.yml more compatible
