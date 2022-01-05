---
title: v1.0.0 Armory Agent Service (2022-01-05)
toc_hide: true
version: 01.00.00

---

## New Features
### Armory Cloud Integration
Agent 1.0 is the first stable release that is able to communicate with Armory Cloud for making deployments.
How to use
In the file /opt/armory/config/armory-agent.yml make sure that the value clouddriver.grpc is empty or not set, and configure connection settings to Armory Cloud as follows:


### Admin REST API
Several new REST endpoints were added to better troubleshoot agent:
* GET /accounts: Returns the list of accounts loaded by agent, together with their discovered kinds
* GET /operations: Returns the list of currently executing operations like list, deploy, etc.
* GET /watches: Returns the list of watches, grouped by account and watch state.
* GET /debug/pprof: Retruns information exported by golang to diagnose go applications, like stack traces of all goroutines and heap allocations.

### Structured Logging
Log messages enforce including key-value pairs that are relevant to the message and context, which make it far easier to locate relevant information in a sea of logs just by filtering for the correct key-value pairs.
These are the supported keys:
* agentId: Identifier of the agent instance logging the message.
* account: Account name related to the message.
* kind: Kubernetes kind name.
* group: Kubernetes API group name.
* operationId: UUID of the operation logging the message.
* operationType: Name of the operation (list, deploy, etc.).
* namespace: Namespace (if applicable).
* watchedNamespace: For messages logged by the watching system, this is the namespace that is being watched. An empty string means watching in all namespaces.
* error: Error message, if any.
* msg: The actual log message.
* level: Log level.
* time: Logged time.
Example:


### New Prometheus Metrics
The following new prometheus metrics are available in this version:
kubesvc_kubernetes_requests  [Counter]: Amount of requests sent to a Kubernetes API Server.
kubesvc_watches  [Gauge]: Amount of live watches registered to Kubernetes API Servers to monitor changes in the cluster.

## Improvements
### Faster Reconnections
In previous versions, agent validated access to all the kinds in the clusters every time it established a connection to clouddriver. This validation is a time consuming process depending on the number of accounts, in which agent is not able to perform operations.
In version 1.0 there are no initial validations, when agent fails to list or watch a kind because of permissions, that is not tried again even across service disconnections. This allows agent to be ready to receive operations faster when the connection is established.

### Initial cache memory
Agent clouddriver plugin can now persist the object versions that agent reads from the cluster, and agent can continue the cache from that version in case either service are restarted. This allows for faster restart cycles because agent doesn't need to list the full infrastructure every time after a restart.

