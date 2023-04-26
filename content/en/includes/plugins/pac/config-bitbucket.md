Bitbucket has both cloud and server offerings. See the Atlassian [docs](https://confluence.atlassian.com/bitbucketserver/bitbucket-rebrand-faq-779298912.html) for more on the name change from Stash to Bitbucket Server. Consult your company's Bitbucket support desk if you need help determining what flavor and version of Bitbucket you are using.

Add the Bitbucket configuration:

```yaml
templateOrg: <repo-org>
templateRepo: <dinghy-templates-repo>
stashUsername: <stash_user>
stashToken: <abc>
stashEndpoint: <https://my-endpoint>
```

All fields are required.

* `templateRepo`: VCS repository where module templates are located
* `stashUsername`: Stash username
* `stashToken`: Stash token. This field supports "encrypted" field references; see [Secrets]({{< ref "continuous-deployment/armory-admin/Secrets" >}}) for details.
* `stashEndpoint`: Stash API endpoint. If you're using Bitbucket Server, update the endpoint to include the api e.g. https://your-endpoint-here.com/rest/api/1.0

>If you're using Bitbucket Server, update the endpoint to include the api, e.g. `--stash-endpoint https://your-endpoint-here.com/rest/api/1.0`

You need to set up webhooks for each project that has the `dinghyfile` or module separately. Make the webhook `POST` to: `https://spinnaker.your-company.com:8084/webhooks/git/bitbucket`. If you're using Stash `<v3.11.6`, you need to install the [webhook plugin](https://marketplace.atlassian.com/plugins/com.atlassian.stash.plugin.stash-web-post-receive-hooks-plugin/server/overview) to be able to set up webhooks.