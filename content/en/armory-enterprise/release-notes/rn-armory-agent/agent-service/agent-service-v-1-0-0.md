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
```
hub:
  auth:
    armory:
      clientId: "" # (Required, string, defult: empty): Client ID of this Armory Cloud client.
      secret: ""   # (Required, string, defult: empty): Secret of this Armory Cloud client.
  connection:
    grpc: agents.cloud.armory.io # (Required, host:port, default: agents.cloud.armory.io): Host and GRPC port where the Hub is exposed.
    tls:
      insecureSkipVerify: false  # (Optional, boolean, default: false): Don't check server name of hub certificate.
      serverName: ""             # (Optional, string, default: empty): Should match the server name in hub certificate, unless InsecureSkipVerify is given. It is also included in the client's handshake to support virtual hosting unless it is an IP address.
      cacertFile: ""             # (Optional, path, default: empty): If provided, verify hub certificate with this trust store. Otherwise, the system trust store is used.
      clientCertFile: ""         # (Optional, path, default: empty): Client certificate file for mTLS.
      clientKeyFile: ""          # (Optional, path, default: empty): Client key file if not included in the client certificate for mTLS.
      clientKeyFilePassword: ""  # (Optional, string, default: empty): Password of the client key file if needed.
```


### Admin REST API
Several new REST endpoints were added to better troubleshoot agent:
* GET `/accounts`: Returns the list of accounts loaded by agent, together with their discovered kinds
* GET `/operations`: Returns the list of currently executing operations like list, deploy, etc.
* GET `/watches`: Returns the list of watches, grouped by account and watch state.
* GET `/debug/pprof`: Retruns information exported by golang to diagnose go applications, like stack traces of all goroutines and heap allocations.

### Structured Logging
Log messages enforce including key-value pairs that are relevant to the message and context, which make it far easier to locate relevant information in a sea of logs just by filtering for the correct key-value pairs.
These are the supported keys:
* `agentId`: Identifier of the agent instance logging the message.
* `account`: Account name related to the message.
* `kind`: Kubernetes kind name.
* `group`: Kubernetes API group name.
* `operationId`: UUID of the operation logging the message.
* `operationType`: Name of the operation (list, deploy, etc.).
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


### New Prometheus Metrics
The following new prometheus metrics are available in this version:
`kubesvc_kubernetes_requests`  [Counter]: Amount of requests sent to a Kubernetes API Server.
`kubesvc_watches`  [Gauge]: Amount of live watches registered to Kubernetes API Servers to monitor changes in the cluster.

## Improvements
### Faster Reconnections
In previous versions, agent validated access to all the kinds in the clusters every time it established a connection to clouddriver. This validation is a time consuming process depending on the number of accounts, in which agent is not able to perform operations.
In version 1.0 there are no initial validations, when agent fails to list or watch a kind because of permissions, that is not tried again even across service disconnections. This allows agent to be ready to receive operations faster when the connection is established.

### Initial cache memory
Agent clouddriver plugin can now persist the object versions that agent reads from the cluster, and agent can continue the cache from that version in case either service are restarted. This allows for faster restart cycles because agent doesn't need to list the full infrastructure every time after a restart.

