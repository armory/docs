---
title: spinnaker.ui.entitlements.isFeatureEnabled
linkTitle: spinnaker.ui.entitlements.isFeatureEnabled
Description: Allows UI elements to be hidden from the Spinnaker UI entirely.
weight: 10
---
IMPORTANT: This package is only available if you are running policy engine version 0.1.0 or later (TODO: finalize this version number).

When hiding an element from the UI via this package, Armory reccomends also disabling it in spinnaker.http.authz, which will prevent the same users from invoking it via API.
Note: this package only allows hiding functionality entirely. If you instead want to conditionally disable features based off property's pased to them, that can often be done in the spinnaker.http.authz package.
