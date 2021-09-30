---
title: v0.6.5 Armory Agent Service (2021-09-30)
toc_hide: true
version: 00.06.05

---

### New

- Resolve resource mapping for non discovered kinds during agent startup, this allows operations to complete even if there was a failure when reading a specific kind during startup provided the agent has permissions to read it.
