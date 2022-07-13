---
title: "Gist vs Codeblock"
draft: true
---

## Overview

Gist pros:

* You don't have to worry about spacing within the markdown codeblock (think yaml).
* A gist displays line numbers.

Gist cons:

* No "one-click" copy. User has to select code, then copy OR clone the entire armory-gists repo


## Gist contains a single file

If the gist is only a single file, simply use the gist key.


{{</* gist armory-gists 543b67dba35c5910ffa48cf1649c8954 */>}}


{{< gist armory-gists 543b67dba35c5910ffa48cf1649c8954 >}}


```bash
#!/bin/bash

# This function creates a new password
newPassword() {
  echo $(openssl rand -base64 32)
}

# Add metadata for host spin-svc.namespace
print_san() {
  local svc
  svc="${1?}"
  printf '%s\n' "subjectAltName=DNS:localhost,DNS:pacrd-controller-manager-metrics-service.${LOCATION}"
}

# Service name
svc=pacrd
# New password
password=$(newPassword)
# Where certs are located and will be added - ca.pem and ca.key should be there
OUT_CERTS_DIR=.
# Namespace to form spin-svc.namespace
LOCATION=mtls
# CA password
CA_PASSWORD=password
# Create key and certificate
openssl genrsa -aes256 -passout "pass:${password}" -out "$OUT_CERTS_DIR/${svc}.key" 2048
openssl req -new -key "$OUT_CERTS_DIR/${svc}.key" -out "$OUT_CERTS_DIR/${svc}.csr" -subj /C=US/CN=spin-${svc}.${LOCATION} -passin "pass:${password}"
openssl x509 -req -in "$OUT_CERTS_DIR/${svc}.csr" -CA "$OUT_CERTS_DIR/ca.pem" -CAkey "$OUT_CERTS_DIR/ca.key" -CAcreateserial -out "$OUT_CERTS_DIR/${svc}.crt" -days 3650 -sha256 -passin "pass:${CA_PASSWORD}" -extfile <(print_san "$svc")
# Save password
echo ${password} > pacrd.pass.txt
```

## Gist contains multiple files

The gist contains multiple files but you only want to display one of the files.



{{</* gist armory-gists f347e1ce0e90ae9d8b6f684c258c804d "pipeline-stage-deploy-manifest.yaml" */>}}

{{< gist armory-gists f347e1ce0e90ae9d8b6f684c258c804d "pipeline-stage-deploy-manifest.yaml" >}}

```yaml
# file: pipeline-stage-deploy-manifest.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-deploymanifest-samples
spec:
  description: A sample showing how to define artifacts.
  application: &app-name pacrd-pipeline-stages-samples
  expectedArtifacts:
    - id: &image-id my-artifact
      displayName: *image-id
      matchArtifact: &manifest-repo-artifact
        type: docker/image
        properties:
          name: my-organization/my-container
          artifactAccount: docker-registry
      defaultArtifact:
        <<: *manifest-repo-artifact
      useDefaultArtifact: true
  stages:
    - type: deployManifest
      properties:
        name: Deploy manifest example
        refId: "1"
        account: kubernetes
        cloudProvider: kubernetes
        moniker:
          app: *app-name
        manifestArtifactId: *image-id
        namespaceOverride: spinnaker
        requiredArtifactIds: [ "my-artifact" ]
        skipExpressionEvaluation: true
        source: artifact
        trafficManagement:
          enabled: true
          options:
            enableTraffic: true
            namespace: jossuegamez
            services: [ "servicea", "serviceb" ]
            strategy: redblack
    - type: deployManifest
      properties:
        name: Deploy text manifest
        refId: "2"
        requisiteStageRefIds: [ "1" ]
        account: kubernetes
        cloudProvider: kubernetes
        moniker:
          app: *app-name
        namespaceOverride: spinnaker
        skipExpressionEvaluation: true
        source: text
        trafficManagement:
          enabled: true
          options:
            enableTraffic: true
            namespace: spinnaker
            services: [ "servicea", "serviceb" ]
            strategy: redblack
        manifests:
          - |
            apiVersion: v1
            kind: Deployment
            metadata:
              name: foo
            spec:
              containers:
                - name: bar
                  image: nginx:1.17
          - |
            apiVersion: v1
            kind: Service
            metadata:
              name: foo
            spec:
              type: ClusterIP
              selector:
                app: foo
              ports:
                - protocol: TCP
                  port: 80
                  targetPort: 80
```
