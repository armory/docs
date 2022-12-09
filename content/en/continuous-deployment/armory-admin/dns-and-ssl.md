---
title: DNS and SSL
# This has different content than install-guide/dns-and-ssl
aliases:
  - /spinnaker_install_admin_guides/dns_and_ssl/
  - /spinnaker_install_admin_guides/dns-and-ssl/
  - /spinnaker-install-admin-guides/dns_and_ssl/
  - /docs/spinnaker-install-admin-guides/dns-and-ssl/
  - /install-guide/dns-and-ssl/
description: >
  Configure your infrastructure so users can access your Spinnaker instance.   
---

## Overview

In order to use Spinnaker in your organization, you're going to want to configure your infrastructure so that users can access Spinnaker.  This has several steps:

* Expose the Spinnaker endpoints (Deck and Gate)
* Configure TLS encryption for the exposed endpoints
* Create DNS entries for your endpoints
* Update Spinnaker so that it's aware of its new endpoints.

## Expose the Spinnaker endpoints
Spinnaker users need access to two endpoints within Spinnaker

* Deck (the Spinnaker UI microservice), which listens on port 9000
* Gate (the spinnaker API microservice), which listens on port 8084

There are a number of ways to expose these endpoints, and your configuration of these will be heavily dependent on the Kubernetes environment where Spinnaker is installed.  Several common options are as follows:

* Set up an ALB ingress controller within your Kubernetes environment, and add an ingress for the `spin-deck` and `spin-gate` services.
* Set up an nginx ingress controller within your Kubernetes environment, and add an ingress for the `spin-deck` and `spin-gate` services.
* Create Kubernetes `loadbalancer` services for both the `spin-deck` and `spin-gate` Kubernetes deployments

## Configure TLS encryption for the exposed endpoints

You should encrypt the exposed Spinnaker endpoints.  There are three high-level ways of achieving this:

* Most common: Terminate TLS on the load balancer(s) in front of the endpoints, and allow HTTP traffic between the load balancer and the endpoint backends.
* Terminate TLS on the load balancer(s) in front of the endpoints, and configure the load balancer and endpoint backends with TLS between them, as well.
* Least common: Configure your load balancer(s) to support the SNI so that the load balancer passes the initial TLS connection to the backends.

There are a number of ways to achieve all of these - you can work with your Kubernetes, security, and networking teams to determine which methods best meet your organization's needs.

If you need to terminate TLS on the backend containers (the second or third options), review the Open Source Spinnaker documentation regarding configuring TLS certificates on the backend microservices: (Setup/Security/SSL)[https://spinnaker.io/setup/security/ssl/].

## Create a DNS Entry for your load balancer

Add a DNS Entry to your DNS management system.  You should only need to add a DNS entry for the user-facing ALB, ELB, or other load balancer which is what you use to currently access Spinnaker.   It typically has a name such as the one below

```
armoryspinnaker-prod-external-123456789.us-west-1.elb.amazonaws.com
```

Add a CNAME entry for the given ELB to create a simple name you will use to access your instance of Spinnaker, e.g. `spinnaker.armory.io`.

## Update Spinnaker configuration

Update the endpoints for Spinnaker Deck (the Spinnaker UI microservice) and Spinnaker Gate (the Spinnaker API microservice)


```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    config:
      security:
        apiSecurity:
          overrideBaseUrl: https://spinnaker-gate.mydomain.com
        uiSecurity:
          overrideBaseUrl: https://spinnaker.mydomain.com
```

Don't forget to apply your changes:

```bash
kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>
```
