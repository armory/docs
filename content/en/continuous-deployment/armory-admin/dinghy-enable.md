---
title: Enable Pipelines as Code in Armory Continuous Deployment
linkTitle: Enable Pipelines as Code
description: >
  Learn how to configure Armory CD to use pipeline templates stored in source control. Options for Pipelines as Code's Dinghy service include pulling from multiple branches and Regexp2 support.
---

![Proprietary](/images/proprietary.svg)

## Advantages to using Pipelines as Code

{{% include "admin/pac-overview.md" %}}

At a high level, follow these steps to enable Pipelines as Code:

1. [Enable](#enable-pipelines-as-code) Pipelines as Code in your `SpinnakerService` manifest.
1. [Configure a database](#configure-a-database).
1. [Enable and configure your repos](#enable-your-repos).

You can also [configure notifications](#configure-notifications) to work with Pipelines as Code. Be sure to look at the [additional options](#additional-options) section for optional features such as custom branch configuration if you don't use `master` or `main` branches and how to use multiple branches instead of a default single branch.

## Enable Pipelines as Code

_Dinghy_ is the microservice you need to enable to use Pipelines as Code. Add the following to your `SpinnakerService` manifest:

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
          enabled: true
{{< /prism >}}

- `dinghy.enabled`: `true`; required to enable Pipelines as Code.

**Apply your changes**

Assuming Armory CD lives in the `spinnaker` namespace, execute the following to update your instance:

{{< prism lang="bash"  >}}
kubectl -n spinnaker apply -f spinnakerservice.yml
{{< /prism >}}

## Configure a database

### Configure Redis

Dinghy can use Redis to store relationships between pipeline templates and pipeline Dinghy files. An external Redis instance is highly recommended for production use. If Redis becomes unavailable, you need to update your Dinghy files in order to repopulate Redis with the relationships.

> Dinghy can only be configured to use a password with the default Redis user.

To set/override the Armory CD Redis settings do the following:

In `SpinnakerService` manifest:

{{< prism lang="yaml" line="8-11" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        redis:
          baseUrl: "redis://spin-redis:6379"
          password: "password"
{{< /prism >}}

Apply your changes:

{{< prism lang="bash">}}
kubectl -n spinnaker apply -f spinnakerservice.yml
{{< /prism >}}

### Configure MySQL

{{< include "early-access-feature.html" >}}

The Dinghy service can use MySQL to store relationships between pipeline templates and pipeline Dinghy files. Armory recommends an external MySQL instance for production use because it can provide more durability for Pipelines as Code. If MySQL becomes unavailable, you need to update your Dinghy files in order to repopulate MySQL with the relationships.

 {{< include "rdbms-utf8-required.md" >}}

First make sure the schema exists in your database.

{{< prism lang="sql" >}}
CREATE SCHEMA IF NOT EXISTS dinghy DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
      CREATE USER IF NOT EXISTS 'dinghy_service'@'%' IDENTIFIED BY '${SOME_PASSWORD_HERE}';
      CREATE USER IF NOT EXISTS 'dinghy_migrate'@'%' IDENTIFIED BY '${SOME_PASSWORD_HERE}';
      GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, EXECUTE, SHOW VIEW ON dinghy.* TO 'dinghy_service'@'%';
      GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, REFERENCES, INDEX, ALTER, LOCK TABLES, EXECUTE, SHOW VIEW ON dinghy.* TO dinghy_migrate@'%';
{{< /prism >}}

Next, configure Pipelines as Code to use your MySQL database. Add the following to your `SpinnakerService` manifest:

{{< prism lang="sql" line="8-14">}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
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
{{< /prism >}}

Apply your changes:

{{< prism lang="bash">}}
kubectl -n spinnaker apply -f spinnakerservice.yml
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

## Enable your repos

Before configuring your repos, ensure you have the following:

1. A personal access token (in either [GitHub](https://github.com/settings/tokens) or Bitbucket/Stash) that has read access to the repo where you store your `dinghyfile` and the repo where you store `module` files.
1. The GitHub, GitLab, or Bitbucket/Stash organization where the app repos and templates reside. For example, if your repo is `armory-io/dinghy-templates`, your `template-org` would be `armory-io`.
1. The name of the repo containing your modules. For example, if your repo is `armory-io/dinghy-templates`, your `template-repo` would be `dinghy-templates`.

### Enable GitHub

{{< prism lang="yaml" line="11-14">}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true  # Whether or not Dinghy is enabled
          templateOrg: my-org # SCM organization or namespace where application and template repositories are located
          templateRepo: dinghy-templates # SCM repository where module templates are located
          githubToken: abc  #  GitHub token.
          githubEndpoint: https://api.github.com # (Default: https://api.github.com) GitHub API endpoint. Useful if you’re using GitHub Enterprise
{{< /prism >}}

* `githubToken`: This field supports "encrypted" field references; see [Secrets]({{< ref "Secrets" >}}) for details.

Apply your changes:

{{< prism lang="bash">}}
kubectl -n spinnaker apply -f spinnakerservice.yml
{{< /prism >}}

#### GitHub webhooks

Set up webhooks at the organization level for push events. You can do this by going to `https://github.com/organizations/<your_org_here>/settings/hooks`.

1. Set `content-type` to `application/json`.
1. Set the `Payload URL` to your Gate URL. Depending on whether you configured Gate to use its own DNS name or a path on the same DNS name as Deck, the URL follows one of the following formats:

   * `https://<your-gate-url>/webhooks/git/github` if you have a separate DNS name or port for Gate
   * `https://<your-spinnaker-url>/api/v1/webhooks/git/github` if you're using a different path for Gate

If your Gate endpoint is protected by a firewall, you need to configure your firewall to allow inbound webhooks from GitHub's IP addresses. You can find the IPs in this API [response](https://api.github.com/meta). Read more about [GitHub's IP addresses](https://help.github.com/articles/about-github-s-ip-addresses/).

You can configure webhooks on multiple GitHub organizations or repositories to send events to Dinghy. Only a single repository from one organization can be the shared template repository in Dinghy. However, Dinghy can process pipelines from multiple GitHub organizations. You want to ensure the GitHub token configured for Dinghy has permission for all the organizations involved.

#### Pull request validations

When you make a GitHub pull request (PR) and there is a change in a `dinghyfile`, Pipelines as Code automatically performs a validation for that `dinghyfile`. It also updates the GitHub status accordingly. If the validation fails, you see an unsuccessful `dinghy` check.

{{< figure src="/images/dinghy/pr_validation/pr_validation.png" alt="PR that fails validation." >}}

Make PR validations mandatory to ensure users only merge working `dinghyfiles`.

Perform the following steps to configure mandatory PR validation:

1. Go to your GitHub repository.
1. Click on **Settings > Branches**.
1. In **Branch protection rules**, select **Add rule**.
1. Add `master` in **Branch name pattern** so that the rule gets enforced on the `master` branch. Note that if this is a new repository with no commits, the "dinghy" option does not appear. You must first create a `dinghyfile` in any branch.
1. Select **Require status checks to pass before merging** and make **dinghy** required.  Select **Include administrators** as well so that all PRs get validated, regardless of user.

The following screenshot shows what your GitHub settings should resemble:
{{< figure src="/images/dinghy/pr_validation/branch_mandatory.png" alt="Configured dinghy PR validation." >}}


### Enable Bitbucket Server (Stash) and Bitbucket Cloud

Bitbucket has both cloud and server offerings. See the Atlassian [docs](https://confluence.atlassian.com/bitbucketserver/bitbucket-rebrand-faq-779298912.html) for more on the name change from Stash to Bitbucket Server. Consult your company's Bitbucket support desk if you need help determining what flavor and version of Bitbucket you are using.

Add the Bitbucket configuration to your `SpinnakerService` manifest:

{{< prism lang="yaml" line="11-15" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true                      # Whether or not Dinghy is enabled
          templateOrg: my-org                # SCM organization or namespace where application and template repositories are located
          templateRepo: dinghy-templates     # SCM repository where module templates are located
          stashUsername: stash_user          # Stash username
          stashToken: abc                    # Stash token. This field supports "encrypted" field references
          stashEndpoint: https://my-endpoint # Stash API endpoint. If you're using Bitbucket Server, update the endpoint to include the api e.g. https://your-endpoint-here.com/rest/api/1.0
{{< /prism >}}

Apply your changes:

{{< prism lang="bash">}}
kubectl -n spinnaker apply -f spinnakerservice.yml
{{< /prism >}}

> If you're using Bitbucket Server, update the endpoint to include the api, e.g. `--stash-endpoint https://your-endpoint-here.com/rest/api/1.0`

You need to set up webhooks for each project that has the `dinghyfile` or module separately. Make the webhook `POST` to: `https://spinnaker.your-company.com:8084/webhooks/git/bitbucket`. If you're using Stash `<v3.11.6`, you need to install the [webhook plugin](https://marketplace.atlassian.com/plugins/com.atlassian.stash.plugin.stash-web-post-receive-hooks-plugin/server/overview) to be able to set up webhooks.

### Enable GitLab

Add the GitHub configuration to your `SpinnakerService` manifest:

{{< prism lang="yaml" line="11-14" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true                       # Whether or not Dinghy is enabled
          templateOrg: my-org                 # SCM organization or namespace where application and template repositories are located
          templateRepo: dinghy-templates      # SCM repository where module templates are located
          gitlabToken: abc                    # GitLab token. This field supports "encrypted" field references
          gitlabEndpoint: https://my-endpoint # GitLab endpoint
{{< /prism >}}

Apply your changes:

{{< prism lang="bash">}}
kubectl -n spinnaker apply -f spinnakerservice.yml
{{< /prism >}}

Under **Settings** -> **Integrations**  on your project page, point your webhooks to `https://<your-gate-url>/webhooks/git/gitlab`.  Make sure the server your
GitLab install is running on can connect to your Gate URL. Armory also needs to communicate with your GitLab installation. Ensure that connectivity works as well.

## Configure notifications

### Slack notifications

If you [configured]({{< ref "notifications-slack-configure" >}}) Armory to send Slack notifications for pipeline events, you can configure Dinghy to send pipeline update results to Slack.

Add the following to your `SpinnakerService` manifest:

{{< prism lang="yaml" line="11-15" >}}
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
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
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
            enabled: true       # (Default: true) Whether or not github notifications are enabled for Dinghy events, once spec.spinnakerConfig.profles.dinghy.notifiers are enabled
{{< /prism >}}


![GitHub Notifications](/images/armory-admin/dinghy-enable/dinghy-github-notifications.jpg)

## Additional options

### Custom branches

> Configuring a custom branch is required if you are using a repo that does not use `master` or `main` as the default branch, or you want to use a branch other than `master` or `main`.

By default, Dinghy uses the `master` branch in your repository and fallbacks to `main` if `master` doesn't exist. If you wish to use a different branch in your repository, you can configure that using the `repoConfig` tag in your YAML configuration.

The `repoConfig` tag supports a collection of the following values:

* `branch` - the name of the branch you wish to use
* `provider` - the name of the provider. Pipelines as Code supports the following:

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

Pipelines as Code supports two additional template formats in addition to JSON:

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

## Known issues

If Dinghy crashes on start up and you encounter an error in Dinghy similar to:

{{< prism lang="bash" >}}
time="2020-03-06T22:35:54Z"
level=fatal
msg="failed to load configuration: 1 error(s) decoding:\n\n* 'Logging.Level' expected type 'string', got unconvertible type 'map[string]interface {}'"
{{< /prism >}}

You probably configured global logging levels with `spinnaker-local.yml`. The work around is to override Dinghy's logging levels:

{{< prism lang="yaml" line="9-10" >}}
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        Logging:
          Level: INFO
{{< /prism >}}

