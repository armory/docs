---
title: v2.17.5 Armory Release (OSS Release 1.17.6)
toc_hide: true
date: 2020-02-01
version: 02.17.05
description: Release notes for Armory Enterprise v2.17.5
aliases:
  - armoryspinnaker_v2.17.5
---

## 02/01/20 Release Notes


> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

## Known Issues

There are currently no known issues with this release.

## Highlighted Updates

### Armory
This release includes the following:

- TLS and mTLS support added to Terraformer and Dinghy clients
- Additional improvements to the Terraformer UI/UX
- Elimination of a large number of CVEs across the individual services

| CVE | Affected service(s) |
|-------------------|------------------------------------------------------------------------------------------|------------------------------------------------|
| CVE-2017-18342 | Clouddriver |
| CVE-2019-12900 | Clouddriver, Echo, Fiat, Front50, Gate, Kayenta, Monitoring-daemon, Orca |
| CVE-2019-17267 | Clouddriver, Echo, Fiat, Front50, Gate, Kayenta, Orca |
| CVE-2019-16335 | Clouddriver, Echo, Fiat, Front50, Gate, Kayenta, Orca  |
| CVE-2019-14540 | Clouddriver, Echo, Fiat, Front50, Gate, Kayenta, Orca  |
| CVE-2019-14697 | Clouddriver, Echo Fiat, Front50, Gate, Kayenta, Monitoring-daemon, Orca |
| CVE-2019-16942 | Clouddriver, Echo, Fiat, Front50, Gate, Kayenta, Orca  |
| CVE-2019-17531 | Clouddriver, Echo, Fiat, Front50, Gate, Kayenta, Orca  |
| CVE-2018-1000654 | Clouddriver, Echo, Fiat, Front50, Gate, Kayenta, Orca  |
| CVE-2018-20843 | Monitoring-daemon |
| CVE-2018-14599 | Monitoring-daemon |
| CVE-2018-14600 | Monitoring-daemon |
| CVE-2018-14550 | Monitoring-daemon |
| CVE-2019-10202 | Gate |

###  Spinnaker Community Contributions

No changes to report.

<br>

## Detailed Updates

### Bill of Materials
Here's the bom for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.17.5-rc4012
timestamp: "2020-01-31 22:34:06"
services:
  clouddriver:
    version: 6.4.4-09a60e8-5f272cd-rc1069
  deck:
    version: 2.13.4-d5d7828-75cecc4-rc254
  dinghy:
    version: 0.0.4-bb15163-rc2012
  echo:
    version: 2.9.1-787cde5-771a15b-rc593
  fiat:
    version: 1.8.3-cb77e1e-c62d038-rc1069
  front50:
    version: 0.20.1-9c0b294-9415a44-rc1066
  gate:
    version: 1.13.0-250616f-a453541-rc2208
  igor:
    version: 1.7.0-54d7797-37fe1ed-rc912
  kayenta:
    version: 0.12.0-0085ac5-5dcec80-rc822
  monitoring-daemon:
    version: 0.16.0-cbc7624-rc2
  monitoring-third-party:
    version: 0.16.0-cbc7624-rc2
  orca:
    version: 2.11.2-25ef38f-b88f62a-rc953
  rosco:
    version: 0.15.1-33810a8-269dc83-rc905
  terraformer:
    version: 0.0.2-b6cdbbf-rc20
dependencies:
  redis:
    version: 2:2.8.4-2
artifactSources:
  dockerRegistry: docker.io/armory</code>
</pre>
</details>



### Armory
#### Dinghy&trade; - 0f8317f...bb15163
- feat(tls): Allow CA file, client cert options, go-yaml-tools bump (#192)

#### Terraformer&trade; - 26397ae...b6cdbbf
 - feat(command): add detailed-exitcode to plan (#113)
 - feat(tls): Allow CA file, client cert options, go-yaml-tools bump (#112)
 - fix(logs): adjust logic used for appending logs and persisting (#111)
 - feat(logs): add combined logs output (#109)

#### Armory Clouddriver  - 37fca53...09a60e8
 - chore(vulnerabilities): resolve CVEs and other security issues (#50)

#### Armory Deck  - 93a8f76...d5d7828
 - fix(terraformer): update ui for stages to use combined logs from... (#566)
 - fix(terraformer): add workspace field (#565)

#### Armory Echo  - c413c8a...787cde5
 - chore(vulnerabilities): resolve CVEs and other security issues (#120)

#### Armory Fiat  - 940de73...cb77e1e
 - chore(vulnerabilities): resolve CVEs and other security issues (#33)

#### Armory Front50  - ce3824b...9c0b294
 - chore(vulnerabilities): resolve CVEs and other security issues (#29)

#### Armory Gate  - a14ec61...250616f
 - chore(vulnerabilities): resolve CVEs and other security issues (#85)

#### Armory Igor  - 182a383...54d7797
 - chore(vulnerabilities): resolve CVEs and other security issues (#40)

#### Armory Kayenta  - d49aed7...0085ac5
 - chore(vulnerabilities): resolve CVEs and other security issues (#45)

#### Armory Orca  - a6e8420...25ef38f
 - chore(vulnerabilities): resolve CVEs and other security issues (#62)

#### Armory Rosco  - 5ac82a7...33810a8
 - chore(vulnerabilities): resolve CVEs and other security issues (#30)


### Armory Open Core
#### Dinghy (Open Core) - 7dfd930...60cb2f5
 - feat(mTLS): Allow CA file, client cert options, go-yaml-tools bump (#77)

###  Spinnaker Community Contributions
See Spinnaker's release notes which are included in this release:

[Spinnaker 1.17.6](https://www.spinnaker.io/community/releases/versions/1-17-6-changelog#individual-service-changes)

#### Clouddriver  - 5f272cd
No Changes

#### Deck  - 75cecc4
No Changes

#### Echo  - 771a15b
No Changes

#### Fiat  - c62d038
No Changes

#### Front50  - 9415a44
No Changes

#### Gate  - a453541
No Changes

#### Igor  - 37fe1ed
No Changes

#### Kayenta  - 5dcec80
No Changes

#### Orca  - b88f62a
No Changes

#### Rosco  - 269dc83
No Changes
