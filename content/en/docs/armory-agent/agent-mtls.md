---
title: "Configure Mutual TLS Authentication"
linkTitle: "Configure mTLS"
weight: 40
description: >
  Configure mTLS authentication in the Armory Agent plugin and service.
---

## {{% heading "prereq" %}}

You need the following to configure mTLS:

* Clouddriver certificate and private key
* `CA.crt`

You can create a certificate and keys like this:

```bash
# The first step is to create a certificate authority (CA) that both the Agent and Clouddriver trust
openssl req -new -x509 -nodes -days 365 -subj '/CN=my-ca' -keyout ca.key \
    -out ca.crt

openssl x509 -in ca.crt -text -noout

#Clouddriver cert
openssl genrsa -out clouddriver.key 2048

openssl req -new -key clouddriver.key -subj '/CN=localhost' -out clouddriver.csr

openssl x509 -req -in clouddriver.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
    -days 365 -out clouddriver.crt

openssl x509 -in clouddriver.crt -text -noout

#client certificate
openssl genrsa -out agent.key 2048

openssl req -new -key agent.key -subj '/CN=my-client' -out agent.csr

openssl x509 -req -in agent.csr -CA ca.crt -CAkey ca.key -CAcreateserial \
    -days 365 -out agent.crt
```



## Agent plugin configuration

### Create a secret

Create a secret that contains `clouddriver.crt` and `clouddriver.pem`.

```bash
kubectl create secret tls <your-secret-name> \
   --cert=clouddriver.crt --key=clouddriver.key  
```

Or:

```bash
kubectl create secret generic <your-secret-name> \
   --from-file=clouddriver.crt --from-file=clouddriver.key
```

### Mount the secret

Mount the secret in the plugin.

In your `agent-plugin/clouddriver-plugin.yaml` file,
`spec.kustomize.clouddriver.deployment.patchesStrategicMerge` section,
add the following lines to mount the Clouddriver cert from your secret:

{{< prism lang="yaml" line="20-21, 26-28" >}}
spec:
  kustomize:
    clouddriver:
      deployment:
        patchesStrategicMerge:
          - |
            spec:
              template:
                spec:
                  initContainers:
                  - name: kubesvc-plugin
                    image: docker.io/armory/kubesvc-plugin:<release>
                    volumeMounts:
                      - mountPath: /opt/plugin/target
                        name: kubesvc-plugin-vol
                  containers:
                  - name: clouddriver
                    volumeMounts:
                      - mountPath: /opt/clouddriver/lib/plugins
                        name: kubesvc-plugin-vol
                      - mountPath: /opt/clouddriver/cert  
                        name: cert
                  volumes:
                  - name: kubesvc-plugin-vol
                    emptyDir: {}
                  - name: cert
                    secret:
                      secretName: <your-secret-name>
{{< /prism >}}


### Configure the plugin

Configure the plugin to use the mounted certs in the `agent-plugin/config.yaml` file. Note that `certificateChain`, `trustCertCollection`, and `privateKey` values must in `file:///filepath/filename` format.

{{< prism lang="yaml" line="12-20" >}}
apiVersion: spinnaker.armory.io/{{< param "operator-extended-crd-version" >}}
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        # See https://docs.armory.io/docs/installation/armory-agent/agent-options/
        kubesvc:
          cluster: redis
          grpc:
            server:
              security:
                enabled: true
                certificateChain: file:<path-to-agent.crt>
                trustCertCollection: file:<path-to-agent.crt>
                privateKey: file:<path-to-agent.key>
                clientAuth: REQUIRE
{{< /prism >}}

See the {{< linkWithTitle "agent-plugin-options.md" >}} page for additional options.

## Agent service configuration

### Create a secret

Create a secret in the target cluster namespace where the Agent resides.

```bash
kubectl create secret generic <agent-secret-name> \
--from-file=agent.crt --from-file=agent.key
```

### Modify deployment configuration

Modify the Agent's deployment configuration to mount the certs. @TODO what file is this in?

If you have a custom CA, you need to mount the cert into the known trusted cert location:  `/etc/ssl/cert.pem`. Golang apps in Alpine use `/etc/ssl/cert.pem` as the source of a trusted CA.

  1. Obtain a copy of the `cert.pem` file from a running Agent.
  2. Append your custom CA onto the copied `cert.pem`  (for example `cat ca.crt >> cert.pem`)
  3. Mount `cert.pem` to Agent deployment

@TODO is this config correct? do the "this didn't work" sections work now or not?

{{< prism lang="yaml"  >}}
spec:
  template:
    spec:
      containers:
        volumeMounts:
        - mountPath: /opt/kubesvc/cert
          name: armoryagentcert
        - mountPath: /opt/spinnaker/config
          name: volume-kubesvc-config
        - mountPath: /opt/kubesvc/cacert  # this didn't work as of Nov 2020
          name: clouddrivercacert         # this didn't work as of Nov 2020
      volumes:
      - name: armoryagentcert
        secret:
          secretName: <agent-secret-name>
      - name: clouddrivercacert         # this didn't work as of Nov 2020
        secret:                         # this didn't work as of Nov 2020
          secretName: <your-secret-name> # this didn't work as of Nov 2020
      - name: certpem
        secret:
          secretName: ??? @TODO what secret is this?
{{< /prism >}}


### Configure the service

@TODO what file is this in?

{{< prism lang="yaml" >}}
clouddriver:
  grpc: <:443
  insecure: false
  tls:
    #serverName: my-ca  #to override the server name to verify
    insecureSkipVerify: false #if true, don't verify server's cert
    clientKeyFile: /opt/kubesvc/cert/agent.key #ref to the private key (mTLS)
    #clientKeyPassword: #if the clientKeyFile is password protected
    #cacertFile: /opt/kubesvc/cacert/ca.crt #to validate server's cert
    clientCertFile: /opt/kubesvc/cert/agent.crt #client cert for mTLS.

{{< /prism >}}

See the {{< linkWithTitle "agent-options.md" >}} for additional options.

## Forward proxy configuration

### Add proxy variables

Add proxy variables in the Agent's deployment file. @TODO what file is this?

{{< prism lang="yaml" line="25-30" >}}
spec:
  template:
    spec:
      containers:
      - image: armory/kubesvc
        env:
        - name: HTTP_PROXY
          value: <proxyaddress:proxyport>
        - name: HTTPS_PROXY
          value: <proxyaddress:proxyport>
{{< /prism >}}

### Configure the Agent

Configure the Agent to **not** proxy Kubernetes traffic intended for KubeAPI in your cluster.

Add the `noProxy: true` option to have traffic destined for Kubernetes ignore the proxy environment settings under `kubernetes`.

@TODO what file is this?

{{< prism lang="yaml" line="12" >}}
kubernetes:  
  accounts: []
  noProxy: true
{{< /prism >}}

## x509 certificate subject filtering

If you have many Agents that want to talk to Clouddriver, and all of them have valid x509 certificates for mTLS, you can authorize a particular subset by configuring a subject filter in your `clouddriver.yaml` configuration. If a certificate subject line matches **any** of the filters, that certificate is authorized. All non-matching certificate subjects calls are rejected with an `X509CertificateAuthorizationFilterException`.

You can specify multiple filtering criteria. However, the order in which the criteria are read is not guaranteed. Be careful when matching on two parts of a subject line, for example `UID=.*O=Armory`, because the `UID` and `O` attributes may not appear in that order. It might be safest to write a regular expression that can match in any order.

### Plugin filter configuration

Add an `grpc.auth.x509` section to your Clouddriver profile. See lines 7-13 in the following example:


{{< prism lang="yaml" line="7-13" >}}
spec:
  spinnakerConfig:;;
    profiles:
      clouddriver:
        kubesvc:
          cluster: redis
          grpc:
            auth:
              x509:
				        #Note: enabled must be true for filters to be applied
                enabled: true
                filters:
                  - UID=([a-z]){3}:[1-9]{3}:ksvc
            server:
              security:
                enabled: true
                # protocols: SSLv2Hello:TLSv1:TLSv1.1:TLSv1.2:TLSv1.3
                clientAuth: REQUIRE
                trustCertCollection: file:<path-to-ca.crt>
                certificateChain: file:<path-to-clouddriver.crt>
                privateKey: file:<path-to-clouddriver.key>
               # privateKeyPassword: <private-key-password>
{{< /prism >}}
