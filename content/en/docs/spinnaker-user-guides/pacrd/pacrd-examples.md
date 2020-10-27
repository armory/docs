---
title: PaCRD Examples
linkTitle: Example CRDs
description: >
  YAML examples for testing PaCRD pipelines
---

## Application example

```yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Application
metadata:
  name: pacrd-pipeline-stages-samples
spec:
  email: test@armory.io
  description: Description
```



## Pipeline functional examples

### Deploy Nginx
```yaml
# file: deploy-nginx.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-deploymanifest-integration-samples
spec:
  description: A sample showing how to define artifacts.
  application: &app-name pacrd-pipeline-stages-samples
  stages:
    - type: deployManifest
      properties:
        name: Deploy text manifest
        refId: "1"
        requisiteStageRefIds: [ ]
        account: spinnaker
        cloudProvider: kubernetes
        moniker:
          app: *app-name
        skipExpressionEvaluation: true
        source: text
        manifests:
          - |
            apiVersion: apps/v1
            kind: Deployment
            metadata:
              name: nginx-deployment
              labels:
                app: nginx
            spec:
              replicas: 2
              selector:
                matchLabels:
                  app: nginx
              template:
                metadata:
                  labels:
                    app: nginx
                spec:
                  containers:
                  - name: nginx
                    image: nginx:1.14.2
                    ports:
                    - containerPort: 80
```



## Pipeline stages examples

### Bake Manifest
```yaml
# file: pipeline-stage-bakemanifest.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-bakemanifest-samples
spec:
  description: Bake Manifest pipeline sample
  application:  &app-name pacrd-pipeline-stages-samples
  stages:
    - type: bakeManifest
      properties:
        name: Bake Application
        refId: "1"
        outputName: *app-name
        templateRenderer: helm2
```

### Check Preconditions
```yaml
# file: pipeline-stage-checkpreconditions.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-checkpreconditions-samples
spec:
  description: Check Preconditions example
  application: &app-name pacrd-pipeline-stages-samples
  parameterConfig:
    - name: canary_deploy
      default: "false"
      hasOptions: false
      label: canary_deploy
      pinned: false
      required: true
  stages:
    - type: checkPreconditions
      properties:
        name: Check Canary
        refId: "1"
        preconditions:
          - type: expression
            context:
              expression: parameters[  \"canary_deploy\"  ]  == \"true\"
              failureMessage: "this execution failed"
            failPipeline: true
```

### Delete Manifest
```yaml
#file: pipeline-stage-deletemanifest.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-deletemanifest-samples
spec:
  description: Samples for DeleteManifest
  application: &app-name pacrd-pipeline-stages-samples
  stages:
    - type: deleteManifest
      properties:
        name: Static target
        refId: "1"
        account: kubernetes
        app: *app-name
        cloudProvider: kubernetes
        location: spinnaker
        mode: static
        kind: apiService
        targetName: testingName
        options:
          cascading: true
          gracePeriodSeconds: 60
    - type: deleteManifest
      properties:
        name: Dynamic target
        refId: "2"
        requisiteStageRefIds: [ "1" ]
        account: kubernetes
        app: *app-name
        cloudProvider: kubernetes
        location: spinnaker
        mode: dynamic
        cluster: test-cluster
        kind: apiService
        criteria: newest
        options:
          cascading: true
          gracePeriodSeconds: 60
    - type: deleteManifest
      properties:
        name: Match by labels
        refId: "3"
        requisiteStageRefIds: [ "2" ]
        account: kubernetes
        app: *app-name
        cloudProvider: kubernetes
        location: spinnaker
        mode: label
        kinds: [ "apiService", "clusterRoleBinding" ]
        labelSelectors:
          selectors:
            - key: testkey
              kind: EQUALS
              values:
                - value1
                - value2
            - key: testkey2
              kind: NOT_EXISTS
              values:
                - value1
                - value2
        options:
          cascading: true
          gracePeriodSeconds: 60
```

### Deploy manifest
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

### Find artifacts from resource
```yaml
# file: pipeline-stage-findartifactsfromresource.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-findartifactsfromresource-samples
spec:
  description: Find Artifacts From Resource pipeline sample
  application: &app-name pacrd-pipeline-stages-samples
  stages:
    - type: findArtifactsFromResource
      properties:
        refId: "1"
        name: Find Baseline
        account: kubernetes
        app: *app-name
        cloudProvider: kubernetes
        location: spinnaker
        manifestName: deployment something
        mode: static
```


### Manual Judgment
```yaml
# file: pipeline-stage-manualJudgment.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-manualjudgment-samples
spec:
  description: Manual Judgment pipeline sample
  application: &app-name pacrd-pipeline-stages-samples
  stages:
    - type: manualJudgment
      properties:
        name: Manual example
        refId: "1"
        failPipeline: true
        instructions: Check if this stage works
```

### Undo Rollout Manifest
```yaml
# file: pipeline-stage-undorolloutmanifest.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-undorollout-samples
spec:
  description: Samples for undorollout
  application: &app-name pacrd-pipeline-stages-samples
  stages:
    - type: manualJudgment
      properties:
        name: Should we start?
        refId: "1"
        failPipeline: true
        instructions: Check if this stage works
    - type: undoRolloutManifest
      properties:
        name: Static target
        refId: "2"
        requisiteStageRefIds: [ "1" ]
        account: kubernetes
        app: *app-name
        cloudProvider: kubernetes
        location: &location ffreire
        mode: static
        kind: apiService
        targetName: testingName
        numRevisionsBack: 1
```

### Unknown stage
```yaml
# file: pipeline-stage-unknown.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-unknown-samples
spec:
  description: Samples for unknown pipelines
  application: &app-name pacrd-pipeline-stages-samples
  parameterConfig:
    - name: example_var
      default: "false"
      hasOptions: false
      label: example_var
      pinned: false
      required: true
  stages:
    - type: wait
      properties:
        refId: "2"
        name: Wait Stage
        waitTime: 30
    - type: pipeline
      properties:
        refId: "5"
        requisiteStageRefIds:
          - "2"
        name: Execute second pipeline
        failPipeline: true
        # This should be changed for the actual pipeline Id
        pipeline: 9a3fe533-5b0e-4d1e-8ceb-2fe4a9a5e7ab
        waitForCompletion: true
```

### Webhook
```yaml
# file: pipeline-stage-webhook.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: pacrd-webhook-samples
spec:
  description: Samples for Webhooks
  application:  &app-name pacrd-pipeline-stages-samples
  stages:
    - type: webhook
      properties:
        name: Waiting for completion from webhook repsonse
        refId: "1"
        cancelEndpoint: http://test/cancel
        cancelMethod: POST
        cancelPayload: |
          {
            "cancelation": "payload"
          }
        canceledStatuses: CANCELED, CANCEL
        customHeaders: |
          {
            "customheader": "customvalue",
            "customheader2": "customalue2"
          }
        method: POST
        payload: |
          {
            "test": "payloadtest",
            "statuscode": 200
          }
        progressJsonPath: $.buildInfo.status
        failFastStatusCodes: [ 404, 418 ]
        retryStatusCodes: [ 404, 418 ]
        statusJsonPath: $.buildInfo.status
        statusUrlResolution: webhookResponse
        statusUrlJsonPath:  $.buildInfo.url
        successStatuses: SUCCESS, OK
        terminalStatuses: TERMINAL, FINISHED
        url: http://test
        waitBeforeMonitor: "1"
        waitForCompletion: true
        comments: This is a test for weekhooks
        signalCancellation: true
```

