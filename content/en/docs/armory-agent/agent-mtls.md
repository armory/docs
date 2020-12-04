---
title: "Configuring Mutual TLS Authentication"
linkTitle: "Configuring mTLS"
weight: 11
description: >
  Configure mTLS authentication in the Armory Agent plugin and service.
---

<!--
Code is located in gist.github.com. Login creds are in 1Password.
-->

## Overview

@TODO - do we need this section?

## Prerequisites

You need the following In order to configure mTLS:

* Clouddriver certificate and private key
* `CA.crt`

You can create a certificate and keys like this:

```bash
# The first step is to create a certificate authority (CA) that both the client and server trust
openssl req -new -x509 -nodes -days 365 -subj '/CN=my-ca' -keyout ca.key \
    -out ca.crt

openssl x509 -in ca.crt -text -noout

#server cert
openssl genrsa -out server.key 2048

openssl req -new -key server.key -subj '/CN=localhost' -out server.csr

openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
    -days 365 -out server.crt

openssl x509 -in server.crt -text -noout

#client certificate
openssl genrsa -out client.key 2048

openssl req -new -key client.key -subj '/CN=my-client' -out client.csr

openssl x509 -req -in client.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
    -days 365 -out client.crt
```



## Agent plugin configuration


1. Create a secret that contains `clouddriver.crt` and `clouddriver.pem`.

   ```bash
   kubectl create secret tls vincent-clouddriver-agent-v3 \
       --cert=clouddriver.crt --key=clouddriver.key  
   ```

   Or:

   ```bash
   kubectl create secret generic vincent-clouddriver-agent-v3 \
       --from-file=clouddriver.crt --from-file=clouddriver.key
   ```

1. Mount the secret in the plugin.

   In your `agent-plugin/clouddriver-plugin.yaml` file, add lines 43-44 and 48-50 to mount the Clouddriver cert from your secret.

   <details><summary>Show the script</summary>
   {{< gist  armory-gists 26186532a4cce0b7f8bc203fb9ab758a "agent-plugin-cloudriver-plugin.yaml" >}}
   </details>

1. Configure the Agent to use the mounted certs in the `agent-plugin/config.yaml` file. See lines 12 - 19 in the file below. Note that `certificateChain`, `trustCertCollection`, and `privateKey` values must in in `file:///filepath/filename` format.

   <details><summary>Show the script</summary>
   {{< gist  armory-gists 26186532a4cce0b7f8bc203fb9ab758a "agent-plugin-config.yaml" >}}
   </details>


   See the {{< linkWithTitle "agent-plugin-options.md" >}} for additional options.

## Agent service configuration

1. Create a secret in the target cluster namespace where the Agent resides.

   ```bash
   kubectl create secret generic armoryagentcert \
   --from-file=agent.crt --from-file=agent.key
   ```

1. Modify the Agent's deployment configuration to mount the certs.

   If you have a custom CA, you need to mount the cert into the known trusted cert location:  `/etc/ssl/cert.pem`. Golang apps in Alpine use `/etc/ssl/cert.pem` as the source of a trusted CA.

      1. Obtain a copy of the `cert.pem` file from a running Agent.
      2. Append your custom CA onto the copied `cert.pem`  (e.g. `cat ca.crt >> cert.pem`)
      3. Mount `cert.pem` to Agent deployment


   <br/>
   See lines 53-54 and 74-76 for how to mount the certs.

   See lines 59-60 and 80-82 for how to mount the custom certs.

   <details><summary>Show the script</summary>
   {{< gist  armory-gists 26186532a4cce0b7f8bc203fb9ab758a "agent-service-deployment.yaml" >}}
   </details>

1.  Configure the Agent.

   See lines 19-25 for an example of how to configure the Agent.

   <details><summary>Show the script</summary>
   {{< gist  armory-gists 26186532a4cce0b7f8bc203fb9ab758a "kubesvc.yaml" >}}
   </details>

   See the {{< linkWithTitle "agent-options.md" >}} for additional options.

## Forward proxy configuration

@TODO are we assuming the reader knows when and why to do this?

1. Add proxy variables in the Agent's deployment file.

   See lines 25-30.

   <details><summary>Show the script</summary>
   {{< gist  armory-gists 26186532a4cce0b7f8bc203fb9ab758a "forward-proxy-config.yaml" >}}
   </details>

1. Configure the Agent for **not** proxying Kubernetes traffic intended for KubeAPI in your cluster.

   Add this `noProxy: true` option to have traffic destined for Kubernetes ignore the proxy environment settings under `kubernetes`. @TODO what file is this?

   See line 13.

   <details><summary>Show the script</summary>
   {{< gist  armory-gists 26186532a4cce0b7f8bc203fb9ab758a "no-proxy-snippet.yaml" >}}
   </details>

