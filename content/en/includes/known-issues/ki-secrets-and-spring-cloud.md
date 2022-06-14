#### Secrets do not work with Spring Cloud Config

If you enable [Spring Cloud Config](https://spring.io/projects/spring-cloud-config)
all the properties
(e.g. [Docker](https://github.com/spinnaker/clouddriver/blob/1d442d40e1a1eac851288fd1d45e7f19177896f9/clouddriver-docker/src/main/java/com/netflix/spinnaker/config/DockerRegistryConfiguration.java#L58))
using [Secrets]({{< ref "armory-enterprise/armory-admin/secrets" >}})
will not be resolved when spring cloud tries to refresh.

**Affected versions**:

* 2.26.x and later

**Known Affected providers in Clouddriver**:

* Kubernetes
* Cloudfoundry
* Docker

**Workaround**:

Do not use secrets for properties that are annotated with `@RefreshScope`.
