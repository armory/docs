---
title: Jenkins Webhook-Based Approvals Tutorial
linktitle: Jenkins
exclude_search: true
description: >
  Tutorial
---

## Objectives



## {{% heading "prereq" %}}

- You have read the webhook approval [introductory page]({{< ref "cdaas-webhooks" >}}).





{{< prism lang="yaml" line-numbers="true" line="3" >}}
webhooks:
  - name: jenkins-integration
    method: POST
    uriTemplate: https://myprivate.jenkins:9000/buildByToken/buildWithParameters?token=${secrets.potato-facts-jenkins-secret}&job=PotatoIntegrationTestJob&replicaSetName=${replicaSetName}&callbackUri=${callbackUri}
    networkMode: remoteNetworkAgent // direct or rna - `nil` by default will fall back to the configured account
    agentIdentifier: jenkins-rna //can override the test-env.account with an agent name or account name that has an rna configured
    headers:
      - key: Authorization
        value: Basic ${potato-facts-jenkins-auth}
{{< /prism >}}

not that the URI template has a token, webhook parms as placeholders, and the callback