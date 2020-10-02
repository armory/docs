---
title: Plugin Options
weight: 4
---

### Options


| Setting  | Type  | Default  | Description |
| -------- | ----- | -------- | ----------- |
| `kubesvc.cluster` | string | none | Type of clustering.<br>`local`: don’t try to coordinate with other Clouddrivers<br>`redis`: use Redis to coordinate via pubsub |
| `kubesvc.loadBalancer`  | string | none | Pick a different account load balancing algorithm. Only implementation so far is the “MN algorithm” that does hides kubesvc connections from other clouddriver and assigns account to the least busy connected Clouddriver while never unassigning an account from a still connected CD unless it dies or stops being connected to that account. |
| `kubesvc.cache.cacheStreamingPoolCoreSize` (10)<br>`kubesvc.cache.cacheStreamingPoolMaxSize` (100) | integer | 10/100 | Thread pool sizing to write to cache. Each thread handles events for a single account. It doesn't need to be greater than the number of agents. More threads means faster response |
| `kubesvc.cache.onDemandQuickWaitMs` | integer | 10000 | How long to wait for a recache operation caused by a force cache refresh request. |
| `kubesvc.cache.eventsCleanupFrequencySeconds` | integer | 7200 (2h) | How long to keep Kubernetes events cached for. |
| `kubesvc.cache.accountCleanupFrequencySeconds` | integer | 600 (10m) | How long to keep accounts that are no longer connected to any kubesvc |
| `kubesvc.cache.cleanDataWithUnusedAccounts` | boolean | true | When cleaning an old account, also clean its associated data |
| `kubesvc.disableV2Provider` | boolean | false | If you don’t need the V2 provider account, set that to true to speed up caching deserialization. |
| `kubesvc.runtime.defaults.onlySpinnakerManaged` | boolean | false | Same meaning as V2 provider. Should Spinnaker cache manifests that are not deployed by Spinnaker? |
| `kubesvc.runtime.defaults.customResources[].kubernetesKind`<br>`kubesvc.runtime.defaults.customResources[].spinnakerKind`<br>`kubesvc.runtime.defaults.customResources[].deployPriority`<br>`kubesvc.runtime.defaults.customResources[].versioned`<br>`kubesvc.runtime.defaults.customResources[].namespaced` | string<br>string<br>number as string (“100”)<br>boolean<br>boolean | none<br>none<br>“100”<br>false<br>false | Same meaning as V2 provider. Customize behavior of Spinnaker for an unknown (to Spinnaker) resource.<br><br>- `kubernetesKind` in the format `<kind>.<api group>`<br>- `spinnakerKind` is one of the Spinnaker kinds<br>- `deployPriority` will determine in which order Spinnaker will deploy a resource if multiple manifests are to be deployed in an operation.<br>- `versioned` should Spinnaker version new resource or just update them?<br>- `namespaced` is barely used with kubesvc. TODO: remove |
| `kubesvc.runtime.accounts[string].onlySpinnakerManaged`<br>`kubesvc.runtime.accounts[string].customResources[]…`  |                                                                    |                                         | Same as above but per account. This takes priority over default runtime settings. Default values are used if not populated for the account.<br><br>Format is a map (account name → props), e.g.<br>kubesvc.runtime.accounts:<br>   prod:<br>     onlySpinnakerManaged: true |
| `kubesvc.grpc.server.*`|                                                                    |                                         | Options to configure gRPC server. This is really https://github.com/yidongnan/grpc-spring-boot-starter/blob/v2.7.0.RELEASE/grpc-server-spring-boot-autoconfigure/src/main/java/net/devh/boot/grpc/server/config/GrpcServerProperties.java#L52 repackaged under `kubesvc` with the only different being the default port (9091) vs (9090)<br><br>e..g<br>`grpc.server.port` → `kubesvc.grpc.server.port`<br><br>You can control many things the most important ones will be:<br>`kubesvc.grpc.server.security.enabled` (will be turned on to true in the future)<br>`kubesvc.grpc.server.security.certificateChain`<br>`kubesvc.grpc.server.security.privateKey`<br>`kubesvc.grpc.server.security.clientAuth` [default: NONE, OPTIONAL, REQUIRE] |
| `kubesvc.operations.retry.maxRetries`<br>`kubesvc.operations.retry.backoffMs` | int<br>long | 5<br>2000 | When an operation is to be sent to an account, Clouddriver will attempt to find a connected agent. If it cannot (e.g. restart of an agent, re-balancing, network issue), the operation will be retried up to `retry - 1` times with `backoffMs` wait time b/w each try. |

