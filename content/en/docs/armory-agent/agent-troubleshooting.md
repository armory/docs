---
title: Troubleshoot the Armory Agent Service and Plugin
linkTitle: Troubleshoot
weight: 80
description: >
  Successful installation and startup messages, common errors, tips, and gRPC endpoint testing.
---
![Proprietary](/images/proprietary.svg)

{{< include "early-access-feature.html" >}}

## Networking issues

Communication between Clouddriver and the Agent must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between Clouddriver and the Agent.   

## Agent plugin messages

After a successful plugin installation, the `spin-clouddriver-grpc` (or `spin-clouddriver-ha-grpc`) service should be running:

```bash
$ kubectl get service spin-clouddriver-grpc
NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
spin-clouddriver-grpc   ClusterIP   172.20.110.67   <none>        9091/TCP   30s
```

Clouddriver's log should have the following messages:

```
2020-10-02 16:23:58.031  INFO 1 --- [           main] org.pf4j.AbstractPluginManager           : Start plugin 'Armory.Kubesvc@0.4.4'

...

2020-10-02 16:24:10.046  INFO 1 --- [           main] n.d.b.g.s.s.GrpcServerLifecycle          : gRPC Server started, listening on address: *, port: 9091
```

## Testing gRPC endpoints

In Infrastructure or Agent modes, you can test the gRPC endpoints with the
[`grpcurl`](https://github.com/fullstorydev/grpcurl) utility.

```bash
$ grpcurl <your-grpc-endpoint>:<port> list
```

The default `port` is `443`.

Command options:

* `-plaintext`: if your gRPC endpoint is not configured for TLS
* `-insecure`: if you are using TLS with custom certificates

Output is similar to:

```bash
events.Caching
grpc.health.v1.Health
grpc.reflection.v1alpha.ServerReflection
ops.Operations
```

### Verbose logging

You have to change the logging and verbosity levels to display detailed logging output.

First execute the following:

```
export GRPC_GO_LOG_SEVERITY_LEVEL=info GRPC_GO_LOG_VERBOSITY_LEVEL=2
```

Then run `grpcurl` with the `-v` switch:

```
grpcurl -v <your-grpc-endpoint>:<port> list
```

Use `-plaintext` or `-insecure` depending on whether your endpoint is configured for TLS.

Output is similar to:

```bash
INFO: 2021/01/25 22:10:52 parsed scheme: ""
INFO: 2021/01/25 22:10:52 scheme "" not registered, fallback to default scheme
INFO: 2021/01/25 22:10:52 ccResolverWrapper: sending update to cc: {[{192.168.88.133:9091  <nil> 0 <nil>}] <nil> <nil>}
INFO: 2021/01/25 22:10:52 ClientConn switching balancer to "pick_first"
INFO: 2021/01/25 22:10:52 Channel switches to new LB policy "pick_first"
INFO: 2021/01/25 22:10:52 Subchannel Connectivity change to CONNECTING
INFO: 2021/01/25 22:10:52 Subchannel picks a new address "192.168.88.133:9091" to connect
INFO: 2021/01/25 22:10:52 pickfirstBalancer: UpdateSubConnState: 0xc0002996b0, {CONNECTING <nil>}
INFO: 2021/01/25 22:10:52 Channel Connectivity change to CONNECTING
INFO: 2021/01/25 22:10:52 Subchannel Connectivity change to READY
INFO: 2021/01/25 22:10:52 pickfirstBalancer: UpdateSubConnState: 0xc0002996b0, {READY <nil>}
INFO: 2021/01/25 22:10:52 Channel Connectivity change to READY
events.Caching
grpc.health.v1.Health
grpc.reflection.v1alpha.ServerReflection
ops.Operations
INFO: 2021/01/25 22:10:52 Channel Connectivity change to SHUTDOWN
INFO: 2021/01/25 22:10:52 Subchannel Connectivity change to SHUTDOWN
```


## Agent service messages

On a normal startup, the Agent will show the following messages:

```
# This shows where the configuration is read. "no such file" is expected.
time="2020-10-02T22:22:14Z" level=info msg="Config file /opt/armory/config/armory-agent-local.yaml not present; falling back to default settings" error="stat /opt/armory/config/armory-agent-local.yaml: no such file or directory"
...

# Where is the Agent connecting to?
time="2020-10-02T22:22:14Z" level=info msg="connecting to spin-clouddriver-grpc:9091..."

# Connection successful
time="2020-10-02T22:22:14Z" level=info msg="connected to spin-clouddriver-grpc:9091"

# Showing the UID of the agent, that's what will show in Clouddriver
time="2020-10-02T22:22:14Z" level=info msg="connecting to Spinnaker: 9bece238-a429-40aa-8fad-285c72f56859"
...

# Agent registering with 32 successfully discovered clusters Spinnaker
time="2020-10-02T22:22:14Z" level=info msg="registering with 32 servers"
...

# At that point Clouddriver assigned caching to this instance of the Agent
time="2020-10-02T22:22:27Z" level=info msg="starting agentCreator account-01"
```

Common errors:

- `io.grpc.netty.shaded.io.netty.handler.codec.http2.Http2Exception: HTTP/2 client preface string missing or corrupt. Hex dump for received bytes: 160301011901000115030383b0f1d28d2a75383e4e1f98f4`
  When connecting to Spinnaker<sup>TM</sup> as a service, make sure to set `clouddriver.insecure: true` or provide certificates so the plugin can terminate TLS.
- `org.springframework.jdbc.BadSqlGrammarException: jOOQ; bad SQL grammar [update kubesvc_assignments set reachable = ?, last_updated = ? where cd_id = ?]; nested exception is java.sql.SQLSyntaxErrorException: Table 'clouddriver.kubesvc_assignments' doesn't exist`
  The plugin by default tries to automatically create the tables it needs after printing this error message.
  This can be ignored, and in case of any issue, another error message should follow later in the logs.
- `Parameter 1 of method getRedisClusterRecipient in io.armory.kubesvc.config.KubesvcClusterConfiguration required a bean of type 'com.netflix.spinnaker.kork.jedis.RedisClientDelegate' that could not be found.`
  Make sure `redis.enabled: true` is set in Clouddriver's profile. For a more limited solution, keep only one Clouddriver instance and set `kubesvc.cluster: local` in Clouddriver's profile
- `Parameter 0 of method sqlTableMetricsAgent in com.netflix.spinnaker.config.SqlCacheConfiguration required a bean of type 'org.jooq.DSLContext' that could not be found.`
  Make sure `sql.enabled: true` is set in Clouddriver's profile
- `Parameter 2 of constructor in io.armory.kubesvc.agent.KubesvcCachingAgentDispatcher required a bean of type 'com.netflix.spinnaker.clouddriver.kubernetes.security.KubernetesCredentials$Factory' that could not be found.`
  Make sure `providers.kubernetes.enabled: true` is set.
- `Failed to list *unstructured.Unstructured: statefulsets.apps is forbidden: User "system:serviceaccount:default:test" cannot list resource "statefulsets" in API group "apps" at the cluster scope`
  Make sure the service account or user that corresponds to the `kubeconfig` file is bound to a cluster role or role with `watch` and `list` permissions to all resources. Alternatively, make sure to set `kubernetes.accounts[].kinds` in `armory-agent.yaml` file
- `Assigning accounts to Kubesvc enabled Clouddrivers (caching)` multiple times in Clouddriver & `[..] is unreachable [..] getting credentials: exec: fork/exec /usr/local/bin/aws: exec format error`
  Currently only static tokens are available. Generate a kubeconfig that uses a token from a SA with permissions to the cluster instead.

  ```bash
  kubectl create sa armory-agent -n default # replace default with a relevant namespace
  kubectl create clusterrolebinding armory-agent --serviceaccount default:armory-agent --clusterrole cluster-admin # or make a proper rbac role
  TOKEN_SECRET="$(kubectl get sa armory-agent -n default -o jsonpath='{.secrets.*.name}')"
  TOKEN="$(kubectl get secret "$TOKEN_SECRET" -n default -o jsonpath='{.data.token}' | base64 --decode)"
  # Replace your kubeconfig from
  # users:
  # - user:
  #     exec:
  # to
  # users:
  # - user:
  #     token: $TOKEN_SECRET
  # Remember to replace $TOKEN_SECRET with the actual contents from the command above
  ```


## Agent tips

- It is a good idea to have each Kubernetes cluster accessible by at least two instances of the Agent. Only one instance will actively stream Kubernetes changes. The second one will be on standby and can be used for other operations such as deploying manifests and getting logs.

- For better availability, you can run Agent deployments in [different availability zones](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity).

- Restarting the Agent won't cause direct outages, provided it is limited in time (less than 30s). No operation can happen while no Agent is connected to Spinnaker. Caching is asynchronous and other operations are retried `kubesvc.operations.retry.maxRetries` times. Furthermore, restarts are generally fast, and the Agent resumes where it left off.
