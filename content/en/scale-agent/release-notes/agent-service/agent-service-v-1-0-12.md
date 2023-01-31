---
title: v1.0.12 Armory Agent Service (2022-02-17)
toc_hide: true
version: 01.00.12
date: 2022-02-17
---

## Fixes

- Fixed a nil pointer exception condition that caused the Armory Agent to crash in certain conditions.

## Improvements

- Agent now identifies and uses a preferred resource mapping for the provided manifest version on a Deploy Manifest stage. This helps prevent mismatch errors between versions of a deployed manifest.

