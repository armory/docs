---
title: Clound Foundry Support
description: Armory supports Cloud Foundry on a customer-by-customer basis. Additionally, Armory's support for the Cloud Foundry provider in Armory Continuous Deployment is limited to what is explicitly defined on this page.
toc_hide: true
exclude_search: true
aliases:
  - /pcf-support/
---

## Supported Cloud Foundry Versions

The Cloud Foundry (CF) provider in Armory Continuous Deployment is based on versions 3.38.0 and 2.103.0 of Cloud Foundry. Features available in subsequent versions of Cloud Foundry are not guaranteed to be compatible with or available in Armory Continuous Deployment.

## Supported  Resources

This section outlines the types of Cloud Foundry resources that Armory Continuous Deployment supports.

* **Applications**
  - Application deployment attributes (manifest)
      - [Application Attributes](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#optional-attributes)
          - [buildpacks](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#buildpack)
          - [command](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#start-commands)
          - [disk_quota](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#disk-quota)
          - [docker](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#docker)
          - [health-check-http-endpoint](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#health-check-http-endpoint)
          - [health-check-type](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#health-check-type)
          - [instances](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#instances)
          - [memory](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#memory)
          - [no-route](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#no-route)
          - [path](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#path)
          - [processes](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#processes)
          - [random-route](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#random-route)
          - [routes](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#routes)
          - [stack](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#stack)
          - [timeout](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#timeout)
      - [Environment Variables](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#env-block)
      - [Services](https://docs.cloudfoundry.org/devguide/deploy-apps/manifest-attributes.html#services-block)
      - [Routes](https://docs.cloudfoundry.org/devguide/deploy-apps/routes-domains.html)

* **[Services](https://docs.cloudfoundry.org/devguide/services/)**
  - User Provided
  - Managed
* **[Routes (Loadbalancers)](https://docs.cloudfoundry.org/devguide/deploy-apps/routes-domains.html)**



## Supported Operations

Armory Continuous Deployment supports the following Cloud Foundry related stages in application pipelines:

**Stages**
  - Deploy CF ServerGroup
  - Destroy CF ServerGroup
  - Clone CF ServerGroup
  - Resize CF ServerGroup
  - Deploy CF Service
  - Destroy CF Service
  - Create CF Service Key
  - Delete CF Service Key
  - Create CF Service Bindings
  - Delete CF Service Bindings
  - Map CF Loadbalancer
  - Unmap CF Loadbalancer
  - Bake CF Manifest

There may be more Cloud Foundry related stages available than these, but Armory provides no guarantee in regards to their functionality.

## Supported Rollout Strategies

Armory Continuous Deployment supports the following rollout strategies for Cloud Foundry applications:

- No strategy
- Highlander
- Blue/Green (formerly known as Red/Black in Spinnaker)
- Rolling Blue/Green (formerly known as Rolling Red/Black in Spinnaker)
- Canary
