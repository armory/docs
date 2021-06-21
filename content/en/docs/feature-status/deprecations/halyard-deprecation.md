---
title: Halyard Deprecation
description: Armory will be discontinuing support for Halyard. This article explains why Armory is doing this and how it impacts your company.
toc_hide: true
hidden: true
exclude_search: true
---

Armory will be discontinuing support for Halyard soon. This article explains
why we’re doing this and how it will impact you.
 
## What Does This Mean?


As of 2021/09/01, Halyard will be considered End of Support, and Armory will no
longer support issues solely pertaining to Halyard. You will still be able to
access and use the tool to install and configure Armory Enterprise releases up
to and including 2.26.This means that any workflow that uses Halyard may break
when you upgrade to a release that comes out after 2.26

We encourage all Halyard users to migrate to the Armory Operator, our supported
method of installing and configuring Armory’s products beyond the 2.26 release.
 
## Why is Armory Removing Support?

The Armory Operator now has a superset of the functionality provided by
Halyard, including a more native Kubernetes installation experience. In an
effort to create the best possible installation experience, we are
consolidating supported installation tools to only the Armory Operator.
Focusing on a single installation experience allows us to develop requested
features at a faster pace.

We understand that this decision is disruptive to you, so we are giving as much
advance notice as possible.  For more information about how Armory handles
feature and technology deprecation, please see
[https://docs.armory.io/deprecations](https://docs.armory.io/deprecations).
 
## Am I Affected?

If your company currently uses Halyard, then yes.  You can still access Halyard
until 2021/12/30; however, Armory is unable to support issues solely
related to Halyard you may experience after 2021/09/01.
 
## What Do I Need to Do?
To assure the best user-experience possible, we recommend migrating to the Armory Operator.

We have instructions for migrating to the Operator on this page:
[https://docs.armory.io/docs/installation/armory-operator/hal-op-migration/](https://docs.armory.io/docs/installation/armory-operator/hal-op-migration/).
 
## What Happens if I Don't Act in Time?

As mentioned above, if your company uses Halyard, it will no longer be
guaranteed to function after 2021/09/01. This means that you will not be able
to install any releases beyond 2.26. 
 
## Who Should I Contact if I have Questions or Need Further Assistance?

You can reach our Customer Care team 24/7 at support@armory.io or visit the
**Help Center** to submit a case.
