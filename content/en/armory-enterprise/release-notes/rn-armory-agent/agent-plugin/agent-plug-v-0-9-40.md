---
title: v0.9.40 Armory Agent Clouddriver Plugin (2022-02-17)
toc_hide: true
version: 00.09.40

---

### New features

Agent no longer needs redis. Communication between clouddrivers can now be through direct HTTP requests instead of using the redis pubusb, the plugin will watch changes to the kubernetes kind `Endpoint` where clouddriver pods are running, in order to know the IP address of each clouddriver replica.

**Prerequisites**
Clouddriver pods need to mount a service account with permissions to `list` and `watch` the kubernetes kind `Endpoint` in their current namespace.

**Configuration**
This is an opt-in change and can be enabled by changing in `clouddriver.yml` file this config:

```
kubesvc:
  cluster: redis
redis:
  enabled: true
```

To this config:

```
kubesvc:
  cluster: kubernetes
redis:
  enabled: false # Setting to false only if redis is not used by other processes, like caching agent scheduler or task repository
```

These are the full configuration options:
```
kubesvc:
  cluster-kubernetes:
    kubeconfigFile # (Default: null) Use this kubeconfgFile to talk to the spinnaker cluster instead of the service account mounted in clouddriver pod
    verifySsl # (Default: true) Verify kubernetes API server certificate
    namespace #(Default: null) Watch endpoints on this namespace instead of the autodetected namespace where clouddriver is running
    httpPortName # (Default: http) Name of the port in the clouddriver kubernetes Service selector for port 7002
    clouddriverServiceNamePrefix # (Default: spin-clouddriver) Prefix of the kubernetes Service name that routes traffic to clouddriver http pods at port 7002
```

**Troubleshooting**
A new REST endpoint is available in clouddriver, which indicates all the discovered clouddriver pods, their IP addressess and status (ready/not ready):
```
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
