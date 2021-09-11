---
title: "Configure Mutual TLS Authentication"
linkTitle: "Configure mTLS"
weight: 40
description: >
  Configure mTLS authentication in the Armory Agent plugin and service.
---

{{< include "early-access-feature.html" >}}

## {{% heading "prereq" %}}

You need the following to configure mTLS:

* A Certificate Authority (CA) certificate in the `pem` format, used for validating the issuer for mTLS requests.
* Clouddriver certificate and corresponding private key.
* Agent certificate and corresponding private key.

## Agent plugin configuration

### Create a Kubernetes secret

Create a secret that contains your Clouddriver certificate and corresponding key.

```bash
kubectl create secret tls <clouddriver-secret-name> \
   --cert=<your-clouddriver-cert> --key=<your-clouddriver-key>
```

Or:

```bash
kubectl create secret generic <clouddriver-secret-name> \
   --from-file=<your-clouddriver-cert> --from-file=<your-clouddriver-key>
```

### Mount the secret

Mount the secret in the plugin.

In your `agent-plugin/clouddriver-plugin.yaml` file,
`spec.kustomize.clouddriver.deployment.patchesStrategicMerge` section,
add the following lines to mount the Clouddriver cert from your secret:

{{< prism lang="yaml" line="10-18" >}}
spec:
  kustomize:
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  containers:
                  - name: clouddriver
                    volumeMounts:
                      - mountPath: <path> # such as /opt/clouddriver/cert  
                        name: cert
                  volumes:
                  - name: cert
                    secret:
                      secretName: <clouddriver-secret-name>
{{< /prism >}}


### Configure the plugin

In the `agent-plugin/config.yaml` file, configure the plugin to use the mounted certs. Note that `trustCertCollection`, `certificateChain`, and `privateKey` values must in `file:///filepath/filename` format.

{{< prism lang="yaml" line="12-18" >}}
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        kubesvc:
          cluster: redis
          grpc:
            server:
              security:
                enabled: true
                trustCertCollection: file:<path-to-CA-cert>
                certificateChain: file:<path-to-your-clouddriver-cert>
                privateKey: file:<path-to-your-clouddriver-key>
                clientAuth: REQUIRE
{{< /prism >}}

See the {{< linkWithTitle "agent-plugin-options.md" >}} page for additional options.

## Agent service configuration

### Create a secret

Create a secret in the target cluster namespace where the Agent resides.

```bash
kubectl create secret generic <agent-secret-name> \
--from-file=<your-agent-cert> --from-file=<your-agent-key>
```

### Modify deployment configuration

Modify the Agent's deployment configuration in `deployment.yaml` to mount the certs.

>The paths that files are mounted to in the `deployment.yaml` file should always match the corresponding location in the `armory-agent.yaml` configuration file. For example, the `mountPath` of the CA cert in the `deployment.yaml` file must match the `clouddriver.tls.clientCertFile` location in `armory-agent.yaml`.

{{< prism lang="yaml" line="5-19" >}}
spec:
  template:
    spec:
      containers:
        volumeMounts:
        - mountPath: <path> # for example, /opt/armory-agent/cert
          name: armoryagentcert
        - mountPath: <path> # for example, /opt/armory-agent/cacert
          name: clouddrivercacert         
      volumes:
      - name: armoryagentcert
        secret:
          secretName: <agent-secret-name>
      - name: clouddrivercacert         
        secret:                         
          secretName: <clouddriver-secret-name>
      - name: certpem
        secret:
          secretName: <CA-secret-name>
{{< /prism >}}

If you use a custom CA, you can install it on the Agent pod. The default location on that image, which uses the Alpine base, is `/etc/ssl/cert.pem`, so you can either append your CA cert to the trust store, which is `/etc/ssl/cert.pem`, or you can mount the file anywhere and configure the
`clouddriver.tls.cacertFile` property in your YAML to point to that location.

See the [Agent Options]({{< ref "agent-options#options" >}}) for configuration details.

### Configure the service

Add the certificate information in `armory-agent.yaml`. Note that `clientCertFile` and `clientKeyFile` values must in `file:///filepath/filename` format.

{{< prism lang="yaml" line="7-8">}}
clouddriver:
  grpc: <:443
  insecure: false
  tls:
    #serverName: <my-ca>
    insecureSkipVerify: false
    clientCertFile: <path-to-your-agent-cert> #client cert for mTLS.
    clientKeyFile: <path-to-your-agent-key>
    #clientKeyPassword:
{{< /prism >}}

See the [Agent Options]({{< ref "agent-options#options" >}}) for configuration details.

## x509 certificate subject filtering

If you have many Agents that want to talk to Clouddriver, and all of them have valid x509 certificates for mTLS, you can authorize a particular subset by configuring a subject filter in your `clouddriver.yaml` configuration. If a certificate subject line matches **any** of the filters, that certificate is authorized. All non-matching certificate subjects calls are rejected with an `X509CertificateAuthorizationFilterException`.

You can specify multiple filtering criteria. However, the order in which the criteria are read is not guaranteed because when Java reads the certificates, it does not maintain the order used in the certificate itself. Be careful when matching on two parts of a subject line, for example `UID=.*O=Armory`, because the `UID` and `O` attributes may not appear in that order. It might be safest to write a regular expression that can match in any order.

### Plugin filter configuration

Add an `grpc.auth.x509` section to your Clouddriver profile:

{{< prism lang="yaml" line="7-12" >}}
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        kubesvc:
          cluster: redis
          grpc:
            auth:
              x509:
                enabled: true # must be true for filters to be applied
                filters:
                  - UID=([a-z]){3}:[1-9]{3}:ksvc
{{< /prism >}}

See the {{< linkWithTitle "agent-plugin-options.md" >}} page for configuration options.
