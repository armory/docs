---
title: Troubleshooting
weight: 6
---

## Agent plugin

After a successful plugin installation, `spin-clouddriver-grpc` (or `spin-clouddriver-ha-grpc`) service should be up:

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


In infrastructure or agent modes, you can test the gRPC endpoints with the
[`grpcurl`](https://github.com/fullstorydev/grpcurl) utility.

```bash
$ grpcurl your-grpc-endpoint:443 list
events.Caching
grpc.health.v1.Health
grpc.reflection.v1alpha.ServerReflection
ops.Operations
```

> Use `-plaintext` if your gRPC endpoint is not configured for TLS, `-insecure` if you are using TLS with custom certificates.


## Agent service

On a normal startup, the Agent will show the following messages:

```
# This shows where the configuration is read. "no such file" is expected.
time="2020-10-02T22:22:14Z" level=info msg="Config file /opt/spinnaker/config/kubesvc-local.yaml not present; falling back to default settings" error="stat /opt/spinnaker/config/kubesvc-local.yaml: no such file or directory"
...

# Where is the Agent connecting to?
time="2020-10-02T22:22:14Z" level=info msg="connecting to spin-clouddriver-grpc:9091..."

# Connection successful
time="2020-10-02T22:22:14Z" level=info msg="connected to spin-clouddriver-grpc:9091"

# Showing the UID of the agent, that's what will show in clouddriver
time="2020-10-02T22:22:14Z" level=info msg="connecting to Spinnaker: 9bece238-a429-40aa-8fad-285c72f56859"
...

# Agent registering with 32 successfully discovered clusters Spinnaker
time="2020-10-02T22:22:14Z" level=info msg="registering with 32 servers"
...

# At that point Clouddriver assigned caching to this instance of the Agent
time="2020-10-02T22:22:27Z" level=info msg="starting agentCreator account-01"
```

Common errors:

- When connecting to Spinnaker<sup>TM</sup> as a service, make sure to set `clouddriver.insecure: true` or provide certificates so the plugin can terminate TLS.

## Tips

- It is a good idea to have each Kubernetes cluster accessible by at least two instances of the Agent. Only one instance will actively stream Kubernetes changes. The second one will be on standby and can be used for other operations such as deploying manifests and getting logs.

- For better availability, you can run Agent deployments in [different availability zones](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity).

- Restarting the Agent won't cause direct outages provided it is limited in time (less than 30s). No operation can happen while no Agent is connected to Spinnaker. Caching is asynchronous and other operations are retried `kubesvc.operations.retry.maxRetries` times. Furthermore, restarts are generally fast and the Agent resumes where it left off.


