---
title: Armory-extended Halyard Deprecation
linkTitle: Halyard Deprecation
description: Armory will be discontinuing support for Halyard. This article explains why Armory is doing this and how it impacts your company.
toc_hide: true
hidden: true
exclude_search: true
---

## What does this mean?

On 2021 Sept 01, Armory-extended Halyard, Armory's proprietary extension of Halyard, will be deprecated with an and End of Support date of 2021 Dec 30. This means that after 2021 Sept 01, no new development is done specific to the feature except for critical (P0/1) bugs and security CVE fixes. Support for critical (P0/1) bugs and security CVE fixes will end on 2021 Dec 30.

Additionally, releases after 2.26 require you to use the Armory Operator. Any current workflows that use Armory-extended Halyard may break
if you try to upgrade to a release that is later than 2.26. We encourage all Armory-extended Halyard users to [migrate to the Armory Operator]({{< ref "hal-op-migration.md" >}}), the only supported method of installing and configuring Armory’s products beyond the 2.26 release.

## Why is Armory removing support?

The Armory Operator has a superset of the functionality provided by
Armory-extended Halyard, including a more native Kubernetes installation experience. In an
effort to create the best possible installation experience, we are
consolidating supported installation tools to only the Armory Operator.
Focusing on a single installation experience allows us to develop requested
features at a faster pace.

We understand that this decision may be disruptive to you, so we are giving as much
advance notice as possible.  For more information about how Armory handles
feature and technology deprecation, please see
[Feature Deprecations & End of Support]({{> ref "deprecations" >}}).

## Am I affected?

If your company currently uses Armory-extended Halyard, then yes. You can still access Armory-extended Halyard
until 2021 Dec 30; however, Armory is unable to support issues solely related to Armory-extended Halyard you may experience after 2021 Sept 01.

## What do I need to do?

To assure the best user-experience possible, we recommend migrating to the Armory Operator.

The {{< linkWithTitle "hal-op-migration" >}} contains instructions for migrating to the Operator.

 ## What happens if I don't act in time?

As mentioned above, if your company uses Armory-extended Halyard, you will not be able to install any releases beyond 2.26 unless you migrate to the Armory Operator. Additionally, after 2021 Dec 30, Armory cannot guarantee the availability of Armory-extended Halyard.

## Who should I contact if I have questions or need further assistance?

For customers who have an assigned Technical Account Manager and/or Account Executive, they are your first and best resource. For others, you can reach our Customer Care team at [support@armory.io](mailto:support@armory.io) or visit the [Help Center](https://support.armory.io/) to submit a case.
