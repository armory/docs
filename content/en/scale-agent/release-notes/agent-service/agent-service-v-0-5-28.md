---
title: v0.5.28 Armory Agent Service (2021-09-30)
toc_hide: true
version: 00.05.28

---

## Known Issues

{{< include "release-notes/agent/ki-permissions-whitespace.md" >}}

## Fixes

- Resolve resource mapping for non discovered kinds during agent startup. This allows operations to complete even if there is a failure when reading a specific kind during startup as long as the agent has permissions to read it.
