---
title: Configure Pipelines-as-Code
linkTitle: Configure
weight: 10
description: >
  Learn how to configure Armory Pipelines-as-Code in your Spinnaker or Armory CD instance.
---

## Where to configure the service

* Spinnaker (Halyard): `dinghy.yml` section of your ConfigMap
* Spinnaker (Spinnaker Operator): `spinnaker-kustomize-patches/plugins/oss/pipelines-as-code/dinghy.yml`
* Armory CD: `spinnaker-kustomize-patches/armory/features/pipelines-as-code/features.yml`

## Configure your repos

{{< readfile file="/includes/plugins/pac/before-enable-repo.md" >}}

### Configure GitHub

{{< readfile file="/includes/plugins/pac/config-github.md" >}}

### Configure Bitbucket Server (Stash) and Bitbucket Cloud

{{< readfile file="/includes/plugins/pac/config-bitbucket.md" >}}

### Configure GitLab

{{< readfile file="/includes/plugins/pac/config-gitlab.md" >}}

## Configure an external persistent database

The Pipelines-as-Code service uses an in-cluster Redis instance to store relationships between pipeline templates and pipeline config files (`.dinghyfile`). You can, however, configure the service to use an external persistent database.

### Configure Redis

Armory highly recommends that you use an external Redis instance for production use. If Redis becomes unavailable, you need to update your pipeline config files in order for the service to repopulate Redis with the relationships.

> Dinghy can only be configured to use a password with the default Redis user.

To set/override the default Redis settings, add the following to your config file:

{{< prism lang="yaml">}}
redis:
  baseUrl: "redis://spin-redis:6379"
  password: "password"
{{< /prism >}}

### Configure MySQL

{{< include "early-access-feature.html" >}}

The Pipelines-as-Code service can use MySQL to store relationships between pipeline templates and pipeline Dinghy files. Armory recommends an external MySQL instance for production use because it can provide more durability for Pipelines-as-Code. If MySQL becomes unavailable, you need to update your Dinghy files in order to repopulate MySQL with the relationships.

 {{< include "rdbms-utf8-required.md" >}}

First make sure the schema exists in your database.

{{< prism lang="sql" >}}
CREATE SCHEMA IF NOT EXISTS dinghy DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      CREATE USER IF NOT EXISTS 'dinghy_service'@'%' IDENTIFIED BY '${SOME_PASSWORD_HERE}';
      CREATE USER IF NOT EXISTS 'dinghy_migrate'@'%' IDENTIFIED BY '${SOME_PASSWORD_HERE}';
      GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, EXECUTE, SHOW VIEW ON dinghy.* TO 'dinghy_service'@'%';
      GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, LOCK TABLES, EXECUTE, SHOW VIEW ON dinghy.* TO dinghy_migrate@'%';
{{< /prism >}}

Next, configure Pipelines-as-Code to use your MySQL database. Add the following to your config file:

{{< prism lang="yaml">}}
sql:
  baseUrl: mysql:3306
  databaseName: dinghy
  enabled: true
  password: <password>
  user: <user>
{{< /prism >}}

### Migration from Redis to SQL

There is a migration strategy to move the relationships from Redis to SQL. In order to do that, you need to have the configuration from your Redis and add the configuration for MySQL as shown previously. When you do this and the pod starts, what happens is that the migration is done automatically by a job. To verify that the migration was done successfully, you can access your database and run the following query:

{{< prism lang="sql">}}
select * from executions;
select * from fileurls;
select * from fileurl_childs;
{{< /prism >}}

In the `executions` table, you should be able to see one record with the name `REDIS_TO_SQL_MIGRATION`.

In `fileurls` and `fileurl_childs`, you should be able to see the migration information with the Dinghyfiles, modules, and their relationships.

After Dinghy finishes the migration, it closes the Redis connection and works in full MySQL mode.


## Configure notifications

### Slack notifications

If you [configured]({{< ref "notifications-slack-configure" >}}) Armory CD or Spinnaker to send Slack notifications for pipeline events, you can configure Pipelines-as-Code to send pipeline update results to Slack.

Add the following to your `SpinnakerService` manifest:

{{< prism lang="yaml" line="11-15" >}}
...
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true
          notifiers:
            enabled: true         # Enable to allow any notifier type to occur
            slack:
              enabled: true       # Whether or not Slack notifications are enabled for dinghy events
              channel: my-channel # Slack channel where notifications will be sent to
            github:
              enabled: false       # (Default: true) Whether or not github notifications are enabled for Dinghy events, once spec.spinnakerConfig.prifles.dinghy.notifiers are enabled.  Only enable if you want both slack and github notifications at the same time
{{< /prism >}}

![Slack Notifications](/images/dinghy-slack-notifications.png)

### GitHub notifications

Dinghy can provide more robust information to GitHub about executed pipeline changes. This information appears as a comment in the PR.  

Keep the following in mind when enabling GitHub notifications:

* When using Armory CD versions below 2.26.2, GitHub notifications are not supported with custom endpoints and [should be disabled due to a known issue](https://support.armory.io/support?id=kb_article&sysparm_article=KB0010290). This issue has been resolved as of [2.26.2, Dinghy Change #447]({{< ref "armoryspinnaker_v2-26-2#dinghy---226622610" >}}).
* Enabling this functionality may lead to a large number of comments on a pull request if, for example, you update a module that is used by multiple pipelines. This can lead to the GitHub UI not loading or GitHub rate limiting cause of related API calls.

To configure, add the following to your `SpinnakerService` manifest:

{{< prism lang="yaml" line="11-12" >}}
...
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        notifiers:
          enabled: true
          github:
            enabled: true  # (Default: true) Whether or not github notifications are enabled for Pipeline as Code events, once spec.spinnakerConfig.profles.dinghy.notifiers are enabled
{{< /prism >}}


![GitHub Notifications](/images/plugins/pac/dinghy-github-notifications.jpg)

## Additional options

### Custom branches

> Configuring a custom branch is required if you are using a repo that does not use `master` or `main` as the default branch, or you want to use a branch other than `master` or `main`.

By default, Dinghy uses the `master` branch in your repository and fallbacks to `main` if `master` doesn't exist. If you wish to use a different branch in your repository, you can configure that using the `repoConfig` tag in your YAML configuration.

The `repoConfig` tag supports a collection of the following values:

* `branch` - the name of the branch you wish to use
* `provider` - the name of the provider. Pipelines-as-Code supports the following:

   * `github`
   * `bitbucket-cloud`
   * `bitbucket-server`
* `repo` - the name of the repository

For example:

{{< prism lang="yaml" line="9-15" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        repoConfig:
        - branch: some_branch
          provider: bitbucket-server
          repo: my-bitbucket-repository
        - branch: some_branch
          provider: github
          repo: my-github-repository
{{< /prism >}}

### Multiple branches

{{< include "early-access-feature.html" >}}

This feature enables you to select multiple branches in the UI.

If you want to pull from multiple branches in the same repo, you must add `multipleBranchesEnabled` to the `dinghy` config in your `SpinnakerService` manifest:

{{< prism lang="yaml" line="10" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          multipleBranchesEnabled: true
{{< /prism >}}

- `multipleBranchesEnabled`: (Optional; default `false`) `true` if you want to enable pulling from multiple branches in your repo.

If `true`, you must configure your repo branches in the `spec.spinnakerConfig.profiles.dinghy` section of your `SpinnakerService` manifest.  For example:

{{< prism lang="yaml" line="9-18" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        repoConfig:
          - branch: prod
            provider: github
            repo: my-github-repository
          - branch: dev
            provider: github
            repo: my-github-repository
          - branch: main
            provider: github
            repo: my-github-repository
{{< /prism >}}

### Negative expressions support in your `dinghyfile`

The Regexp2 engine supports negative expressions, so you don’t need to define patterns for all files to be ignored. You can ignore everything other than required files. For example, in your project you have some project-specific files: `file.js`, `file.ts`, `file.css`. You also have files used by Dinghy: `dinghyfile`, `minimum-wait.stage.module`, `maximum-wait.stage.module`. If you enable `dinghyIgnoreRegexp2Enabled`, you can create your `.dinghyfile` with one of the following regular expressions:

      - file.(js|ts|css)
      - ^(?!.*(.stage.module)|(dinghyfile)).*

   Both of those regular expressions product the same result:

      - file.js -> ignored
      - file.ts -> ignored
      - file.css -> ignored
      - dinghyfile -> processed by Dinghy
      - minimum-wait.stage.module -> processed by Dinghy
      - maximum-wait.stage.module -> processed by Dinghy

To enable this feature, add `dinghyIgnoreRegexp2Enabled` to your `SpinnakerService` manifest:

{{< prism lang="yaml" line="11" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true
          dinghyIgnoreRegexp2Enabled: true
{{< /prism >}}

- `dinghy.dinghyIgnoreRegexp2Enabled`: (Optional; default `false`) `true `if you want Dinghy to ignore everything other than required files.

### Fiat

If Fiat is enabled, add the field `fiatUser: <your-service-account>` to the `dinghy` section in `SpinnakerService` manifest. Note that the service account has to be in a group that has read/write access to the pipelines you are updating.

For example:

{{< prism lang="yaml" line="9-10" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          fiatUser: <your-service-account>
{{< /prism >}}

If you have app specific permissions configured in Armory CD, make sure you add the service account. For information on how to create a service account, see [Creating service accounts](https://www.spinnaker.io/setup/security/authorization/service-accounts/#creating-service-accounts).

### Custom dinghyfile name

If you want to change the name of the file that describes pipelines, add `spec.spinnakerConfig.armory.dinghy.dinghyFilename: <your-filename>` to your  `SpinnakerService` manifest:

{{< prism lang="yaml" line="9-10" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          dinghyFilename: <your-filename>
{{< /prism >}}

### Disable lock pipelines

If you want to disable lock pipelines in the UI before overwriting changes, add  `spec.spinnakerConfig.armory.dinghy.autoLockPipelines: false` to your  `SpinnakerService` manifest:

{{< prism lang="yaml" line="9-10" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          autoLockPipelines: false
{{< /prism >}}

### Define additional template formats

Pipelines-as-Code supports two additional template formats in addition to JSON:

* [HCL](https://github.com/hashicorp/hcl)
* [YAML](https://yaml.org/)

> Selecting one of these parsers means that all of your templates must also be in that format.

In your `SpinnakerService` manifest, you need to configure `spec.SpinnakerConfig.profiles.dinghy.parserFormat` with one of the parsers:

* `json` (Default)
* `yaml`
* `hcl`

For example:

{{< prism lang="yaml" line="8-9" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        parserFormat: <parser-format>
{{< /prism >}}


## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/use.md" >}}