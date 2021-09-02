---
title: v2.26.1 Armory Release (OSS Spinnaker™ v1.26.6)
toc_hide: true
version: 02.26.01
description: >
  Release notes for Armory Enterprise v2.26.1
---

## 2021/07/22 Release Notes

> Note: If you're experiencing production issues after upgrading Spinnaker, rollback to a [previous working version]({{< ref "upgrade-spinnaker#rolling-back-an-upgrade" >}}) and please report issues to [http://go.armory.io/support](http://go.armory.io/support).

For information about what Armory supports for this version, see the [Armory Enterprise Compatibility Matrix]({{< ref "armory-enterprise-matrix-2-26.md" >}}).

## Required Halyard or Operator version

To install, upgrade, or configure Armory 2.26.0, use one of the following tools:

- Armory-extended Halyard 1.12 or later
  - 2.26.x is the last minor release that you can use Halyard to install or manage. Future releases require the Armory Operator. For more information, see [Halyard Deprecation]({{< ref "halyard-deprecation" >}}).

- Armory Operator 1.2.6 or later

   For information about upgrading, Operator, see [Upgrade the Operator]({{< ref "op-manage-operator#upgrade-the-operator" >}}).

## Security

Armory scans the codebase as we develop and release software. Contact your Armory account representative for information about CVE scans for this release.

## Upcoming potential breaking change

{{< include "breaking-changes/bc-java-tls-mysql.md" >}}

## Breaking changes
<!-- Copy/paste from the previous version if there are recent ones. We can drop breaking changes after 3 minor versions. Add new ones from OSS and Armory. -->

> Breaking changes are kept in this list for 3 minor versions from when the change is introduced. For example, a breaking change introduced in 2.21.0 appears in the list up to and including the 2.24.x releases. It would not appear on 2.25.x release notes.

#### Suffixes for the Kubernetes Run Job stage

The `kubernetes.jobs.append-suffix` parameter no longer works. The removal of this parameter was previously announced as part of a [breaking change](https://docs.armory.io/docs/release-notes/rn-armory-spinnaker/armoryspinnaker_v2-22-0/#suffix-no-longer-added-to-jobs-created-by-kubernetes-run-job-stage) in Armory 2.22.

To continue adding a random suffix to jobs created by the Kubernetes Run Job stage, use the `metadata.generateName` field in your Kubernetes job manifests. For more information, see [Generated values](https://kubernetes.io/docs/reference/using-api/api-concepts/#generated-values).

{{< include "breaking-changes/bc-k8s-version-pre1-16.md" >}}

{{< include "breaking-changes/bc-k8s-infra-buttons.md" >}}

## Known issues
<!-- Copy/paste known issues from the previous version if they're not fixed. Add new ones from OSS and Armory. If there aren't any issues, state that so readers don't think we forgot to fill out this section. -->

{{< include "known-issues/ki-bake-var-file.md" >}}
{{< include "known-issues/ki-lambda-ui-caching.md" >}}


## Highlighted updates

### AWS Cloudwatch

You can now configure the Kayenta service to assume a role when connecting to AWS Cloudwatch:

```yaml
kayenta:
  aws:
    enabled: true
    accounts:
      - name: monitoring
        region: <your-region>
        iamRoleArn: <your-role-ARN> # For example arn:aws:iam::042225624470:role/theRole
        # iamRoleExternalId: Optional. For example 12345
        iamRoleArnTarget: <your-role-ARN-target> # For example arn:aws:iam::042225624470:role/targetcloudwatchaccount
        # iamRoleExternalIdTarget: <your-ExternalID> # Optional. For example 84475
        supportedTypes:
          - METRICS_STORE        
```

### Pipelines as Code

#### Ignore file

Pipelines as Code now supports using an ignore file for GitHub repos to ignore certain files in a repo that it watches. To use this feature, create a file named `.dinghyignore` in the root directory of the repo.

You can add specific filenames, filepaths, or glob-style paths. For example, the following `.dinghyignore` file ignores the file named `README.md`, all the files in the `milton` directory, and all `.pdf` files:

```
README.md
milton/
*.pdf
```

#### JSON validation

In 2.26.0, strict JSON validation was on by default. In 2.26.1, it is now configurable as a boolean in `spec.spinnakerConfig.profiles.dinghy.jsonValidationDisabled`:


```yaml
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        jsonValidationDisabled: <boolean>
```

The config is optional. If omitted, strict validation is on by default.

> When strict validation is on, existing pipelines may fail if any JSON is invalid.

###  Spinnaker Community Contributions

There have also been numerous enhancements, fixes, and features across all of Spinnaker's other services. See the
[Spinnaker v1.26.6](https://www.spinnaker.io/changelogs/1.26.6-changelog/) changelog for details.

## Detailed updates

### Bill Of Materials (BOM)

Here's the BOM for this version.
<details><summary>Expand</summary>
<pre class="highlight">
<code>version: 2.26.1
timestamp: "2021-07-20 19:04:54"
services:
    clouddriver:
        commit: 58e826ca
        version: 2.26.12
    deck:
        commit: 09f8ec58
        version: 2.26.7
    dinghy:
        commit: 33f6f14c
        version: 2.26.6
    echo:
        commit: 3cdb74fa
        version: 2.26.9
    fiat:
        commit: b2360f92
        version: 2.26.10
    front50:
        commit: d3dfd429
        version: 2.26.11
    gate:
        commit: ec2ae48c
        version: 2.26.9
    igor:
        commit: a9b45bca
        version: 2.26.9
    kayenta:
        commit: 1d27eaf7
        version: 2.26.10
    monitoring-daemon:
        version: 2.26.0
    monitoring-third-party:
        version: 2.26.0
    orca:
        commit: 69f66bf3
        version: 2.26.15
    rosco:
        commit: 1dfc60f1
        version: 2.26.13
    terraformer:
        commit: "540902e6"
        version: 2.26.9
dependencies:
    redis:
        version: 2:2.8.4-2
artifactSources:
    dockerRegistry: docker.io/armory
</code>
</pre>
</details>

### Armory


#### Armory Echo - 2.26.5...2.26.9



#### Armory Rosco - 2.26.8...2.26.13


#### Armory Clouddriver - 2.26.6...2.26.12


#### Armory Deck - 2.26.5...2.26.7


#### Armory Gate - 2.26.5...2.26.9

#### Armory Kayenta - 2.26.5...2.26.10

  - feat(cloudwatch): add assume role feat and cleanup dependencies (#233) (#270)

#### Armory Igor - 2.26.6...2.26.9


#### Dinghy™ - 2.26.1...2.26.6

  - fix(local_modules_not_working_in_template_repo): updating internal bu… (backport #429) (#430)
  - fix(parsing_errors_when_using_yaml): upgrade to version of OSS dinghy that includes this fix BOB-30150 (#436) (#438)
  - feat(add_dinghyignore): upgrade oss dinghy version (#439) (#440)
  - feat(add_flag_for_json_validation): upgrade to latest version of OSS dinghy PUX-405 (#441) (#442)

#### Armory Fiat - 2.26.6...2.26.10


#### Armory Front50 - 2.26.7...2.26.11


#### Armory Orca - 2.26.12...2.26.15


#### Terraformer™ - 2.26.3...2.26.9
