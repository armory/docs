---
title: "Getting started with Spinnaker using Quick Spin"
linktitle: "Quick Spin"
description: >
  Use Quick Spin to quickly get Spinnaker up and running.
---

## {{% heading "prereq" %}}

To create a Spinnaker instance using Quick Spin you must have Docker and Docker Compose installed on your machine.
> Docker Compose is installed with Docker Desktop

## Spin up a Spinnaker instance using Quick Spin
Use the following steps to run a local instance of quick-spin using docker compose.

1. Clone the [quick-spin](https://github.com/armory-io/quick-spin) repository.
   `git clone https://github.com/armory-io/quick-spin.git'`
2. Change directory into the root of the project.
   `cd quick-spin`
3. Start the docker container.
   `docker compose up`
4. Navigate to the Spinnaker UI from a browser.
   `http://localhost:9000`

### Stop the Quick Spin container
- Stop a running Quick Spin container using one of the following options:
Stopping the container using the `Ctrl + c` keyboard shortcut from the terminal where the instance is running. 
 - In the terminal, from the the root of the `quick-spin` directory issue the `docker compose stop` command.

Both options stop the container but do not remove the instance. Remove the container  containers, networks, volumes, and images created with the `compose up` command with:
`docker compose down -v --rmi all`

##Configuring Kubernetes on Quick Spin
By default, `quick-spin` uses the `~/.kube/config` file to fetch kubernetes configuration. To define a different patch for the config file inclue the configuration in the docker-compose.yml file.

> Example:
```
services:
  quick-spin:
    volumes:
      - type: bind
        source: ~/.kube/config
        target: /home/spinnaker/.kube/config
```
### Connect to a local K8s instance
To connect to a local Kubernetes instance like a Kind test bed or a Minikube instance, replace the `server` value for the cluster property with the localhost path.

> Default server configuration in the kube config file
```
# ~/.kube/config
apiVersion: v1
clusters:
- cluster:
    server: https://127.0.0.1:53133
```

> Example server configuration for a local Kubernetes instance
# ~/.kube/config
apiVersion: v1
clusters:
- cluster:
    server: https://host.docker.internal:53133```
```






