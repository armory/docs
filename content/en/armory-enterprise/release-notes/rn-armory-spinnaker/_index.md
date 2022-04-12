---
title: Armory Enterprise for Spinnaker Release Notes
linkTitle: Armory Enterprise Release Notes
aliases:
  - /releases/
  - /release/
  - /version/
  - /versions/
  - /release-notes/
layout: release-notes-recent
semver_list: true
description: >
  Armory Enterprise releases, long term stable releases and patches.
---

<!-- the release-notes-recent.html layout inserts the section index list at the top of the page -->



## Minimum Operator version

To install, upgrade, and configure Armory Enterprise, ensure that you are running at least the minimum Operator version for your release:

| Armory Enterprise version | Minimum Operator version |
| ----------------------- | ----------------------- |
| 2.27.x | 1.4.0 |
| 2.26.x | 1.2.6 |
| 2.25.x | 1.2.6 |

## LTS releases

Starting with version 2.27.1, Armory Enterprise follows a Long Term Stable (LTS) release model where there are two LTS releases per year. Major features and changes are packaged into an LTS release.

Each LTS is supported for 1 year from its release date. During the supported lifetime of an LTS release, Armory ships patch releases for the LTS that include improvements like CVE remediation, bug fixes, and performance improvements.

<!--

## Different Armory Enterprise Release Types

Armory Enterprise is based off open source Spinnaker's [release cadence](https://www.spinnaker.io/community/releases/release-cadence), in which we extend Spinnaker features. We provide a few different release types.

| Release Type | Description                                       |
| ------------ | ------------------------------------------------- |
| `stable`     | Stable release for use in production environments |
| `rc`         | Latest Armory Enterprise + Spinnaker release candidates            |
| `ossedge`    | Spinnaker nightly builds (_untested_)                   |
| `edge`       | Armory Enterprise nightly + Spinnaker nightly builds (_untested_)  |


## Understanding Armory Enterprise and open source Spinnaker releases
### Stable Releases
>Note: Open source Spinnaker is abbreviated as OSS

```yml
$ hal version list
...
 - 2.2.0 (Spinnaker Release 1.11.9):
   Changelog: https://docs.armory.io/release-notes/armoryspinnaker_v2.2.0/
   Published: Mon Feb 25 04:58:47 GMT 2019
   (Requires Halyard >= 1.2.0)
 - 2.3.0 (Spinnaker Release 1.12.x):
   Changelog: https://docs.armory.io/release-notes/armoryspinnaker_v2.3.0/
   Published: Thu Mar 28 03:44:19 GMT 2019
   (Requires Halyard >= 1.2.0)
```
**Stable** releases have been tested by Armory. Most of our customers will be using them.

We use [semantic versioning](https://semver.org/) for tagging, e.g. `12.3.4`.
- MAJOR versions correspond to any major Armory platform changes or breaking open source changes.
- MINOR versions correspond to a new open source release branch.
- PATCH versions are reserved for minor changes in the same open source branch.

| Armory Enterprise Release | Spinnaker Release Branch |
| -------------- | -----------        |
| 2.1.x          | 1.10.x             |
| 2.2.x          | 1.11.x             |
| 2.3.x          | 1.12.x             |
| 2.4.x          | 1.13.x             |
| 2.5.x          | 1.14.x             |
| 2.15.x         | 1.15.x             |
| 2.16.x         | 1.16.x             |
| 2.17.x         | 1.17.x             |
| 2.18.x         | 1.18.x             |
| 2.19.x         | 1.19.x             |


### RC Releases
```yml
$ hal version list --release=rc
...
 - 2.2.1-rc463 (2.2.1 Release Candidate):
   Changelog: https://docs.armory.io/release-notes/armoryspinnaker_v2.2.1/
   Published: Mon Apr 01 16:53:32 GMT 2019
   (Requires Halyard >= 1.2.0)
 - 2.3.1-rc40 (2.3.1 Release Candidate):
   Changelog: https://docs.armory.io/release-notes/armoryspinnaker_v2.3.1/
   Published: Mon Apr 01 16:53:33 GMT 2019
   (Requires Halyard >= 1.2.0)
```
An **rc** release reflects the latest from Armory Enterprise and Spinnaker release branches.
- These versions are used internally at Armory.
- A few customers may be using it, but we do not recommend using it in production.

<!--
- A **next rc** will be created from Spinnaker `1.10.*`
  + This version has not been tested at Armory, only built and served.
  + A few customers may be using it, but we do not recommend using it in production.


**RC**s also follow semantic versioning with the format like `1.2.3-rc202`.


### Spinnaker Edge Releases
```yml
$ hal version list --release=ossedge
...
 - 2019.04.03-ossedge2143 (OSS Edge release):
   Changelog: https://docs.armory.io/release-notes
   Published: Wed Apr 03 18:34:18 GMT 2019
   (Requires Halyard >= 1.2.0)
```
An **ossedge** release is created from Spinnaker `master`.
- This version has not been tested at Armory, only built and served.
- This is mainly being used for development work by our customers and **should not be** used in production or any critical workloads.

Armory uses dates and build numbers for their versions. e.g.:
- `2019.04.03-ossedge2143`
- `2019.04.02-ossedge2142`
- `2019.04.01-ossedge2141`
- (Weekend! 🎉💃)
- `2019.03.29-ossedge2140`
- `2019.03.28-ossedge2139`
- `2019.03.27-ossedge2138`
- ...

### Edge Releases
```yml
bash-4.4$ hal version list --release=edge
....
 - 2018.11.01-edge1031 (Edge release):
   Changelog: https://docs.armory.io/release-notes
   Published: Thu Nov 01 20:10:29 GMT 2018
```
An **edge** release is created from Spinnaker `master` and Armory `master`.
- These aren't actively maintained, but can be built when a customer has need for it.
- This is mainly being used for development work by our customers and **should not be** used in production or any critical workloads.

## Selecting a version to install
```yml
$ hal config version edit --version 2.3.0
```
See [Halyard reference](https://www.spinnaker.io/reference/halyard/commands/#hal-config-version-edit) for additional information.

-->
