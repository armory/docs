---
title: Notification Config
weight: 2
description: >
  This page describes `spec.spinnakerConfig.config.notifications`.
aliases:
  - /operator_reference/notification/
---

**spec.spinnakerConfig.config.notifications**

```yaml
notifications:
  slack:
    enabled:
    botName:
    token:
    baseUrl:
    forceUseIncomingWebhook:
  twilio:
    enabled:
    account:
    baseUrl:
    from:
    token:
  github-status:
    enabled:
    token:
    enabled:
```

## Slack parameters

- `enabled`: true or false.
- `botName`: The name of your Slack bot.
- `token`: Your Slack bot token. Supports encrypted value.
- `baseUrl`: Slack endpoint. Optional, only set if using a compatible API.
- `forceUseIncomingWebhook`: true or false. Force usage of incoming webhooks endpoint for Slack. Optional, only set if using a compatible API.

## Twilio parameters

- `enabled`: true or false.
- `account`: Your Twilio account SID.
- `baseUrl`: Twilio REST API base url
- `from`: The phone number from which the SMS will be sent (e.g. +1234-567-8910).
- `token`: Your Twilio auth token. Supports encrypted value.

## GitHub status parameters

- `enabled`: true or false.
- `token`: Your GitHub account token. Supports encrypted value.
