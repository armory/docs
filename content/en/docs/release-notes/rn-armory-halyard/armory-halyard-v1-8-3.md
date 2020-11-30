---
title: v1.8.3 Armory Halyard
version: 01.08.03
toc_hide: true
aliases:
  - armory-halyard_v1.8.3
---

## 04/02/2020 Release Notes

Armory-extended Halyard  1.8.3 is the minimum version required to deploy Armory 2.19+.

## Full Version
1.8.3-rc569 (OSS 1.32.0-214e5ba-stable548 build 569)

## Known Issues

### Plugins

When you try to deploy Spinnaker using Halyard 1.8.3, you encounter the following error:

```
Validation in Global:
! ERROR Could not translate your halconfig: Unrecognized field
  "plugins" (class
```

**Workaround**

Remove the top level key for Plugins in your Halconfig.

### Secrets

Secrets are stored decrypted at rest in the Pods of the Spinnaker services.

**Workaround**
Upgrade to Armory-extended Halyard 1.9.0 or later.


## Armory-extended Halyard
 No Changes

## Halyard Community Contributions
- fix(stats): New stats command only available in Armory 2.19+ (OSS 1.19+) (#1569)
- feat(stats): Rename telemetry to stats, enable by default (#1565)
- chore(containers): Upgrade the bundled tools (#1568)
- chore(dependencies): upgrade commons-collections  version (#1545)
- feat(codebuild): Add support for static credentials (#1554)
- feat(plugins): lays down plugin-manifest for Deck (#1539)
- feat(kubernetes): prepare for upcoming removal of V1 provider (#1549)
- fix(gate): apply the JVM flags to gate (#1547)
- feat(telemetry): add ability to report deploy method (#1543)
- feat(features): add support for Cloud Formation (#1493)
