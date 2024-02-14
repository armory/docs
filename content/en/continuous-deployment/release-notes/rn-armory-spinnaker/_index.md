---
title: Armory Continuous Deployment Release Notes
linkTitle: Armory CD Release Notes
weight: 1
aliases:
  - /releases/
  - /release/
  - /version/
  - /versions/
  - /release-notes/
layout: release-notes-recent
semver_list: true
description: >
  Armory Continuous Deployment releases, long term support releases, and patches.
---

<!-- partials/list-release-notes-recent.html layout inserts the section index list at the top of the page -->



## Minimum Armory Operator version

To install, upgrade, and configure Armory Continuous Deployment (Armory CD), ensure that you are running at least the minimum Operator version for your release:

| Armory CD version | Minimum Operator version |
|-------------------| ------------------------ |
| 2.32.x            | 1.8.6                    |
| 2.30.x            | 1.8.6                    |
| 2.28.x            | 1.6.0                    |
| 2.27.x            | 1.4.0                    |


## LTS releases

Starting with version 2.27.1, Armory CD follows a Long Term Support (LTS) release model with two LTS releases per year. An LTS release contains significant features and changes.

Armory supports the three (3) most recent LTS releases. 

During the supported lifetime of an LTS release, Armory ships _Feature_ releases for the LTS. 

## Feature releases

Starting with version 2.31.0, Armory is introducing a _Feature_ release, which is an additional type of major release that complements an LTS release. Feature releases may contain bug fixes, performance improvements, CVE remediation, and non-breaking features or enhancements placed behind a feature flag.

Feature releases do the following:

* Enable customers to test and consume Armory CD and open source Spinnaker features faster
* Improve the quality and stability of LTS releases by having changes tested and validated within the Feature releases

Armory releases an LTS version approximately every 6 months, with one or two Feature releases between LTS releases. Feature releases have a shortened support window of 6 months.