In Armory Enterprise 2.26.3, the location of where you put the `armory.cloud` config block is different from other versions.

{{< tabs name="KnownIssue" >}}
{{% tab name="Operator" %}}



Your Kustomize patch file should resemble the following where `armory.cloud` is a child of the `gate` and `orca` blocks instead of a `spinnaker` block:

```yaml
#patch-plugin-deployment.yml
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
  namespace: <namespace>
spec:
  spinnakerConfig:
    profiles:
      gate:
        spinnaker:
          extensibility:
            # This snippet is necessary so that Gate can serve your plugin code to Deck
            deck-proxy:
              enabled: true
              plugins:
                Armory.Deployments:
                  enabled: true
                  version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                enabled: true
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
        # Note how armory.cloud is a child of gate instead of spinnaker
        armory.cloud:
          enabled: true
          iam:
            clientId: <clientId for Spinnaker from earlier>
            clientSecret: <clientSecret for Spinnaker from earlier>
            tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
          api:
            baseUrl: https://api.cloud.armory.io
      # Note how armory.cloud is a child of orca instead of spinnaker
      orca:
        armory.cloud:
          enabled: true
          iam:
            clientId: <clientId for Spinnaker from earlier>
            clientSecret: <clientSecret for Spinnaker from earlier>
            tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
          api:
            baseUrl: https://api.cloud.armory.io
        spinnaker:
          extensibility:
            plugins:
              Armory.Deployments:
                enabled: true
                version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
            repositories:
              armory-deployment-plugin-releases:
                url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```



{{% /tab %}}
{{% tab name="Halyard" %}}

Your `spinnaker-local.yml` file should not have the `armory.cloud` block anymore and only contain the block to install the Aurora plugin:

```yaml
#spinnaker-local.yml
spinnaker:
  extensibility:
    plugins:
      Armory.Deployments:
        enabled: true
        version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
```

Your `gate-local.yml` file should include the `extensibility` and the `armory.cloud` configurations like the following example:

```yaml
#gate-local.yml
spinnaker:
  extensibility:
    # This snippet is necessary so that Gate can serve your plugin code to Deck
    deck-proxy:
      enabled: true
      plugins:
        Armory.Deployments:
          enabled: true
          version: <Latest-version> # Replace this with the latest version from: https://github.com/armory-plugins/armory-deployment-plugin-releases/releases/
    repositories:
      armory-deployment-plugin-releases:
        enabled: true
        url: https://raw.githubusercontent.com/armory-plugins/armory-deployment-plugin-releases/master/repositories.json
armory.cloud:
  enabled: true
  iam:
    clientId: <clientId for Spinnaker from earlier>
    clientSecret: <clientSecret for Spinnaker from earlier>
    tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
  api:
    baseUrl: https://api.cloud.armory.io
```

Your `orca-local.yml` file should include the `armory.cloud` configration like the following:

```yaml
#orca-local.yml
armory.cloud:
  enabled: true
  iam:
    clientId: <clientId for Spinnaker from earlier>
    clientSecret: <clientSecret for Spinnaker from earlier>
    tokenIssuerUrl: https://auth.cloud.armory.io/oauth/token
  api:
    baseUrl: https://api.cloud.armory.io
```

{{% /tab %}}
{{< /tabs >}}