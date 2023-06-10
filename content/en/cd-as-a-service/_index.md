---
title: Armory Continuous Deployment-as-a-Service
linkTitle: Armory CD-as-a-Service
no_list: true
description: >
  Armory CD-as-a-Service is a single control plane that enables deployment to multiple Kubernetes clusters using CD-as-a-Service's secure, one-way Kubernetes agents. These agents facilitate multi-cluster orchestration and advanced deployment strategies, such as canary and blue/green, for your apps.
---

## Overview of Armory CD-as-a-Service

Armory CD-as-a-Service delivers intelligent deployment-as-a-service that supports advanced deployment strategies so developers can focus on building great code rather than deploying it. By automating code deployment across all of your Kubernetes environments, Armory CD-as-a-Service removes demands on developers and reduces the risk of service disruptions due to change failures. It does this by seamlessly integrating pre-production verification tasks with advanced production deployment strategies. This mitigates risks by providing deployment flexibility while limiting blast radius, which leads to a better customer experience. Best of all, Armory CD-as-a-Service doesn’t require migrating to a new deployment platform. It easily plugs into any existing SDLC.

{{< figure src="/images/cdaas/cdaas-arch.png" alt="CD-as-a-Service High-Level Architecture" height="75%" width="75%" >}}

See the [Key Components]({{< ref "cd-as-a-service/concepts/architecture/key-components" >}}) section for details.

The [Armory CDaaS product page](https://www.armory.io/products/continuous-deployment-as-a-service/) contains a full list of features and pricing.


{{< cardpane >}}

{{% card header="Get Started" %}}
[Quickstart]({{< ref "cd-as-a-service/setup/quickstart" >}})</br>
[Deploy Your Own App]({{< ref "cd-as-a-service/setup/deploy-your-app" >}})</br>
[Deploy Using GitHub Action]({{< ref "cd-as-a-service/setup/gh-action" >}})</br>
[Install an Agent]({{<  ref "cd-as-a-service/tasks/networking/install-agent.md" >}})</br>
{{% /card %}}

{{% card header="Learn About CD-as-a-Service" %}}
[Key Components]({{<  ref "cd-as-a-service/concepts/architecture/key-components.md" >}})</br>
[Orgs, Tenants, and Users]({{<  ref "cd-as-a-service/concepts/architecture/orgs-tenants.md" >}})</br>
[RBAC]({{<  ref "cd-as-a-service/concepts/iam/rbac.md" >}})</br>

{{% /card %}}

{{% card header="Set Up Your Organization" %}}
[Add Tenants]({{<  ref "cd-as-a-service/tasks/tenants/add-tenants.md" >}})</br>
[Create Roles]({{<  ref "cd-as-a-service/tasks/iam/create-role.md" >}})</br>
[Invite Users]({{<  ref "cd-as-a-service/tasks/iam/invite-users.md" >}})</br>
{{% /card %}}

{{< /cardpane >}}

{{< cardpane >}}
{{% card header="Strategies" %}}
[Blue/Green Deployment]({{< ref "cd-as-a-service/setup/blue-green" >}})</br>
[Canary Analysis]({{< ref "cd-as-a-service/setup/canary" >}})</br>
[Query Reference Guide]({{< ref "cd-as-a-service/reference/ref-queries.md" >}})</br>
[Integrate a Metrics Provider]({{< ref "cd-as-a-service/tasks/canary/add-integrations" >}})</br>
[Construct Retrospective Analysis Queries]({{< ref "cd-as-a-service/tasks/canary/retro-analysis" >}})</br>
{{% /card %}}



{{% card header="Deployment" %}}
[Create a Deployment Config File]({{< ref "cd-as-a-service/tasks/deploy/create-deploy-config" >}})</br>
[Deployment Config File Reference]({{< ref "cd-as-a-service/reference/ref-deployment-file.md" >}})</br>
[Deploy Using Credentials]({{< ref "cd-as-a-service/tasks/deploy/deploy-with-creds.md" >}})</br>
[Add Context Variables]({{< ref "cd-as-a-service/tasks/deploy/add-context-variable" >}})</br>
[Create and Use Secrets]({{< ref "cd-as-a-service/tasks/secrets/secrets-create" >}})</br>
{{% /card %}}

{{% card header="Traffic Management" %}}
[Traffic Management Using Istio]({{<  ref "cd-as-a-service/concepts/deployment/traffic-management/istio.md" >}})</br>
[Traffic Management Using Linkerd]({{<  ref "cd-as-a-service/concepts/deployment/traffic-management/smi-linkerd.md" >}})</br>
[Configure Istio]({{< ref "cd-as-a-service/tasks/deploy/traffic-management/istio" >}})</br>
[Configure Linkerd]({{< ref "cd-as-a-service/tasks/deploy/traffic-management/linkerd" >}})</br>
{{% /card %}}

{{< /cardpane >}}

{{< cardpane >}}


{{% card header="Webhooks" %}}
[Webhook-Based Approvals]({{< ref "cd-as-a-service/concepts/external-automation" >}})</br>
[Configure a Webhook]({{< ref "cd-as-a-service/tasks/webhook-approval" >}})</br>
[GitHub Webhook-Based Approval Tutorial]({{<  ref "cd-as-a-service/tutorials/external-automation/webhook-github" >}})</br>
{{% /card %}}

{{% card header="Tools" %}}
[CLI]({{< ref "cd-as-a-service/tasks/cli" >}})</br>
{{% /card %}}

{{% card header="Tutorials" %}}

[Create and Manage RBAC Roles]({{<  ref "cd-as-a-service/tutorials/access-management/rbac-users" >}})</br>
[Deploy a Sample App]({{<  ref "cd-as-a-service/tutorials/deploy-sample-app" >}})</br>


{{% /card %}}
{{< /cardpane >}}

