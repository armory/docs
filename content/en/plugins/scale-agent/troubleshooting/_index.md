---
title: Troubleshoot the Armory Scale Agent Service and Plugin
linkTitle: Troubleshooting
weight: 99
no_list: true
description: >
  Armory Scale Agent for Spinnaker and Kubernetes successful installation and startup messages, common errors, tips, and gRPC endpoint testing.
---

## Networking issues

Communication between Clouddriver and the Armory Scale Agent must be `http/2`. `http/1.1` is *not* compatible and causes communication issues between Clouddriver and the Armory Scale Agent.   

## Scale Agent plugin messages

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

### Kubernetes clustering

If there are no errors, the log should look like this:

```bash
Watching kubernetes Endpoints on namespace {}
```

If there is any problem watching Endpoints, Clouddriver logs an exception beginning like this:

```bash
>>>>>>> Unable to list kubernetes Endpoints in namespace {} to discover clouddriver instances. Agent will NOT work if running more than one clouddriver replica!
```

If there are errors, run these commands inside Clouddriver pods. They should return yes:

```bash
kubectl auth can-i list endpoints

kubectl auth can-i watch endpoints
```
If any of the answers is **no**, then you need to add a ClusterRole and ClusterRoleBindings in order to be able to list/get and watch endpoints in the namespace.
Below is a procedure for creating the ClusterRole and ClusterRoleBindings:

#### Create the ClusterRole and ClusterRoleBinding:
```yaml
### Cluster Role
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: watch-endpoints
rules:
- apiGroups:
  - "*"
  resources:
  - endpoints
  verbs:
  - "list"
  - "get"
  - "watch"
---

### Cluster Role Binding
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: watch-endpoints-rb
  namespace: "<CHANGE_NAMESPACE>"
subjects:
  - kind: User
    name: system:serviceaccount:<CHANGE_NAMESPACE>:default
    apiGroup: rbac.authorization.k8s.io
  - kind: Group
    name: system:serviceaccounts
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: watch-endpoints
  apiGroup: rbac.authorization.k8s.io
```

Place the above yaml contents in a yaml file and apply it with `kubectl apply -f  <file>.yml`. 
Now you should be able to list and watch endpoints in the namespace.

---

The output of the REST request `GET /armory/clouddrivers` should return all existing Clouddriver pods. If there are missing pods, run this command inside each Clouddriver pod:

```bash
kubectl get endpoints
```

The result should be similar to:

```yaml
NAME                       ENDPOINTS                                                      AGE
spin-clouddriver           10.0.11.54:7002,10.0.11.88:7002,10.0.13.152:7002 + 5 more...   9d
```

Then execute:

```bash
kubectl describe endpoints spin-clouddriver
```

There should be one or more entries having `NAME` beginning with what is specified in the config setting `kubesvc.cluster-kubernetes.clouddriverServiceNamePrefix`, which defaults to `spin-clouddriver`. Also, the entry should have at least one port named like what is configured in `kubesvc.cluster-kubernetes.httpPortName`, which defaults to `http`. Your output should be similar to:

```yaml
Name:         spin-clouddriver
Namespace:    spinnaker
Labels:       app=spin
              cluster=spin-clouddriver
Annotations:  endpoints.kubernetes.io/last-change-trigger-time: 2022-02-23T20:41:39Z
Subsets:
  Addresses:          10.0.11.54,10.0.11.88,10.0.13.152,10.0.15.176,10.0.15.246,10.0.5.200,10.0.5.39,10.0.7.150
  NotReadyAddresses:  <none>
  Ports:
    Name  Port  Protocol
    ----  ----  --------
    http  7002  TCP

Events:  <none>
```

The output of the REST request `GET /armory/agents` should return valid data regarding which Agents are connected to which Clouddrivers. The field `clouddriverAlive` must be true for active connections.

Your reponse should be similar to:

```json
[
  {
    "accounts": [],
    "agentId": "armory-agent-69c7ff7b46-jblql",
    "caching": true,
    "clouddriverAlive": true,
    "clouddriverId": "spin-clouddriver-766c678c6c-4zzzf",
    "lastConnection": "2022-02-23T22:18:54.725Z",
    "type": "kubernetes"
  }
]
```

If one account/Agent is associated with more than one Clouddriver instance having `clouddriverAlive: true`, it's possible that the balancer Agent that runs every 30 seconds didn't flip the flag to false for dead connections. However, the plugin will just select the Clouddriver with the most recent `lastConnection` date.

If no account/Agent is registered with a Clouddriver having `clouddriverAlive: true`, it's possible that the Armory Scale Agent is not connected yet to any Clouddriver.

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


## Scale Agent service messages

On a normal startup, the Armory Scale Agent shows the following messages:

```
# This shows where the configuration is read. "no such file" is expected.
time="2020-10-02T22:22:14Z" level=info msg="Config file /opt/armory/config/armory-agent-local.yaml not present; falling back to default settings" error="stat /opt/armory/config/armory-agent-local.yaml: no such file or directory"
...

# Where is the Armory Scale Agent connecting to?
time="2020-10-02T22:22:14Z" level=info msg="connecting to spin-clouddriver-grpc:9091..."

# Connection successful
time="2020-10-02T22:22:14Z" level=info msg="connected to spin-clouddriver-grpc:9091"

# Showing the UID of the agent, that's what shows in Clouddriver
time="2020-10-02T22:22:14Z" level=info msg="connecting to Spinnaker: 9bece238-a429-40aa-8fad-285c72f56859"
...

# Agent registering with 32 successfully discovered clusters Spinnaker
time="2020-10-02T22:22:14Z" level=info msg="registering with 32 servers"
...

# At that point Clouddriver assigned caching to this instance of the Armory Scale Agent
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

## Caching Kubernetes cluster objects

When Kubernetes objects are not displaying in the Spinnaker cluster tab UI, perform the following:

1. Verify that the Kubernetes objects are deployed in the cluster.
1. Verify if the cache for the Kubernetes objects is in the `kubesvc_cache` database table.

   ```sql
   SELECT id, agent, kind, account, application, namespace, last_updated FROM clouddriver.kubesvc_cache WHERE id LIKE '%:account1:%:minimal-ingress';
   ```

   Replace:

   * `account1` with the name of the account that is doing the caching
   * `minimal-ingress` with the name of the Kubernetes deployment

   Output is similar to:

   ```bash
   +-----------------------------------------------------------------------+-------+---------+----------+-------------+-----------+---------------+
   | id                                                                    | agent | kind    | account  | application | namespace | last_updated  |
   +-----------------------------------------------------------------------+-------+---------+----------+-------------+-----------+---------------+
   | kubernetes.v2:infrastructure:ingress:account1:default:minimal-ingress |       | ingress | account1 | NULL        | default   | 1683925888736 |
   +-----------------------------------------------------------------------+-------+---------+----------+-------------+-----------+---------------+
   1 row in set (0.00 sec)
   ```

   >Note: you can remove `account` to only filter by the name of the Kubernetes deployment: `WHERE id LIKE '%:myapp'`.

1. Verify that the Agent Couddriver plugin is receiving cache events for the Kubernetes objects.

   1. The Clouddriver plugin should have caching enabled for the required kind.

      Check the `kubesvc.cache.cacheKinds` plugin property has the Kubernetes kinds to cache. The default value is `kubesvc.cache.cacheKinds: ['ReplicaSet','Service','Ingress','DaemonSet','Deployment','Pod','StatefulSet','Job','CronJob','NetworkPolicy','Namespace','CustomResourceDefinition']`. Add or remove a Kubernetes kinds as needed.

   1. Set the `CachingHandler` log level to `DEBUG`.
   
      Add `logging.level.io.armory.kubesvc.services.cache.CachingHandler: DEBUG`:

      ```yaml
      apiVersion: spinnaker.armory.io/v1alpha2
      kind: SpinnakerService
      metadata:
        name: spinnaker
      spec:
        spinnakerConfig:
          profiles:
            clouddriver:
              logging.level.io.armory.kubesvc.services.cache.CachingHandler: DEBUG
      ```

      Then look for the caching logs of the Kubernetes objects.

      ```bash
      kubectl -n spinnaker logs deployment/spin-clouddriver | grep -E 'New entry to cache from instance.*account: account1.*Kind=Ingress/minimal-ingress'
      ```

      Replace:

      * `spinnaker` with the name of the namespace where Clouddriver is running
      * `spin-clouddriver` with the name of the Clouddriver deployment
      * `account1` with the name of the account that is doing the caching
      * `Ingress` with the kind of the Kubernetes deployment
      * `minimal-ingress` with the name of the Kubernetes deployment

      Output is similar to:

      ```bash
      2023-05-12 21:05:08.966 DEBUG 1 --- [ault-executor-2] i.a.k.services.cache.CachingHandler      : New entry to cache from instance: armory-agent-7bfc4dd84-5kt2r, account: account1, type: ADD, onDemand: false, key: default/networking.Kubernetes.io/v1, Kind=Ingress/minimal-ingress, syncKey: , resourceVersion: 2157, watchedNamespace: , startTimestamp: 1683925507264, endTimestamp: 0
      2023-05-12 21:11:28.732 DEBUG 1 --- [ault-executor-2] i.a.k.services.cache.CachingHandler      : New entry to cache from instance: armory-agent-7bfc4dd84-5kt2r, account: account1, type: ADD, onDemand: false, key: default/networking.Kubernetes.io/v1, Kind=Ingress/minimal-ingress, syncKey: , resourceVersion: 2157, watchedNamespace: , startTimestamp: 1683925507264, endTimestamp: 0
      ```

1. Verify that the Agent is sending cache events for the Kubernetes object kinds.

   Check that the plugin's list of kinds contains the ones you want.

   ```bash
   kubectl -n spinnaker logs deployments/armory-agent | grep 'Using kind list:'
   ```

   Replace:

   * `spinnaker` with the namespace where your Agent is running
   * `armory-agent` with the name of the Agent deployment

   Output is similar to:

   ```bash
   time="2023-05-12T21:05:07Z" level=info msg="Using kind list: [ReplicaSet Service Ingress DaemonSet Deployment Pod StatefulSet Job CronJob NetworkPolicy Namespace CustomResourceDefinition]" account=account1 agentId=armory-agent-7bfc4dd84-5kt2r
   ```

1. Verify that the Agent has the caching enabled for the desired kind.

   The `kubernetes.accounts[].kinds` and `kubernetes.accounts[].omitKinds` Agent properties could restrict what the Agent is caching. Look for the logs that indicate Agent is caching the Kubernetes kinds you want cached.

   ```bash
   kubectl -n spinnaker logs deployments/armory-agent | grep -E 'Watcher: full kind recache with . objects" account=account1.*kind=Ingress'
   ```

   Replace:
   * `spinnaker` with the name of the namespace where agent is running
   *  `armory-agent` with the name of the agent deployment
   *  `account1` with the name of the account that is doing the caching
   *  `Ingress` with the kind of the Kubernetes deployment

   Output is similar to:

   ```bash
   time="2023-05-12T21:05:08Z" level=info msg="Watcher: full kind recache with 1 objects" account=account1 agentId=armory-agent-7bfc4dd84-5kt2r group=networking.k8s.io kind=Ingress watchedNamespace=default
   time="2023-05-12T21:11:28Z" level=info msg="Watcher: full kind recache with 1 objects" account=account1 agentId=armory-agent-7bfc4dd84-5kt2r group=networking.k8s.io kind=Ingress watchedNamespace=default
   ```

## Orphaned accounts

Execute the following query to find accounts with status ORPHANED in the `kubesvc_accounts` table:

```sql
SELECT * FROM kubesvc_accounts;
```

Output is similar to:

```bash
+----------+----------+
| name     | status   |
+----------+----------+
| account1 | ORPHANED |
+----------+----------+
1 row in set (0.00 sec)
```

Follow these steps to determine why the account is orphaned:

1. Verify that the account is included in the Agent config file. For example:

   ```yaml
   kubernetes:
     accounts:
       - name: account1
         serviceAccount: true
   ```

1. Verify that the account is not in conflict with other Agent instances using the Kubernetes host or cert fingerprint.
 
   If the account was dynamically added by another Agent instance that doesn't exist anymore, pointing to a different Kubernetes cluster, it was not dynamically deleted. The record of the dynamic account remains in `kubesvc_accounts` table with a different Kubernetes host and/or cert fingerprint.

   ```sql
   SELECT name, kube_host, cert_fingerprint, status  FROM kubesvc_accounts;
   ```

   Output is similar to:
   ```bash
   +----------+-----------------------------------------+-------------------------------------------------+----------+
   | name     | kube_host                               | cert_fingerprint                                | status   |
   +----------+-----------------------------------------+-------------------------------------------------+----------+
   | account1 | https://kubernetes.docker.internal:6443 | 27:5E:05:42:E0:9B:EE:74:53:B9:6B:63:9D:A4:9C:B4 | ORPHANED |
   +----------+-----------------------------------------+-------------------------------------------------+----------+
   1 row in set (0.00 sec)
   ```

   Set the `DefaultAgentHandler` log level to `DEBUG`. For example:

   ```YAML
   apiVersion: spinnaker.armory.io/v1alpha2
   kind: SpinnakerService
   metadata:
     name: spinnaker
   spec:
     spinnakerConfig:
       profiles:
         clouddriver:
           logging.level.io.armory.kubesvc.services.registration.kubesvc.DefaultAgentHandler: DEBUG
   ```

   When the Agent tries to add the same account name pointing to a different Kubernetes cluster, the log indicates that the account was ignored (`ignored accounts [account1]`). For example:

   ```bash
   kubectl -n spinnaker logs deployments/spin-clouddriver | grep -E 'Agent .*: registered newly added accounts'
   ```

   Replace:
   * `spinnaker` with the name of the namespace where clouddriver is running
   * `spin-clouddriver` with the name of the clouddriver deployment

   Output is similar to:

   ```bash                     
   2023-05-12 22:29:53.536 DEBUG 1 --- [ault-executor-1] i.a.k.s.r.kubesvc.DefaultAgentHandler    : Agent armory-agent-7974564c46-2fqj2: registered newly added accounts [], stopped handling removed accounts [], updated accounts [], ignored accounts [account1]. Originally had existing accounts [account1], and just now had incoming accounts [account1]
   ```
   
## Scale Agent tips

- It is a good idea to have each Kubernetes cluster accessible by at least two instances of the Armory Scale Agent. Only one instance will actively stream Kubernetes changes. The second one will be on standby and can be used for other operations such as deploying manifests and getting logs.

- For better availability, you can run Agent deployments in [different availability zones](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity).

- Restarting the Armory Scale Agent won't cause direct outages, provided it is limited in time (less than 30s). No operation can happen while no Agent is connected to Spinnaker. Caching is asynchronous and other operations are retried `kubesvc.operations.retry.maxRetries` times. Furthermore, restarts are generally fast, and the Armory Scale Agent resumes where it left off.
