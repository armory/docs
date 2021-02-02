---
title: Armory Halyard
weight: 3
description: >
  Armory-extended Halyard is a versatile command line interface (CLI) to configure and deploy Armory in Kubernetes or any cloud environment. 
---

{{< include "halyard-note.md" >}}

## Running in Docker

Running Armory-extended Halyard in Docker is convenient and portable. The daemon will need access to files and environment variables, such as:
- Halyard's main configuration directory - make sure the daemon has write access to that directory
- `kubeconfig` file for Spinnaker's installation cluster (usually `~/.kube/config`)
- AWS profiles (usually `~/.aws`) if access to AWS is needed
- Any other configuration files that reside on the Docker host

> The Docker container expects to use `heptio-authenticator-aws` instead of `aws-iam-authenticator`

### Starting Daemon

{{% include "install/docker-note.md" %}}

You can start Armory-extended Halyard in a Docker container with the following command:

```bash
docker run --name armory-halyard --rm \
    -v ~/.hal:/home/spinnaker/.hal \
    -v ~/.kube:/home/spinnaker/.kube \
    -v ~/.aws:/home/spinnaker/.aws \
    -it docker.io/armory/halyard-armory:{{< param halyard-armory-version >}}
```

> Note: If you're installing to Google Cloud, you'll want to change the
> ".aws" mapping above to your Google credentials json file, and then
> you'll need to set the environment variable GOOGLE_APPLICATION_CREDENTIALS
> within the shell so the installer can find it.

Our installer currently expects to find your kubeconfig named `config` in
the `.kube` directory you map below.  If you've named your config something
else, you'll need to rename or symlink the file accordingly.

### Running Halyard Commands

Once Armory-extended Halyard is running, you can interact with it by opening a separate
Terminal and running:

```bash
docker exec -it armory-halyard bash
```

From there, you can issue all your [Halyard commands](https://www.spinnaker.io/reference/halyard/).

## Run in Kubernetes

Armory-extended Halyard can also be installed as a Kubernetes `StatefulSet`. The advantage of running Halyard in the same cluster as Spinnaker is to get the same network access as Spinnaker itself in some locked down environments.

### Installing Daemon

You can install Armory-extended Halyard with the following manifest:

```yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: halconfig-pvc
  labels:
    app: halyard
  namespace: halyard
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi

---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: halyard
  namespace: halyard
spec:
  replicas: 1
  selector:
    matchLabels:
      app: halyard
  serviceName: halyard
  template:
    metadata:
      labels:
        app: halyard
    spec:
      containers:
      - name: halyard
        image: index.docker.io/armory/halyard-armory:{{< param halyard-armory-version >}}
        volumeMounts:
        - name: halconfig
          mountPath: /home/spinnaker/
      securityContext:
        fsGroup: 65533
      volumes:
      - name: halconfig
        persistentVolumeClaim:
          claimName: halconfig-pvc
```

Copy and paste the manifest into a file named halyard.yml, then deploy the above manifest (halyard.yml) into Kubernetes with the following command:
```bash
kubectl apply -f halyard.yml
```
> Note: This installs Halyard into the namespace 'halyard'


### Running Halyard Commands

Once the `StatefulSet` is ready - you can interact with it by running:

```bash
kubectl -n halyard exec -ti statefulset/halyard -- bash
```

Users of Kubernetes versions older than 1.16 may need to run this instead:

```bash
kubectl -n halyard exec -ti statefulset/halyard bash
```

Be sure to check the `kubectl` [docs](https://kubernetes.io/docs/reference/kubectl/kubectl/) for the version of Kubernetes that you are running.
