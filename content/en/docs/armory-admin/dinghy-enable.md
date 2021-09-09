---
title: Enable Pipelines as Code in Armory Enterprise
linkTitle: Enable Pipelines as Code
aliases:
  - /spinnaker/install_dinghy/
  - /docs/spinnaker/install-dinghy/
description: >
  Learn how to configure Spinnaker to use pipeline templates stored in source control.
---

![Proprietary](/images/proprietary.svg)

## Advantages to using Pipelines as Code

{{% include "admin/pac-overview.md" %}}

This guide includes:

* Configurations for enabling Armory's Pipelines as Code feature using Armory Operator or Halyard
* Settings for GitHub, GitLab, or Bitbucket/Stash webhooks to work with the Pipelines as code
* GitHub [custom branch configuration](#custom-branch-configuration) for information about how to explicitly set the branch that Pipelines as Code uses.

## Enabling Pipelines as Code

_Dinghy_ is the microservice for Pipelines as Code. You need to enable it to use Pipelines as Code.

{{< tabs name="enable" >}}
{{% tab name="Operator" %}}


In `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true       # Whether or not Dinghy is enabled
          ... # Rest of config omitted for brevity
```

Assuming Spinnaker lives in the `spinnaker` namespace:

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

{{% /tab %}}

{{% tab name="Halyard" %}}

```bash
hal armory dinghy enable
```

{{% /tab %}}
{{< /tabs >}}


## Configuring SQL

{{< include "early-access-feature.html" >}}

The Dinghy service can use MySQL to store relationships between pipeline templates and pipeline Dinghy files. An external MySQL instance is highly recommended for production use because it can provide more durability for Pipelines as Code. If MySQL becomes unavailable, Dinghy files will need to be updated in order to repopulate MySQL with the relationships.

{{< tabs name="MySQL" >}}
{{% tab name="Operator" %}}

In `SpinnakerService` manifest:

```yaml
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
```

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

{{% /tab %}}

{{% tab name="Halyard" %}}

Edit the `~/.hal/default/profiles/dinghy-local.yml` file and add the following:

```yaml
sql:
  user: root
  password: password
  baseUrl: mysql-url:3306
  databaseName: dinghy
  enabled: true
```


{{% /tab %}}
{{< /tabs >}}


### Migration from Redis to SQL

There's a migration strategy to move the relationships from Redis to SQL. In order to do that, you need to have the configuration from your redis and add the configuration for SQL as shown previously, when you do this and the pod starts, what will happen is that the migration will be done automatically by a job. To verify that the migration was done successfully you can enter into your database and query this tables.

```sql
select * from executions;
select * from fileurls;
select * from fileurl_childs;
```

In `executions` table you should be able to see one record with the name `REDIS_TO_SQL_MIGRATION`.

In `fileurls` and `fileurl_childs` you should be able to see the migration information with the Dinghyfiles, modules and their relationships.

After Dinghy makes the migration at start, it will close the Redis connection and it will work in full SQL mode.


## Configuring Redis

Dinghy can use Redis to store relationships between pipeline templates and pipeline Dinghy files. An external Redis instance is highly recommended for production use. If Redis becomes unavailable, Dinghy files will need to be updated in order to repopulate Redis with the relationships.

> Dinghy can only be configured to use a password with the default Redis user.

To set/override the Spinnaker Redis settings do the following:

{{< tabs name="redis" >}}
{{% tab name="Operator" %}}

In `SpinnakerService` manifest:

```yaml
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
```

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

{{% /tab %}}

{{% tab name="Halyard" %}}

Edit the `~/.hal/default/profiles/dinghy-local.yml` file and add the following:

```yaml
redis:
  baseUrl: "redis://spin-redis:6379"
  password: "password"
```

Then run `hal deploy apply` to deploy the changes.
{{% /tab %}}
{{< /tabs >}}

## Configuring Pipelines as Code

1. Create a personal access token (in either [GitHub](https://github.com/settings/tokens) or Bitbucket/Stash) that has read access to the repo where you store your `dinghyfile` and the repo where you store `module` files.
1. Get your GitHub, GitLab, or Bitbucket/Stash organization where the app repos and templates reside. For example, if your repo is `armory-io/dinghy-templates`, your `template-org` would be `armory-io`.
1. Get the name of the repo containing modules. . For example, if your repo is `armory-io/dinghy-templates`, your `template-repo` would be `dinghy-templates`.

### GitHub

{{< tabs name="github" >}}
{{% tab name="Operator" %}}

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true                  # Whether or not Dinghy is enabled
          templateOrg: my-org            # SCM organization or namespace where application and template repositories are located
          templateRepo: dinghy-templates # SCM repository where module templates are located
          githubToken: abc               #  GitHub token. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
          githubEndpoint: https://api.github.com # (Default: https://api.github.com) GitHub API endpoint. Useful if you’re using GitHub Enterprise
          ... # Rest of config omitted for brevity
```

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

{{% /tab %}}

{{% tab name="Halyard" %}}

```bash
hal armory dinghy edit \
  --template-org "armory-io" \
  --template-repo "dinghy-templates" \
  --github-token "your_token/password"
# For GitHub enterprise, you may customize the endpoint:
  --github-endpoint "https://your-endpoint-here.com/api/v3" # (Default: https://api.github.com) GitHub API endpoint. Useful if you’re using GitHub Enterprise
hal deploy apply
```

{{% /tab %}}
{{< /tabs >}}

#### Configuring GitHub webhooks

Set up webhooks at the organization level for Push events. You can do this by going to ```https://github.com/organizations/<your_org_here>/settings/hooks```.

1. Set `content-type` to `application/json`.
1. Set the `Payload URL` to your Gate URL. Depending on whether you configured Gate to use its own DNS name or a path on the same DNS name as Deck, the URL follows one of the following formats:

   * `https://<your-gate-url>/webhooks/git/github` if you have a separate DNS name or port for Gate
   * `https://<your-spinnaker-url>/api/v1/webhooks/git/github` if you're using a different path for Gate

If your gate endpoint is protected by a firewall, you need to configure your firewall to allow inbound webhooks from GitHub's IP addresses. You can find the IPs in this API [response](https://api.github.com/meta). Read more about  [GitHub's IP addresses](https://help.github.com/articles/about-github-s-ip-addresses/).

> You can configure webhooks on multiple GitHub organizations or repositories to send events to Dinghy. Only a single repository from one organization can be the shared template repository in Dinghy. However, pipelines can be processed from multiple GitHub organizations. You want to ensure the GitHub token configured for Dinghy has permission for all the organizations involved.

#### Pull request validations

{{% alert title="New feature" %}}Pull Request Validation is a new feature in Armory 2.21.{{% /alert %}}

When you make a GitHub Pull Request (PR) and there is a change in a `dinghyfile`, Pipelines as Code automatically performs a validation for that `dinghyfile`. It also updates the GitHub status accordingly. If the validation fails, you see an unsuccessful `dinghy` check.

{{< figure src="/images/dinghy/pr_validation/pr_validation.png" alt="PR that fails validation." >}}

Make PR Validations mandatory to ensure users only merge working `dinghyfiles`.

Perform the following steps to configure mandatory PR validation:

1. Go to your GitHub repository.
1. Click on **Settings > Branches**.
1. In **Branch protection rules**, select **Add rule**.
1. Add `master` in **Branch name pattern** so that the rule gets enforced on the `master` branch. Note that if this is a new repository with no commits, the "dinghy" option does not appear. You must first create a `dinghyfile` in any branch.
1. Select **Require status checks to pass before merging** and make **dinghy** required.  Select **Include administrators** as well so that all PRs get validated, regardless of user.

The following screenshot shows what your GitHub settings should resemble:
{{< figure src="/images/dinghy/pr_validation/branch_mandatory.png" alt="Configured dinghy PR validation." >}}


### Bitbucket Server (Stash) and Bitbucket Cloud

Bitbucket has both cloud and server offerings. See the Atlassian [docs](https://confluence.atlassian.com/bitbucketserver/bitbucket-rebrand-faq-779298912.html) for more on the name change from Stash to Bitbucket Server. Consult your company's Bitbucket support desk if you need help determining what flavor and version of Bitbucket you are using.

{{< tabs name="bitbucket" >}}
{{% tab name="Operator" %}}

```yaml
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
          stashToken: abc                    # Stash token. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
          stashEndpoint: https://my-endpoint # Stash API endpoint. If you're using Bitbucket Server, update the endpoint to include the api e.g. https://your-endpoint-here.com/rest/api/1.0
          ... # Rest of config omitted for brevity
```

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

{{% /tab %}}

{{% tab name="Halyard" %}}

```bash
hal armory dinghy edit \
  --template-org "armory-io" \
  --template-repo "dinghy-templates" \
  --stash-token "your_token/password" \
  --stash-username "stash_user" \
  --stash-endpoint "https://your-endpoint-here.com"  
hal deploy apply
```
{{% /tab %}}
{{< /tabs >}}

> If you're using Bitbucket Server, update the endpoint to include the api, e.g. `--stash-endpoint https://your-endpoint-here.com/rest/api/1.0`

You need to set up webhooks for each project that has the `dinghyfile` or module separately. Make the webhook `POST` to: `https://spinnaker.your-company.com:8084/webhooks/git/bitbucket`. If you're using stash `<v3.11.6`, you need to install the [webhook plugin](https://marketplace.atlassian.com/plugins/com.atlassian.stash.plugin.stash-web-post-receive-hooks-plugin/server/overview) to be able to set up webhooks.

### GitLab

{{< tabs name="gitlab" >}}
{{% tab name="Operator" %}}


```yaml
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
          gitlabToken: abc                    # GitLab token. This field supports "encrypted" field references (https://docs.armory.io/spinnaker-install-admin-guides/secrets/)
          gitlabEndpoint: https://my-endpoint # GitLab endpoint
          ... # Rest of config omitted for brevity
```

```bash
kubectl -n spinnaker apply -f spinnakerservice.yml
```

{{% /tab %}}

{{% tab name="Halyard" %}}

> GitLab with Pipelines as Code requires Halyard 1.7.2 or later.


```bash
hal armory dinghy edit \
--template-org "armory-io" \
--template-repo "dinghy-templates" \
--gitlab-token "your_token/password"
--gitlab-endpoint "https://your-endpoint-here.com"  

hal deploy apply
```

{{% /tab %}}
{{< /tabs >}}

Under "Settings -> Integrations"  on your project page, point your webhooks
to `https://<your-gate-url>/webhooks/git/gitlab`.  Make sure the server your
GitLab install is running on can connect to your Gate URL. Armory also needs
to communicate with your GitLab installation. Ensure that connectivity works as well.

### Custom branch configuration

> Configuring a custom branch is required if you are using a repo that does not use `master` as the base branch. Newly created GitHub repositories that use `main` as the default base branch must configure a custom branch using the `repoConfig` parameter.

By default, Dinghy will use the `master` branch in your repository. If you wish to use a different base branch for your repository, this can be configured using the `repoConfig` tag in your yaml configuration.

The `repoConfig` tag supports a collection of the following values. Each node in the collection must contain all of the fields listed below.
* `branch` - the name of the branch you wish to use
* `provider` - the name of the provider (see below for available providers)
* `repo` - the name of the repository

All providers available in Dinghy are supported. Please refer to the list below for the proper name to use in the configuration for each provider.
* `github`
* `bitbucket-cloud`
* `bitbucket-server`

{{< tabs name="custom" >}}
{{% tab name="Operator" %}}

```yaml
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
          ... # Rest of config omitted for brevity
```

{{% /tab %}}

{{% tab name="Halyard" %}}

This configuration goes inside your `profiles/dinghy-local.yml` file:
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
{{< /tabs >}}

### Other Options

#### Fiat

If Fiat is enabled, add the field `fiatUser: "your-service-account"` to the `dinghy` section in `SpinnakerService` manifest (Operator) or pass the option `--fiat-user "your-service-account"` (Halyard). Note that the service account has to be in a group that has read/write access to the pipelines you will be updating.

If you have app specific permissions configured in Spinnaker, make sure you add the service account. For information on how to create a service account, click [here](https://www.spinnaker.io/setup/security/authorization/service-accounts/#creating-service-accounts).

#### Custom Filename

If you want to change the name of the file that describes pipelines, add the field `dinghyFilename: "your-name-here"` to the `dinghy` section in `SpinnakerService` manifest (Operator) or pass the option: `--dinghyfile-name "your-name-here"` (Halyard).

#### Disabling Locks

If you want to disable lock pipelines in the UI before overwriting changes, add the field `autoLockPipelines: false` to `SpinnakerService` manifest (Operator) or pass the option: `--autolock-pipelines false` (Halyard).

#### Slack Notifications

If you [configured]({{< ref "notifications-slack-configure" >}}) Armory to send Slack notifications for pipeline events, you can configure Dinghy to send pipeline update results to Slack.

{{< tabs name="slack" >}}
{{% tab name="Operator" %}}

```yaml
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
            slack:
              enabled: true       # Whether or not Slack notifications are enabled for dinghy events
              channel: my-channel # Slack channel where notifications will be sent to
              ... # Rest of config omitted for brevity
```

{{% /tab %}}

{{% tab name="Halyard" %}}


```bash
$ hal armory dinghy slack enable --channel my-channel
```

For a complete listing of options check out the [Armory Halyard]({{< ref "armory-halyard#hal-armory-dinghy-edit" >}}) documentation.

{{% /tab %}}
{{< /tabs >}}

![Slack Notifications](/images/dinghy-slack-notifications.png)

#### GitHub Notifications
{{% alert title="New feature" %}}GitHub Notifications is a new feature in Armory 2.24.{{% /alert %}}

As a new feature in Armory's release of 2.24.x+, Dinghy can now provide more robust information to GitHub about executed pipeline changes. This information appears as a comment in the PR.  

>Currently, as of 2.24.1 and 2.25.0, GitHub notifications are not supported with custom endpoints and should be disabled. See the KB article [Dinghy Crashing for Customers using 2.24+ when customers are using a Custom Endpoint](https://support.armory.io/support?id=kb_article&sysparm_article=KB0010290) for details.


{{< tabs name="ghnotifications" >}}
{{% tab name="Operator" %}}

```yaml
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
            github:
              enabled: true       # Whether or not github notifications are enabled for Dinghy events
```

{{% /tab %}}

{{% tab name="Halyard" %}}


In your hal config profiles directory e.g. (`~/.hal/default/profiles/`), update the `dinghy-local.yml` file to include the following:

```yaml
notifiers:
  github:
    enabled: true
```

{{% /tab %}}
{{< /tabs >}}

![GitHub Notifications](/images/armory-admin/dinghy-enable/dinghy-github-notifications.jpg)

### Other Template Formats

> This feature requires Armory 2.5.4 or above.

Dinghy supports two additional template formats in addition to JSON:

* [HCL](https://github.com/hashicorp/hcl)
* [YAML](https://yaml.org/)

> Selecting one of these parsers means that all of your templates must also be in that format.

You need to configure `parserFormat` with one of the parsers:

* `json` (Default)
* `yaml`
* `hcl`

{{< tabs name="other" >}}
{{% tab name="Operator" %}}

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      dinghy:
        parserFormat: hcl
        ... # Rest of config omitted for brevity
```

{{% /tab %}}

{{% tab name="Halyard" %}}

Add the following config to `~/.hal/default/profiles/dinghy-local.yml`:

```yaml
parserFormat: hcl
```

{{% /tab %}}
{{< /tabs >}}

## Known Issues

If Dinghy crashes on start up and you encounter an error in Dinghy similar to:

```bash
time="2020-03-06T22:35:54Z"
level=fatal
msg="failed to load configuration: 1 error(s) decoding:\n\n* 'Logging.Level' expected type 'string', got unconvertible type 'map[string]interface {}'"
```

You probably configured global logging levels with `spinnaker-local.yml`. The work around is to override Dinghy's logging levels:

{{< tabs name="issues" >}}
{{% tab name="Operator" %}}

```yaml
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
          ... # Rest of config omitted for brevity
```

{{% /tab %}}

{{% tab name="Halyard" %}}

Create `.hal/default/profiles/dinghy-local.yml` with the following config:

```bash
Logging:
  Level: INFO
```

{{% /tab %}}
{{< /tabs >}}
