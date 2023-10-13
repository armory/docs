---
---
{{< highlight yaml "linenos=table,hl_lines=12-14 21-22" >}}
profiles:
  gate:
    spinnaker:
      extensibility:
        repositories:
          pluginRepository:
            url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
        plugins:
          Armory.GitHubIntegration:
            enabled: true
            version: <version>
          Armory.ArmoryHeader:
            enabled: true
            version: 0.2.0
        deck-proxy:
          enabled: true
          plugins:
            Armory.GitHubIntegration:
              enabled: true
              version: <version>
            Armory.ArmoryHeader:
              enabled: true
{{< /highlight >}}