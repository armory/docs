Bitbucket has both cloud and server offerings. See the Atlassian [docs](https://confluence.atlassian.com/bitbucketserver/bitbucket-rebrand-faq-779298912.html) for more on the name change from Stash to Bitbucket Server. Consult your company's Bitbucket support desk if you need help determining what flavor and version of Bitbucket you are using.

Add the following to your config file:

```yaml
spec:
  spinnakerConfig:
    config:
      armory:
        dinghy:
          enabled: true
          templateOrg: <repo-org>
          templateRepo: <dinghy-templates-repo>
          stashUsername: <stash_user>
          stashToken: <abc>
          stashEndpoint: <https://my-endpoint> 
```