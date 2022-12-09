---
title: Policy Engine Extension Deprecation
description: Armory will be discontinuing support for the Policy Engine Extension. Instead, use the Policy Engine Plugin. This article explains why Armory is doing this and how it impacts your company.
toc_hide: true
hidden: true
exclude_search: true
---

## What does this mean?

On 2021 June 21, Policy Engine Extension will be deprecated with an End of Support date of 2021 Sept 31. This means that after 2021 June 21, no new development will be done that is specific to the feature except for critical (P0/1) bugs and security CVE fixes. Support for critical (P0/1) bugs and security CVE fixes will end on 2021 Sept 31. Additionally, the last Armory Enterprise version that supports Policy Engine Extension is 2.26.x.

## Why is Armory removing support?

To better meet customer needs, we’ve released Policy Engine Plugin, which handles all Policy Engine Extension use cases and includes additional functionality. To stay focused on our customer needs, we do not intend to support both Policy Engine Plugin and Policy Engine Extension. Please [migrate to the Policy Engine Plugin]({{< ref "policy-engine-enable#migrating-to-the-policy-engine-plugin" >}}) to ensure uninterrupted support.

We understand that this decision may be disruptive to you, so we are giving as much advance notice as possible. For more information about how Armory handles feature and technology deprecation, please see [Deprecations]({{< ref "deprecations" >}}).

## Am I affected?

If your company currently uses Policy Engine Extension, then yes. As mentioned above, you can still access Policy Engine Extension until 2021 Sept 31 as part of Armory Enterprise releases. After 2021 Sept 31 however, Armory is unable to support any issues solely related to Policy Engine Extension.

## What do I need to do?

To assure the best user-experience possible, we recommend [migrating to the Policy Engine Plugin]({{< ref "policy-engine-enable#migrating-to-the-policy-engine-plugin" >}}).

 ## What happens if I don't act in time?

If your company uses Policy Engine Extension, it will no longer be guaranteed to function as part of Armory Enterprise releases after 2021 Sept 31, or for release versions newer than 2.26.x. Any workflows that utilize Policy Engine Extension may break when you upgrade Armory Enterprise to a new release after that date.

## Who should I contact if I have questions or need further assistance?

For customers who have an assigned Technical Account Manager and/or Account Executive, they are your first and best resource. For others you can reach our Customer Care team at [support@armory.io](mailto:support@armory.io) or visit the [Help Center](https://support.armory.io/) to submit a case.
