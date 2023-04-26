Add the following to your config file:

```yaml
templateOrg: <repo-org>
templateRepo: <dinghy-templates-repo>
githubToken: <abc>
githubEndpoint: <https://api.github.com>
```

All fields are required.

* `templateOrg`: VCS organization or namespace where application and template repositories are located
* `templateRepo`: VCS repository where module templates are located
* `githubToken`: GitHub token; This field supports "encrypted" field references; see [Secrets]({{< ref "continuous-deployment/armory-admin/Secrets" >}}) for details.
* `githubEndpoint`: (Default: https://api.github.com) GitHub API endpoint. Useful if you’re using GitHub Enterprise.

**GitHub webhooks**

Set up webhooks at the organization level for push events. You can do this by going to `https://github.com/organizations/<your_org_here>/settings/hooks`.

1. Set `content-type` to `application/json`.
1. Set the `Payload URL` to your Gate URL. Depending on whether you configured Gate to use its own DNS name or a path on the same DNS name as Deck, the URL follows one of the following formats:

   * `https://<your-gate-url>/webhooks/git/github` if you have a separate DNS name or port for Gate
   * `https://<your-spinnaker-url>/api/v1/webhooks/git/github` if you're using a different path for Gate

If your Gate endpoint is protected by a firewall, you need to configure your firewall to allow inbound webhooks from GitHub's IP addresses. You can find the IPs in this API [response](https://api.github.com/meta). Read more about [GitHub's IP addresses](https://help.github.com/articles/about-github-s-ip-addresses/).

You can configure webhooks on multiple GitHub organizations or repositories to send events to Dinghy. Only a single repository from one organization can be the shared template repository in Dinghy. However, Dinghy can process pipelines from multiple GitHub organizations. You want to ensure the GitHub token configured for Dinghy has permission for all the organizations involved.

**Pull request validations**

When you make a GitHub pull request (PR) and there is a change in a `dinghyfile`, Pipelines-as-Code automatically performs a validation for that `dinghyfile`. It also updates the GitHub status accordingly. If the validation fails, you see an unsuccessful `dinghy` check.

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
