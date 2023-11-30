---
title: Cache Agents On Event Plugin Release Notes
linkTitle: Release Notes
weight: 99
description: >
  Cache Agents On Event for Spinnaker release notes.
---

## v0.2.1 2023/11/28

### Fixed
- Resolved bug relative to retrofit dependency on unhandled messages for JSON responses causing internal exceptions.

## v0.1.0 2022/11/30
### Fixes
- Excluded aws notify endpoint spinnaker crash when plugin is configured but provider not.

- Removes unnecessary code related with AWSCredentialsProvider

- Changed using WebSecurity instead of HttpSecurity
### Features
- Initial release

## Known issues
- If provider infa is not correctly configured, and sns topic confirmed, Gate Enpdpoint will not receive messages.

- When Spinnaker is configured with Authentication (ie SAML or Oauth2) the Gate endpoint is not excluded from the Spring Security filters - The notifications are not delivered

**Fix**: Deploy a dedicated Gate replicaset without authentication enabled. Only expose the /aws/notify endpoint

{{< include "plugins/cats/armory-header-plugin.md" >}}