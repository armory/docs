---
title: PaCRD
linkTitle: PaCRD
description: >
  PaCRD is a Kubernetes controller that manages the lifecycle of applications and pipelines within a cluster.
aliases:
  - /docs/spinnaker/pacrd/
  - /docs/spinnaker-user-guides/pacrd
---

PaCRD (a combination of "Pipelines as Code" and "Custom Resource Definition") is
a [Kubernetes controller](https://kubernetes.io/docs/concepts/architecture/controller/) that manages the lifecycle of Spinnaker<sup>TM</sup> applications
and pipelines as objects within your cluster. PaCRD extends Kubernetes
functionality to support Spinnaker Application and Pipeline objects that can be
observed for changes through a mature lifecycle management API.

With PaCRD you can:

- Maintain your Spinnaker pipelines as code with the rest of your Kubernetes
manifests.
- Persist Pipeline and Application changes with confidence to your Spinnaker
cluster.
- Leverage existing tools like Helm and Kustomize to template your pipelines
across teams and projects.

To get started right away, check out the [Quick Start](#quick-start) section for installation instructions.

## Prerequisites

To use PaCRD, make sure you meet the following requirements:

- Have a working Kubernetes 1.11+ cluster
- Have a working Spinnaker installation
  - Although there is no minimum version required for this experiment, Armory
  recommends using the latest release
- Have permissions to install CRDs, create RBAC roles, and create service
accounts

## Quick Start

Download the current `pacrd` manifest to your local machine:

```bash
curl -fsSL https://engineering.armory.io/manifests/pacrd-1.0.0.yaml > pacrd-1.0.0.yaml
```

Then, inspect the manifest to make sure it is compatible with your cluster.

Create the following files in the directory where you downloaded the `pacrd` manifest to customize the
installation: `kustomization.yaml` and `patch.yaml`.

Start by creating a `kustomization.yaml` file, which contains
the installation settings:

```yaml
# file: kustomization.yaml
resources:
  - pacrd-1.0.0.yaml
patchesStrategicMerge:
  - patch.yaml
namespace: spinnaker  # Note: you should change this value if you are _not_ deploying into the `spinnaker` namespace.
```

Next, create a `patch.yaml` file that contains your `pacrd` config. If you are not
deploying into the `spinnaker` namespace, update the `front50` and `orca` keys:

```yaml
# file: patch.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: pacrd-config
  namespace: spinnaker
data:
  pacrd.yaml: |
    spinnakerServices:
      # NOTE: change `spinnaker` to your namespace name here
      front50: http://spin-front50.spinnaker:8080
      orca: http://spin-orca.spinnaker:8083
    # OPTIONAL: uncomment the next line to configure a Fiat service account, it should be at the same level that spinnakerServices.
    # fiatServiceAccount: my-service-account
```

When you are ready, apply the `pacrd` manifest to your cluster:

```bash
# If using `kubectl` >= 1.14
kubectl apply -k .

# Otherwise, use `kustomize` and `kubectl` toegether
kustomize build | kubectl apply -f -
```

<!--

Since we're still experimental, and we don't allow a lot of configuration right
now, I'm omitting this section of the docs. When we start to firm up the details
of how this will be installed and run we can expand the Installation section
and include details about customizing an install.

## Installation

!-->

## Usage

Once you have PaCRD installed and running in your cluster, you can define your applications and pipelines. Then apply them to the cluster.

While this product is in an [**Experimental**]({{< ref "release-definitions" >}}) state, [kind](https://github.com/kubernetes-sigs/kind) objects for PaCRD
live under the `pacrd.armory.spinnaker.io/v1alpha1` version moniker.

## Applications

In Spinnaker, an Application is a logical construct that allows you to group
resources under a single name. You can read more about applications in the
Spinnaker [docs](https://www.spinnaker.io/guides/user/applications/#about-applications).

For available Application configuration options check out
[our CRD documentation here](../pacrd-crd-docs/).

### Creating an application

In Kubernetes, define your application in an `application.yaml` file.  The configuration fields are the same as what you see when you [create an application](https://www.spinnaker.io/guides/user/applications/create/#create-an-application) using the Spinnaker UI. The following example defines an application named "myapplicationname".

*Note: Application names must adhere to both [Kubernetes](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/)
__and__ Spinnaker name standards.*

```yaml
#file: application.yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Application
metadata:
  name: pacrd-pipeline-stages-samples
spec:
  email: test@armory.io
  description: Description
```

Create the application in your cluster by running:

```bash
kubectl apply -f application.yaml
```

Check on the status of your application by using either the `get` or `describe`
commands. `kubectl` recognizes either `app` or `application` for the resource
kind:

```bash
kubectl get app myapplicationname

# or kubectl get application myapplicationname
```

The command returns information similar to the this:

```
NAME                URL                                                             LASTCONFIGURED   STATUS
myapplicationname   http://spinnaker.io/#/applications/myapplicationname/clusters   7m26s            Created
```

### Updating an application

You can update in one of two ways:

- Reapply the application manifest in your repository
   -  `kubectl apply -f application.yaml`
- Edit the application manifest in-cluster
   - `kubectl edit app myapplicationname`

When you update your application in Kubernetes, the changes propagate into
Spinnaker. If an error occurs during the update, your application may show an
`ErrorFailedUpdate` state. You can see the details of that failure by describing
the resource and looking in the "Events" section:

```bash
kubectl describe app myapplicationname
```

### Deleting an application

You can delete an application in one of two ways:

- Reapply the application manifest in your repository
   - `kubectl delete -f application.yaml`
- Delete the application directly
   - `kubectl delete app myapplicationname`

When you delete your application in Kubernetes, the deletion propagates into
Spinnaker. If an error occurs during deletion, your application may show an
`ErrorFailedDelete` state. You can see the details of that failure by describing
the resource and looking in the "Events section":

```bash
kubectl describe app myapplicationname
```

## Pipelines

Pipelines allow you to encode the process that your team follows to take a
service from commit to a desired environment, such as production. You can
read more about pipelines in the Spinnaker [docs][https://www.spinnaker.io/concepts/pipelines/].

View Pipeline configuration options in the [CRD documentation](../pacrd-crd-docs/).

### Creating pipelines

In Kubernetes, define your pipeline in a `pipeline.yaml` file. The configuration fields are the same as what you see when you [create a pipeline](https://www.spinnaker.io/guides/user/pipeline/managing-pipelines/#create-a-pipeline) using the Spinnaker UI. The following example defines a simple pipeline named "myapplicationpipeline", which bakes a manifest and prompts for a manual judgment.

*Note: This example assumes that you've created the `myapplicationname`
application from the [previous section](#applications). Create one before
proceeding if you have not done so already.*

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

Create your pipeline in your cluster:

```bash
kubectl apply -f pipeline.yaml
```

Check on the status of your pipeline by using either the `get` or `describe`
commands. `kubectl` will recognize either `pipe` or `pipeline` for the resource
kind:

```bash
kubectl get pipe myapplicationpipeline

# or ... kubectl get pipeline myapplicationpipeline
```

The command returns information similar to the this:

```
NAME                    STATUS    LASTCONFIGURED   URL
myapplicationpipeline   Updated   5s               http://spinnaker.company.com/#/applications/myapplicationname/executions/configure/f1eb82ce-5a8f-4b7a-9976-38e4aa022702
```

A `describe` call can give you additional contextual information about the
status of your pipeline:

```bash
kubectl describe pipeline myapplicationpipeline
```

The command returns information similar to the this::

```
Name:         myapplicationpipeline
API Version:  pacrd.armory.spinnaker.io/v1alpha1
Kind:         Pipeline
Metadata:
  # omitted for brevity
Spec:
  # omitted for brevity
Status:
  Id:               f1eb82ce-5a8f-4b7a-9976-38e4aa022702
  Last Configured:  2020-03-09T15:55:27Z
  Phase:            Updated
  URL:              http://localhost:9000/#/applications/myapplicationname/executions/configure/f1eb82ce-5a8f-4b7a-9976-38e4aa022702
Events:
  Type     Reason                 Age                From       Message
  ----     ------                 ----               ----       -------
  Normal   Updated                94s                pipelines  Pipeline successfully created in Spinnaker.
  Warning  ErrorUpdatingPipeline  93s                pipelines  Bad Request: The provided id f1eb82ce-5a8f-4b7a-9976-38e4aa022702 doesn't match the pipeline id null
  Normal   Updated                91s (x2 over 91s)  pipelines  Pipeline successfully updated in Spinnaker.
```

### Updating pipelines

You can update a pipeline in one of two ways:

- Reapply the pipeline manifest in your repository
   - `kubectl apply -f pipeline.yaml`
- Edit the pipeline manifest in-cluster
   - `kubectl edit pipeline myapplicationpipeline`

When you update your pipeline in Kubernetes, the changes propagate into
Spinnaker. If an error occurs during the update, your pipeline may show an
`ErrorFailedUpdate` state. You can see the details of that failure by describing
the resource and looking in the "Events" section:

```bash
kubectl describe pipeline myapplicationpipeline
```

### Deleting pipelines

You can delete a pipeline in one of two ways:

- Delete the pipeline manifest from your repository definition
   - `kubectl delete -f pipeline.yaml`
- Delete the pipeline directly
   - `kubectl delete pipeline myapplicationpipeline`

When you delete your pipeline in Kubernetes, the deletion propagates into
Spinnaker. If an error occurred during deletion, then your pipeline may show an
`ErrorFailedDelete` state. You can see the details of that failure by describing
the resource and looking in the "Events section":

```bash
kubectl describe pipeline myapplicationpipeline
```

## Artifacts

An [artifact](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/) is an object that references an external
resource. Examples include a Docker container, a file in source control, an AMI,
or a binary blob in S3. Artifacts in PaCRD come in two types:

- **Definitions** contain all necessary information to locate an artifact.
- **References** contain enough information to find a Definition.

### Defining Artifacts

Define your pipeline artifacts in a section called `expected artifacts`. The
following example defines a single container image that the pipeline expects as
an input to the BakeManifest stage:

```yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: my-pipeline
spec:
  description: A sample showing how to define artifacts.
  application: my-application
  expectedArtifacts:
    - id: &image-id my-application-docker-image
      displayName: *image-id
      matchArtifact:
        type: docker/image
        properties:
          name: my-organization/my-container
          artifactAccount: docker-registry
  stages:
    - type: bakeManifest
      properties:
        name: Bake Application
        refId: "1"
        outputName: myManifest
        templateRenderer: helm2
        inputArtifacts:
          - id: *image-id
```

Each `matchArtifact` block contains:

- `type`: **required**; the artifact classification; see the [Types of Artifacts](https://www.spinnaker.io/reference/artifacts-with-artifactsrewrite/types/overview/) section in the Spinnaker documentation for supported types
- `properties`: dictionary of key-value pairs appropriate for that artifact

PaCRD only validates officially supported artifacts. PaCRD does not validate custom artifacts or artifacts defined [via Plugins](https://www.spinnaker.io/guides/user/plugins/user-guide/).

### Referencing Artifacts

Reference artifacts in the `inputArtifacts` section of a pipeline stage. You
can use either the artifact `id` or `displayName`. If you are new to using
artifacts, you can use the `displayName` value, which is most often what appears
when the Spinnaker UI displays your pipeline.

The following example defines two artifacts in the `expectedArtifacts` section. Each artifact is then referenced in the `inputArtifacts` section of the `bakeManifest` stage. The first is declared with `id` and the second with `displayName`.

```yaml
apiVersion: pacrd.armory.spinnaker.io/v1alpha1
kind: Pipeline
metadata:
  name: my-pipeline
spec:
  description: A sample showing how to reference artifacts.
  application: my-application
  expectedArtifacts:
    - id: first-inline-artifact-id
      displayName: My First Inline Artifact Id
      matchArtifact:
        type: embedded/base64
        properties:
          name: my-inline-artifact
    - id: second-inline-artifact-id
      displayName: My Second Inline Artifact
      matchArtifact:
        type: embedded/base64
        properties:
          name: my-second-inline-artifact
  stages:
    - type: bakeManifest
      properties:
        name: Bake Application
        refId: "1"
        outputName: myManifest
        templateRenderer: helm2
        inputArtifacts:
          - id: first-inline-artifact-id
          - displayName: My Second Inline Artifact
```

PaCRD validates that the `inputArtifacts` referenced in the `bakeManifest` stage
correspond to exactly one artifact declared in the `expectedArtifacts` section
of the CRD.

PaCRD throws a `PipelineValidationFailed` error when it can't find an input
artifact in the list of expected artifacts. You can see which input artifact
failed validation by executing a describe call against the pipeline under
creation. If you use the above example but replace the `id` reference with
`a-nonsense-value`, pipeline validation fails.

Execute `kubectl describe`:

```bash
kubectl describe pipeline my-pipeline
```

Expected output displays which input artifact failed validation:

```
Events:
  Type     Reason                    Age                    From       Message
  ----     ------                    ----                   ----       -------
  Normal   Updated                   2m53s (x2 over 2m54s)  pipelines  Pipeline successfully updated in Spinnaker.
  Warning  PipelineValidationFailed  0s (x4 over 3s)        pipelines  artifact with id "a-nonsense-value" and name "" could not be found for this pipeline
```

## Setting up New Relic

If you want to setup a New Relic configuration you can add your license to your `patch.yaml` file like:

   ```yaml
   # file: patch.yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: pacrd-config
     namespace: spinnaker
   data:
     pacrd.yaml: |
       spinnakerServices:
         # NOTE: change `spinnaker` to your namespace name here
         front50: https://spin-front50.spinnaker:8080
         orca: https://spin-orca.spinnaker:8083
       # fiatServiceAccount: <fiatServiceAccount>
       newRelicLicense: <newRelicLicense>
   ```

Since reconciliation happens multiple times per minute, Armory sends metrics only during the first three minutes of each hour.   Error messages contain obfuscated URLs, application names, and pipeline names.

By default the application name will be `pacrd`, if you want to change this you can add `NewRelicAppName` property at the same level of `newRelicLicense` and add your own custom application name.

Here's an example of error stack traces.

![](/images/pacrd/new_relic.png)



## Setting up mTLS

If you want to set up mTLS for this particular service, you need to configure Spinnaker for mTLS first. See [Configuring mTLS for Spinnaker Services]({{< ref "mtls-configure" >}}) for details.

### Prerequisites

- ca.pem file
- ca.key file
- ca certificate password
- pacrd.crt
- pacrd.key
- pacrd certificate password (pacrd.pass.txt)

If you don't have the PaCRD certificate, key, and password files, you can generate them using this script:

{{< gist armory-gists 543b67dba35c5910ffa48cf1649c8954 >}}

Once you have that information you can continue.

### Steps

1. Add the PaCRD certificate files as a Kubernetes secret:

   ```bash
   kubectl create secret generic pacrd-cert \
           --from-file=./pacrd.crt \
           --from-file=./pacrd.key \
           --from-file=./pacrd.pass.txt \
           --from-file=./ca.pem
   ```

1. Go to the `pacrd` installation folder that has your` kustomization.yaml`, `patch.yaml`, and `pacrd.yaml`.  Create a new file called `mtls.yaml` with the following content:

   ```yaml
   # file: mtls.yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     labels:
       control-plane: controller-manager
     name: pacrd-controller-manager
     namespace: spinnaker
   spec:
     template:
       spec:
         containers:
         - name: manager
           containers:
           volumeMounts:
           - mountPath: /opt/secrets
             name: pacrd-certificates
         volumes:
         - secret:
             secretName: pacrd-cert
           name: pacrd-certificates
   ```

   This file will mount the certificates to `/opt/secrets/` in the pacrd manager container.

1. Update `kustomization.yaml` to include the `mtls.yaml` file:

   ```yaml
   # file: kustomization.yaml
   resources:
     - pac_new.yaml
   patchesStrategicMerge:
     - patch.yaml
     - mtls.yaml
   namespace: spinnaker # Note: you should change this value if you are _not_ deploying into the `spinnaker` namespace.
   ```

1. Update your `patch.yaml` file to add the certificate information:

   ```yaml
   # file: patch.yaml
   apiVersion: v1
   kind: ConfigMap
   metadata:
     name: pacrd-config
     namespace: spinnaker
   data:
     pacrd.yaml: |
       spinnakerServices:
         # NOTE: change `spinnaker` to your namespace name here
         front50: https://spin-front50.spinnaker:8080
         orca: https://spin-orca.spinnaker:8083
       # fiatServiceAccount: <fiatServiceAccount>
       # newRelicLicense: <newRelicLicense>
       server:
         ssl:
           enabled: true
           certFile: /opt/secrets/pacrd.crt
           keyFile: /opt/secrets/pacrd.key
           keyPassword: /opt/secrets/pacrd.pass.txt
           cacertFile: /opt/secrets/ca.pem
           clientAuth: want
       http:
         cacertFile: /opt/secrets/ca.pem
         clientCertFile: /opt/secrets/pacrd.crt
         clientKeyFile: /opt/secrets/pacrd.key
         clientKeyPassword: /opt/secrets/pacrd.pass.txt
   ```

1. Redeploy your service with `kustomize build | kubectl apply -f -`

## Known Limitations

## v0.1.x - v0.9.x

### Applications

- Deleting an application in Kubernetes triggers the following behavior:

    - Delete the application in Kubernetes.
    - Delete the application in Spinnaker.
    - Delete pipelines associated with the application _in Spinnaker only_.

### Pipelines

- Pipeline stages must be defined with a `type` key for the stage name and a
key of the same name where all stage options live. For example, for the
"Bake Manifest" stage you would structure your definition like this:

```yaml
# ...
stages:
  - type: BakeManifest
    bakeManifest:
      name: Bake the Bread
      # ...
# ...
```


## v0.1.x - v0.4.0

### Applications

- Documentation for available Application spec fields must be
found in the installation manifest for this controller. You can do so by
grepping for `applications.pacrd.armory.spinnaker.io` in the installation
manifest. Fields are documented under `spec.validation.openAPIV3Schema`.

### Pipelines

- Documentation for available Pipeline spec fields must be
found in the installation manifest for this controller. You can do so by
grepping for `pipelines.pacrd.armory.spinnaker.io` in the installation
manifest. Fields are documented under `spec.validation.openAPIV3Schema`.
