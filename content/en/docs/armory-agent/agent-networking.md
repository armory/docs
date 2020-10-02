---
title: Armory Agent Networking
linkTitle: Networking
description: >
  How Armory Agent services running in Kubernetes clusters communicate with the Armory Agent plugin running in Spinnaker's Clouddriver service
---

![Armory Agent networking](/images/armory-agent/agent-networking.png)

The Armory Agent service and plugin use [gPRC](https://grpc.io/) on HTTP/2 to communicate with each other. This approach enables bidirectional, authenticated streaming over a single TCP connection and scales to millions of RPCs per second.

The Armory Agent service makes outbound calls to the plugin running in Spinnaker<sup>TM</sup>'s Clouddriver service.  As long as the Armory Agent service has outbound connectivity to the Armory Agent plugin, it can register itself to become a deployment target.  This means that you can have agents running on-premise or in public clouds such as AWS, GCP, Azure, Oracle, or Alibaba.

Outbound connections from the Armory Agent service leverage gRPC for security, as well as mTLS and JWT authentications.  Bidirectional channels within the tunnel use gRPC over HTTP/2.  Each of those channels is authenticated with a randomized token per channel.  These measures ensure that Armory Agent services can safely register with the Armory Agent plugin running in Clouddriver.

The Armory Agent service-to-plugin communication exchanges minimal amounts of data about the Kubernetes deployment target.  This information is mostly metadata and includes no PII information.  The plugin buffers this information is fully resilient to failover in the case of a break in network connectivity.  This is accomplished by running 1 persistent connection to the Kubernetes API levering “watch” function to get any updates.  



## Ingress for gRPC

When you install the Armory Agent service on a cluster other than the one Spinnaker is running on, you need to create an Ingress controller that uses mTLS for gRPC, Gate, and Deck. You can do this through annotations to provision cloud load balancers in AWS, GCP, and Azure. requires an Ingress controller to access Deck(UI) and Gate(API) services.  

