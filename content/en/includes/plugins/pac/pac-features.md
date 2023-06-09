| Feature       | Armory CD Version | Spinnaker Version | Notes   |
| ------------- | ----------------- | ----------------- | ------- |
| [Fiat service account integration]({{< ref "plugins/pipelines-as-code/install/configure#fiat" >}})                   | All supported versions    | 1.26+ |                 |
| GitHub status notifications                                                            | All supported versions    |   1.26+ |                                              |
| [Local modules for development]({{< ref "plugins/pipelines-as-code/use#local-module-functionality" >}}) | All supported versions    |    1.26+ |                                                  |
| Modules                                                                                | All supported versions   1.26+ |   | Templatize and reuse pipeline snippets across applications and teams |
| Pull Request Validation      | 2.21 or later             |   1.26+ |                                                         |
| [Slack notifications]({{< ref "plugins/pipelines-as-code/install/configure#slack-notifications" >}})                 | All supported versions    |  1.26+ |                                                            |
| [Webhook secret validation]({{< ref "plugins/pipelines-as-code/use#webhook-secret-validation" >}})      | All supported versions    |    1.26+ |                                                       |

**Templating languages**

To create a dinghyfile, you can use one of the following templating languages:

* HashiCorp Configuration Language (HCL)
* JSON
* YAML

**ARM CLI**

The ARM CLI is a tool to render dinghyfiles and modules. Use it to help develop and validate your pipelines locally.

You can find the latest version on [Docker Hub](https://hub.docker.com/r/armory/arm-cli).