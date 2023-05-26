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
          gitlabToken: <abc>
          gitlabEndpoint: <https://my-endpoint>
``` 
