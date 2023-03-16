---
title: v1.7.3 Armory Operator
toc_hide: true
version: 01.07.03
description: Release notes for Armory Operator v1.7.3
date: 2022-10-18
---

## 2022-10-18 Release Notes

Upgrade the Operator using `kubectl replace`. See [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}) for details.


## Security

Armory scans the codebase as we develop and release software. For information about CVE scans for this release, contact your Armory account representative.

## Known issues

{{< include "known-issues/ki-operator-webhookerror.md" >}}
## Highlighted updates

* Support for using a different Regex engine when structuring ignore patterns -- enabling this feature flag allows for negative lookahead

   ```
   spec:
     spinnakerConfig:
       config:
         armory:
           dinghy:
             enabled: true
             dinghyIgnoreRegexp2Enabled: true
   ```

   See [Negative expressions support in your `dinghyfile`]({{<  ref "continuous-deployment/armory-admin/dinghy-enable#negative-expressions-support-in-your-dinghyfile" >}}) for more information.

### Armory Operator

* chore(halyard): bump Halyard, add dinghyIgnoreRegexp2Enabled feature