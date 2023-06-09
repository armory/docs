---
title: Pipelines as CRD (PaCRD) Deprecation
description: Armory will be discontinuing support for Pipelines as CRD (PaCRD). This article explains why Armory is doing this and how it impacts your company.
toc_hide: true
hidden: true
exclude_search: true
---

## What does this mean?

On 2021 Aug 30,  PaCRD will be deprecated with an End of Support date of 2021 Nov 01. This means that after 2021 Aug 30, no new development is done specific to the feature except for critical (P0/1) bugs and security CVE fixes. Support for critical (P0/1) bugs and security CVE fixes will end on 2021 Nov 01.

With that said, Armory is donating the source code for PaCRD to the open source community. If you choose to, you can continue to use PaCRD on a self-supported basis.

## Why is Armory removing support?

Technology and customer needs change quickly, and we understand that this decision impacts your business. Our PaCRD and Pipelines-as-Code (PaC) offerings solve similar customer problems; however, adoption for PaCRD remains below the threshold for us to continue investment. We are making this decision in order to continue focusing our attention on augmenting Armory’s core deployment experience which you rely on.

We understand that this decision may be disruptive to you, so we are giving as much advance notice as possible. For more information about how Armory handles feature and technology deprecation, please see the [Deprecations section]({{< ref "deprecations" >}}).

## Am I affected?

If your company currently uses PaCRD, then yes.  As mentioned above, you can still access PaCRD until 2021 Nov 01 as part of an Armory release. After 2021 Nov 01 however, Armory is unable to support any issues solely related to PaCRD that you may experience.

## What do I need to do?

To assure the best user-experience possible, we recommend the following options:

- Migrate to using our more mature Pipelines-as-Code feature

 ## What happens if I don't act in time?

If your company uses PaCRD, it will no longer be guaranteed to function as part of Armory Continuous Deployment releases after 2021 Nov 01. Any workflows that utilize PaCRD may break when you upgrade Armory Continuous Deployment to a new release after that date.

## Who should I contact if I have questions or need further assistance?

For customers who have an assigned Technical Account Manager and/or Account Executive, they are your first and best resource. For others you can reach our Customer Care team at [support@armory.io](mailto:support@armory.io) or visit the [Help Center](https://support.armory.io/) to submit a case.
