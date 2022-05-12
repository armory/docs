---
title: Armory Continuous Deployments-as-a-Service Architecture
linkTitle: Architecture
description: >
  Armory Continuous Deployments-as-a-Service Architecture
exclude_search: true
weight: 10
aliases:
  - /armory-deployments/architecture/
---

## Key Components

### Remote Network Agent (RNA)

The RNA allows Armory Cloud Services to interact with your Kubernetes clusters and orchestrate deployments without direct network access to your clusters. RNAs get installed in every deployment target and connect those clusters to the Agent Hub in Armory Cloud. The connections are encrypted, long-lived gRPC HTTP2 connections. The connections are used for bidirectional communication between Armory Cloud Services and RNAs. The agent issues API calls to your Kubernetes Cluster based on requests from Armory Cloud.

### Armory Cloud

Armory Cloud is a collection of cloud-based services that Armory operates. These services are used to orchestrate deployments and monitor their progress.

Several specific services in Armory Cloud are important for understanding how Project Aurora and Armory CDaaS function. These services have endpoints that users and non-cloud services interact with. Details of the external URLs for these services are covered in [Networking](#networking).

#### Agent Hub

Agent Hub routes deployment commands to RNAs and caches data received from them. Agent Hub does not require direct network access to the agents since they connect to Agent Hub through an encrypted, long-lived gRPC HTTP2 connection. Agent Hub uses this connection to send deployment commands to the RNA for execution.

#### OIDC auth service

The Open ID Connect (OIDC) service is used to authorize and authenticate machines and users. The RNAs, Armory Enterprise (Spinnaker) plugin, and other services all authenticate against this endpoint. The service provides an identity token that can be passed to the Armory API and Agent Hub.

#### Rest API

Clients connect to these APIs to interact with Armory CDaaS.

#### CDaaS Console

The CDaaS Console provides a UI to perform administrative functions like inviting users and creating auth tokens. It also includes the Status UI, where you can monitor the progress of deployments and approve steps that require a manual judgment.

## Architecture

Armory CDaaS contains components that you manage in your environment and components that Armory manages in the cloud. The components you manage allow Armory’s cloud services to integrate with your existing infrastructure.


{{< figure height=50% width=50% src="/images/cdaas/overview.jpg" alt="The Armory command line interface and its integrations connect to Armory CDaaS. Armory CDaaS uses the Agent Hub to connect to your Kubernetes cluster using a gRPC connection established between the Agent Hub and Remote Network Agent, which is installed in your cluster." >}}

You connect your Kubernetes clusters to Armory CDaaS by installing the RNA on each target cluster. The agent establishes a bidirectional link with Armory Hub. Armory Hub uses this link to route communication from services within Armory Cloud to the agent in your Kubernetes cluster. The agent enables Armory Cloud to act as a control plane for your infrastructure.

### How it works

Armory CDaaS powers deployments to your Kubernetes clusters.

{{< figure height=40% width=40% src="/images/cdaas/how-it-works.jpg" alt="In your Kubernetes cluster, the RNA enables communication with Armory Cloud services through the Agent Hub. " >}}

When you start a deployment, Armory CDaaS processes your deployment request and generates CRDs that then get used to execute the deployment. Armory CDaaS triggers Kubernetes infrastructure changes using a bidirectional link to the target cluster that the RNA maintains. The RNA creates the generated CRDs in your Kubernetes cluster for the changes.

You can track the status of a deployment in the Armory CDaaS CLI or the Status UI.


## Security

### Armory CDaaS Identity and Access Management (IAM)

Armory CDaaS uses OIDC to authenticate both user and machine principals and issue short-lived access tokens, which are signed JSON web tokens (JWTs).

The Armory CDaaS API consumes these access tokens in order to validate that a request has authorization for a given tenant’s resources and operations.

Use the the [CDaaS Console](https://console.cloud.armory.io/) to manage the following:

- Ceate credentials for machines and scope them for specific permissions and use cases.
- Invite and manage users.
- Enable OIDC based external identity providers (IdP), such as Okta, Auth0, or OneLogin.

The following concepts can help you when configuring access in the Cloud Console:

- **Organization**

  A company like “Acme” or “Armory.”

- **Environment**

  A collection of accounts and their associated resources that you explicitly define. Environments are useful for separation and isolation, such as when you want to have distinct non-production and production environments. Accounts added to one environment are not accessible by machine credentials scoped to another environment.

- **Tenant**

  The combination of an Organization and Environment.

- **Principals**

  There are two types of principals:  a Machine or a User.

  *Machine principals* are credentials that are created within the Armory Cloud Console with specific scopes. They are used by service accounts, such as for allowing Spinnaker to connect to Armory Cloud.

  *User principals* are users that are invited to an organization, either by being invited or logging in through a configured external (IdP) such as Okta or Auth0.

- **Scopes**

  Scopes are individual permissions that grant access to certain actions. They can be assigned to Machine to Machine credentials. For example, the scope `read:infrastructure:data` allows a machine credential to fetch cached data about infrastructure and list accounts that are registered with the RNA.

- **Groups**

  Groups are attached to user principals and sourced from an external IdP like Okta or LDAP. Note that they are not currently being used by the Armory Cloud API.

### Networking

All network traffic is secured and encrypted with TLS end-to-end.
The following network endpoints are used for communication into Armory CDaaS:

| DNS                       | Port | Protocol                                        | Description                                                                           |
|---------------------------|------|-------------------------------------------------|---------------------------------------------------------------------------------------|
| agent-hub.cloud.armory.io | 443  | TLS enabled gRPC over HTTP/2<br>TLS version 1.2 | Agent Hub connection. gRPC is used to provide bidirectional, on demand communication. |
| api.cloud.armory.io       | 443  | HTTP over TLS (HTTPS)<br>TLS version 1.2        | Armory REST API                                                                       |
| auth.cloud.armory.io      | 443  | HTTP over TLS (HTTPS)<br>TLS version 1.2        | OIDC Service                                                                          |
| console.cloud.armory.io   | 443  | HTTP over TLS (HTTPS)<br>TLS version 1.2        | Web UI                                                                                |

### Data encryption

#### Encryption in transit

All data is encrypted using end-to-end encryption while in transit.

Encryption in transit is over HTTPS using TLS encryption. When using Armory-provided software for both the client and server, these connections are secured by TLS 1.2. Certain APIs support older TLS versions for clients that do not support 1.2.

#### Encryption at Rest

Encryption at rest uses AES256 encryption.
