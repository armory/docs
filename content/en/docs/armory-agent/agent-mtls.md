---
title: "Configure Mutual TLS Authentication"
linkTitle: "Configure mTLS"
weight: 40
description: >
  Configure mTLS authentication in the Armory Agent plugin and service.
---

<!--
Code is located in gist.github.com. Login creds are in 1Password.
-->

## {{% heading "prereq" %}}

You need the following to configure mTLS:

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

In your `agent-plugin/clouddriver-plugin.yaml` file, add lines 43-44 and 48-50 to mount the Clouddriver cert from your secret.

{{< prism lang="yaml" line="43-44, 48-50" >}}
apiVersion: spinnaker.armory.io/v1alpha2
kind: SpinnakerService
metadata:
  name: spinnaker
spec:
  spinnakerConfig:
    profiles:
      clouddriver:
        spinnaker:
          extensibility:
            pluginsRootPath: /opt/clouddriver/lib/plugins
            plugins:
              Armory.Kubesvc:
                enabled: true
  kustomize:
    clouddriver:
      service:
        patchesStrategicMerge:
          - |
            spec:
              ports:
                - name: http
                  port: 7002
                - name: grpc
                  port: 9091
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


### Configure the Agent

Configure the Agent to use the mounted certs in the `agent-plugin/config.yaml` file. See lines 12 - 19 in the following example. Note that `certificateChain`, `trustCertCollection`, and `privateKey` values must in `file:///filepath/filename` format.

{{< prism lang="yaml" line="12-19" >}}
apiVersion: spinnaker.armory.io/v1alpha2
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
                certificateChain: file:///opt/clouddriver/cert/tls.crt
                # list of crts
                trustCertCollection: file:///opt/clouddriver/cert/tls.crt
                # cacert
                privateKey: file:///opt/clouddriver/cert/tls.key
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

Modify the Agent's deployment configuration to mount the certs.

If you have a custom CA, you need to mount the cert into the known trusted cert location:  `/etc/ssl/cert.pem`. Golang apps in Alpine use `/etc/ssl/cert.pem` as the source of a trusted CA.

  1. Obtain a copy of the `cert.pem` file from a running Agent.
  2. Append your custom CA onto the copied `cert.pem`  (for example `cat ca.crt >> cert.pem`)
  3. Mount `cert.pem` to Agent deployment

In the following example, see lines 53-54 and 74-76 for how to mount the certs and lines 59-60 and 80-82 for how to mount the custom certs.

{{< prism lang="yaml" line="53-54, 59-60, 74-76, 80-82" >}}
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: spin
    app.kubernetes.io/name: kubesvc
    app.kubernetes.io/part-of: spinnaker
    cluster: spin-kubesvc
  name: spin-kubesvc
spec:
  replicas: 1
  selector:
    matchLabels:
      app: spin
      cluster: spin-kubesvc
  template:
    metadata:
      labels:
        app: spin
        app.kubernetes.io/name: kubesvc
        app.kubernetes.io/part-of: spinnaker
        cluster: spin-kubesvc
    spec:
      # imagePullSecrets:
      # - name: regcred
      containers:
      - env:
        - name: GRPC_GO_LOG_SEVERITY_LEVEL
          value: INFO
        - name: GRPC_GO_LOG_VERBOSITY_LEVEL
          value: "9999"
        image: armory/kubesvc
        imagePullPolicy: IfNotPresent
        name: kubesvc
        ports:
          - name: health
            containerPort: 8082
            protocol: TCP
          - name: metrics
            containerPort: 8008
            protocol: TCP
        readinessProbe:
          httpGet:
            port: health
            path: /health
          failureThreshold: 3
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /opt/kubesvc/cert
          name: armoryagentcert
        - mountPath: /opt/spinnaker/config
          name: volume-kubesvc-config
        - mountPath: /opt/kubesvc/cacert  # this didn't work as of Nov 2020
          name: clouddrivercacert         # this didn't work as of Nov 2020
        - mountPath: /etc/ssl
          name: certpem
        resources:
          limits:
            cpu: 1000m
            memory: 1Gi
          requests:
            cpu: 200m
            memory: 500Mi
      serviceAccount: kubesvc
      restartPolicy: Always
      volumes:
      - name: volume-kubesvc-config
        configMap:
          name: kubesvc-config
      - name: armoryagentcert
        secret:
          secretName: <your-secret-name>
      - name: clouddrivercacert         # this didn't work as of Nov 2020
        secret:                         # this didn't work as of Nov 2020
          secretName: <your-secret-name> # this didn't work as of Nov 2020
      - name: certpem
        secret:
          secretName: <your-secret-name>
{{< /prism >}}


### Configure the Agent

In the following example, see lines 19-25 for how to configure the Agent.

{{< prism lang="yaml" line="19-25" >}}
kubernetes:
  accounts:
  - name: <account-name>
    serviceAccount: true
    #permissions:
    #  WRITE:
    #  - APPDEV_TEAMA
    #  READ:
  # Add your accounts here; /kubeconfigfiles is the path where kubeconfig files added
  # to kustomization.yaml are mounted.
#  - kubeconfigFile: /kubeconfigfiles/kubecfg-test.yml
#    name: account1
#    metrics: false
#    kinds: []
#    omitKinds: []
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
#certFile: #deprecated
# OPTIONAL
# server:
#   port: 8082

prometheus:
  enabled: true
  # port: 8008
{{< /prism >}}

See the {{< linkWithTitle "agent-options.md" >}} for additional options.

## Forward proxy configuration

### Add proxy variables

Add proxy variables in the Agent's deployment file.

See lines 25-30.

{{< prism lang="yaml" line="25-30" >}}
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: spin
    app.kubernetes.io/name: kubesvc
    app.kubernetes.io/part-of: spinnaker
    cluster: spin-kubesvc
  name: spin-kubesvc
spec:
  replicas: 1
  selector:
    matchLabels:
      app: spin
      cluster: spin-kubesvc
  template:
    metadata:
      labels:
        app: spin
        app.kubernetes.io/name: kubesvc
        app.kubernetes.io/part-of: spinnaker
        cluster: spin-kubesvc
    spec:
      containers:
      - image: armory/kubesvc
        env:
        - name: HTTP_PROXY
          value: <proxyaddress:proxyport>
        - name: HTTPS_PROXY
          value: <proxyaddress:proxyport>
        imagePullPolicy: IfNotPresent
        name: kubesvc
        ports:
          - name: health
            containerPort: 8082
            protocol: TCP
          - name: metrics
            containerPort: 8008
            protocol: TCP
        readinessProbe:
          httpGet:
            port: health
            path: /health
          failureThreshold: 3
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
        volumeMounts:
        - mountPath: /opt/spinnaker/config
          name: volume-kubesvc-config
        - mountPath: /kubeconfigfiles
          name: volume-kubesvc-kubeconfigs
      restartPolicy: Always
      volumes:
      - name: volume-kubesvc-config
        configMap:
          name: kubesvc-config
      - name: volume-kubesvc-kubeconfigs
        secret:
          defaultMode: 420
          secretName: kubeconfigs-secret
---
apiVersion: v1
kind: Service
metadata:
  name: kubesvc-metrics
  labels:
    app: spin
    cluster: spin-kubesvc
spec:
  ports:
  - name: metrics
    port: 8008
    targetPort: metrics
    protocol: TCP
  selector:
    app: spin
    cluster: spin-kubesvc
{{< /prism >}}

### Configure the Agent

Configure the Agent to **not** proxy Kubernetes traffic intended for KubeAPI in your cluster.

Add the `noProxy: true` option to have traffic destined for Kubernetes ignore the proxy environment settings under `kubernetes`.

See line 13.

{{< prism lang="yaml" line="12" >}}
kubernetes:  
  accounts: []
  # Add your accounts here, /kubeconfigfiles is the path where kubeconfig files added
  # to kustomization.yaml are mounted.
#  - kubeconfigFile: /kubeconfigfiles/kubecfg-test.yml
#    name: account1
#    metrics: false
#    kinds: []
#    omitKinds: []
    # You can add all the other fields from clouddriver settings, they'll be ignored.

  noProxy: true

clouddriver:
  grpc: spin-clouddriver-grpc:9091

server:
  port: 8082

prometheus:
  enabled: true
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