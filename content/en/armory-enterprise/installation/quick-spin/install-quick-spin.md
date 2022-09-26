---
title: Install Quick Spin 
linkTitle: "Install Quick Spin"
draft: true
weight: 3
description: >
  Use the Armory Quick Spin container to quickly get an evaluation or testing instance of Spinnaker up and running.
---

{{< include "armory-license.md" >}}

## Prerequisites

To run the Quick `quick-spin` container you need a hosting machine that can support a running instance with 
  - 4 vCPU
  - 8GB Memory
  - 2GB Disk space

The hosting machine must have [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed. Docker Compose is installed with Docker Desktop.

## Usage

To run a local instance of `quick-spin` using [docker compose](https://docs.docker.com/compose/):

1. Clone the [Quick Spin repository](https://github.com/armory-io/quick-spin).
   
```shell
git clone https://github.com/armory-io/quick-spin.git
```
2. From the terminal navigate to the root of the cloned repository.
   
```shell
cd quick-spin
```
3. Run the following command:
   
```shell
docker compose up
```

4. Open the Spinnaker UI in your web browser: [http://localhost:9000](http://localhost:9000).

### Stop quick-spin

To stope the running Quick Spin instance navigate to the terminal instance running the container and:

1. Use the `Ctrl + c` keyboard shortcut.
2. Enter the  `docker compose stop` command.

> Result: The Quick Spin container stops running.  
> The containers are not removed.

To restart the container navigate to the root of the quick-spin repository and  run `docker compose start`.

### Remove quick-spin

To completely the `quick-spin` containers, networks, volumes, and images use:

```shell
docker compose down -v --rmi all
```