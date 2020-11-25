---
title: v1.9.0 Armory Halyard
version: 01.09.00
toc_hide: true
aliases:
  - armory-halyard_v1.9.0
---

## 04/23/2020 Release Notes

This version is required to deploy Armory 2.19+.


## Known Issue

### Halyard version

There is a known issue where Armory-extended Halyard 1.9.0 fails to install Armory 2.18.1. The Pod for Echo enters a crash loop.

**Workaround**

Use Armory-extended Halyard  1.8.3 if you want to install Armory 2.18.1.

## Highlights

Armory's extended Halyard 1.9.0 resolves an issue where secrets are stored decrypted at rest in the Pods of the Spinnaker services.

##  Armory-extended Halyard
- fix(secrets): have services decrypt their own secrets
- chore(build): bump OSS Halyard to 1.34.0
- Changes to add enabled/disabled to webhooks validation
- feat(dinghy): Support for webhook secrets in dinghy
- feat(stats): Rename telemetry to stats props due to change in halyard
- chore(vulnerabilities): resolve CVEs and other security issues
- feat(telemetry): add ability to report deploy method to "echo" via telemetry



## Halyard Community Contributions
You can see the full changelog here: [version-1.32.0...version-1.34.0](https://github.com/spinnaker/halyard/compare/version-1.32.0...version-1.34.0)

- chore(java11): Compile with Java 11 (but targeting Java 8) (#1608)
- chore(containers): Make Dockerfiles work with buildtool's containers.yml (#1607)
- chore(mergify): autobump reviews should go to oss-approvers (#1606)
- chore(dependencies): Autobump spinnakerGradleVersion (#1605)
- chore(deps): bump internal spinnaker dependencies (#1604)
- chore(mergify): if an autobump fails, request a review (#1603)
- chore(build): enable the spinnaker project plugin (#1602)
- chore(build): upgrade spinnaker gradle plugin (#1601)
- fix(daemon): Don't try to kill daemon created by another user (#1600)
- chore(dependencies): Autobump korkVersion (#1599)
- fix(container): restore openssl to alpine image (#1596)
- feat(plugins): add plugins to all services (#1594)
- chore(dependencies): Autobump korkVersion (#1595)
- chore(dependencies): Autobump korkVersion (#1593)
- chore(dependencies): Autobump korkVersion (#1592)
- chore(dependencies): Autobump korkVersion (#1591)
- fix(plugins): Revert add plugins to all services (#1559) (#1590)
- chore(gha): don't run the GHA build when pushing to a fork (#1589)
- chore(dependencies): Autobump korkVersion (#1588)
- chore(dependencies): Autobump korkVersion (#1587)
- feat(plugins): add plugins to all services (#1559)
- fix(plugins): fix plugins-manifest.json  (#1564)
- chore(dependencies): Autobump korkVersion (#1586)
- (tag: version-1.33.0, upstream/release-1.33.x) chore(dependencies): Autobump korkVersion (#1585)
- chore(mergify): release-* branches require release manager approval (#1584)
- fix(config): Ignore any existing `plugins` stanzas. (#1583)
- Revert "chore(build): Remove init-publish script (#1579)" (#1580)
- chore(build): Remove init-publish script (#1579)
- feat(build): Remove TravisCI and replace with GitHub Actions (#1578)
- chore(dependencies): Autobump korkVersion (#1577)
- chore(dependencies): Autobump korkVersion (#1576)
- chore(dependencies): Autobump korkVersion (#1575)
- chore(dependencies): Autobump korkVersion (#1574)
- chore(dependencies): Autobump korkVersion (#1573)
- feat(k8s/deploy): Add custom health check to service-settings (#1572)
- chore(dependencies): Autobump korkVersion (#1571)
- chore(dependencies): Autobump korkVersion (#1570)
