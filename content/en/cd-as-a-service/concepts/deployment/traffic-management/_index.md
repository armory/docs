---
title: Traffic Management Using a Service Mesh
linkTitle: Traffic Management
no_list: true
description: >
  Learn about service mesh traffic management for your Armory Continuous Deployment-as-a-Service canary deployments.
aliases: 
  - /cd-as-a-service/concepts/deployment/traffic-mgmt/
---

## Service Meshes and the Service Mesh Interface (SMI)

There are many guides and introductions to service meshes, such as the [Service Mesh Manifesto](https://buoyant.io/service-mesh-manifesto/).

Most guides to the service mesh concept start by describing a control plane and a data plane. Ignore both of these terms. Instead, focus on the proxy, which is typically auto-injected as a sidecar in your application pods.

>CD-as-a-Service does not configure proxy sidecar injection.

This proxy intercepts all inbound and outbound network traffic and understands application-level protocols (think HTTP and gRPC). Because it understands application protocols, the proxy can implement application features: HTTP metrics, path-and-header-based routing, access control, or retries. The service mesh, as a whole — the previously ignored data and control plane — is a system to implement, configure, and observe these features. The magic of a mesh is that it's possible to get consistent HTTP metrics (or retries, access control, etc.) across a set of heterogenous microservices without the wrangling or even buy-in of the service owners.

The Service Mesh Interface (SMI) is an abstraction of the features common among service mesh implementations; the abstraction takes the form of Kubernetes Custom Resource Definitions (CRDs).

SMI solves a common integration problem: _n_ consumers want to integrate with _m_ producers, each having its own interface, creating a miserable _m ⋅ n_ integration matrix. Because of SMI, tools that want to integrate with service mesh providers — Linkerd, Istio, Consul — don't need to integrate with each mesh individually. Instead, they can just integrate with SMI. Popular service meshes understand SMI natively or via adapters.   


## Supported service mesh products

* [Linkerd](https://linkerd.io/)
* [Istio](https://istio.io/)


## {{%  heading "nextSteps" %}}

- {{< linkWithTitle "cd-as-a-service/concepts/deployment/traffic-management/progressive-canary-linkerd.md" >}}
- {{< linkWithTitle "cd-as-a-service/tasks/deploy/traffic-management/traffic-manage-linkerd.md" >}}