---
title: Configure Gate and Deck to Run on the Same Hostname
linkTitle: Configure Gate and Deck for the Same Hostname
description: >
  Simplify DNS and Ingress management by deploying Gate and Deck to the same host.  
aliases:
  - /docs/spinnaker-install-admin-guides/single-hostname-deck-gate/
---

## Overview

The Spinnaker<sup>TM</sup> microservice Gate serves as the API gateway for
Armory and is leveraged by the Deck microservice to display various Armory data
via a user interface. In order to successfully use the Deck UI, both Deck and
Gate must be accessible via DNS. The standard approach to configuring access to
both Deck and Gate is to set DNS routing to each service on separate hostnames
or separate sub-domains of the same hostname. While this approach is typical,
it increases the complexity of both DNS management and Ingress management into
Kubernetes.

To simplify both DNS management and Ingress management, Armory can be configured
to serve the Gate microservice on the same hostname as the Deck UI but located
at a sub-path. We recommend configuring the Gate microservice so that it is served from the `/api/v1` of the Deck UI hostname when using a single hostname for both Deck and Gate.

## Prerequisites for running on the same host

* Deck is accessible at `https://spinnaker.example.com`
* Gate is accessible at `https://spinnaker.example.com/api/v1`
* Kubernetes Ingress and Service is used to route traffic from these paths to port 8084 on Gate and 9000 on Deck.

>Note: Configuring a Kubernetes Ingress and Service is outside the scope of this document.

## Configure Spinnaker


1. Set Gate's server servlet to be aware of its context path at `/api/v1` in your `SpinnakerService` config.

   Add the following under the `spec.spinnakerConfig.profiles` section:

   ```yaml
   gate:
     server:
       servlet:
         context-path: /api/v1
   ```

1. Set Gate's health endpoint to `/api/v1/health` in your `SpinnakerService` config.

   Add the following under the `spec.spinnakerConfig.service-settings` section:

   ```yaml
   gate:
     healthEndpoint: /api/v1/health
   ```

1. Update Deck's URL in your `SpinnakerService` config.

   Add the following under the `spec.config.security` section:

   ```yaml
   uiSecurity:
     overrideBaseUrl: https://spinnaker.example.com
   ```

1. Update Gate's URL in your `SpinnakerService` config.

   Add the following under the `spec.config.security` section:

   ```yaml
   apiSecurity:
     overrideBaseUrl: https://spinnaker.example.com/api/v1
   ```

1. Deploy your `SpinnakerService` config using either `kubectl` or `kustomize` command syntax


