---
title: v0.6.6 Armory Agent Service (2021-10-07)
toc_hide: true
version: 00.06.06

---

## Known Issues

{{< include "release-notes/agent/ki-permissions-whitespace.md" >}}

## Fixes
*  Resolved an issue that occurred when watching Kubernetes kinds. The Agent now checks for both `list` and `watch` permissions. Previously, the Agent only checked for `list` permission, which resulted in errors like the following not being filtered out: `Failed to watch *unstructured.Unstructured: unknown`.
