---
title: Configure Pipelines-as-Code Optional Features
linkTitle: Configure Features
weight: 10
description: >
  Learn how to configure optional Pipelines-as-Code features in your Spinnaker or Armory CD instance.
---

## Where to configure the Dinghy service

* Spinnaker (Halyard): `dinghy.yml` section of your ConfigMap
* Spinnaker (Spinnaker Operator): `spinnaker-kustomize-patches/plugins/oss/pipelines-as-code/dinghy.yml`
* Armory CD: Either `spinnaker-kustomize-patches/armory/features/pipelines-as-code/features.yml` or `spinnakerservice.yml`

## Auto lock pipelines - disable

Set `autoLockPipelines: false` to disable lock pipelines in the UI before overwriting changes.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
autoLockPipelines: false
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          autoLockPipelines: false
```
{{% /tab %}}
{{< /tabpane >}}

## Branches

### Custom branches

Configuring a custom branch is required if you are using a repo that does not use `master` or `main` as the default branch, or you want to use a branch other than `master` or `main`.

By default, Dinghy uses the `master` branch in your repository and fallbacks to `main` if `master` doesn't exist. If you wish to use a different branch in your repository, you can configure that using the `repoConfig` tag in your YAML configuration.

The `repoConfig` tag supports a collection of the following values:

* `branch` - the name of the branch you wish to use
* `provider` - the name of the provider. Pipelines-as-Code supports the following:

   * `github`
   * `bitbucket-cloud`
   * `bitbucket-server`
* `repo` - the name of the repository

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
repoConfig:
- branch: some_branch
  provider: bitbucket-server
  repo: my-bitbucket-repository
- branch: some_branch
  provider: github
  repo: my-github-repository
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
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
```
{{% /tab %}}
{{< /tabpane >}}



### Multiple branches

{{< include "early-access-feature.html" >}}

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Each branch in a repository must be explicitly configured in a separate  `repoConfig` item. In the example below, Dinghy will properly handle changes from two branches, `branch_a` and `branch_b` in `repository-GitHub-repository`. Add the following to your `dinghy.yml` config:

```yaml
multipleBranchesEnabled: true
repoConfig:
- branch: branch_a
  provider: github
  repo: my-github-repository
- branch: branch_b
  provider: github
  repo: my-github-repository
- branch: some_branch
  provider: bitbucket-server
  repo: my-bitbucket-repository
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          multipleBranchesEnabled: true
    profiles:
      dinghy:
        repoConfig:
        - branch: some_branch
          provider: bitbucket-server
          repo: my-bitbucket-repository
        - branch: some_branch
          provider: github
          repo: my-github-repository
```
{{% /tab %}}
{{< /tabpane >}}

## Custom dinghyfile name

This changes the name of the file that describes pipelines.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
dinghyFilename: <your-filename>
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          dinghyFilename: <your-filename>
```
{{% /tab %}}
{{< /tabpane >}}

## External persistent database

The Pipelines-as-Code service uses an in-cluster Redis instance to store relationships between pipeline templates and pipeline config files (`.dinghyfile`). You can, however, configure the service to use an external persistent database.

### Configure Redis

Armory highly recommends that you use an external Redis instance for production use. If Redis becomes unavailable, you need to update your pipeline config files in order for the service to repopulate Redis with the relationships.

> You can only configure Dinghy to use a password with the default Redis user.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
redis:
  baseUrl: "redis://spin-redis:6379"
  password: "password"
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        redis: "redis://spin-redis:6379"
        password: "<password>"
```
{{% /tab %}}
{{< /tabpane >}}

### Configure MySQL

{{< include "early-access-feature.html" >}}

The Pipelines-as-Code service can use MySQL to store relationships between pipeline templates and pipeline Dinghy files. Armory recommends an external MySQL instance for production use because it can provide more durability for Pipelines-as-Code. If MySQL becomes unavailable, you need to update your Dinghy files in order to repopulate MySQL with the relationships.

{{< include "rdbms-utf8-required.md" >}}

First make sure the schema exists in your database.

```sql
CREATE SCHEMA IF NOT EXISTS dinghy DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      CREATE USER IF NOT EXISTS 'dinghy_service'@'%' IDENTIFIED BY '${SOME_PASSWORD_HERE}';
      CREATE USER IF NOT EXISTS 'dinghy_migrate'@'%' IDENTIFIED BY '${SOME_PASSWORD_HERE}';
      GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, EXECUTE, SHOW VIEW ON dinghy.* TO 'dinghy_service'@'%';
      GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, LOCK TABLES, EXECUTE, SHOW VIEW ON dinghy.* TO dinghy_migrate@'%';
```

Next, configure Pipelines-as-Code to use your MySQL database.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
sql:
  baseUrl: mysql:3306
  databaseName: dinghy
  enabled: true
  password: <password>
  user: <user>
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        sql:
          baseUrl: mysql:3306
          databaseName: dinghy
          enabled: true
          password: password
          user: user
```
{{% /tab %}}
{{< /tabpane >}}

### Migration from Redis to SQL

There is a migration strategy to move the relationships from Redis to SQL. In order to do that, you need to have the configuration from your Redis and add the configuration for MySQL as shown previously. When you do this and the pod starts, what happens is that the migration is done automatically by a job. To verify that the migration was done successfully, you can access your database and run the following query:

```sql
select * from executions;
select * from fileurls;
select * from fileurl_childs;
```

In the `executions` table, you should be able to see one record with the name `REDIS_TO_SQL_MIGRATION`.

In `fileurls` and `fileurl_childs`, you should be able to see the migration information with the Dinghyfiles, modules, and their relationships.

After Dinghy finishes the migration, it closes the Redis connection and works in full MySQL mode.

## Fiat

If you have enabled Fiat, add the field `fiatUser: <your-service-account>` to your config. Note that the service account has to be in a group that has read/write access to the pipelines you are updating.

If you have app specific permissions configured, make sure you add the service account. For information on how to create a service account, see [Creating service accounts](https://www.spinnaker.io/setup/security/authorization/service-accounts/#creating-service-accounts).

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
fiatUser: <your-service-account>
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          fiatUser: <your-service-account>
```
{{% /tab %}}
{{< /tabpane >}}


## Negative expressions support

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

Add `dinghyIgnoreRegexp2Enabled: true` if you want Dinghy to ignore everything other than required files.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
dinghyIgnoreRegexp2Enabled: true
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          dinghyIgnoreRegexp2Enabled: true
```
{{% /tab %}}
{{< /tabpane >}}

## Notifications

### Slack notifications

If you [configured]({{< ref "notifications-slack-configure" >}}) Armory CD or Spinnaker to send Slack notifications for pipeline events, you can configure Pipelines-as-Code to send pipeline update results to Slack.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
notifiers:
  enabled: true         # Enable to allow any notifier type to occur
  slack:
    enabled: true       # Whether or not Slack notifications are enabled for Dinghy events
    channel: <my-channel> # Slack channel where notifications will be sent to
  github:
    enabled: false       # (Default: true) Whether or not github notifications are enabled for Dinghy events; once `spec.spinnakerConfig.profiles.dinghy.notifiers` are enabled, only enable this if you want both Slack and GitHub notifications at the same time
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
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
```
{{% /tab %}}
{{< /tabpane >}}

![Slack Notifications](/images/dinghy-slack-notifications.png)

### GitHub notifications

Dinghy can provide more robust information to GitHub about executed pipeline changes. This information appears as a comment in the PR.  

Keep the following in mind when enabling GitHub notifications:

* When using Armory CD versions below 2.26.2, GitHub notifications are not supported with custom endpoints and [should be disabled due to a known issue](https://support.armory.io/support?id=kb_article&sysparm_article=KB0010290). This issue has been resolved as of [2.26.2, Dinghy Change #447]({{< ref "armoryspinnaker_v2-26-2#dinghy---226622610" >}}).
* Enabling this functionality may lead to a large number of comments on a pull request if, for example, you update a module that is used by multiple pipelines. This can lead to the GitHub UI not loading or GitHub rate limiting cause of related API calls.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
notifiers:
  enabled: true
  github:
    enabled: true # (Default: true) Whether or not github notifications are enabled for Dinghy events; once `notifiers` are enabled, only enable this if you want both Slack and GitHub notifications at the same time
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        notifiers:
          enabled: true
          github:
            enabled: true # (Default: true) Whether or not github notifications are enabled for Dinghy events, once spec.spinnakerConfig.profles.dinghy.notifiers are enabled
```
{{% /tab %}}
{{< /tabpane >}}

![GitHub Notifications](/images/plugins/pac/dinghy-github-notifications.jpg)

## Permissions check for a commit

The `userWritePermissionsCheckEnabled` feature, when enabled, verifies if the author of a commit that changed app parameters has sufficient WRITE permission for that app. You can specify a list of authors whose permissions are not valid. This option’s purpose is to skip permissions checks for bots and tools.

**How this feature works**

A webhook generated by commits pushed to a branch contains information about the commit author.  Dinghy extracts the author's email and fetches user roles for that email from Fiat. Given the roles, Dinghy fetches app permissions and compares the app’s WRITE roles with the roles of the author. If they match, Dinghy processes the webhook and applies changes from the commit to the app or pipelines. If permissions don’t match, Dinghy rejects the webhook since the author doesn’t have the required write permissions.

**How to enable**

This feature is **disabled by default** to prevent users from experiencing unexpected application behavior. You can enable the feature by setting `userWritePermissionsCheckEnabled` to true. When you omit `userWritePermissionsCheckEnabled` or set it to false, Dinghy does not check permissions.

To skip permissions checks for users such as bots or service accounts, set the value of `ignoreUsersWritePermissions` to the comma-delimited list of repo user email addresses.

When `userWritePermissionsCheckEnabled` is false or omitted, `ignoreUsersWritePermissions` has no effect.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
userWritePermissionsCheckEnabled: true
ignoreUsersWritePermissions: “user1@example.com,user2@example.com”
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          userWritePermissionsCheckEnabled: true
          ignoreUsersWritePermissions: “user1@example.com,user2@example.com”
```
{{% /tab %}}
{{< /tabpane >}}

## Template formats

Pipelines-as-Code supports two additional template formats in addition to the default JSON:

* [HCL](https://github.com/hashicorp/hcl)
* [YAML](https://yaml.org/)

>Selecting one of these parsers means that all of your templates must also be in that format.

{{< tabpane text=true right=true >}}
{{% tab header="Spinnaker"  %}}
Add the following to your `dinghy.yml` config:

```yaml
parserFormat: <parser-format>
```
{{% /tab %}}
{{% tab header="Armory CD"  %}}

```yaml
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        parserFormat: <parser-format>
```
{{% /tab %}}
{{< /tabpane >}}

Replace `<parser-format` with one of the parsers:

* `json` (Default)
* `yaml`
* `hcl`

## {{% heading "nextSteps" %}}

* {{< linkWithTitle "plugins/pipelines-as-code/use.md" >}}
