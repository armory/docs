---
title: "Armory Enterprise Managed Services"
linkTitle: "Managed Services"
weight: 10
exclude_search: true
type: docs
description: An overview of the benefits that come with using Armory Enterprise Managed Services.
---

Focus on building apps and not managing Spinnaker™. Armory experts take over Spinnaker operations, upgrades, and break-fix efforts in your environment.

With Armory experts managing Spinnaker using proven methodology and best practices, your Engineering team is free to focus on enabling the digital transformation required to move the business forward. This gives you a competitive edge by accelerating innovation through the delivery of new applications and services that are faster and better than those of your competitors.

## What is included

Here is everything included in the Armory Managed Services offering.

### Armory Enterprise for Spinnaker

Armory Site Reliability Engineers (SREs) install, configure, and operate Armory's Enterprise distribution of Spinnaker in the customer's cloud environment. Currently, Armory supports running Spinnaker in AWS and GCP. Armory supports any integrations listed on the [Armory Enterprise Compatibility Matrix](https://docs.armory.io/docs/feature-status/armory-enterprise-matrix/).

Armory provides two environments for you to use:

- **Red Zone**: Red Zone Spinnaker is not monitored and not production grade. It is used by Armory to prove out upgrades and new configurations. It can also be used by the customer as a test bed to try out new concepts. It should not be used to run any pipelines that are critical to your business.
- **Green Zone:** Green Zone Spinnaker is monitored and has uptime guarantees. It is used to run any applications and pipelines that are critical to your business.

### Migration

Armory SREs take care of migrations from any existing Spinnaker instance. Armory's Managed offering uses Operator, and the team can migrate from other configuration/deploy tools, such as Halyard. Armory offers two types of migration:

- **At-will migration**: Armory sets up a new Spinnaker alongside your existing Spinnaker. The customer can migrate as teams are ready.
- **Scheduled migration**: Armory sets up your new Spinnaker at a temporary location and migrates your configurations. There is a scheduled cutover date where the following occurs:

  - The current Spinnaker instance gets disabled
  - A final migration of configurations and data
  - A CNAME swap to the new Spinnaker

### Upgrades and patches

Armory SREs routinely upgrade and patch Spinnaker and all related services. Communication before, during, and after is provided.

### Supporting services

Armory SREs can install, configure, and operate all services needed to run Spinnaker in your cloud environment, including the Kubernetes cluster, persistent storage, network configurations, load balancers, security groups, and anything else needed.

Note that this is limited to resources needed for core Spinnaker operations. Armory does not maintain or support batch/run jobs clusters, WAFs, IDS/IPS or other similar settings. Resources like these are the customer's responsibility.

### Monitoring and alerting

Armory monitors the Green Zone Spinnaker 24x7 to ensure uptime guarantees are met. The Armor SRE team has a global presence across the North America, EMEA, and APAC regions. Customers can also notify Armory through the [Support Portal](https://support.armory.io/support) in the event of an outage or degradation in services.

### Incident response

Armory SREs provide notifications through the Support Portal whenever an incident is qualified. During an incident, Armory SREs  communicate with customers using a shared Slack channel and/or on a dedicated Zoom bridge. After the incident concludes, Armory SREs provide root cause analysis, including timeline, resolution, future prevention, and action items.

## What is not included

Armory SREs are experts at installing, configuring, and operating Spinnaker. The following article describes what is not covered by Armory Managed Services: [https://support.armory.io/support?id=kb_article_view&amp;sysparm_article=KB0010007](https://support.armory.io/support?id=kb_article_view&sysparm_article=KB0010007). 

Most of these can, however, be provided with through a Premium Support package or Professional Services offerings.

### Customer services and security

Armory operated resources are limited to resources that are necessary for core Spinnaker operations. Armory does not maintain or support batch/run jobs clusters, WAFs, IDS/IPS or other similar settings. Resources like these are the customer's responsibility.

### Application and user onboarding

The customer is responsible for building out the applications and pipelines needed to support their use cases. This includes troubleshooting pipeline executions and the third-party software that Spinnaker integrates with. Armory SREs provide support for any Spinnaker configuration changes needed.

The customer is also responsible for onboarding users to the system. Armory SREs can help setup integrations with any authentication and authorization system listed in the [Armory Enterprise Compatibility Matrix](https://docs.armory.io/docs/feature-status/armory-enterprise-matrix/), such as Okta or LDAP.

### Third-party software support

Armory SREs are not able to support third-party software solutions or integrations. They can provide logs and metrics on request that are related to Spinnaker.

### Usage metrics and dashboards

While Armory does monitor your environment, no monitoring dashboards or usage metrics are available to customers as a product offering.

## Shared responsibility

Because Spinnaker is managed by Armory within a customer's environment and Armory does not typically have full access to lower-level infrastructure resources and controls, Armory practices the shared responsibility model.

There are minimum requirements, but Armory can own up to as much of the managing infrastructure as viable while in communication with customers around requirements for the environment. Any ownership of resources outside of Armory control adds complexity and operational overhead, which may reduce overall uptime and deliverables.

## Monitoring and incident response

Armory monitors Spinnaker 24x7 using a own monitoring system and proactively responds to any detected issues. The following table describes Armory’s response times for each type of incident. The response time SLAs are the same for issues created by the customer or by Armory Engineers during proactive monitoring.

| **Priority** | **Response SLA** | **Definition** |
| --- | --- | --- |
| P-0 | 1 hour 24x7 | The Armory production instance is severely impacted and no workaround exist. Includes security issues. |
| P-1 | 1 business day | **In production clusters:** A non-critical feature is not working correctly and is blocking partial use of the platform, while other functionality is working correctly. **In non-production clusters:** An issue that blocks the promotion of changes to a production cluster |
| P-2 | 4 business days | Any issue affecting non-production clusters which is noncritical and non-time-sensitive |

The SLI and SLO described in the [Managed Customer: Spinnaker monitoring metrics](https://go.armory.io/managed-spinnaker-monitoring-metrics)  document help Armory measure the state of the system and are the foundation for the SLAs above.

## Uptime SLAs

Armory Managed Services guarantees **99.9%** uptime. This is measured through synthetic checks and does not included any scheduled maintenance windows coordinated in advance with the customer.

Due to the shared responsibility model, there are cases where Armory cannot guarantee uptime. If there is a failure to provide adequate compute resources or timely response to outages in supporting services that are not owned by Armory, Armory's ability to maintain uptime promises cannot be guaranteed.

## Support and escalation process

As part of Armory’s Managed Spinnaker offering, Armory SREs proactively monitor your Spinnaker instances. Additionally, the designated Technical Account Manager provides ongoing touch points around support issues, feature requests, and roadmap items while also holding quarterly service level reviews. You can expect responses based on the response time SLAs described here.

- For cases where issues were not detected by Armory or new feature requests, support tickets should be filed through the [Armory Support Portal](http://go.armory.io/support). They are be triaged and handled based on priority and SLA as Support Cases. All communication about the issue occurs in comments within the support ticket.
    - In some cases, Armory engineers may reach out through Slack to uncover more information about the issue. Armory updates the support ticket after the real-time chat is complete.
- For cases where an issue is discovered by Armory, Armory opens a support ticket on your behalf in the Armory Support Portal. You will be notified through email and Slack. All communication about the ticket occurs in comments within the support ticket.
    - In cases where Armory discovers a critical issue, Armory SREs reach out and send updates through Slack. Armory updates the support ticket after the real-time chat is completed.

## Managed Spinnaker configuration changes

Depending on the customer's level of comfort, Spinnaker configuration changes can be handled in two ways:

1. Change requests filed through the [Armory Support Portal](http://go.armory.io/support) and applied by Armory SREs to dev and production environments. All communication about changes occurs in comments within the support ticket.
    - In some cases, Armory SREs reach out through Slack to get more information about the desired configuration state. Armory updates the support ticket after the real-time chat is completed.
2. Because all Spinnaker configurations are stored in source control, customers can initiate a configuration change themselves. The changes get reviewed by Armory SREs and automatically applied to dev and then production clusters.

## Auditing Spinnaker events

Monitoring and logging can be configured to emit key metrics and logs to the customer's preferred monitoring and centralized logging system for auditing purposes. You need to ensure Spinnaker can reach these services and file a change request in the Armory Support Portal with access details to get this option enabled.

Events, metrics and logging can be acquired by the customer for auditing purposes. Implementation of this is customer specific. Armory exposes Prometheus for metrics and webhooks for event notifications, and logs are in standard Java log formats.

## Architecture

Armory Enterprise Spinnaker runs in the customer's cloud. To successfully manage your environment, there are a few shared services that are be accessed by both Armory and the customer's VPC. All network traffic is encrypted.

{{< figure src="/images/managed/managed-architecture.png">}}
