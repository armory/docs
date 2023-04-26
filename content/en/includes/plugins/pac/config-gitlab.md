Add the following to your config file:

```yaml
templateOrg: <repo-org>
templateRepo: <dinghy-templates-repo>
gitlabToken: <abc>
gitlabEndpoint: <https://my-endpoint>
```

All fields are required.

* `templateOrg`: VCS organization or namespace where application and template repositories are located
* `templateRepo`: VCS repository where module templates are located
* `gitlabToken`: GitLab token. This field supports "encrypted" field references; see [Secrets]({{< ref "continuous-deployment/armory-admin/Secrets" >}}) for details.
* `gitlabEndpoint`: GitLab endpoint

Under **Settings** -> **Integrations**  on your project page, point your webhooks to `https://<your-gate-url>/webhooks/git/gitlab`.  Make sure the server your GitLab install is running on can connect to your Gate URL. Armory also needs to communicate with your GitLab installation. Ensure that connectivity works as well.