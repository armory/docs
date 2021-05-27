---
title: spinnaker.ui.entitlements.isFeatureEnabled
linkTitle: spinnaker.ui.entitlements.isFeatureEnabled
Description: Allows UI elements to be hidden from the Spinnaker UI entirely.
weight: 10
---
IMPORTANT: This package is only available if you are running policy engine version 0.1.2 or later.

When hiding an element from the UI via this package, Armory reccomends also disabling it in spinnaker.http.authz, which will prevent the same users from invoking it via API. spinnaker.http.authz can access the same fields as this package, but also contains more keys.

Note: this package only allows hiding functionality entirely. If you instead want to conditionally disable features based off property's pased to them, that can often be done in the spinnaker.http.authz package.
