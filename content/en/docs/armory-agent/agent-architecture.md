---
title: Architecture
description: >
  How the Armory Agent works
---


## Communication with Clouddriver
![](https://paper-attachments.dropbox.com/s_716E58F6E839B4F4555DEA68E72A2ED554567BFE6B633074E17BD71244EE29FA_1600892715692_image.png)


Armory Agent communicates from the deployed Kubernetes cluster to Clouddriver leveraging best security practices and optimizations to minimize chattiness on the wire.  On the Spinnaker side Clouddriver leverages the newly created Spinnaker plugin framework.  The other side of the communication is the Armory Agent itself running within any Kubernetes cluster.

Security:
The first security principle is that the Armory Agent does outbound calls to the Clouddriver plugin (gRPC outbound).  As long as the Armory Agent has outbound connectivity to the running Spinnaker Clouddriver plugin, it can register itself to become a deployment target.  This also means that you can have agents running on premise or in public clouds such as AWS, GCP, Azure, Oracle, or Alibaba.

Secure Bi-Directional Communication:
These outbound connections leverage gRPC for security as well as mTLS and JWT authentications.  Given that gRPC using HTTP/2 within the tunnel for bi-directional channels, each of those channels is authenticated with a randomized token per channel.  These measures ensure that Agent can safely register itself with Clouddriver plug-ins which are configured in the Agents deployment yaml.

Communication Content and Flow:
The Agent to Clouddriver communication exchanges minimal amounts of data about the Kubernetes deployment target.  This information is mostly metadata and includes no PII information.  This information is buffered on the Clouddriver plugin and is fully resilient to failover in the case of a break in network connectivity.  This is accomplished by running 1 persistent connection to the Kubernetes API levering “watch” function to get any updates.  



## Ingress for gRPC

Spinnaker requires an ingress to access Deck(UI) and Gate(API) services.  In “Agent Mode” and “Infra Mode” it’s required to create an gRPC ingress using mTLS.  This can be done through annotations to provision cloud load balancers in AWS, GCP, and Azure.  These three Spinnaker services should leverage a single ingress for simplicity.  

If you do not have an preferred ingress you can copy this ngnix configuration here.


## Armory Agent running in Kubernetes

Armory Agent run natively in Kubernetes.  The “kubesvc.yml” file will configure the Agent Pod with a Kubernetes Service Account.  This is how you control the access to the Kubernetes namespaces. The preferred configuration is to have a ClusterRole access to all namespaces to monitor the cluster with a single connection to the KubernetesAPI.  Also a client certificate bundle is configured (mounted) to authenticate to the Clouddriver plugin via mTLS.


![Armory Agent across all namespaces (deployment restriction done in RBAC on pipelines)](https://paper-attachments.dropbox.com/s_716E58F6E839B4F4555DEA68E72A2ED554567BFE6B633074E17BD71244EE29FA_1600981509462_image.png)
![Armory Agents can have restrictive permissions](https://paper-attachments.dropbox.com/s_716E58F6E839B4F4555DEA68E72A2ED554567BFE6B633074E17BD71244EE29FA_1600994214857_image.png)

### Permissions:

The Armory Agent can run with your kubernetes cluster with many different levels of granularity.  Access to the kubernetes namespaces and event bus is fully configurable to meet even the most regulated cluster configurations.  The permissions are inherited by the kubernetes role binding used when installing the agent.  This means you can have 1 Armory Agent for the entire Kubernetes cluster or multiple with limited access to namespaces and events.
Account Management:
The Armory Agent can assume any service accounts within the cluster for Spinnaker deployment pipelines.  


## Scalability

Kubernetes Deployments

Kube Agent is all about distributing work and high scale deployments.  This is to combat the growing number of kubernetes clusters, environments, and regions seen in the field.  By distributing the processing work for Spinnaker and optimizing the way Clouddriver collects information we can push Spinnaker to even further scales than what has been seen before.

Armory Agent Multicloud Kubernetes Deployments.

A single large Agent will perform just as well as many smaller Agents.  You can choose the deployment option that best fits your software deployment strategy.


![Armory Agent scales as the number of Development teams and Environments grow](https://paper-attachments.dropbox.com/s_716E58F6E839B4F4555DEA68E72A2ED554567BFE6B633074E17BD71244EE29FA_1601009399172_image.png)


## Resiliency

Armory Engineering has ensured that Kube Agent is made for all production cloud use cases.  This includes failure.  We understand that things don’t always go smoothly and with that in mind have created a highly resilient kubernetes deployment system.

## Armory Agent communication to Armory SaaS

The Agent design works extremely well with Armory Spinnaker SaaS.  Kube Agent can reach out and register itself with your Armory SaaS instance.


![Resilience above what Kubernetes provides by default by running redundant Armory Agents](https://paper-attachments.dropbox.com/s_716E58F6E839B4F4555DEA68E72A2ED554567BFE6B633074E17BD71244EE29FA_1600985407580_image.png)


If the Primary Agent fails, the Secondary monitoring Kubernetes cluster 1 will pickup and start forwarding events and performing operations where the Primary Agent left off.  There can be any number of Agents monitoring a Kubernetes cluster at one time.



