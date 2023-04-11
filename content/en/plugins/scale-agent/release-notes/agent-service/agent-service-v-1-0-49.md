---
title: v1.0.49 Armory Agent Service (2023-03-21)
toc_hide: true
version: 01.00.49
---

### Feature
- Added capability to print logs into console and a file simultaneously.
- When saving to file, log rotation is enabled and is adjusted with the settings:
```
logging:
  multiWrite: true
  file: /home/armory/scale-agent.log
  maxSizeMb:  1
  maxAgeDays: 10
  maxBackups: 10
  localTime:  true
  compress:   true  
  ```