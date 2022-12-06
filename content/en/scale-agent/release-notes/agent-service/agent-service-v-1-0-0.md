---
title: v1.0.0 Armory Agent Service (2022-01-05)
toc_hide: true
version: 01.00.00

---

## New Features

### Admin REST API

There are new REST endpoints to help you better troubleshoot Agent:

* GET `/accounts`: Returns the list of accounts loaded by Agent, together with their discovered kinds
* GET `/operations`: Returns the list of currently executing operations, such as list and deploy.
* GET `/watches`: Returns the list of watches, grouped by account and watch state.
* GET `/debug/pprof`: Returns information exported by Golang to diagnose Go applications, like stack traces of all goroutines and heap allocations.

### Structured logging

Log messages now enforce including key-value pairs that are relevant to the message and context, which makes it easier to locate relevant information to search through logs by filtering for the correct key-value pairs.

The following list describes the supported key-value pairs:

* `agentId`: Identifier of the Armory Agent instance logging the message.
* `account`: Account name related to the message.
* `kind`: Kubernetes kind name.
* `group`: Kubernetes API group name.
* `operationId`: UUID of the operation logging the message.
* `operationType`: Name of the operation, such as list or deploy.
* `namespace`: Namespace (if applicable).
* `watchedNamespace`: For messages logged by the watching system, this is the namespace that is being watched. An empty string means watching in all namespaces.
* `error`: Error message, if any.
* `msg`: The actual log message.
* `level`: Log level.
* `time`: Logged time.

Example:
```
time="2022-01-04T18:14:16Z" level=info msg="Watcher: full kind recache with 114 objects" account=account-859 agentId=7e01bfa1-c522-49ad-8c06-1a3f22b8979a group=apps kind=ReplicaSet watchedNamespace="(all namespaces)"
time="2022-01-04T18:14:16Z" level=warning msg="too old resource version: 89585712 (89626290)" account=account-856 agentId=7e01bfa1-c522-49ad-8c06-1a3f22b8979a group=apps kind=ReplicaSet watchedNamespace="(all namespaces)"
time="2022-01-04T21:24:00Z" level=info msg="Operation Deploy processed (status 201 Created) in 13.887357ms" account=account-000 agentId=24a230e6-6b89-44fa-9664-a922f4768a1e namespace=testns-000 operationId=01FRKFMF52JBWB3ZW1K3676P8H operationType=Deploy
```


### New Prometheus metrics

The following new Prometheus metrics are available in this version:

* `kubesvc_kubernetes_requests`  [Counter]: Amount of requests sent to a Kubernetes API Server.
* `kubesvc_watches`  [Gauge]: Amount of live watches registered to Kubernetes API Servers to monitor changes in the cluster.

## Improvements

### Faster reconnection

In previous versions, Agent validated access to all the kinds in the clusters every time it established a connection to Clouddriver. The amount of time the validation process took depended on the number of accounts. This led to situations where the Armory Agent did not perform operations for extended periods of time because it was busy validating access.

In version 1.0, there are no initial validations. When Agent fails to list or watch a kind because of permission issues, it does not attempt validation again even across service disconnections. This allows Agent to be ready to receive operations faster when the connection is established.

### Initial cache memory

The Agent Clouddriver Plugin can now persist the object versions that Agent reads from the cluster, and the Armory Agent can continue the cache from that version if Clouddriver or the Armory Agent service restart. This allows for faster restart cycles because Agent doesn't need to list the full infrastructure every time after a restart.