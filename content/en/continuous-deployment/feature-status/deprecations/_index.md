---
title: Feature Deprecations & End of Support
linkTitle: Deprecations
description: Updates on what features are deprecated, links to relevant information for that feature, and the deprecation timeline.
aliases:
  - /deprecations/
  - /docs/deprecations
no_list: true
---

## Overview

To continually improve the Armory customer experience, we will occasionally deprecate and end support for certain Armory features.  We understand these decisions can have very real implications for your business, so we will always be direct and honest with you about why a decision has been made and how it might affect you. Where possible, we will provide migration paths and suggestions for features that solve for the same use cases.

The following clarifies what we mean when a feature is deprecated or reaches end of support:

* **Deprecated**: when a feature enters the end of support cycle and no new development is done except for critical (P0/1) bugs and security CVE fixes specific to the feature.

* **End of Support**: when a feature is no longer available for customer or technical support, including critical (P0/1) bugs and security CVE fixes specific to the feature.   

| Feature                                                | Deprecated | End of Support | Last compatible Armory Continuous Deployment release |
|--------------------------------------------------------|------------|----------------|-------------------------------------------|
| [Pipelines as CRD]({{< ref "pacrd-deprecation.md" >}}) | 2021 Aug 01 | 2021 Nov 01     | Not applicable                            |
| [Halyard]({{< ref "halyard-deprecation.md" >}}) | 2021 Sept 01 | 2021 Dec 30 | 2.26.x |


## FAQ

#### How much notice will I receive on Feature Deprecations and End of Support?

Our goal is to deprecate all features for at least 6 months prior to reaching End of Support, and we’ll begin communicating this as soon as a feature is officially deprecated.  For features that require significant support to gracefully migrate away from, our goal is to deprecate for at least 12 months to ensure plenty of lead time for adjustments.

A list of feature deprecations and related information is maintained in the [deprecations section]({{< ref "deprecations" >}}), and you will be notified by various methods in order to limit any surprises for your teams.

There are situations in which the deprecation timeline may be accelerated due to special circumstances. In all cases, we provide as much advance notification as possible. These situations include but are not limited to the following:

- Essential changes, such as those needed to maintain the integrity and stability of the platform for all customers.
- When third party software leveraged by Armory is changed or no longer available.
- When changes are needed to protect data security and comply with any legal requirements.

#### How will Armory announce feature deprecations?

To ensure you have ample time to prepare for these planned changes, we’ll communicate in the following ways:

* **[Deprecation section on the Armory Continuous Deployment docs site]({{< ref "deprecations" >}})** - Each deprecated feature will be outlined within this Deprecation Policy and Status document. There will also be a separate document that includes a detailed overview of the status, important dates leading up to the deprecation of the feature, what each phase of the deprecation includes, how it impacts you as the customer, and the transition process.

* **Email Communication** - Armory will send a series of emails leading up to the deprecation to ensure that you have taken or have plans to take complete any required actions to ensure a smooth transition.  Additionally, any deprecations will be noted in the Armory newsletter.


* **In-Person Communication** - Armory customers who have an assigned Technical Account Manager and/or an Account Executive will receive a direct communication in addition to general email notifications.

#### Who do I contact with any questions or concerns?

For customers who have an assigned Technical Account Manager and/or Account Executive, these are your first and best resource. For others you can reach our Customer Care team at [support@armory.io](mailto:support@armory.io) or visit the [Help Center](https://support.armory.io/) to submit a case.
