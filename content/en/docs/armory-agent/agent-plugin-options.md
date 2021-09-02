---
title: Plugin Configuration
linkTitle: Plugin Config
weight: 60
tags: ["Kubernetes", "Spinnaker", "Agent Configuration"]
categories: ["Agent"]
description: >
  This guide contains a detailed list of Armory Agent plugin configuration options for Clouddriver.
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

| Setting  | Type  | Default  | Description |
| -------- | ----- | -------- | ----------- |
| `kubesvc.cluster` | string | none | Type of clustering.<br>`local`: don’t try to coordinate with other Clouddriver instances<br>`redis`: use Redis to coordinate via pubsub. Use `redis` if you plan to use multiple Clouddriver instances.<br>`local` will be deprecated in a future release. |
| `kubesvc.loadBalancer`  | string | none | Pick a different account load balancing algorithm. Only implementation so far is the “MN algorithm” that does hides Agent connections from other clouddriver instances and assigns account to the least busy connected Clouddriver while never unassigning an account from a still connected instance unless it dies or stops being connected to that account. |
| `kubesvc.cache.cacheStreamingPoolCoreSize`<br>`kubesvc.cache.cacheStreamingPoolMaxSize` | integer | 10/100 | Thread pool sizing to write to cache. Each thread handles events for a single account at a time. It doesn't need to be greater than the number of agents. More threads means faster response. If Kubernetes accounts are very busy, you can set max size to `number of Kubernetes accounts / number of Clouddriver instances`. |
| `kubesvc.cache.onDemandQuickWaitMs` | integer | 10000 | How long to wait for a recache operation. |
| `kubesvc.cache.operationWaitMs` | integer | 30000 | How long to wait for a Kubernetes operation like deploy, scale, delete, or others |
| `kubesvc.cache.eventsCleanupFrequencySeconds` | integer | 7200 (2h) | How long to keep Kubernetes events cached for. |
| `kubesvc.cache.accountCleanupFrequencySeconds` | integer | 600 (10m) | How long to keep accounts that are no longer connected to any Agent |
| `kubesvc.cache.cleanDataWithUnusedAccounts` | boolean | true | When cleaning an old account, also clean its associated data |
| `kubesvc.disableV2Provider` | boolean | false | If you don’t need the V2 provider account, set that to true to speed up caching deserialization. |
| `kubesvc.runtime.defaults.onlySpinnakerManaged` | boolean | false | Same meaning as V2 provider. Should Spinnaker cache manifests that are not deployed by Spinnaker? |
| `kubesvc.runtime.defaults.customResources[].kubernetesKind`<br>`kubesvc.runtime.defaults.customResources[].spinnakerKind`<br>`kubesvc.runtime.defaults.customResources[].deployPriority`<br>`kubesvc.runtime.defaults.customResources[].versioned`<br>`kubesvc.runtime.defaults.customResources[].namespaced` | string<br>string<br>number as string (“100”)<br>boolean<br>boolean | none<br>none<br>“100”<br>false<br>false | Same meaning as V2 provider. Customize behavior of Spinnaker for an unknown (to Spinnaker) resource.<br><br>- `kubernetesKind` in the format `<kind>.<api group>`<br>- `spinnakerKind` is one of the Spinnaker kinds<br>- `deployPriority` will determine in which order Spinnaker will deploy a resource if multiple manifests are to be deployed in an operation.<br>- `versioned` should Spinnaker version new resource or just update them?<br>- `namespaced` is barely used with kubesvc. TODO: remove |
| `kubesvc.runtime.accounts[string].onlySpinnakerManaged`<br>`kubesvc.runtime.accounts[string].customResources[]…`  |                                                                    |                                         | Same as above but per account. This takes priority over default runtime settings. Default values are used if not populated for the account.<br><br>Format is a map (account name → props), e.g.<br>kubesvc.runtime.accounts:<br>   prod:<br>     onlySpinnakerManaged: true |
| `kubesvc.grpc.auth.x509.enabled` | boolean | false | Enable x509 subject filtering |
| `kubesvc.grpc.auth.x509.filters` | list(string) | `[]` | x509 subject line filter; see [x509 Certificate Subject Filtering]({{< ref "agent-mtls#x509-certificate-subject-filtering" >}}) |
| `kubesvc.grpc.server.address`| string| `*` | Address to bind the gRPC server to|
| `kubesvc.grpc.server.port`| int | `9091` | Port to bind the gRPC server to |
| `kubesvc.grpc.server.healthServiceEnabled`| boolean | `true` | Enable gRPC healthcheck service |
| `kubesvc.grpc.server.maxInboundMessageSize`| data size | `4MB` | Maximum size of a gRPC message. It should be at least as big as the biggest Kubernetes object manifest you can expect. |
| `kubesvc.grpc.server.security.enabled`| boolean | `false` | Enable transport level security |
| `kubesvc.grpc.server.security.certificateChain`| string | none | Reference to the server's certificate chain. |
| `kubesvc.grpc.server.security.privateKey`| string | none | Reference to the private key of the server. |
| `kubesvc.grpc.server.security.privateKeyPassword`| string | none | Reference to private key password if password protected. You can use [secret management]({{<  ref "secrets" >}}) to store the password. |
| `kubesvc.grpc.server.security.clientAuth`| string | `NONE` | `NONE`: no client certificate verification, `OPTIONAL`: verify client certificates if presented, `REQUIRE`: require client to present certificates and verify it |
| `kubesvc.grpc.server.security.ciphers`| list(string) | `[]` | By default, use the systems default ciphers. |
| `kubesvc.grpc.server.security.trustCertCollection`| string | none | By default, use the systems default truststore (cacerts). Otherwise, reference to a truststore to validate clients. |
| `kubesvc.grpc.server.security.protocols`| string | none | By default, use the systems default protocols. Otherwise, list of protocols accepted (`TLSv1.1`, `TLSv1.2`, etc. |
| `kubesvc.grpc.server.security.keepAliveHeartbeatSeconds`| int | none | how often should send keepalive grpc pings to client |
| `kubesvc.grpc.server.security.KeepAliveTimeOutSeconds`| int | none | How long to wait for a response after a keepalive before closing the connection |
| `kubesvc.operations.retry.maxRetries`<br>`kubesvc.operations.retry.backoffMs` | int<br>long | 5<br>2000 | When an operation is to be sent to an account, Clouddriver will attempt to find a connected agent. If it cannot (e.g. restart of an agent, re-balancing, network issue), the operation will be retried up to `retry - 1` times with `backoffMs` wait time b/w each try. |
| `kubesvc.heartbeat.initialDelay`<br>`kubesvc.heartbeat.period`<br>`kubesvc.heartbeat.periodUnit` | long<br>long<br>timeUnit | 0<br>30<br>SECONDS | How often each Clouddriver node reports its assingments as recent. Set the heartbeat period to a value less than `kubesvc.cache.accountCleanupFrequencySeconds` to prevent losing account cache. |
| `kubesvc.credentials.poller.reloadFrequencyMs` | long | 30000 | <span class="badge badge-primary">2.23.0+</span> <span class="badge badge-primary">1.23.0+</span> How often the plugin will refresh account credentials to clouddriver in case `credentials.poller.enabled` is disabled. Otherwise the standard properties of `credentials.poller.enabled` and `credentials.poller.types.kubernetes.reloadFrequencyMs` are respected |

