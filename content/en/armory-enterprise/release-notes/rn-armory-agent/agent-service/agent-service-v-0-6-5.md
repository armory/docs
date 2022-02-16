---
title: v0.6.5 Armory Agent Service (2021-09-30)
toc_hide: true
version: 00.06.05

---

## Known Issues

{{< include "release-notes/agent/ki-permissions-whitespace.md" >}}

## Fixes

- Resolve resource mapping for non discovered kinds during agent startup. This allows operations to complete even if there is a failure when reading a specific kind during startup as long as the agent has permissions to read it.
