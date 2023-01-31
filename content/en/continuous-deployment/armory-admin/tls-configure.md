---
title: Configure TLS for Spinnaker Services
linkTitle: Configure TLS
aliases:
  - /spinnaker_install_admin_guides/spinnaker-services-tls/
  - /spinnaker_install_admin_guides/services_tls/
  - /docs/spinnaker-install-admin-guides/spinnaker-services-ssl/
description: >
  Spinnaker services communicate with each other and can exchange potentially sensitive data. Enabling TLS between services ensures that this data is encrypted and that a service will only communicate with another service that has a valid certificate.
---

> Switching from plain HTTP to HTTPS will cause some short disruption to the services as they become healthy at different times.


## Overview of TLS

When a client attempts to communicate with a server over SSL:
- the server must present a certificate to the user.
- the client must validate that certificate by checking it against its known valid certificate authorities (CA).

To properly set up TLS between services, we need to provide each service with:
1. a certificate signed by a CA
2. the CA certificate to verify these certificates

Note that distributing a CA public key is only needed if you sign certificates with a CA that is not bundled in most systems. **In this document, we assume that you are using a self-signed CA.**

**Java**

Java services can present #1 as a keystore and #2 as a trust store in PKCS12 (preferred) or JKS format.

**Golang**

Golang services need a X509 certificate (PEM format) and a private key for #1 as well as the X509 certificate of the CA for #2.


## What you need

{{% include "admin/tls/what-you-need.md" %}}


## Configuring Java services

Add the following to each Java service profile under `profiles` in the [SpinnakerService's profiles]({{< ref "op-config-manifest#specspinnakerconfigprofiles" >}}):

```yaml
# Only needed for "server" role
server:
  ssl:
    enabled: true
    key-store: <reference to [service].p12>
    key-store-type: PKCS12
    key-store-password: <[SERVICE]_KEY_PASS>

# Needed for all Java services
ok-http-client:
  key-store: <reference to truststore.p12>
  key-store-type: PKCS12
  key-store-password: <TRUSTSTORE_PASS>
  trust-store: <reference to truststore.p12>
  trust-store-type: PKCS12
  trust-store-password: <TRUSTSTORE_PASS>
```

>Currently, `ok-http-client.key-store` is required even though it is not used in a simple TLS setup.

## Configuring Golang services

```yaml
server:
  ssl:
    enabled: true
    certFile: <reference to [service].crt>
    keyFile: <reference to [service].key if not included in the certFile's PEM>
    keyPassword: <[GOSERVICE]_KEY_PASS if required>

http:
  cacertFile: <reference to ca.pem>
```

## Changing service endpoints

{{% include "admin/tls/tls-changing-service-endpoints.md" %}}

## Deploying Spinnaker

After you finish modifying the service YAML files, run `kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>` to apply your changes to your Spinnaker deployment.

Switching from plain HTTP to HTTPS will cause some short disruption to the services as they become healthy at different times.


## Providing certificates and passwords to services

### Secret engines

You can store secrets (and non secrets) in [supported secret stores]({{< ref "secrets" >}}) as well as in Kubernetes secrets if using the [Armory Operator]({{< ref "armory-operator" >}}). This is the simplest route.

For instance, assuming all the information is stored in a bucket named `mybucket` on s3 that all services have access to, `SpinnakerService` manifest  might look like:

```yaml
apiVersion: spinnaker.armory.io/{{< param operator-extended-crd-version >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      echo:
        server:
          ssl:
            enabled: true
            key-store: encryptedFile:s3!b:mybucket!r:us-west-2!f:echo.jks
            key-store-type: JKS
            key-alias: echo
            key-store-password: encrypted:s3!b:mybucket!r:us-west-2!f:passwords.yml!k:echo.keyPassword

        ok-http-client:
          key-store: encryptedFile:s3!b:mybucket!r:us-west-2!f:truststore.jks
          key-store-type: JKS
          key-store-password: encrypted:s3!b:mybucket!r:us-west-2!f:passwords.yml!k:truststorePassword
          trust-store: encryptedFile:s3!b:mybucket!r:us-west-2!f:truststore.jks
          trust-store-type: JKS
          trust-store-password: encrypted:s3!b:mybucket!r:us-west-2!f:passwords.yml!k:truststorePassword
```

Run `kubectl -n <spinnaker namespace> apply -f <SpinnakerService manifest>`  after you make your changes.

### Manually providing information

An alternative if you cannot use one of the supported secret engine is to store the information in Kubernetes secrets and manually provide the information. Files are added through a `volumeMount` and passwords through an environment variable.

For instance, assuming `mysecrets` Kubernetes Secret is available in the same namespace as Spinnaker with the following keys:

```yaml
data:
  echo.jks: <base64 encoded keystore>
```

We'll now provide the following in `service-settings/echo.yml`:
```yaml
kubernetes:
  volume:
  - name: secretvol
    mountPath: /var/mysecrets
```

And a reference would then be:

```yaml
server:
  ssl:
    key-store: /var/mysecrets/echo.jks
```

Apply your changes.

