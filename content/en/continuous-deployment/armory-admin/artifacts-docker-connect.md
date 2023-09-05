---
title: Connect Docker Registries
description: >
  Learn how to configure Spinnaker to access a Docker registry.
---

## Overview of connecting Spinnaker to Docker registries

Many of the commands below have additional options that may be useful, or
possibly required.

## Enable Docker registries in Spinnaker

If you've just installed Armory or Open Source Spinnaker<sup>TM</sup>, you need to enable Docker registry providers.

Add the following snippet to `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      providers:
        dockerRegistry:
          enabled: true
```



### Add a Docker registry and repositories to Spinnaker

To add a new registry, you use some variation of the following configuration.
This example uses a public Docker Hub registry (armory/demoapp) and actually
would not use the `username` or `password` options, since the registry is
public.  In most cases, you'll be configuring a private registry and the
authentication credentials will be required, so the options are shown here
as an example.

Add the following snippet to `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    config:
      providers:
        dockerRegistry:
          enabled: true
          primaryAccount: my-docker-registry # Account with search priority. (Required when using a locally deployed registry.)
          accounts:
          - name: my-docker-registry
            requiredGroupMembership: [] # A user must be a member of at least one specified group in order to make changes to this account's cloud resources.
            providerVersion: V1
            permissions: {}
            address: https://index.docker.io   # The registry address you want to pull and deploy images from. For example: index.docker.io - DockerHub quay.io - Quay gcr.io - Google Container Registry (GCR) [us|eu|asia].gcr.io - Regional GCR localhost - Locally deployed registry
            username: yourusername             # Your docker registry username
            password: abc                      # Your docker registry password. This field support "encrypted" secret references.
            email: fake.email@spinnaker.io     # Your docker registry email (often this only needs to be well-formed, rather than be a real address)
            cacheIntervalSeconds: 30           # How many seconds elapse between polling your docker registry. Certain registries are sensitive to over-polling, and larger intervals (e.g. 10 minutes = 600 seconds) are desirable if you're seeing rate limiting.
            clientTimeoutMillis: 60000         # Timeout time in milliseconds for this repository.
            cacheThreads: 1                    # How many threads to cache all provided repos on. Really only useful if you have a ton of repos.
            paginateSize: 100                  # Paginate size for the docker repository _catalog endpoint.
            sortTagsByDate: false              # Sort tags by creation date.
            trackDigests: false                # Track digest changes. This is not recommended as it consumes a high QPM, and most registries are flaky.
            insecureRegistry: false            # Treat the docker registry as insecure (don't validate the ssl cert).
            # repositories:                      # An optional list of repositories to cache images from. If not provided, Spinnaker will attempt to read accessible repositories from the registries _catalog endpoint
            # repositoriesRegex: <regexForYourRepos> # Optional regular expression that specifies what repositories Clouddriver caches images from. This is useful if you add repos frequently. Any new repo that matches the regex gets cached automatically.
            - library/nginx
            # passwordFile: docker-pass        # The path to a file containing your docker password in plaintext (not docker/config.json file). This field support "encryptedFile" secret references.
            # passwordCommand: abc # Command to retrieve docker token/password, commands must be available in environment
            # environment: dev # The environment name for the account. Many accounts can share the same environmen(e.g. dev, test, prod)
```

>Some registries, like Docker Hub, require you to identify the
repositories explicitly, like above.  Some do not (such as the Google
Container Registry).  You can read more in the Spinnaker [docs](https://www.spinnaker.io/setup/install/providers/docker-registry/).

Amazon's ECR requires additional configuration to work properly with Spinnaker.
See the {{< linkWithTitle "artifacts-ecr-connect" >}} guide for details.
