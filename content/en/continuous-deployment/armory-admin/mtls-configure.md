---
title: Configure mTLS for Spinnaker Services
linkTitle: Configure mTLS
aliases:
- /docs/spinnaker-install-admin-guides/service-mtls/
description: This guide describes how to enable mutual TLS (mTLS) between Spinnaker services. Adding mTLS provides additional security for your Spinnaker services since only validated clients can interact with services when mTLS is enabled.
---

## Overview of mTLS

mTLS is a transport level security measure. When a client connects to a server, as in a TLS connection:
- The server responds with its certificate. Additionally, the server sends a certificate request and a list of Distinguished Names the server recognizes.
- The client verifies the certificate of the server and responds with its own certificate and the Distinguished Name its certificate was (in)directly signed with.
- The server verifies the certificate of the client.


To set up TLS, provide the following:

1. For a server:
   - Certificate and private key
   - Chain of certificates to validate clients

1. For a client:
   - Certificate and private key to present to the server
   - Chain of certificates to validate the server (if self signed)

For information about TLS, see {{< linkWithTitle "tls-configure" >}}.

## What you need

{{% include "admin/tls/what-you-need.md" %}}

## Configuring Java services

Add the following to each Java service under `profiles` in the [SpinnakerService's profiles]({{< ref "continuous-deployment/installation/armory-operator/op-manifest-reference#specspinnakerconfigprofiles" >}}):

```yaml
# Only needed for "server" role
server:
  ssl:
    enabled: true
    key-store: <reference to [service].p12>
    key-store-type: PKCS12
    key-store-password: <[SERVICE]_KEY_PASS>
    trust-store: <reference to ca.p12>
    trust-store-type: PKCS12
    trust-store-password: <TRUSTSTORE_PASS>
    # Roll out with "want" initially
    client-auth: need

# Needed for all Java services
ok-http-client:
  key-store: <reference to [service].p12>
  key-store-type: PKCS12
  key-store-password: [SERVICE]_KEY_PASS
  trust-store: <reference to truststore.p12>
  trust-store-type: PKCS12
  trust-store-password: <TRUSTSTORE_PASS>
```


## Configuring Golang services

```yaml
server:
  ssl:
    enabled: true
    certFile: <reference to [service].crt>
    keyFile: <reference to [service].key if not included in the certFile's PEM>
    keyPassword: <[GOSERVICE]_KEY_PASS if required>
    cacertFile: <reference to ca.pem>
    # Roll out with "want" initially
    clientAuth: need

http:
  cacertFile: <reference to ca.pem>
  clientCertFile: <reference to [service].crt>
  clientKeyFile: <reference to [service.key]>
  clientKeyPassword: <[GOSERVICE]_KEY_PASS if required>
```

## Changing service endpoints

{{% include "admin/tls/tls-changing-service-endpoints.md" %}}

## Changing readiness probe

Change the readiness probe used by Kubernetes from an HTTP request to a TCP probe.

Add the following snippet to each service in `SpinnakerService` manifest:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:  
    service-settings:
      <service>:
        kubernetes:
          useTcpProbe: true
```


## Deployment

Apply your changes to your Spinnaker deployment:

```bash
kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>
```

If Spinnaker services are already using HTTPS, you can roll out mTLS without interruption by making the client certificate optional (`want`) in `server.ssl.client-auth` (Java) and `server.ssl.clientAuth`. Then once all the services are stable, rolling out a new configuration with that value set to `need`.
