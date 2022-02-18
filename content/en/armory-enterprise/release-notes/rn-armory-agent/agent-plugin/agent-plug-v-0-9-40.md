---
title: v0.9.40 Armory Agent Clouddriver Plugin (2022-02-17)
toc_hide: true
version: 00.09.40

---

## New features

### Agent HTTP communication

Agent no longer requires Redis. Communication between Clouddrivers can now be done direct HTTP requests instead of Redis pubsub. The plugin watches changes to the Kubernetes kind `Endpoint` where Clouddriver pods run to learn the IP address of each Clouddriver replica. This method of communication is more reliable than Redis pubsub. This change is optional.

To use this change, make sure the following requirement is met:

- Clouddriver pods need to mount a service account with permissions to `list` and `watch` the Kubernetes kind `Endpoint` in their current namespace.

To configure this change, update your `clouddriver.yml` file with the following changes:

```yaml
kubesvc:
  cluster: kubernetes
redis:
  enabled: false 
```

You should only set `redis.enabled` to `false` if no other processes use Redis, such as the Caching Agent Scheduler or the Task Repository.


There are additional configuration options available:

```yaml
kubesvc:
  cluster-kubernetes:
    kubeconfigFile: path/to/kubeconfig # (Default: null) Agent uses this kubeconfgFile to communicate with the Armory Enterprise  cluster instead of the service account mounted in the Clouddriver pod.
    verifySsl: <true|false> # (Default: true) Verify kubernetes API server certificate.
    namespace: <namespace> #(Default: null) Agent watches endpoints on this namespace instead of the autodetected namespace where Clouddriver runs.
    httpPortName: <portName> # (Default: http) Name of the port in the clouddriver Kubernetes Service selector for port 7002.
    clouddriverServiceNamePrefix: <clouddriverPrefix> # (Default: spin-clouddriver) Prefix of the Kubernetes Service name that routes traffic to Clouddriver http pods at port 7002.
```

### Clouddriver pod REST endpoint

A new REST endpoint is available for Clouddriver, which lists all the discovered Cclouddriver pods, their IP addresses and status (ready/not ready):

```bash
GET /armory/clouddrivers
[
  {
    baseUrl: "http://10.0.11.161:7002/",
    id: "spin-clouddriver-5d9c78474b-s25sl",
    lastUpdated: "2022-02-16T22:42:14.855Z",
    ready: true
  }
]
```