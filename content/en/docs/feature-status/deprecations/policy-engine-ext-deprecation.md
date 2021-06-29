---
title: Policy Engine Extension Deprecation
description: Armory will be discontinuing support for the Policy Engine Extension. Instead, use the Policy Engine Plugin. This article explains why Armory is doing this and how it impacts your company.
toc_hide: true
hidden: true
exclude_search: true
---

## What does this mean?

On 2021/06/21,  Policy Engine Extension will be deprecated with an End of Support date of 2021/09/31. This means that after 2021/06/21, no new development is done specific to the feature except for critical (P0/1) bugs and security CVE fixes. Support for critical (P0/1) bugs and security CVE fixes will end on 2021/09/31. The final Armory Enterprise release that includes the Policy Engine Extension is 2.26.

## Why is Armory removing support?

Technology and customer needs change quickly, and we understand that this decision impacts your business. Armory is removing support for the Policy Engine Extension because the Policy Engine Plugin is now GA. The plugin version of the Policy Engine includes new features that are not supported by the extension project.

We understand that this decision may be disruptive to you, so we are giving as much advance notice as possible. For more information about how Armory handles feature and technology deprecation, please see [https://docs.armory.io/deprecations](https://docs.armory.io/deprecations).

## Am I affected?

If your company currently uses the Policy Engine Extension, then yes. As mentioned above, you can still access the Policy Engine Extension in releases up to 2.26 and expect the outlined level of support as described in the [What does this mean?](#what-does-this-mean) section. After 2021/09/31 however, Armory is unable to support any issues solely related to PaCRD that you may experience.

## What do I need to do?

To assure the best user-experience possible, we recommend [migrating to the Policy Engine Plugin]({{< ref "policy-engine-enable#migrating-to-the-policy-engine-plugin" >}}). 

 ## What happens if I don't act in time?

If your company uses Policy Engine Extension, it will no longer be included as part of Armory Enterprise releases after 2.26. Any workflows that utilize the Policy Engine Extension may break when you upgrade Armory Enterprise to a release after 2.26.
 
## Who should I contact if I have questions or need further assistance?

For customers who have an assigned Technical Account Manager and/or Account Executive, they are your first and best resource. For others you can reach our Customer Care team at [support@armory.io](mailto:support@armory.io) or visit the [Help Center](https://support.armory.io/) to submit a case.
