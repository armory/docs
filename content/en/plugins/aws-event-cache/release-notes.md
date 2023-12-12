---
title:  AWS Event Cache Plugin Release Notes
linkTitle: Release Notes
weight: 99
description: >
   AWS Event Cache Plugin for Spinnaker release notes.
---

## v0.2.1 2023/11/28

### Fixed

- Resolved bug relative to retrofit dependency on unhandled messages for JSON responses causing internal exceptions.

## v0.1.0 2022/11/30

- Excluded AWS notify endpoint Spinnaker crash when plugin is configured but provider is not.

- Removes unnecessary code related with AWSCredentialsProvider

- Changed using WebSecurity instead of HttpSecurity

### Features

- Initial release

## Known issues

- If provider infra is not correctly configured, and SNS topic confirmed, the Gate endpoint does not receive messages.
