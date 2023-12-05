---
title: Armory Continuous Deployment Release Notes
linkTitle: Armory CD Release Notes
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

<!-- the release-notes-recent.html layout inserts the section index list at the top of the page -->



## Minimum Operator version

To install, upgrade, and configure Armory Continuous Deployment (Armory CD), ensure that you are running at least the minimum Operator version for your release:

| Armory CD version | Minimum Operator version |
| ----------------- | ------------------------ |
| 2.30.x            | 1.8.6                    |
| 2.28.x            | 1.6.0                    |
| 2.27.x            | 1.4.0                    |


## LTS releases

Starting with version 2.27.1, Armory CD follows a Long Term Support (LTS) release model with two LTS releases per year. Significant features and changes are packaged into an LTS release.

Armory supports the three (3) most recent major LTS releases. During the supported lifetime of an LTS release, Armory ships minor releases for the LTS that include improvements such as CVE remediation, bug fixes, and performance improvements. Non-breaking features or enhancements may also be included and will typically be placed behind a feature flag.

## Feature releases

Starting with version 2.31.0 Armory CD is introducing feature releases which are an additional type of major release that will complement LTS releases. Feature releases will be released in between the two major LTS releases each year and will have a shortened support window of 6 months.

Feature releases will

* Enable Armory customer to test and consume Armory & OSS features faster
* Improve the quality and stability of LTS releases by having changes pre-tested and validated ahead of time within the feature releases

LTS releases will continue to go out roughly every 6 months with one or two feature releases also going out between them.