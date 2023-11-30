---
---
{{< highlight yaml "linenos=table,hl_lines=12-14 21-22" >}}
profiles:
    spinnaker:
      spinnaker:
        extensibility:
          repositories:
            pluginRepository:
              url: https://raw.githubusercontent.com/armory-plugins/pluginRepository/master/repositories.json
          plugins:
            Armory.AWSCATsOnEvent:
              enabled: true
              version: <version>
      clouddriver: &clouddriver-cats
        spinnaker:
          extensibility:
            plugins:
              Armory.AWSCATsOnEvent:
                enabled: true
      clouddriver-ro:
        *clouddriver-cats
      clouddriver-rw:
        *clouddriver-cats
      clouddriver-caching:
        *clouddriver-cats
      gate:
        spinnaker:
          extensibility:
            plugins:
              Armory.AWSCATsOnEvent:
                enabled: true

{{< /highlight >}}